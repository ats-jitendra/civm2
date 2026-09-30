import 'package:CIVM/piedmont/models/supervisor_invoice_list_model.dart';
import 'package:CIVM/piedmont/resources/app_colors.dart';
import 'package:CIVM/piedmont/resources/app_url.dart';
import 'package:CIVM/piedmont/screens/my_chrome_safari_map_recording.dart';
import 'package:CIVM/piedmont/utils/common_functions.dart';
import 'package:CIVM/piedmont/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/piedmont/view_model/image_code_view_model.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:open_file/open_file.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/pdf_view.dart';

import 'package:CIVM/piedmont/screens/video_folder/fullVideo/full_screen_video_player.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

// ignore: must_be_immutable
class AdmInvoiceListTransmissionHerbicide extends StatefulWidget {
  AdmInvoiceListTransmissionHerbicide({
    super.key,
  });

  @override
  State<AdmInvoiceListTransmissionHerbicide> createState() =>
      _AdmInvoiceListTransmissionHerbicideState();
}

class _AdmInvoiceListTransmissionHerbicideState
    extends State<AdmInvoiceListTransmissionHerbicide>
    with TickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  final List<Color> containerColors = [
    const Color.fromARGB(255, 252, 231, 238),
    const Color.fromARGB(255, 226, 246, 253),
    const Color.fromARGB(255, 212, 249, 212),
    const Color.fromARGB(255, 251, 251, 215),
    const Color.fromARGB(255, 251, 239, 251),
  ];
  List<String> menu = [];
  Future? myFuture;
  List<SupervisorInvoiceListData> dataList = [];
  List<SupervisorInvoiceListData> filteredList = [];
  String auditId = '';
  String accountNumber = '';
  String status = '';
  bool isError = false;
  bool isLoading = false;
  String selectedCrewLoginID = '';
  List<Map<String, dynamic>> crewList = [];
  String? selectedCrew;
  final browser = MyChromeSafariBrowser();
  ImageViewViewModel imageViewModel = ImageViewViewModel();

  ///

  String? selectedYear = DateTime.now().year.toString();

  List<String> selectedMonths = [];

  final List<String> monthsList = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  List<dynamic> selectedmonth = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12"
  ];
  String selectedmonthString = "";
  final List<String> yearsList = [
    "2023",
    "2024",
    "2025",
    "2026",
  ];
    List<String> selectedTransmissionNames = [];
  List<String> transmissionList = [];
  String? selectedTransmissionName;
  String? selectedSubstationId = "";
  String? month;
  List<dynamic> monthh = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  
  int? downloadingIndex;
  int? viewingIndex;

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
      // appBar: AppBar(
      //   iconTheme: const IconThemeData(color: Colors.white),
      //   title: const Text(
      //     'Invoice List',
      //     style: TextStyle(color: Colors.white),
      //   ),
      //   backgroundColor: AppColors.baseColor,
      // ),
      //  drawer: DrawerManu(menu: menu),
      body: SafeArea(
        child: Column(
          children: [
            progressHeader("Transmission Herbicide", onTap: () {
              showFilterDialog(context);
            }),
            Expanded(
              child: SingleChildScrollView(
                child: FutureBuilder(
                  future: myFuture,
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 250),
                        child: Center(child: CircularProgressIndicator()),
                      );
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
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 8, left: 8, top: 8),
                                    child: Row(
                                      children: [
                                        // Expanded(
                                        //   child: ProgressCard(
                                        //     title: "Total Miles",
                                        //     value: totalMiles,
                                        //     //  milesCompleted
                                        //     //     .toStringAsFixed(2),
                                        //     icon: Icons.route,
                                        //     startColor: const Color(0xFF4CAF50),
                                        //     endColor: const Color(0xFF2E7D32),
                                        //   ),
                                        // ),

                                        Expanded(
                                          child: ProgressCard(
                                            title: "Completed Miles",
                                            value: completedMiles,
                                            // "\$${totalMilesCompletedCost.toStringAsFixed(2)}",
                                            icon: Icons.check_circle_outline,
                                            // startColor: const Color(0xFF2196F3),
                                            // endColor: const Color(0xFF1565C0),
                                            startColor: const Color(0xFF4CAF50),
                                            endColor: const Color(0xFF2E7D32),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: ProgressCard(
                                            title: "Completed Miles Cost",
                                            value: cost,
                                            //"${expectedMiles.toStringAsFixed(2)} (${standardExpectedMiles.toStringAsFixed(2)}/W)",
                                            icon: Icons.attach_money,
                                            startColor: const Color(0xFFFF9800),
                                            endColor: const Color(0xFFEF6C00),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(
                                  //       right: 8, left: 8, top: 8),
                                  //   child: Row(children: [
                                  //     const SizedBox(width: 8),
                                  //     Expanded(
                                  //       child: Container(),
                                  //     ),
                                  //   ]),
                                  // ),
                                ],
                              ),
                              Container(
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
                                                  left: 4.0,
                                                  right: 4.0,
                                                  top: 4,
                                                  bottom: 4),
                                              child: TextFormField(
                                                controller: searchController,
                                                onChanged: (value) =>
                                                    filterData(
                                                        value), // 👈 important
                                                style: const TextStyle(
                                                    color: AppColors.baseColor,
                                                    fontSize: 16),
                                                obscureText: false,

                                                // keyboardType: TextInputType.number,
                                                decoration:
                                                    const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color.fromARGB(
                                                          255, 23, 1, 88),
                                                    ),
                                                    // borderRadius:
                                                    //     BorderRadius.circular(25),
                                                  ),
                                                  hintText:
                                                      'Search your input...',
                                                ),
                                                validator: (value) {
                                                  if (value!.toString ==
                                                      'null') {
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
                                        physics:
                                            const AlwaysScrollableScrollPhysics(),
                                        itemCount: filteredList.length,
                                        itemBuilder:
                                            (BuildContext ctxt, int index) {
                                          var item = filteredList[index];
                                          return Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.88,
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        AppColors.green1
                                                            .withOpacity(0.9),
                                                        AppColors.green2
                                                            .withOpacity(0.7),
                                                        AppColors.green1
                                                            .withOpacity(0.9),
                                                      ],
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 8.0),
                                                        child: Row(
                                                          children: [
                                                          //                                                              Expanded(
                                                          //   // alignment: Alignment.topLeft,
                                                          //   child: Column(
                                                          //     children: [
                                                          //       const Align(
                                                          //         alignment:
                                                          //             Alignment
                                                          //                 .topLeft,
                                                          //         child: Text(
                                                          //           "VIEW",
                                                          //           textAlign:
                                                          //               TextAlign
                                                          //                   .left,
                                                          //           style: TextStyle(
                                                          //             fontSize:
                                                          //                 12,
                                                          //             fontWeight:
                                                          //                 FontWeight
                                                          //                     .bold,
                                                          //             color: Colors
                                                          //                 .white,
                                                          //           ),
                                                          //         ),
                                                          //       ),
                                                          //       Align(
                                                          //         alignment:
                                                          //             Alignment
                                                          //                 .topLeft,
                                                          //         child: InkWell(
                                                          //           onTap: () {
                                                          //             downloadInvoice(
                                                          //               item.tOKENNO
                                                          //                   .toString(),
                                                          //               item.mILESCOMPLETED
                                                          //                   .toString(),
                                                          //               getMonthInvoice(
                                                          //                 item.aPPROVEDDATE
                                                          //                     .toString(),
                                                          //               ),
                                                          //               getYearInvoice(
                                                          //                 item.aPPROVEDDATE
                                                          //                     .toString(),
                                                          //               ),
                                                          //               'VIEW',
                                                          //             );
                                                          //           },
                                                          //           child: Align(
                                                          //             alignment:
                                                          //                 Alignment
                                                          //                     .topLeft,
                                                          //             child:
                                                          //                 isViewLoading
                                                          //                 ? const SizedBox(
                                                          //                     width: 24,
                                                          //                     height: 24,
                                                          //                     child: CircularProgressIndicator(
                                                          //                       strokeWidth: 2,
                                                          //                       color: Colors.orange,
                                                          //                     ),
                                                          //                   )
                                                          //                 : const Icon(
                                                          //                     Icons.remove_red_eye,
                                                          //                     color: Colors.orange,
                                                          //                   ),
                                                          //           ),
                                                          //         ),
                                                          //       ),
                                                          //     ],
                                                          //   ),
                                                          // ),
                                                          // Expanded(
                                                          //   // alignment: Alignment.topLeft,
                                                          //   child: Column(
                                                          //     children: [
                                                          //       const Align(
                                                          //         alignment:
                                                          //             Alignment
                                                          //                 .topLeft,
                                                          //         child: Text(
                                                          //           "DOWNLOAD: ",
                                                          //           textAlign:
                                                          //               TextAlign
                                                          //                   .left,
                                                          //           style: TextStyle(
                                                          //             fontSize:
                                                          //                 12,
                                                          //             fontWeight:
                                                          //                 FontWeight
                                                          //                     .bold,
                                                          //             color: Colors
                                                          //                 .white,
                                                          //           ),
                                                          //         ),
                                                          //       ),
                                                          //       Align(
                                                          //         alignment:
                                                          //             Alignment
                                                          //                 .topLeft,
                                                          //         child: InkWell(
                                                          //           onTap: () {
                                                          //             downloadInvoice(
                                                          //               item.tOKENNO
                                                          //                   .toString(),
                                                          //               item.mILESCOMPLETED
                                                          //                   .toString(),
                                                          //               getMonthInvoice(
                                                          //                 item.aPPROVEDDATE
                                                          //                     .toString(),
                                                          //               ),
                                                          //               getYearInvoice(
                                                          //                 item.aPPROVEDDATE
                                                          //                     .toString(),
                                                          //               ),
                                                          //               'DOWNLOAD',
                                                          //             );
                                                          //           },
                                                          //           child: Align(
                                                          //             alignment:
                                                          //                 Alignment
                                                          //                     .topLeft,
                                                          //             child:
                                                          //                 isDownloadLoading
                                                          //                 ? const SizedBox(
                                                          //                     width: 24,
                                                          //                     height: 24,
                                                          //                     child: CircularProgressIndicator(
                                                          //                       strokeWidth: 2,
                                                          //                       color: Colors.green,
                                                          //                     ),
                                                          //                   )
                                                          //                 : const Icon(
                                                          //                     Icons.download,
                                                          //                     color: Colors.green,
                                                          //                   ),
                                                          //           ),
                                                          //         ),
                                                          //       ),
                                                          //     ],
                                                          //   ),
                                                          // ),
                                                            Expanded(
                                                            // alignment: Alignment.topLeft,
                                                            child: Column(
                                                              children: [
                                                                const Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .topLeft,
                                                                  child: Text(
                                                                    "VIEW",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .topLeft,
                                                                  child: InkWell(
                                                                    onTap: () async {
                                                                      setState(() {
                                                                        viewingIndex =
                                                                            index;
                                                                      });

                                                                      try {
                                                                        await downloadInvoice(
                                                                          item.tOKENNO
                                                                              .toString(),
                                                                          item.mILESCOMPLETED
                                                                              .toString(),
                                                                          getMonthInvoice(
                                                                            item.aPPROVEDDATE.toString(),
                                                                          ),
                                                                          getYearInvoice(
                                                                            item.aPPROVEDDATE.toString(),
                                                                          ),
                                                                          'VIEW',
                                                                        );
                                                                      } finally {
                                                                        if (mounted) {
                                                                          setState(
                                                                            () {
                                                                              viewingIndex = null;
                                                                            },
                                                                          );
                                                                        }
                                                                      }
                                                                    },
                                                                    child: Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          viewingIndex ==
                                                                              index
                                                                          ? const SizedBox(
                                                                              width: 24,
                                                                              height: 24,
                                                                              child: CircularProgressIndicator(
                                                                                strokeWidth: 2,
                                                                                color: Colors.orange,
                                                                              ),
                                                                            )
                                                                          : const Icon(
                                                                              Icons.remove_red_eye,
                                                                              color: Colors.orange,
                                                                            ),
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
                                                                      Alignment
                                                                          .topLeft,
                                                                  child: Text(
                                                                    "DOWNLOAD: ",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .topLeft,
                                                                  child: InkWell(
                                                                    onTap: () async {
                                                                      setState(() {
                                                                        downloadingIndex =
                                                                            index;
                                                                      });

                                                                      try {
                                                                        await downloadInvoice(
                                                                          item.tOKENNO
                                                                              .toString(),
                                                                          item.mILESCOMPLETED
                                                                              .toString(),
                                                                          getMonthInvoice(
                                                                            item.aPPROVEDDATE.toString(),
                                                                          ),
                                                                          getYearInvoice(
                                                                            item.aPPROVEDDATE.toString(),
                                                                          ),
                                                                          'DOWNLOAD',
                                                                        );
                                                                      } finally {
                                                                        if (mounted) {
                                                                          setState(
                                                                            () {
                                                                              downloadingIndex = null;
                                                                            },
                                                                          );
                                                                        }
                                                                      }
                                                                    },
                                                                    child: Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          downloadingIndex ==
                                                                              index
                                                                          ? const SizedBox(
                                                                              width: 24,
                                                                              height: 24,
                                                                              child: CircularProgressIndicator(
                                                                                strokeWidth: 2,
                                                                                color: Colors.green,
                                                                              ),
                                                                            )
                                                                          : const Icon(
                                                                              Icons.download,
                                                                              color: Colors.green,
                                                                            ),
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
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      "IMAGE: ",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child:
                                                                        InkWell(
                                                                      onTap:
                                                                          () async {
                                                                        await imageViewModel
                                                                            .fetchImageApi(
                                                                          context,
                                                                          item.tOKENNO
                                                                              .toString(),
                                                                        );
                                                                        await Future.delayed(const Duration(
                                                                            seconds:
                                                                                2));
                                                                        openDialogPicture(item
                                                                            .tOKENNO
                                                                            .toString());
                                                                      },
                                                                      child: const Align(
                                                                          alignment: Alignment.topLeft,
                                                                          child: Icon(
                                                                            Icons.image,
                                                                            color:
                                                                                Colors.blue,
                                                                          )),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            ],
                                                        ),
                                                      ),
                                                      const Divider(
                                                        color: Colors.grey,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 8.0),
                                                        child: Row(
                                                          children: [
                                                             Expanded(
                                                              // alignment: Alignment.topLeft,
                                                              child: Column(
                                                                children: [
                                                                  const Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      "JOB NO: ",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      item.tOKENNO
                                                                          .toString(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        //  fontWeight:
                                                                        //      FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
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
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      "TRANSMISSION NAME: ",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      item.tRANSMISSIONNAME
                                                                          .toString(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        //  fontWeight:
                                                                        //      FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
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
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      "ASSIGNED CONTRACTOR: ",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      item.nAME
                                                                          .toString(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        //  fontWeight:
                                                                        //      FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                             ],
                                                        ),
                                                      ),
                                                      const Divider(
                                                        color: Colors.grey,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 8.0),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              // alignment: Alignment.topLeft,
                                                              child: Column(
                                                                children: [
                                                                  const Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      "MAINTENANCE TYPE: ",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      item.mAINTTYPE
                                                                          .toString(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        //  fontWeight:
                                                                        //      FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
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
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      "TYPE: ",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      item.tYPE
                                                                          .toString(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        //  fontWeight:
                                                                        //      FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
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
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      "TOTAL MILES: ",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      item.tOTALMILES
                                                                          .toString(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        //  fontWeight:
                                                                        //      FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                             ],
                                                        ),
                                                      ),
                                                      const Divider(
                                                        color: Colors.grey,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 8.0),
                                                        child: Row(
                                                          children: [
                                                             Expanded(
                                                              // alignment: Alignment.topLeft,
                                                              child: Column(
                                                                children: [
                                                                  const Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      "MILES COMPLETED: ",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      item.mILESCOMPLETED
                                                                          .toString(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        //  fontWeight:
                                                                        //      FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
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
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      "ROW INSTALLATION YEAR: ",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      getYearOrNA(item
                                                                          .cONTRACTYEAR
                                                                          .toString()),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        //  fontWeight:
                                                                        //      FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
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
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      "CYCLE: ",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      item.cYCLE
                                                                          .toString(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        //  fontWeight:
                                                                        //      FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                              ],
                                                        ),
                                                      ),
                                                      const Divider(
                                                        color: Colors.grey,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 8.0),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              // alignment: Alignment.topLeft,
                                                              child: Column(
                                                                children: [
                                                                  const Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      "NEXT MAINT DUE: ",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      item.cYCLE
                                                                          .toString(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        //  fontWeight:
                                                                        //      FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
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
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      "ORDER MONTH: ",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      item.oRDERMONTH
                                                                          .toString(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        //  fontWeight:
                                                                        //      FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
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
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      "ORDER YEAR: ",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      item.oRDERYEAR
                                                                          .toString(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        //  fontWeight:
                                                                        //      FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            //          Expanded(
                                                            //   //  flex: 2,
                                                            //   child: Column(
                                                            //     children: [
                                                            //       Align(
                                                            //           alignment:
                                                            //               Alignment.topLeft,
                                                            //           child: InkWell(
                                                            //             onTap: () async {
                                                            //               String id = '';
                                                            //               final userPreferences1 =
                                                            //                   Provider.of<
                                                            //                           UserPref>(
                                                            //                       context,
                                                            //                       listen:
                                                            //                           false);
                                                            //               UserModel data =
                                                            //                   await userPreferences1
                                                            //                       .getUser();
                                                            //               id = data.user!.id
                                                            //                   .toString();

                                                            //               await browser
                                                            //                   .open(
                                                            //                       url: WebUri(MapUrl.getSupervisorEndPoint(
                                                            //                           item.tOKENNO
                                                            //                               .toString(),
                                                            //                           id)),
                                                            //                       // "https://mapapi.ariespro.com/main/supervisor/CIVM_Map/${wOViewModel.woTabularData.data!.findAllTableData![index].tokenNo.toString()}/USRQWXH589Z"),
                                                            //                       settings: ChromeSafariBrowserSettings(
                                                            //                           shareState: CustomTabsShareState
                                                            //                               .SHARE_STATE_OFF,
                                                            //                           barCollapsingEnabled:
                                                            //                               true));
                                                            //             },
                                                            //             child: Align(
                                                            //               alignment: Alignment
                                                            //                   .centerLeft,
                                                            //               child: Container(
                                                            //                 // margin: const EdgeInsets.only(
                                                            //                 //     left: 40, right: 40, bottom: 10.0),
                                                            //                 padding:
                                                            //                     const EdgeInsets
                                                            //                         .all(8),
                                                            //                 alignment: Alignment
                                                            //                     .centerLeft,
                                                            //                 width: 80,
                                                            //                 // MediaQuery.of(context).size.width,
                                                            //                 // height: MediaQuery.of(context).size.height * 0.4,
                                                            //                 decoration:
                                                            //                     const BoxDecoration(
                                                            //                         // shape: BoxShape.circle,

                                                            //                         color: Color.fromARGB(
                                                            //                             255,
                                                            //                             0,
                                                            //                             58,
                                                            //                             106),
                                                            //                         gradient:
                                                            //                             LinearGradient(
                                                            //                           colors: [
                                                            //                             Color.fromARGB(
                                                            //                                 255,
                                                            //                                 0,
                                                            //                                 79,
                                                            //                                 215),
                                                            //                             Colors.blue,
                                                            //                             Color.fromARGB(
                                                            //                                 255,
                                                            //                                 0,
                                                            //                                 79,
                                                            //                                 215),
                                                            //                           ],
                                                            //                         )),
                                                            //                 child:
                                                            //                     const Align(
                                                            //                   alignment:
                                                            //                       Alignment
                                                            //                           .center,
                                                            //                   child: Text(
                                                            //                     "VIEW MAP",
                                                            //                     style:
                                                            //                         TextStyle(
                                                            //                       color: Colors
                                                            //                           .white,
                                                            //                       fontWeight:
                                                            //                           FontWeight
                                                            //                               .bold,
                                                            //                       fontSize:
                                                            //                           10,
                                                            //                     ),
                                                            //                   ),
                                                            //                 ),
                                                            //               ),
                                                            //             ),
                                                            //           )),
                                                            //     ],
                                                            //   ),
                                                            // ),
                                                          ],
                                                        ),
                                                      ),
                                                      // const Divider(
                                                      //   color: Colors.grey,
                                                      // ),
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 8.0),
                                                        child: Row(
                                                          children: [],
                                                        ),
                                                      ),
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
                            ],
                          ),
                        ));
                  },
                ),
              ),
            ),
          ],
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

  String totalMiles = "";
  String completedMiles = "";
  String circuit = "";
  String cost = "";
  Future<void> fetchData() async {
    String selectedTransmissionNameAPI = "";

    if (selectedTransmissionNames.isEmpty) {
      selectedTransmissionNameAPI = "";
    } else {
      selectedTransmissionNameAPI = selectedTransmissionNames.join(",");
    }
    var url =
        "${AppUrl.getInvoiceListReport}?status=APPROVED&planType=MID Transmission Map&budgetType=Mid Transmission maintenance&maintType=RegularMaint&vFlag=2&year=$selectedYear&month=$selectedmonthString&transmissionName=$selectedTransmissionNameAPI&substation=";
    // "${AppUrl.findClosedPendingPageData}?status=PENDING&budgetType=Transmission maintenance&maintType=RegularMaint&panel=supervisor&planType=IVM Transmission Plan&contractorCompany=Edko LLC";

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

        List list = data["ready_For_review_Data"] ?? [];
        List transmissionData = data["transmissionNames"] ?? [];

        setState(() {
          dataList =
              list.map((e) => SupervisorInvoiceListData.fromJson(e)).toList();

          filteredList = dataList;
          transmissionList.clear();
          transmissionList.addAll(
            transmissionData
                .map<String>((e) => e["transmissionName"].toString())
                .where((name) => name != "NULL")
                .toList(),
          );
          // Store summary values
          totalMiles = (data["totalmile"] ?? "").toString();
          completedMiles = (data["completedMile"] ?? "").toString();
          circuit = (data["circuit"] ?? "").toString();
          cost = (data["cost"] ?? "").toString();
          isError = false;
        });
        print("Total Miles: $totalMiles");
        print("Completed Miles: $completedMiles");
        print("Circuit: $circuit");
        print("Cost: $cost");
        print(data["success"]);

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

          return (item.mAINTTYPE ?? "")
                  .toString()
                  .toLowerCase()
                  .contains(searchText) ||
              (item.tYPE ?? "").toString().toLowerCase().contains(searchText) ||
              (item.tOKENNO ?? "")
                  .toString()
                  .toLowerCase()
                  .contains(searchText) ||
              (item.sUBSTATIONNAME ?? "")
                  .toString()
                  .toLowerCase()
                  .contains(searchText) ||
              (item.fDRNAME ?? "")
                  .toString()
                  .toLowerCase()
                  .contains(searchText) ||
              // (item.contractor ?? "")
              //     .toString()
              //     .toLowerCase()
              //     .contains(searchText) ||
              (item.tOTALMILES ?? "")
                  .toString()
                  .toLowerCase()
                  .contains(searchText) ||
              (item.cONTRACTYEAR ?? "")
                  .toString()
                  .toLowerCase()
                  .contains(searchText) ||
              // (item.contractorCompany ?? "")
              //     .toString()
              //     .toLowerCase()
              //     .contains(searchText) ||
              // (item.cYCLE ?? "")
              //     .toString()
              //     .toLowerCase()
              //     .contains(searchText) ||
              // (item.totalCost ?? "")
              //     .toString()
              //     .toLowerCase()
              //     .contains(searchText) ||

              (item.nEXTMAINTDUE ?? "")
                  .toString()
                  .toLowerCase()
                  .contains(searchText);
        }).toList();
      });
    }
  }

  void showCrewDialog(BuildContext context, String tokenNo) async {
    await fetchCrewList(); // Fetch crew list before showing the dialog

    String? selectedCrew; // Local state for dropdown selection
    //   String? errorMessage; // To show validation error message

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
                        style: const TextStyle(fontWeight: FontWeight.bold)),
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
                              borderSide:
                                  BorderSide(color: Colors.grey.shade400),
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
                              //     errorMessage = "Please select a crew.";
                            });
                            return;
                          }
                          updateFlagValue(tokenNo, selectedCrew.toString());
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

  Widget _buildDialogButton(BuildContext context,
      {required String text,
      required Color color,
      required VoidCallback onTap}) {
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
                color: AppColors.buttonShadow,
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

  Future<void> updateFlagValue(String token, String selectedCrew) async {
    String url = "${AppUrl.distributionIVMShareApi}?token=$token&flag=2";
    // 'https://atsdev2test.ariespro.com/civmapi/vma_row_custom_main_plan/distributionIVMShareApi?token=$token&flag=2';
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
            'Job no: $token  Successfully Shared with $selectedCrew', context);
        print('Job no: $token  Successfully Shared with $selectedCrew');
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

    // final userPreferences = Provider.of<UserPref>(context, listen: false);
//       UserModel userData = await userPreferences.getUser();
    String userType = "5";
    String url =
        "${AppUrl.getAllSupervisorsAndContractors}?userType=${userType}";
    print('fetchcrewlist url $url');

    try {
      final userPreferences = Provider.of<UserPref>(context, listen: false);
      UserModel data = await userPreferences.getUser();
      final response = await http.get(
        Uri.parse(url),
        headers: {"Authorization": 'Bearer ${data.token!}'},
      );

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

  //////////////////////////image code////////////////////////
  Future openDialogPicture(String tokenNo) => showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            int length = imageViewModel.imageData.data?.images?.length ?? 0;

            return AlertDialog(
              content: Container(
                width: MediaQuery.of(context).size.width * 0.99,
                padding: const EdgeInsets.only(top: 8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (length == 0)
                        const Center(
                          child: Text(
                            "No image found!",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.baseColor,
                            ),
                          ),
                        )
                      else
                        for (int i = 0; i < length; i += 2)
                          Row(
                            children: [
                              if (i < length) ...[
                                buildImageWidget(i, tokenNo.toString()),
                              ],
                              if (i + 1 < length) ...[
                                // const SizedBox(width: 8),
                                buildImageWidget(i + 1, tokenNo.toString()),
                              ],
                            ],
                          ),
                    ],
                  ),
                ),
              ),
            );
          });
        },
      );
  Widget buildImageWidget(int i, String tokenNo) {
    String? fileLocation =
        imageViewModel.imageData.data?.images![i].imageLocation;

    bool isVideo(String file) {
      return file.endsWith('.mp4') || file.endsWith('.mov');
    }

    return Expanded(
      child: (fileLocation != null)
          ? Container(
              //  margin: const EdgeInsets.only(top:8, bottom:8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
              ),
              child: Stack(
                children: [
                  if (isPDF(fileLocation))
                    Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => PDFViewer(
                                  pdfUrl:
                                      'https://pemccivm.ariespro.com/assets/clientuploads/$fileLocation')));
                        },
                        child: Image.asset(
                          'assets/pdflogo.jpg',
                          height: 150,
                          width: 150,
                        ),
                      ),
                    )
                  else if (isVideo(fileLocation))
                    InkWell(
                        onTap: () {
                          openFullSizeVideoDialog(fileLocation);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              5), // Optional rounded corners
                          child: SizedBox(
                            height: 150,
                            width: double.infinity,
                            child: VideoPlayerWidget(
                              videoUrl:
                                  'https://pemccivm.ariespro.com/assets/clientuploads/$fileLocation',
                            ),
                          ),
                        ))
                  else
                    InkWell(
                      onTap: () {
                        openFullSizeImageDialog(fileLocation);
                      },
                      child: Image.network(
                        'https://pemccivm.ariespro.com/assets/clientuploads/$fileLocation',
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            if (!isPDF(fileLocation)) {
                              downloadFile(
                                  'https://pemccivm.ariespro.com/assets/clientuploads/$fileLocation',
                                  'File',
                                  context);
                              Navigator.pop(context);
                            } else {
                              downloadFile(
                                  'https://pemccivm.ariespro.com/assets/clientuploads/$fileLocation',
                                  'PDF',
                                  context);
                              Navigator.pop(context);
                            }
                          },
                          child: const Icon(
                            Icons.download,
                            color: Colors.blue,
                            size: 20,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            deleteOnlineImageApi2(fileLocation, tokenNo);
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : const Center(
              child: Text(
                "NO IMAGE",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.baseColor,
                ),
              ),
            ),
    );
  }

  bool isPDF(String fileLocation) {
    return fileLocation.toLowerCase().endsWith('.pdf');
  }

  void openFullSizeVideoDialog(String videoUrl) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          child: FullScreenVideoPlayer(videoUrl: videoUrl),
        );
      },
    );
  }

  void openFullSizeImageDialog(String imageUrl) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          child: Stack(
            children: [
              PhotoViewGallery(
                pageController: PageController(),
                backgroundDecoration: const BoxDecoration(
                  color: Colors.black,
                ),
                onPageChanged: (index) {},
                scrollPhysics: const BouncingScrollPhysics(),
                pageOptions: [
                  PhotoViewGalleryPageOptions(
                    imageProvider: NetworkImage(
                      'https://pemccivm.ariespro.com/assets/clientuploads/$imageUrl',
                    ),
                    minScale: PhotoViewComputedScale.contained * 0.5,
                    maxScale: PhotoViewComputedScale.covered * 0.5,
                  ),
                ],
              ),
              Positioned(
                top: 30,
                right: 20,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> deleteOnlineImageApi2(String fileName, String tokenNo) async {
    final apiUrl =
        'https://atsdev2test.ariespro.com/civmapi/changeOrderLcpCreateOrder/deleteFile?fileName=$fileName&tokenNo=$tokenNo';
    print(apiUrl);
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();

    try {
      final response = await http.delete(
        Uri.parse(apiUrl),
        headers: {"Authorization": 'Bearer ${data.token!}'},
      );

      if (response.statusCode == 200) {
        print('API response: ${response.body}');
        setState(() {});
        print('Image deleted successfully');
        CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
            'Image deleted Successfully', context);
        // Navigator.pop(context);
        await Future.delayed(const Duration(seconds: 2));

        fetchData();
      } else {
        print('API request failed with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

/////////////////////////////////////////////////////
  Future<void> downloadInvoice(
      String tokenNo, String milesCompleted, String month, String year, String buttonPressed,) async {
    try {
      await requestPermission();

      final url = Uri.parse(
          "${AppUrl.baseUrl}DownloadInvoice?tokenNo=$tokenNo&milesCompleted=$milesCompleted&month=$month&year=$year");
      final userPreferences = Provider.of<UserPref>(context, listen: false);
      UserModel data = await userPreferences.getUser();
      print('download invoice $url');
      final response = await http.get(
        url,
        headers: {"Authorization": 'Bearer ${data.token!}'},
      );
      print('response.statusCode ${response.statusCode}');
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;

        Directory? directory;
     if (buttonPressed == 'DOWNLOAD') {
        if (Platform.isAndroid) {
          // Downloads folder in Android
          directory = Directory('/storage/emulated/0/Download');
          // directory = await getExternalStorageDirectory();
        } else {
          directory = await getApplicationDocumentsDirectory();
        }
    } else if (buttonPressed == 'VIEW') {
          directory = await getTemporaryDirectory();
    }
        final filePath = "${directory!.path}/invoice_$tokenNo.pdf";
        final file = File(filePath);

        await file.writeAsBytes(bytes);

        if (buttonPressed == 'DOWNLOAD') {
          print("File saved at: $filePath");
          CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
            'File saved at: $filePath',
            context,
          );
        }

        // Open file
        await Future.delayed(const Duration(seconds: 3));
        await OpenFile.open(filePath);
      } else {
        print("Failed to download file");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      if (mounted) {
      }
    }
  }

  Future<void> requestPermission() async {
    if (await Permission.storage.request().isGranted) {
      print("Permission granted");
    } else {
      print("Permission denied");
    }
  }

  void showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return Dialog(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, top: 16, right: 10.0, bottom: 10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.close,
                                color: Colors.red,
                              ))),

                      const SizedBox(height: 10),
                      textWithOutStar("Select Year"),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.baseColor,
                          ),
                        ),
                        child: DropdownButtonFormField<String>(
                          hint: const Text('Select Year'),
                          value: selectedYear,
                          style: const TextStyle(
                              color: AppColors.baseColor, fontSize: 18),
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: AppColors.baseColor,
                            size: 30,
                          ),
                          decoration: InputDecoration(
                            // labelText: "Select Duration",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding: const EdgeInsets.all(10),
                            enabledBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent)),
                            focusedBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent)),
                          ),
                          items: yearsList.map((year) {
                            return DropdownMenuItem(
                              value: year,
                              child: Text(year),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setStateDialog(() {
                              selectedYear = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 10),

                      /// Monthly Fields

                      textWithOutStar("Select Months"),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.baseColor,
                          ),
                        ),
                        child: MultiSelectDialogField(
                          items: monthsList
                              .map((e) => MultiSelectItem(e, e))
                              .toList(),
                          title: const Text("Months"),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.transparent,
                            ),
                          ),
                          buttonText: const Text("Select Months"),
                          buttonIcon: const Icon(
                            Icons.arrow_drop_down,
                            color: AppColors.baseColor,
                            size: 30,
                          ),
                          listType: MultiSelectListType.CHIP,
                          initialValue: selectedMonths,
                          onConfirm: (values) {
                            selectedMonths = values.cast<String>();
                            this.month = values.join(',');
                            monthh = month!.split(',');
                            print(monthh.length);
                            print(month);
                            monthnumber();
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      textWithOutStar("Select Transmission Name"),
                      // Container(
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(10),
                      //     border: Border.all(
                      //       color: AppColors.baseColor,
                      //     ),
                      //   ),
                      //   child: DropdownButtonFormField<String>(
                      //     isExpanded: true,
                      //     hint: const Text('Select Transmission Name'),
                      //     value: selectedTransmissionName,
                      //     style: const TextStyle(
                      //         color: AppColors.baseColor, fontSize: 18),
                      //     icon: const Icon(
                      //       Icons.arrow_drop_down,
                      //       color: AppColors.baseColor,
                      //       size: 30,
                      //     ),
                      //     decoration: InputDecoration(
                      //       // labelText: "Select Duration",
                      //       border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(10),
                      //       ),
                      //       contentPadding: const EdgeInsets.all(10),
                      //       enabledBorder: const UnderlineInputBorder(
                      //           borderSide:
                      //               BorderSide(color: Colors.transparent)),
                      //       focusedBorder: const UnderlineInputBorder(
                      //           borderSide:
                      //               BorderSide(color: Colors.transparent)),
                      //     ),
                      //     items: transmissionList.map((trans) {
                      //       return DropdownMenuItem<String>(
                      //         value: trans,
                      //         child: Text(trans),
                      //       );
                      //     }).toList(),
                      //     onChanged: (value) {
                      //       setStateDialog(() {
                      //         selectedTransmissionName = value;
                      //       });
                      //     },
                      //   ),
                      // ),
     Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.baseColor,
                          ),
                        ),
                        child: MultiSelectDialogField<String>(
                          items: transmissionList
                              .map((trans) =>
                                  MultiSelectItem<String>(trans, trans))
                              .toList(),
                          title: const Text("Select Transmission Name",style: TextStyle(fontSize: 18),),
                          buttonText: const Text(
                            "Select Transmission Name",
                            style: TextStyle(
                              color: AppColors.baseColor,
                            ),
                          ),
                          buttonIcon: const Icon(
                            Icons.arrow_drop_down,
                            color: AppColors.baseColor,
                            size: 30,
                          ),
                          searchable: true,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          itemsTextStyle: const TextStyle(
                            fontSize: 16,
                          ),
                          listType: MultiSelectListType.CHIP,
                          initialValue: selectedTransmissionNames,
                          onConfirm: (values) {
                            setStateDialog(() {
                              selectedTransmissionNames = values;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 10),

                      /// Yearly Fields

                      const SizedBox(height: 10),
                      Center(
                        child: CustomButton(
                            label: "Submit",
                            onTap: () {
                              myFuture = fetchData();

                              Navigator.pop(context);
                            },
                            showGradientColor: true),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void monthnumber() {
    selectedmonth.clear();
    print(monthh.length);
    for (int i = 0; i < monthh.length; i++) {
      var m;
      if (monthh[i] == 'Jan') {
        m = '01';
      } else if (monthh[i] == 'Feb') {
        m = '02';
      } else if (monthh[i] == 'Mar') {
        m = '03';
      } else if (monthh[i] == 'Apr') {
        m = '04';
      } else if (monthh[i] == 'May') {
        m = '05';
      } else if (monthh[i] == 'Jun') {
        m = '06';
      } else if (monthh[i] == 'Jul') {
        m = '07';
      } else if (monthh[i] == 'Aug') {
        m = '08';
      } else if (monthh[i] == 'Sep') {
        m = '09';
      } else if (monthh[i] == 'Oct') {
        m = '10';
      } else if (monthh[i] == 'Nov') {
        m = '11';
      } else if (monthh[i] == 'Dec') {
        m = '12';
      }

      selectedmonth.add(m);
      print('11selectedmonth${selectedmonth}');
      print('selectedmonthString ${selectedmonth.join(',')}');
      selectedmonthString = "${selectedmonth.join(',')}";
      // minmonth = selectedmonth[0];

      // maxmonth = selectedmonth[selectedmonth.length - 1];
      // print('minmonthnew${minmonth},${maxmonth}');
    }
  }
}
