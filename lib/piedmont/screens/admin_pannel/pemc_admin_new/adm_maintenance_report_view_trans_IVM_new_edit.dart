import 'dart:io';

import 'package:CIVM/piedmont/models/distribution_ivm_ready_for_review_edit_model.dart';
import 'package:CIVM/piedmont/resources/app_colors.dart';
import 'package:CIVM/piedmont/resources/app_url.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/pemc_admin_new/inspection_zielies.dart';
import 'package:CIVM/piedmont/screens/my_chrome_safari_map_recording.dart';
import 'package:CIVM/piedmont/utils/common_functions.dart';
import 'package:CIVM/piedmont/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/piedmont/utils/work_progress_api.dart';
import 'package:CIVM/piedmont/view_model/image_code_view_model.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class AdmTransIvmReadyForReviewEdit extends StatefulWidget {
  String jobNo;
  String year;
  String cycle;
  String transName;
  // String feeder;
  String totalMiles;
  String milesCompleted;
  String milesInProgress;
  String milesPending;
  String lastUpdatedDate;
   String checkPendingStatus;
  AdmTransIvmReadyForReviewEdit(
      {super.key,
      required this.jobNo,
      required this.year,
      required this.cycle,
      required this.transName,
      // required this.feeder,
      required this.totalMiles,
      required this.milesCompleted,
      required this.milesInProgress,
      required this.milesPending,
      required this.lastUpdatedDate,
      required this.checkPendingStatus});

  @override
  State<AdmTransIvmReadyForReviewEdit> createState() =>
      _AdmTransIvmReadyForReviewEditState();
}

class _AdmTransIvmReadyForReviewEditState
    extends State<AdmTransIvmReadyForReviewEdit> with TickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  final TextEditingController _totalMiles = TextEditingController();
  final TextEditingController _milesCompleted = TextEditingController();
  final TextEditingController _milesInProgress = TextEditingController();
  final TextEditingController _milesPending = TextEditingController();
  final TextEditingController _jobNo = TextEditingController();
  final List<Color> containerColors = [
    const Color.fromARGB(255, 252, 231, 238),
    const Color.fromARGB(255, 226, 246, 253),
    const Color.fromARGB(255, 212, 249, 212),
    const Color.fromARGB(255, 251, 251, 215),
    const Color.fromARGB(255, 251, 239, 251),
  ];

  Future? myFuture;
  List<DistributionIvmReadyforreviewEditModelData> dataList = [];
  List<DistributionIvmReadyforreviewEditModelData> filteredList = [];
  String auditId = '';
  String accountNumber = '';
  String status = '';
  bool isError = false;
  bool isLoading = false;

  bool _isVisibleUploadingButton = false;
  bool _isVisibleUploadButton = true;
  String? rights;
  var _setState;
  List<String> imagePaths = [];
  List<XFile> images = [];
  late List<CameraDescription> _cameras;
  late CameraController _camerasController;
  final browser = MyChromeSafariBrowser();
  ImageViewViewModel imageViewModel = ImageViewViewModel();
  bool isApproveAll = false;
  bool isRejectAll = false;
  String buttonText = "";
  @override
  void initState() {
    cameraInit();
    getInitData();
    myFuture = fetchData();
    super.initState();
  }

  @override
  void dispose() {
    if (_camerasController.value.isInitialized) {
      _camerasController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Transmission IVM Inspection Status',
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
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              left: 8, right: 8, top: 10, bottom: 8),
                          padding: const EdgeInsets.all(8),
                          alignment: Alignment.center,
                          width: size.width * 0.99,
                          decoration: BoxDecoration(
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
                              // Container(
                              //   padding: const EdgeInsets.all(10),
                              //   alignment: Alignment.center,
                              //   width: size.width * 0.99,
                              //   decoration: const BoxDecoration(
                              //       boxShadow: [
                              //         BoxShadow(
                              //             color: AppColors.buttonShadow,
                              //             blurRadius: 5,
                              //             offset: Offset(2.0, 5.0))
                              //       ],
                              //       color:
                              //           Color.fromARGB(255, 130, 193, 245),
                              //       gradient: LinearGradient(
                              //         colors: [
                              //           AppColors.baseColor,
                              //           AppColors.buttonOrange,
                              //           AppColors.baseColor,
                              //         ],
                              //       )),
                              //   child: const Row(children: [
                              //     Align(
                              //       alignment: Alignment.centerLeft,
                              //       child: Text(
                              //         "Search Option",
                              //         textAlign: TextAlign.left,
                              //         style: TextStyle(
                              //           color: Colors.white,
                              //           fontWeight: FontWeight.bold,
                              //           fontSize: 20,
                              //         ),
                              //       ),
                              //     ),
                              //   ]),
                              // ),

                              const Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Job No",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: AppColors.baseColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),

                              Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: TextFormField(
                                    enabled: false,
                                    controller: _jobNo,
                                    style: const TextStyle(
                                        color: AppColors.baseColor,
                                        fontSize: 16),
                                    obscureText: false,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppColors.baseColor,
                                        ),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppColors.baseColor,
                                        ),
                                        // borderRadius:
                                        // BorderRadius.circular(25),
                                      ),
                                      hintText: 'Job No',
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please enter Job No.";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.only(
                                left: 8, right: 8, top: 10, bottom: 8),
                            padding: const EdgeInsets.all(8),
                            alignment: Alignment.center,
                            // height: size.height * 0.5,
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
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  alignment: Alignment.center,
                                  width: size.width * 0.99,
                                  // width: MediaQuery.of(context).size.width,
                                  // height: 40,
                                  decoration: const BoxDecoration(
                                      // shape: BoxShape.circle,
                                      //borderRadius: BorderRadius.circular(25),
                                      boxShadow: [
                                        BoxShadow(
                                            color: AppColors.buttonShadow,
                                            blurRadius: 5,
                                            offset: Offset(2.0, 5.0))
                                      ],
                                      color: Color.fromARGB(255, 130, 193, 245),
                                      gradient: LinearGradient(
                                        colors: [
                                          AppColors.baseColor,
                                          AppColors.buttonOrange,
                                          AppColors.baseColor,
                                        ],
                                      )),
                                  child: const Row(children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Prev Progress",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ]),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 20.0, left: 4),
                                  child: Row(
                                    children: [
                                      const Text(
                                        "Last Updated At: ",
                                        //textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        widget.lastUpdatedDate,
                                        //textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),

                                      // Text(
                                      //   (contractorRowMaintenanceProgressViewModelViewModel
                                      //                   .contractorRowMaintenanceProgressViewModelGetTabularData
                                      //                   .data!
                                      //                   .findLastMaintDone![
                                      //                       0]
                                      //                   .lastUpdated ==
                                      //               null ||
                                      //           contractorRowMaintenanceProgressViewModelViewModel
                                      //               .contractorRowMaintenanceProgressViewModelGetTabularData
                                      //               .data!
                                      //               .findLastMaintDone![0]
                                      //               .lastUpdated!
                                      //               .isEmpty ||
                                      //           contractorRowMaintenanceProgressViewModelViewModel
                                      //                   .contractorRowMaintenanceProgressViewModelGetTabularData
                                      //                   .data!
                                      //                   .findLastMaintDone![
                                      //                       0]
                                      //                   .lastUpdated
                                      //                   .toString() ==
                                      //               'null')
                                      //       ? ''
                                      //       // : formattedDate,
                                      //       : contractorRowMaintenanceProgressViewModelViewModel
                                      //           .contractorRowMaintenanceProgressViewModelGetTabularData
                                      //           .data!
                                      //           .findLastMaintDone![0]
                                      //           .lastUpdated
                                      //           .toString(),
                                      //   //textAlign: TextAlign.left,
                                      //   style: const TextStyle(
                                      //     color: Colors.red,
                                      //     fontWeight: FontWeight.bold,
                                      //     fontSize: 18,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      textSpanRow("Year", widget.year),
                                      textSpanRow("Cycle", widget.cycle),
                                      textSpanRow("Transmission Name",
                                          widget.transName),
                                    ],
                                  ),
                                ),
                                // Padding(
                                //   padding:
                                //       const EdgeInsets.only(top: 20.0, left: 4),
                                //   child: Row(
                                //     children: [
                                //       const Text(
                                //         "Cycle: ",
                                //         style: TextStyle(
                                //           color: AppColors.baseColor,
                                //           fontWeight: FontWeight.bold,
                                //           fontSize: 18,
                                //         ),
                                //       ),
                                //       Text(
                                //         widget.cycle,
                                //         style: const TextStyle(
                                //           color: AppColors.baseColor,
                                //           fontWeight: FontWeight.bold,
                                //           fontSize: 18,
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                // Padding(
                                //   padding:
                                //       const EdgeInsets.only(top: 20.0, left: 4),
                                //   child: Row(
                                //     children: [
                                //       const Text(
                                //         "Substation: ",
                                //         //textAlign: TextAlign.left,
                                //         style: TextStyle(
                                //           color: AppColors.baseColor,
                                //           fontWeight: FontWeight.bold,
                                //           fontSize: 18,
                                //         ),
                                //       ),
                                //       Text(
                                //         widget.substation,
                                //         // widget.substation,
                                //         // globalSubstation,
                                //         style: const TextStyle(
                                //           color: AppColors.baseColor,
                                //           fontWeight: FontWeight.bold,
                                //           fontSize: 18,
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                // Padding(
                                //   padding:
                                //       const EdgeInsets.only(top: 20.0, left: 4),
                                //   child: Row(
                                //     children: [
                                //       const Text(
                                //         "Feeder: ",
                                //         //textAlign: TextAlign.left,
                                //         style: TextStyle(
                                //           color: AppColors.baseColor,
                                //           fontWeight: FontWeight.bold,
                                //           fontSize: 18,
                                //         ),
                                //       ),
                                //       Text(
                                //         widget.feeder,
                                //         //  widget.feeder,
                                //         // globalFeeder,
                                //         style: const TextStyle(
                                //           color: AppColors.baseColor,
                                //           fontWeight: FontWeight.bold,
                                //           fontSize: 18,
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                Column(
                                  children: [
                                    const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 2.0,
                                              right: 2.0,
                                              bottom: 2.0,
                                              top: 20.0),
                                          child: Text(
                                            "TOTAL MILES",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: AppColors.baseColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: TextFormField(
                                          enabled: false,
                                          //key: formkey4,
                                          controller: _totalMiles,
                                          style: const TextStyle(
                                              color: AppColors.baseColor,
                                              fontSize: 16),
                                          obscureText: false,
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(
                                                // borderRadius:
                                                // BorderRadius.circular(25),
                                                ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: AppColors.baseColor,
                                              ),
                                              // borderRadius:
                                              // BorderRadius.circular(25),
                                            ),
                                            disabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: AppColors.baseColor,
                                              ),
                                              // borderRadius:
                                              // BorderRadius.circular(25),
                                            ),
                                            hintText: 'TOTAL MILES',
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Please enter Total Miles";
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                    const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 2.0,
                                              right: 2.0,
                                              bottom: 2.0,
                                              top: 20.0),
                                          child: Text(
                                            "MILES COMPLETED",
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              color: AppColors.baseColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: TextFormField(
                                          enabled: false,
                                          //key: formkey4,
                                          controller: _milesCompleted,
                                          style: const TextStyle(
                                              color: AppColors.baseColor,
                                              fontSize: 16),
                                          obscureText: false,
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(
                                                // borderRadius:
                                                // BorderRadius.circular(25),
                                                ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: AppColors.baseColor,
                                              ),
                                              // borderRadius:
                                              // BorderRadius.circular(25),
                                            ),
                                            disabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: AppColors.baseColor,
                                              ),
                                              // borderRadius:
                                              // BorderRadius.circular(25),
                                            ),
                                            hintText: 'Miles Completed',
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Please enter Miles Completed";
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                    const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 2.0,
                                              right: 2.0,
                                              bottom: 2.0,
                                              top: 20.0),
                                          child: Text(
                                            "MILES IN PROGRESS",
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              color: AppColors.baseColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: TextFormField(
                                          enabled: false,
                                          //key: formkey4,
                                          controller: _milesInProgress,
                                          style: const TextStyle(
                                              color: AppColors.baseColor,
                                              fontSize: 16),
                                          obscureText: false,
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(
                                                // borderRadius:
                                                // BorderRadius.circular(25),
                                                ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: AppColors.baseColor,
                                              ),
                                              // borderRadius:
                                              // BorderRadius.circular(25),
                                            ),
                                            disabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: AppColors.baseColor,
                                              ),
                                              // borderRadius:
                                              // BorderRadius.circular(25),
                                            ),
                                            hintText: 'Miles In Progress',
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Please enter Miles In Progress";
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                    const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 2.0,
                                              right: 2.0,
                                              bottom: 2.0,
                                              top: 20.0),
                                          child: Text(
                                            "MILES PENDING",
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              color: AppColors.baseColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: TextFormField(
                                          enabled: false,
                                          // key: formkey5,
                                          controller: _milesPending,
                                          style: const TextStyle(
                                              color: AppColors.baseColor,
                                              fontSize: 16),
                                          obscureText: false,
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(
                                                // borderRadius:
                                                // BorderRadius.circular(25),
                                                ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: AppColors.baseColor,
                                              ),
                                              // borderRadius:
                                              // BorderRadius.circular(25),
                                            ),
                                            disabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: AppColors.baseColor,
                                              ),
                                              // borderRadius:
                                              // BorderRadius.circular(25),
                                            ),
                                            hintText: 'Miles Pending',
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Please enter Miles Pending";
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                 
                                  TotalMilesProgressCard(jobNo: widget.jobNo),
                            
  WorkProgressBySpan(jobNo: widget.jobNo),

  WorkProgressByMiles(jobNo: widget.jobNo), ],
                                ),
                              ],
                            )),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 8, right: 8, top: 10, bottom: 8),
                          padding: const EdgeInsets.all(8),
                          alignment: Alignment.center,
                          height: size.height * 0.5,
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
                              // Padding(
                              //   padding: const EdgeInsets.only(top: 8.0),
                              //   child: Align(
                              //     alignment: Alignment.bottomLeft,
                              //     child: Text(
                              //       "TOTAL NO OF RECORDS : ${dataList.length.toString()}",
                              //       style: const TextStyle(
                              //           fontSize: 16,
                              //           color: AppColors.baseColor,
                              //           fontWeight: FontWeight.bold),
                              //     ),
                              //   ),
                              // ),
                              // Row(
                              //   children: [
                              //     Expanded(
                              //       child: Align(
                              //         alignment: Alignment.centerRight,
                              //         child: Padding(
                              //           padding: const EdgeInsets.only(
                              //               left: 4.0, right: 4.0, top: 4, bottom: 4),
                              //           child: TextFormField(
                              //             controller: searchController,
                              //             onChanged: (value) =>
                              //                 filterData(value), // 👈 important
                              //             style: const TextStyle(
                              //                 color: AppColors.baseColor,
                              //                 fontSize: 16),
                              //             obscureText: false,

                              //             // keyboardType: TextInputType.number,
                              //             decoration: const InputDecoration(
                              //               border: OutlineInputBorder(),
                              //               enabledBorder: OutlineInputBorder(
                              //                 borderSide: BorderSide(
                              //                   color: Color.fromARGB(255, 23, 1, 88),
                              //                 ),
                              //                 // borderRadius:
                              //                 //     BorderRadius.circular(25),
                              //               ),
                              //               hintText: 'Search your input...',
                              //             ),
                              //             validator: (value) {
                              //               if (value!.toString == 'null') {
                              //                 return "Please search your input";
                              //               } else {
                              //                 return null;
                              //               }
                              //             },
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),

                              Expanded(
                                child: ListView.builder(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  itemCount: filteredList.length,
                                  itemBuilder: (BuildContext ctxt, int index) {
                                    var item = filteredList[index];
                                    return Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(4),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.9,
                                            padding: const EdgeInsets.all(8),
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
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
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
                                                                "SERIAL: ",
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 12,
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
                                                              child: Text(
                                                                (index + 1)
                                                                    .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 12,
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
                                                      // Expanded(
                                                      //   flex: 2,
                                                      //   // alignment: Alignment.topLeft,
                                                      //   child: Column(
                                                      //     children: [
                                                      //       const Align(
                                                      //         alignment:
                                                      //             Alignment
                                                      //                 .topLeft,
                                                      //         child: Text(
                                                      //           "ACTION: ",
                                                      //           textAlign:
                                                      //               TextAlign
                                                      //                   .left,
                                                      //           style:
                                                      //               TextStyle(
                                                      //             fontSize: 12,
                                                      //             fontWeight:
                                                      //                 FontWeight
                                                      //                     .bold,
                                                      //             color: Colors
                                                      //                 .white,
                                                      //           ),
                                                      //         ),
                                                      //       ),
                                                      //       (rights !=
                                                      //               "READ ONLY")
                                                      //           ? (item.sTATUS
                                                      //                       .toString() ==
                                                      //                   "PENDING")
                                                      //               ? Row(
                                                      //                   children: [
                                                      //                     InkWell(
                                                      //                       onTap:
                                                      //                           () async {
                                                      //                         // /////////////needed update commented only  for testing dailog////////////////
                                                      //                         approveUploadApi(
                                                      //                             'APPROVED',
                                                      //                             widget.jobNo,
                                                      //                             item.iD.toString(),
                                                      //                             // item.sepId
                                                      //                             //     .toString(),
                                                      //                             // item.budgetType
                                                      //                             //     .toString(),
                                                      //                             index);
                                                      //                       },
                                                      //                       child:
                                                      //                           approveButton(),
                                                      //                     ),
                                                      //                     Padding(
                                                      //                       padding:
                                                      //                           const EdgeInsets.only(left: 8.0, right: 8),
                                                      //                       child:
                                                      //                           InkWell(
                                                      //                         onTap: () async {
                                                      //                           rejectApi(
                                                      //                             'REJECTED',
                                                      //                             widget.jobNo,
                                                      //                             item.iD.toString(),
                                                      //                           );
                                                      //                         },
                                                      //                         child: rejectButton(),
                                                      //                       ),
                                                      //                     ),
                                                      //                   ],
                                                      //                 )
                                                      //               : SizedBox()
                                                      //           : SizedBox(),
                                                      //     ],
                                                      //   ),
                                                      // ),
                                                    
                                                    ],
                                                  ),
                                                ),
                                                const Divider(
                                                  color: Colors.grey,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
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
                                                                "TRANSMISSION NAME: ",
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 12,
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
                                                              child: Text(
                                                                item.tRANSMISSIONNAME
                                                                    .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 12,
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
                                                                "STATUS: ",
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 12,
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
                                                              child: Text(
                                                                item.sTATUS
                                                                    .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 12,
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
                                                                "ROW METHOD: ",
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 12,
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
                                                              child: Text(
                                                                item.rOWMETHOD
                                                                    .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 12,
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
                                                      const EdgeInsets.only(
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
                                                                "TOTAL MILES: ",
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 12,
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
                                                              child: Text(
                                                                item.tOTALMILES
                                                                    .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 12,
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
                                                                "MILES COMPLETED: ",
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 12,
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
                                                              child: Text(
                                                                item.mILESCOMPLETED
                                                                    .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 12,
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
                                                        //  flex: 2,
                                                        // alignment: Alignment.topLeft,
                                                        child: Column(
                                                          children: [
                                                            const Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              child: Text(
                                                                "DATE TIME: ",
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 12,
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
                                                              child: Text(
                                                                item.cREATEDATE
                                                                    .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 12,
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
                                                      const EdgeInsets.only(
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
                                                                "DELAY CAUSE: ",
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
                                                                        .white),
                                                              ),
                                                            ),
                                                            Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              child: Text(
                                                                item.dELAYCAUSE
                                                                    .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 12,
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
                                                                "DELAY REASON: ",
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 12,
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
                                                              child: Text(
                                                                item.dELAYREASON
                                                                    .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 12,
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
                                                                "EFFECTED NO OF DAYS: ",
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 12,
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
                                                              child: Text(
                                                                item.eFFECTEDNOOFDAYS
                                                                    .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 12,
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
                                                Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
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
                                                                    "NOTES: ",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style:
                                                                        TextStyle(
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
                                                                  child: Text(
                                                                    item.nOTES
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
                                                  ],
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
                        //   if(widget.checkPendingStatus=="True")
                        // Padding(
                        //   padding: const EdgeInsets.only(
                        //       top: 12, bottom: 12, left: 12, right: 12),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       GestureDetector(
                        //         onTap: () {
                        //           setState(() {
                        //             isApproveAll = true;
                        //             buttonText = "approve all";
                        //           });
                        //           approveRejectAllApi("APPROVED", widget.jobNo);
                        //         },
                        //         child: Container(
                        //           padding: const EdgeInsets.all(4),
                        //           width: 130,
                        //           height: 40,
                        //           decoration: BoxDecoration(
                        //             color: Colors.green,
                        //             borderRadius: BorderRadius.circular(12),
                        //             boxShadow: [
                        //               BoxShadow(
                        //                 color: Colors.green.withOpacity(0.3),
                        //                 blurRadius: 6,
                        //                 offset: const Offset(0, 3),
                        //               ),
                        //             ],
                        //           ),
                        //           alignment: Alignment.center,
                        //           child: isApproveAll
                        //               ? progressBar()
                        //               : Text(
                        //                   "APPROVE ALL",
                        //                   style: TextStyle(
                        //                     color: Colors.white,
                        //                     fontWeight: FontWeight.bold,
                        //                   ),
                        //                 ),
                        //         ),
                        //       ),
                        //       const SizedBox(width: 10),
                        //       GestureDetector(
                        //         onTap: () {
                        //           setState(() {
                        //             isRejectAll = true;
                        //           });
                        //           approveRejectAllApi("REJECTED", widget.jobNo);
                        //         },
                        //         child: Container(
                        //           padding: const EdgeInsets.all(4),
                        //           width: 130,
                        //           height: 40,
                        //           decoration: BoxDecoration(
                        //             color: Colors.red,
                        //             borderRadius: BorderRadius.circular(12),
                        //             boxShadow: [
                        //               BoxShadow(
                        //                 color: Colors.red.withOpacity(0.3),
                        //                 blurRadius: 6,
                        //                 offset: const Offset(0, 3),
                        //               ),
                        //             ],
                        //           ),
                        //           alignment: Alignment.center,
                        //           child: isRejectAll
                        //               ? progressBar()
                        //               : Text(
                        //                   "REJECT ALL",
                        //                   style: TextStyle(
                        //                     color: Colors.white,
                        //                     fontWeight: FontWeight.bold,
                        //                   ),
                        //                 ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                    
                      ],
                    ),
                  ),
                ));
          },
        ),
      ),
    );
  }

  Widget textSpanRow(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 4),
      child: Text.rich(
        TextSpan(
          text: "$title: ",
          style: const TextStyle(
            fontSize: 18,
            color: AppColors.baseColor,
            fontWeight: FontWeight.bold,
          ),
          children: [
            TextSpan(
                text: content,
                style: TextStyle(
                  fontWeight: FontWeight.normal,

                  // color: Colors.red,
                )),
          ],
        ),
      ),
      // Row(
      //   children: [
      //     const Text(
      //       "Year: ",
      //       style: TextStyle(
      //         color: AppColors.baseColor,
      //         fontWeight: FontWeight.bold,
      //         fontSize: 18,
      //       ),
      //     ),
      //     Text(
      //       "${widget.year}",
      //       style: const TextStyle(
      //         color: AppColors.baseColor,
      //         fontWeight: FontWeight.bold,
      //         fontSize: 18,
      //       ),
      //     ),
      //   ],
      // ),
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
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    // var id = "${data.user!.id}";
    // print('id $id');
    // int currentMonth = DateTime.now().month;
    // int currentYear = DateTime.now().year;
    var url =
        "${AppUrl.getReadyForReviewData}?status=APPROVED,PENDING,REJECTED&id=${widget.jobNo}&month=${getMonth(widget.lastUpdatedDate)}&year=${getYear(widget.lastUpdatedDate)}";
    // AppUrl.getTransmissionIVMReadyForReviewData;

    print('url111 $url');

    rights = data.user!.rights;
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

        setState(() {
          dataList = list
              .map(
                  (e) => DistributionIvmReadyforreviewEditModelData.fromJson(e))
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

          return (item.sTATUS ?? "")
              .toString()
              .toLowerCase()
              .contains(searchText);
          //||
          //     (item.type ?? "").toString().toLowerCase().contains(searchText) ||
          //     (item.tokenNo ?? "")
          //         .toString()
          //         .toLowerCase()
          //         .contains(searchText) ||
          //     (item.substation ?? "")
          //         .toString()
          //         .toLowerCase()
          //         .contains(searchText) ||
          //     (item.fdrName ?? "")
          //         .toString()
          //         .toLowerCase()
          //         .contains(searchText) ||
          //     (item.contractor ?? "")
          //         .toString()
          //         .toLowerCase()
          //         .contains(searchText) ||
          //     (item.totalMiles ?? "")
          //         .toString()
          //         .toLowerCase()
          //         .contains(searchText) ||
          //     (item.contractYear ?? "")
          //         .toString()
          //         .toLowerCase()
          //         .contains(searchText) ||
          //     (item.contractorCompany ?? "")
          //         .toString()
          //         .toLowerCase()
          //         .contains(searchText) ||
          //     (item.cycle ?? "")
          //         .toString()
          //         .toLowerCase()
          //         .contains(searchText) ||
          //     (item.totalCost ?? "")
          //         .toString()
          //         .toLowerCase()
          //         .contains(searchText) ||
          //     (item.costPerMile ?? "")
          //         .toString()
          //         .toLowerCase()
          //         .contains(searchText) ||
          //     (item.nextMaintDue ?? "")
          //         .toString()
          //         .toLowerCase()
          //         .contains(searchText);
        }).toList();
      });
    }
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

  Future openDailogApprove(
    String idLocal,
  ) =>
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return StatefulBuilder(builder: (context, setState) {
              // Size size = MediaQuery.of(context).size;
              _setState = setState;
              return AlertDialog(
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: () {
                              closeButtonApi(idLocal);
                            },
                            child: const Icon(
                              Icons.cancel,
                              color: Colors.red,
                            ),
                          )),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.all(2.0),
                              child: Text(
                                "UPDATE VEGETATION CONDITION REPORT",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: AppColors.baseColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: Column(
                          children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text(
                                    "Maintenance for this work order has been finished. Please Uplaod the image for $idLocal",
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      color: AppColors.baseColor,
                                    ),
                                  ),
                                )),
                            Row(
                              children: [
                                const Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 8.0),
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: EdgeInsets.all(2.0),
                                          child: Text(
                                            "UPLOAD IMAGE",
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: AppColors.baseColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )),
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: InkWell(
                                      onTap: () {
                                        pickImageOptions();
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            bottom: 10.0, top: 2),
                                        padding: const EdgeInsets.all(8),
                                        alignment: Alignment.center,
                                        // width: size.width * 0.5,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: const [
                                              BoxShadow(
                                                  color: AppColors.buttonShadow,
                                                  blurRadius: 5,
                                                  offset: Offset(2.0, 5.0))
                                            ],
                                            color: AppColors.baseColor,
                                            gradient: const LinearGradient(
                                              colors: [
                                                AppColors.baseColor,
                                                AppColors.buttonOrange,
                                                AppColors.baseColor,
                                              ],
                                            )),
                                        child: const Row(
                                          children: [
                                            Text(
                                              'Choose Image',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                                //fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(imagePaths.length, (index) {
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal:
                                      5), // Optional: Add margin for spacing
                              width:
                                  100, // Set a fixed width for each image/icon
                              child: Stack(
                                children: [
                                  Center(
                                    child: Image.file(
                                      File(imagePaths[index]),
                                      height: 100, // Set a height for the image
                                      width: 100, // Set a width for the image
                                      fit: BoxFit
                                          .cover, // Ensure the image covers the container without distortion
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          // Remove the image path from the list
                                          imagePaths.removeAt(index);
                                          images.removeAt(
                                              index); // Also remove from images list
                                        });
                                        // Call your API to delete the image
                                        // deleteOnlineImageApi(
                                        //     imagePaths[index],
                                        //     maintenanceReportViewViewModel
                                        //         .maintenanceReportViewGetTabularData
                                        //         .data!
                                        //         .findAllJoinDatas![index]
                                        //         .tokenNo
                                        //         .toString());
                                      },
                                      child: const Icon(Icons.delete,
                                          color: Colors.red, size: 30),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                      ),
                      Visibility(
                        visible: _isVisibleUploadButton,
                        child: Container(
                            margin: const EdgeInsets.only(
                                left: 6, right: 6, top: 20.0, bottom: 10),
                            child: InkWell(
                              onTap: () {
                                _setState(() {
                                  _isVisibleUploadingButton = true;
                                  _isVisibleUploadButton = false;
                                });

                                print(
                                    'object33333333333333333333333333333333333333');
                                print('imagePaths $imagePaths');
                                     submitImages(imagePaths, idLocal);
                                // if (imagePaths.isNotEmpty) {
                                //   print('case where image111111111111');

                                //   submitImages(imagePaths, idLocal);
                                // } else {
                                //   print(
                                //       'else case where no image111111111111111');

                                //   fetchData();
                                //   _setState(() {
                                //     _isVisibleUploadingButton = false;
                                //     _isVisibleUploadButton = true;
                                //   });
                                //   Navigator.pop(context);
                                // }
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                    left: 40, right: 40, bottom: 10.0),
                                // padding: const EdgeInsets.all(8),
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    // shape: BoxShape.circle,
                                    // borderRadius:
                                    //     BorderRadius.circular(25),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: AppColors.buttonShadow,
                                          blurRadius: 5,
                                          offset: Offset(2.0, 5.0))
                                    ],
                                    color: AppColors.buttonShadow,
                                    gradient: const LinearGradient(
                                      colors: [
                                        AppColors.baseColor,
                                        AppColors.buttonOrange,
                                        AppColors.baseColor,
                                      ],
                                    )),
                                child: const Row(children: [
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "SUBMIT",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                              ),
                            )),
                      ),
                      Visibility(
                        visible: _isVisibleUploadingButton,
                        child: Container(
                            margin: const EdgeInsets.only(
                                left: 6, right: 6, top: 20.0, bottom: 10),
                            child: Container(
                              margin: const EdgeInsets.only(
                                  left: 40, right: 40, bottom: 10.0),
                              // padding: const EdgeInsets.all(8),
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  // shape: BoxShape.circle,
                                  // borderRadius:
                                  //     BorderRadius.circular(25),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: AppColors.buttonShadow,
                                        blurRadius: 5,
                                        offset: Offset(2.0, 5.0))
                                  ],
                                  color: AppColors.buttonShadow,
                                  gradient: const LinearGradient(
                                    colors: [
                                      AppColors.baseColor,
                                      AppColors.buttonOrange,
                                      AppColors.baseColor,
                                    ],
                                  )),
                              child: const Row(children: [
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "SUBMITTING...",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                            )),
                      ),
                    ],
                  ),
                ),
              );
            });
          });
  Future pickImageOptions() => showDialog(
      context: context,
      builder: (context) {
        final ImagePicker _picker = ImagePicker();
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            content: const SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "Select image from",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: AppColors.baseColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              Align(
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          // _pickImagesCamera();
                          // Navigator.pop(context);
                          Navigator.pop(context);
                          _takePictureDialog();
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                              left: 4, right: 4, bottom: 10.0),
                          // padding: const EdgeInsets.all(8),
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          height: 40,
                          decoration: const BoxDecoration(
                              // shape: BoxShape.circle,
                              // borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromARGB(255, 112, 68, 1),
                                    blurRadius: 5,
                                    offset: Offset(2.0, 5.0))
                              ],
                              color: Colors.black,
                              gradient: LinearGradient(
                                colors: [
                                  Colors.orange,
                                  Colors.orange,
                                ],
                              )),
                          child: const Row(children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Camera",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          // _pickImagesGallery();
                          XFile? image = await _picker.pickImage(
                            source: ImageSource.gallery,
                          );
                          if (image != null) {
                            refreshPath(image.path, image); // Add to list
                            Navigator.of(context)
                                .pop(); // Close dialog after selecting
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                              left: 4, right: 4, bottom: 10.0),
                          // padding: const EdgeInsets.all(8),
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          height: 40,
                          decoration: const BoxDecoration(
                              // shape: BoxShape.circle,
                              // borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromARGB(255, 112, 68, 1),
                                    blurRadius: 5,
                                    offset: Offset(2.0, 5.0))
                              ],
                              color: Colors.black,
                              gradient: LinearGradient(
                                colors: [
                                  Colors.orange,
                                  Colors.orange,
                                ],
                              )),
                          child: const Row(children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Gallery",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
      });

  Future<void> approveUploadApi(
      String status, String tokenNo, String id, int index) async {
    final String apiUrl =
        "${AppUrl.updateVegetationCrewFormSetStatusApprovedByIdsForSingleData}?status=$status&tokenNo=$tokenNo&id=$id";
    print(apiUrl);
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();

    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer ${data.token}',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
       var responseData = json.decode(response.body);
        // Store UpdatedIDs into closeId
        closeId = responseData["UpdatedIDs"]?.toString() ?? "";

        print("closeId => $closeId");
        print('api 1 success');
        print("Data: $data");
        checkForDocumentUploadApi(tokenNo);
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Exception: $e");
    }
  }

  Future<void> rejectApi(
    String status,
    String tokenNo,
    String id,
  ) async {
    final String apiUrl =
        "${AppUrl.updateVegetationCrewFormSetStatusApprovedByIdsForSingleData}?status=$status&tokenNo=$tokenNo&id=$id";

    print("reject api url: $apiUrl");
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();

    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer ${data.token}',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print('api 1 success');
        print("Data: $data");
        CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
            'Rejected Successfully', context);
        fetchData();
        // if (budgetType.toString() == 'Mid Cycle maintenance') {
        //   CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
        //       'Mid Cycle Maintenance Rejected Successfully', context);
        // } else {
        //   CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
        //       'IVM Maintenance Rejected Su ccessfully', context);
        // }
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Exception: $e");
    }
  }

  String closeId = "";
  Future<void> closeButtonApi(String tokenNo) async {
    final String apiUrl =
        "${AppUrl.updateVegetationCrewFormSetStatusApprovedByIdsForSingleData}?status=PENDING&tokenNo=$tokenNo&id=$closeId";
    print("closeButtonAp $apiUrl");
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();

    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer ${data.token}',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        Navigator.pop(context);
        print('close button api success');
        print("Data: $data");
        fetchData();
        print('data refreshed');
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Exception: $e");
    }
  }

  ///
  Future<void> approveRejectAllApi(String status, String tokenNo) async {
    int currentMonth = DateTime.now().month;
    final String apiUrl =
        "${AppUrl.updateVegetationCrewFormSetStatusApprovedAndRejectedByIds}?status=$status&tokenNo=$tokenNo&month=${getMonth(widget.lastUpdatedDate)}";
    print("approveRejectAll $apiUrl");
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();

    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer ${data.token}',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
       var responseData = json.decode(response.body);
        // Store UpdatedIDs into closeId
        closeId = responseData["UpdatedIDs"]?.toString() ?? "";

        print("closeId => $closeId");
        setState(() {
          isApproveAll = false;
          isRejectAll = false;
        });
        if (status == "APPROVED") {
          checkForDocumentUploadApi(tokenNo);
          // CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
          //     'All records for Job No:${widget.jobNo} Approved Successfully',
          //     context);
        } else {
          CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
              'All records for Job No:${widget.jobNo} Rejected Successfully',
              context);
          print('reject all case............');
          Future.delayed(Duration(seconds: 2), () {
             Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const InspectionZielies()));
            // if (context.mounted) {
            //   Navigator.pop(context); // pops current screen
            //   Navigator.pop(context); // pops one more (total 2 screens back)
            //   Navigator.pop(context);
            // }
          });
        }

        print("Data: $data");
      } else {
        setState(() {
          isApproveAll = false;
          isRejectAll = false;
        });
        print("Error: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      setState(() {
        isApproveAll = false;
        isRejectAll = false;
      });
      print("Exception: $e");
    }
  }

  ///
  Future<void> checkForDocumentUploadApi(String tokenNo) async {
    final String apiUrl =
        "${AppUrl.baseUrl}maintenanceReportView/getMilesForChekImageUploads?tokenNo=$tokenNo";

    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    print('apiUrl $apiUrl');
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer ${data.token}',
          'Content-Type': 'application/json',
          // Add any additional headers as needed
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print("Data: $data");
        print('api 2 success');
        print(data['leftMiles']);
        if (data['leftMiles'] == 0.0 && data['documentUpload'] != "REJECTED" ||
            data['leftMiles'] == 0 && data['documentUpload'] != "REJECTED" ||
            data['leftMiles'] == 0.00 && data['documentUpload'] != "REJECTED") {
          print('inside if');
          print('dynamicData[leftMiles] ${data['leftMiles']}');
          print('dynamicData[documentUpload] ${data['documentUpload']}');
          openDailogApprove(tokenNo);
        } else {
          // if (isApproveAll == true) {
          if (buttonText == "approve all") {
            CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
                'All records for Job No:${widget.jobNo} Approved Successfully',
                context);
            print('approve all without model case............');
            Future.delayed(Duration(seconds: 2), () {
               Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const InspectionZielies()));
              // if (context.mounted) {
              //   Navigator.pop(context); // pops current screen
              //   Navigator.pop(context); // pops one more (total 2 screens back)
              //   Navigator.pop(context);
              // }
            });
          } else {
            CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
                'Approved Successfully', context);
          }

          fetchData();
          // if (budgetType == 'Mid Cycle maintenance') {
          //   CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
          //       'Mid Cycle Maintenance Approved Successfully', context);
          // } else {
          //   CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
          //       'IVM Maintenance Approved Successfully', context);
          // }
        }
      } else {
        print("Error1111: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Exception: $e");
    }
  }

  Future<void> submitImages(
    List<String> imagePaths,
    String tokenNo,
  ) async {
    print('imagePaths: $imagePaths');
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;

    try {
      var uri = Uri.parse(
          AppUrl.updateImageVEGETATIONCREWFORMsFORFINALSUBMIT);
      var request = http.MultipartRequest("POST", uri);

      // Get the user token
      final userPreferences = Provider.of<UserPref>(context, listen: false);
      UserModel data = await userPreferences.getUser();

      // Set headers
      var headers = {
        "Content-Type": "multipart/form-data",
        "Accept": "*/*",
        "Authorization": 'Bearer ${data.token!}'
      };

      // List to hold MultipartFile objects
      List<http.MultipartFile> multipartFiles = [];

      // Loop through image paths and add them as MultipartFile
      for (int i = 0; i < imagePaths.length; i++) {
        String imagePath = imagePaths[i];

        if (imagePath.isNotEmpty) {
          File img = File(imagePath);

          // Copy the file to the temporary directory
          File file = await img.copy(
              '$tempPath/img_${DateFormat('yyyyMMddHHmmss').format(DateTime.now())}_$i${imagePath.contains('.pdf') ? '.pdf' : '.jpg'}');

          var stream = http.ByteStream(file.openRead());
          var length = await file.length();

          var multipartFile = http.MultipartFile("files", stream, length,
              filename: path.basename(file.path));

          // Add file to the list
          multipartFiles.add(multipartFile);
        }
      }

      if (multipartFiles.isNotEmpty) {
        request.files.addAll(multipartFiles); // Add all the selected files
      }

      // Add tokenNo as a field
      request.fields['tokenNo'] = tokenNo;
      request.headers.addAll(headers);

      // Send the request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        print("Images2222 submitted successfully.");
        fetchData();
        _setState(() {
          _isVisibleUploadingButton = false;
          _isVisibleUploadButton = true;
          imagePaths.clear();
          images.clear();
        });
        // Navigator.pop(context);
        // if (isApproveAll == true) {
        if (buttonText == "approve all") {
          CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
              'All records for Job No:${widget.jobNo} Approved Successfully',
              context);
          print('approve all with model case............');
          Future.delayed(Duration(seconds: 2), () {
             Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const InspectionZielies()));
            // if (context.mounted) {
            //   Navigator.pop(context); // pops current screen
            //   Navigator.pop(context); // pops one more (total 2 screens back)
            //   Navigator.pop(context);
            //   Navigator.pop(context);
            // }
          });
        } else {
          CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
              'Approved Successfully', context);
               print('approve only with model case............');
          Future.delayed(Duration(seconds: 2), () {
             Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const InspectionZielies()));
            // if (context.mounted) {
            //   Navigator.pop(context); 
            //    Navigator.pop(context); 
            //   Navigator.pop(context);
            //   Navigator.pop(context);
            // }
          });
        }

        // Handle the success response
      } else {
        print("Failed to submit images. Status code: ${response.statusCode}");
        print("Failed to submit images. response body: ${response.body}");
      }
    } catch (e, stacktrace) {
      print('Exception: $e\n$stacktrace');
    }
  }

  Future<void> deleteOnlineImageApi(String fileName, String tokenNo) async {
    final apiUrl =
        '${AppUrl.baseUrl}changeOrderLcpCreateOrder/deleteFile?fileName=$fileName&tokenNo=$tokenNo';
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
        // lCPWorkOrderPendingViewModel.fetchLCPWorkOrderPendingTabularListApi(
        //     context, 'PENDING', '', '');
      } else {
        print('API request failed with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> cameraInit() async {
    _cameras = await availableCameras();
    _camerasController = CameraController(_cameras[0], ResolutionPreset.max);
    _camerasController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  Future<void> _takePictureDialog() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
                content: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: 4.0),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: CameraPreview(_camerasController),
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: InkWell(
                        onTap: (() async {
                          XFile image = await _camerasController.takePicture();
                          refreshPath(image.path, image);
                          Navigator.of(context).pop();
                        }),
                        child: Container(
                          margin: const EdgeInsets.all(4.0),
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.height * 0.052,
                          decoration: const BoxDecoration(
                              // shape: BoxShape.circle,

                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromARGB(255, 60, 59, 59),
                                    blurRadius: 5,
                                    offset: Offset(2.0, 5.0))
                              ],
                              color: Colors.black,
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.baseColor,
                                  AppColors.buttonOrange,
                                  AppColors.baseColor,
                                ],
                              )),
                          child: const Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Take Picture",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ]);
          });
        });
  }

  void refreshPath(String path, XFile imageARG) {
    _setState(() {
      imagePaths.add(path);
      images.add(imageARG);
    });
  }

  void getInitData() {
    setState(() {});
    _jobNo.text = widget.jobNo;
    _totalMiles.text = widget.totalMiles;
    _milesCompleted.text = widget.milesCompleted;
    _milesInProgress.text = widget.milesInProgress;
    _milesPending.text = widget.milesPending;
  }
/////////////////////////////////////////////////////
}
