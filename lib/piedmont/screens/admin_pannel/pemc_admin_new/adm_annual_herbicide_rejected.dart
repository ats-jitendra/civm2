import 'package:CIVM/piedmont/models/annual_herbicide_model.dart';
import 'package:CIVM/piedmont/repository/map_url.dart';
import 'package:CIVM/piedmont/resources/app_colors.dart';
import 'package:CIVM/piedmont/resources/app_url.dart';
import 'package:CIVM/piedmont/screens/my_chrome_safari_map_recording.dart';
import 'package:CIVM/piedmont/utils/common_functions.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class AdmAnnualHerbicideRejected extends StatefulWidget {
  AdmAnnualHerbicideRejected({
    super.key,
  });

  @override
  State<AdmAnnualHerbicideRejected> createState() =>
      _AdmAnnualHerbicideRejectedState();
}

class _AdmAnnualHerbicideRejectedState extends State<AdmAnnualHerbicideRejected>
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
  List<FindAllTableDataAnnualHerbicide> dataList = [];
  List<FindAllTableDataAnnualHerbicide> filteredList = [];
  String auditId = '';
  String accountNumber = '';
  String status = '';
  bool isError = false;
  final browser = MyChromeSafariBrowser();
  @override
  void initState() {
    myFuture = fetchData();
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
          'Annual Herbicide (Rejected)',
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
                    await fetchData();
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
                              "TOTAL NO OF RECORDS : ${dataList.length.toString()}",
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
                              return Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            AppColors.green1.withOpacity(0.9),
                                            AppColors.green2.withOpacity(0.7),
                                            AppColors.green1.withOpacity(0.9),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        children: [
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Row(children: [
                                                Expanded(
                                                  // alignment: Alignment.topLeft,
                                                  child: Column(
                                                    children: [
                                                      const Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          "JOB NO: ",
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          item.jobno ??
                                                              "".toString(),
                                                          textAlign:
                                                              TextAlign.left,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                            //  fontWeight:
                                                            //      FontWeight.bold,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  // alignment: Alignment.topLeft,
                                                  child: Column(
                                                    children: [
                                                      const Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          "NAME: ",
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          item.name.toString(),
                                                          textAlign:
                                                              TextAlign.left,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                            //  fontWeight:
                                                            //      FontWeight.bold,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  // alignment: Alignment.topLeft,
                                                  child: Column(
                                                    children: [
                                                      const Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          "TYPE: ",
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          item.type.toString(),
                                                          textAlign:
                                                              TextAlign.left,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                            //  fontWeight:
                                                            //      FontWeight.bold,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ])),
                                          const Divider(color: Colors.grey),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Row(children: [
                                                Expanded(
                                                  // alignment: Alignment.topLeft,
                                                  child: Column(
                                                    children: [
                                                      const Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          "AREA: ",
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          item.area.toString(),
                                                          textAlign:
                                                              TextAlign.left,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                            //  fontWeight:
                                                            //      FontWeight.bold,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  // alignment: Alignment.topLeft,
                                                  child: Column(
                                                    children: [
                                                      const Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          "LATITUDE: ",
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          item.lat.toString(),
                                                          textAlign:
                                                              TextAlign.left,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                            //  fontWeight:
                                                            //      FontWeight.bold,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  // alignment: Alignment.topLeft,
                                                  child: Column(
                                                    children: [
                                                      const Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          "LONGITUDE: ",
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          item.lon.toString(),
                                                          textAlign:
                                                              TextAlign.left,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                            //  fontWeight:
                                                            //      FontWeight.bold,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ])),
                                          const Divider(color: Colors.grey),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Row(children: [
                                                Expanded(
                                                  // alignment: Alignment.topLeft,
                                                  child: Column(
                                                    children: [
                                                      const Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          "GALLONS: ",
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          item.gallon
                                                              .toString(),
                                                          textAlign:
                                                              TextAlign.left,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                            //  fontWeight:
                                                            //      FontWeight.bold,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  // alignment: Alignment.topLeft,
                                                  child: Column(
                                                    children: [
                                                      const Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          "STATUS: ",
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          item.status
                                                              .toString(),
                                                          textAlign:
                                                              TextAlign.left,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                            //  fontWeight:
                                                            //      FontWeight.bold,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  // alignment: Alignment.topLeft,
                                                  child: Column(
                                                    children: [
                                                      const Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          "SUPERVISOR NOTES: ",
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          item.supervisorNotes
                                                              .toString(),
                                                          textAlign:
                                                              TextAlign.left,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                            //  fontWeight:
                                                            //      FontWeight.bold,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ])),
                                          const Divider(color: Colors.grey),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Row(children: [
                                                Expanded(
                                                  // alignment: Alignment.topLeft,
                                                  child: Column(
                                                    children: [
                                                      const Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          "GENERAL FOREMAN NOTES: ",
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          item.generalForemanNotes
                                                              .toString(),
                                                          textAlign:
                                                              TextAlign.left,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                            //  fontWeight:
                                                            //      FontWeight.bold,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  // alignment: Alignment.topLeft,
                                                  child: Column(
                                                    children: [
                                                      const Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          "CREATED BY: ",
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          item.createdBy
                                                              .toString(),
                                                          textAlign:
                                                              TextAlign.left,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                            //  fontWeight:
                                                            //      FontWeight.bold,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  // alignment: Alignment.topLeft,
                                                  child: Column(
                                                    children: [
                                                      const Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          "YEAR: ",
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          item.year.toString(),
                                                          textAlign:
                                                              TextAlign.left,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                            //  fontWeight:
                                                            //      FontWeight.bold,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ])),
                                          const Divider(color: Colors.grey),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Row(children: [
                                                Expanded(
                                                  // alignment: Alignment.topLeft,
                                                  child: Column(
                                                    children: [
                                                      const Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          "GEOMETRY: ",
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          item.geometry
                                                              .toString(),
                                                          textAlign:
                                                              TextAlign.left,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                            //  fontWeight:
                                                            //      FontWeight.bold,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  //  flex: 2,
                                                  // alignment: Alignment.topLeft,
                                                  child: Column(
                                                    children: [
                                                      const Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          "CREATE DATE: ",
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          formatDateIfNeeded(
                                                              item.createDtm
                                                                  .toString()),
                                                          textAlign:
                                                              TextAlign.left,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                            //  fontWeight:
                                                            //      FontWeight.bold,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  //  flex: 2,
                                                  child: Column(
                                                    children: [
                                                      Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: InkWell(
                                                            onTap: () async {
                                                              String id = '';
                                                              final userPreferences1 =
                                                                  Provider.of<
                                                                          UserPref>(
                                                                      context,
                                                                      listen:
                                                                          false);
                                                              UserModel data =
                                                                  await userPreferences1
                                                                      .getUser();
                                                              id = data.user!.id
                                                                  .toString();

                                                              await browser
                                                                  .open(
                                                                      url: WebUri(MapUrl.getsupervisorPemcEndPoint(
                                                                          item.jobno
                                                                              .toString(),
                                                                          id)),
                                                                      // "https://mapapi.ariespro.com/main/supervisor/CIVM_Map/${wOViewModel.woTabularData.data!.findAllTableData![index].tokenNo.toString()}/USRQWXH589Z"),
                                                                      settings: ChromeSafariBrowserSettings(
                                                                          shareState: CustomTabsShareState
                                                                              .SHARE_STATE_OFF,
                                                                          barCollapsingEnabled:
                                                                              true));
                                                            },
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Container(
                                                                // margin: const EdgeInsets.only(
                                                                //     left: 40, right: 40, bottom: 10.0),
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(8),
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                width: 80,
                                                                // MediaQuery.of(context).size.width,
                                                                // height: MediaQuery.of(context).size.height * 0.4,
                                                                decoration:
                                                                    const BoxDecoration(
                                                                        // shape: BoxShape.circle,

                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            0,
                                                                            58,
                                                                            106),
                                                                        gradient:
                                                                            LinearGradient(
                                                                          colors: [
                                                                            Color.fromARGB(
                                                                                255,
                                                                                0,
                                                                                79,
                                                                                215),
                                                                            Colors.blue,
                                                                            Color.fromARGB(
                                                                                255,
                                                                                0,
                                                                                79,
                                                                                215),
                                                                          ],
                                                                        )),
                                                                child:
                                                                    const Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(
                                                                    "VIEW MAP",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          10,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              ])),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
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

  storeEnergyAuditAuditId(String energyAuditId, String accountNo) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('energyAuditId', energyAuditId);
    preferences.setString('ACCOUNT_NO', accountNo);
  }

  Widget customDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      height: 1,
      width: double.infinity,
      color: Colors.grey.shade300,
    );
  }

  Widget buildKeyValueRow(String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        const Expanded(
          flex: 1,
          child: Text(
            ":",
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> fetchData() async {
    var url =
        "${AppUrl.supervisorAnnualHerbicidedata}?status=REJECTED&orderBy=Jobno";

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
        print(" API Success:");
        print(response.body);

        var data = jsonDecode(response.body);

        List list = data["findAllTableData"] ?? [];

        setState(() {
          dataList = list
              .map((e) => FindAllTableDataAnnualHerbicide.fromJson(e))
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

          return (item.area ?? "")
                  .toString()
                  .toLowerCase()
                  .contains(searchText) ||
              (item.gallon ?? "")
                  .toString()
                  .toLowerCase()
                  .contains(searchText) ||
              (item.generalForemanNotes ?? "")
                  .toString()
                  .toLowerCase()
                  .contains(searchText) ||
              (item.geometry ?? "")
                  .toString()
                  .toLowerCase()
                  .contains(searchText) ||
              (item.id ?? "").toString().toLowerCase().contains(searchText) ||
              (item.jobno ?? "")
                  .toString()
                  .toLowerCase()
                  .contains(searchText) ||
              (item.lat ?? "").toString().toLowerCase().contains(searchText) ||
              (item.lon ?? "").toString().toLowerCase().contains(searchText) ||
              (item.name ?? "").toString().toLowerCase().contains(searchText) ||
              (item.status ?? "").toString().toLowerCase().contains(searchText);
        }).toList();
      });
    }
  }
}
