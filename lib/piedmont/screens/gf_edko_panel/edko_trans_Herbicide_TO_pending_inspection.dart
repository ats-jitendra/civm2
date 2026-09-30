import 'dart:io';

import 'package:CIVM/piedmont/models/transmission_herbicide_readyforreview_model.dart';
import 'package:CIVM/piedmont/repository/map_url.dart';
import 'package:CIVM/piedmont/resources/app_colors.dart';
import 'package:CIVM/piedmont/resources/app_url.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/pdf_view.dart';
import 'package:CIVM/piedmont/screens/my_chrome_safari_map_recording.dart';
import 'package:CIVM/piedmont/utils/common_functions.dart';
import 'package:CIVM/piedmont/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/piedmont/utils/work_progress_api.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/piedmont/view_model/image_code_view_model.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;

import 'package:CIVM/piedmont/screens/video_folder/fullVideo/full_screen_video_player.dart';

import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

// ignore: must_be_immutable
class EdkoTransmissionHerbicideReadyForReview extends StatefulWidget {
  EdkoTransmissionHerbicideReadyForReview({
    super.key,
  });

  @override
  State<EdkoTransmissionHerbicideReadyForReview> createState() =>
      _EdkoTransmissionHerbicideReadyForReviewState();
}

class _EdkoTransmissionHerbicideReadyForReviewState
    extends State<EdkoTransmissionHerbicideReadyForReview>
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
  List<ReadyForReviewData> dataList = [];
  List<ReadyForReviewData> filteredList = [];
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
  @override
  void initState() {
    cameraInit();
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
          'Transmission Herbicide (Pending Inspection)',
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
                                          // Padding(
                                          //   padding: const EdgeInsets.only(
                                          //       left: 8.0),
                                          //   child: Row(
                                          //     children: [
                                          //       Expanded(
                                          //         // alignment: Alignment.topLeft,
                                          //         child: Column(
                                          //           children: [
                                          //             const Align(
                                          //               alignment:
                                          //                   Alignment.topLeft,
                                          //               child: Text(
                                          //                 "SERIAL: ",
                                          //                 textAlign:
                                          //                     TextAlign.left,
                                          //                 style: TextStyle(
                                          //                   fontSize: 12,
                                          //                   fontWeight:
                                          //                       FontWeight.bold,
                                          //                   color: Colors.white,
                                          //                 ),
                                          //               ),
                                          //             ),
                                          //             Align(
                                          //               alignment:
                                          //                   Alignment.topLeft,
                                          //               child: Text(
                                          //                 (index + 1)
                                          //                     .toString(),
                                          //                 textAlign:
                                          //                     TextAlign.left,
                                          //                 style:
                                          //                     const TextStyle(
                                          //                   fontSize: 12,
                                          //                   //  fontWeight:
                                          //                   //      FontWeight.bold,
                                          //                   color: Colors.white,
                                          //                 ),
                                          //               ),
                                          //             ),
                                          //           ],
                                          //         ),
                                          //       ),
                                          //       Expanded(
                                          //         flex: 2,
                                          //         // alignment: Alignment.topLeft,
                                          //         child: Column(
                                          //           children: [
                                          //             const Align(
                                          //               alignment:
                                          //                   Alignment.topLeft,
                                          //               child: Text(
                                          //                 "ACTION: ",
                                          //                 textAlign:
                                          //                     TextAlign.left,
                                          //                 style: TextStyle(
                                          //                   fontSize: 12,
                                          //                   fontWeight:
                                          //                       FontWeight.bold,
                                          //                   color: Colors.white,
                                          //                 ),
                                          //               ),
                                          //             ),
                                          //             (rights != "READ ONLY")
                                          //                 ? Row(
                                          //                     children: [
                                          //                       InkWell(
                                          //                         onTap:
                                          //                             () async {
                                          //                           /////////////needed update commented only  for testing dailog////////////////
                                          //                           approveUploadApi(
                                          //                               'APPROVED',
                                          //                               item.tOKENNO
                                          //                                   .toString(),
                                          //                               item.iD
                                          //                                   .toString(),
                                          //                               item.bUDGETTYPE
                                          //                                   .toString(),
                                          //                               index);
                                          //                         },
                                          //                         child:
                                          //                             Container(
                                          //                           // margin: const EdgeInsets.only(
                                          //                           //     left: 40, right: 40, bottom: 10.0),
                                          //                           padding:
                                          //                               const EdgeInsets
                                          //                                   .all(
                                          //                                   8),
                                          //                           alignment:
                                          //                               Alignment
                                          //                                   .center,
                                          //                           width: 80,
                                          //                           // MediaQuery.of(context).size.width,
                                          //                           // height: MediaQuery.of(context).size.height * 0.4,
                                          //                           decoration: const BoxDecoration(
                                          //                               // shape: BoxShape.circle,
                                          //                               boxShadow: [
                                          //                                 BoxShadow(
                                          //                                     color: Color.fromARGB(255, 0, 58, 106),
                                          //                                     blurRadius: 5,
                                          //                                     offset: Offset(2.0, 5.0))
                                          //                               ],
                                          //                               color: Color.fromARGB(255, 0, 58, 106),
                                          //                               gradient: LinearGradient(
                                          //                                 colors: [
                                          //                                   Color.fromARGB(
                                          //                                       255,
                                          //                                       0,
                                          //                                       79,
                                          //                                       215),
                                          //                                   Colors.blue,
                                          //                                   Color.fromARGB(
                                          //                                       255,
                                          //                                       0,
                                          //                                       79,
                                          //                                       215),
                                          //                                 ],
                                          //                               )),
                                          //                           child:
                                          //                               const Text(
                                          //                             "Approve",
                                          //                             style:
                                          //                                 TextStyle(
                                          //                               color: Colors
                                          //                                   .white,
                                          //                               fontWeight:
                                          //                                   FontWeight.bold,
                                          //                               fontSize:
                                          //                                   10,
                                          //                             ),
                                          //                           ),
                                          //                         ),
                                          //                       ),
                                          //                       Padding(
                                          //                         padding:
                                          //                             const EdgeInsets
                                          //                                 .only(
                                          //                                 left:
                                          //                                     8.0,
                                          //                                 right:
                                          //                                     8),
                                          //                         child:
                                          //                             InkWell(
                                          //                           onTap:
                                          //                               () async {
                                          //                             print(
                                          //                                 'sep id :${item.iD.toString()}');
                                          //                             rejectApi(
                                          //                                 'REJECTED',
                                          //                                 item.tOKENNO
                                          //                                     .toString(),
                                          //                                 item.iD
                                          //                                     .toString(),
                                          //                                 item.bUDGETTYPE
                                          //                                     .toString());
                                          //                           },
                                          //                           child:
                                          //                               Container(
                                          //                             padding:
                                          //                                 const EdgeInsets
                                          //                                     .all(
                                          //                                     8),
                                          //                             alignment:
                                          //                                 Alignment
                                          //                                     .center,
                                          //                             width: 80,
                                          //                             // MediaQuery.of(context).size.width,
                                          //                             // height: MediaQuery.of(context).size.height * 0.4,
                                          //                             decoration: const BoxDecoration(
                                          //                                 // shape: BoxShape.circle,
                                          //                                 boxShadow: [
                                          //                                   BoxShadow(
                                          //                                       color: Color.fromARGB(255, 104, 8, 1),
                                          //                                       blurRadius: 5,
                                          //                                       offset: Offset(2.0, 5.0))
                                          //                                 ],
                                          //                                 color: Color.fromARGB(255, 130, 193, 245),
                                          //                                 gradient: LinearGradient(
                                          //                                   colors: [
                                          //                                     Colors.red,
                                          //                                     Colors.pink,
                                          //                                     Colors.pinkAccent,
                                          //                                   ],
                                          //                                 )),
                                          //                             child:
                                          //                                 const Text(
                                          //                               "Reject",
                                          //                               style:
                                          //                                   TextStyle(
                                          //                                 color:
                                          //                                     Colors.white,
                                          //                                 fontWeight:
                                          //                                     FontWeight.bold,
                                          //                                 fontSize:
                                          //                                     10,
                                          //                               ),
                                          //                             ),
                                          //                           ),
                                          //                         ),
                                          //                       ),
                                          //                     ],
                                          //                   )
                                          //                 : SizedBox(),
                                          //           ],
                                          //         ),
                                          //       ),
                                          //     ],
                                          //   ),
                                          // ),
                                          // const Divider(
                                          //   color: Colors.grey,
                                          // ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  // alignment: Alignment.topLeft,
                                                  child: Column(
                                                    children: [
                                                      const Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          "IMAGE: ",
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
                                                        child: InkWell(
                                                          onTap: () async {
                                                            await imageViewModel
                                                                .fetchImageApi(
                                                              context,
                                                              item.tOKENNO
                                                                  .toString(),
                                                            );
                                                            await Future.delayed(
                                                                const Duration(
                                                                    seconds:
                                                                        2));
                                                            openDialogPicture(
                                                                item.tOKENNO
                                                                    .toString());
                                                          },
                                                          child: const Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
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
                                                          item.tOKENNO
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
                                                          item.sTATUS
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
                                              ],
                                            ),
                                          ),
                                          const Divider(
                                            color: Colors.grey,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  // alignment: Alignment.topLeft,
                                                  child: Column(
                                                    children: [
                                                      const Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          "TRANSMISSION NAME: ",
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
                                                          item.tRANSMISSIONNAME
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
                                                          item.tYPE.toString(),
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
                                                          "MAINTENANCE TYPE: ",
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
                                                          item.mAINTTYPE
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
                                              ],
                                            ),
                                          ),
                                          const Divider(
                                            color: Colors.grey,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  // alignment: Alignment.topLeft,
                                                  child: Column(
                                                    children: [
                                                      const Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          "ASSIGNED CONTRACTOR: ",
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
                                                          item.nAME.toString(),
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
                                                          "TOTAL MILES: ",
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
                                                          item.tOTALMILES
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
                                                          "MILES COMPLETED",
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
                                                          item.mILESCOMPLETED
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
                                              ],
                                            ),
                                          ),

                                          const Divider(
                                            color: Colors.grey,
                                          ),
                                          Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      // alignment: Alignment.topLeft,
                                                      child: Column(
                                                        children: [
                                                          const Align(
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: Text(
                                                              "ROW INSTALLATION YEAR: ",
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
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
                                                            alignment: Alignment
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
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: Text(
                                                              "CYCLE: ",
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
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
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: Text(
                                                              item.cYCLE
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
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: Text(
                                                              "NEXT MAINT DUE: ",
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
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
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: Text(
                                                              formatDateIfNeeded(item
                                                                  .nEXTMAINTDUE
                                                                  .toString()),
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
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  // alignment: Alignment.topLeft,
                                                  child: Column(
                                                    children: [
                                                      const Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          "ORDER DATE: ",
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
                                                              item.cREATEDATE
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
                                                                      url: WebUri(MapUrl.getsupervisorTransEndPoint(
                                                                          item.tOKENNO
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
                                                  Expanded(
                                                  child: Column(
                                                    children: [
                                                      Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: InkWell(
                                                          onTap: () async {
                                                            ProgressDialog.show(
                                                              context,
                                                              jobNo:item.tOKENNO.toString()
                                                            );
                                                          },
                                                          child: Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Container(
                                                              // margin: const EdgeInsets.only(
                                                              //     left: 40, right: 40, bottom: 10.0),
                                                              padding:
                                                                  const EdgeInsets.all(
                                                                    8,
                                                                  ),
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              width: 80,
                                                              // MediaQuery.of(context).size.width,
                                                              // height: MediaQuery.of(context).size.height * 0.4,
                                                              decoration: const BoxDecoration(
                                                                // shape: BoxShape.circle,
                                                                color:
                                                                    Color.fromARGB(
                                                                      255,
                                                                      184,
                                                                      111,
                                                                      2,
                                                                    ),
                                                                gradient: LinearGradient(
                                                                  colors: [
                                                                    Colors
                                                                        .deepOrange,
                                                                    Colors
                                                                        .orange,
                                                                  ],
                                                                ),
                                                              ),
                                                              child: const Align(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Text(
                                                                  "PROGRESS",
                                                                  style: TextStyle(
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
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                           ],
                                            ),
                                          ),

                                          //   Padding(
                                          //       padding: const EdgeInsets.only(
                                          //           left: 8.0),
                                          //       child: Row(children: [
                                          //         Expanded(
                                          //           // alignment: Alignment.topLeft,
                                          //           child: Column(
                                          //             children: [
                                          //               const Align(
                                          //                 alignment:
                                          //                     Alignment.topLeft,
                                          //                 child: Text(
                                          //                   "SERVICE ORDER NO: ",
                                          //                   textAlign:
                                          //                       TextAlign.left,
                                          //                   style: TextStyle(
                                          //                     fontSize: 12,
                                          //                     fontWeight:
                                          //                         FontWeight.bold,
                                          //                     color: Colors.white,
                                          //                   ),
                                          //                 ),
                                          //               ),
                                          //               Align(
                                          //                 alignment:
                                          //                     Alignment.topLeft,
                                          //                 child: Text(
                                          //                   item["BI_SO_NBR"] ??
                                          //                       "".toString(),
                                          //                   textAlign:
                                          //                       TextAlign.left,
                                          //                   style:
                                          //                       const TextStyle(
                                          //                     fontSize: 12,
                                          //                     //  fontWeight:
                                          //                     //      FontWeight.bold,
                                          //                     color: Colors.white,
                                          //                   ),
                                          //                 ),
                                          //               ),
                                          //             ],
                                          //           ),
                                          //         ),
                                          //         Expanded(
                                          //           // alignment: Alignment.topLeft,
                                          //           child: Column(
                                          //             children: [
                                          //               const Align(
                                          //                 alignment:
                                          //                     Alignment.topLeft,
                                          //                 child: Text(
                                          //                   "DESCRIPTION: ",
                                          //                   textAlign:
                                          //                       TextAlign.left,
                                          //                   style: TextStyle(
                                          //                     fontSize: 12,
                                          //                     fontWeight:
                                          //                         FontWeight.bold,
                                          //                     color: Colors.white,
                                          //                   ),
                                          //                 ),
                                          //               ),
                                          //               Align(
                                          //                 alignment:
                                          //                     Alignment.topLeft,
                                          //                 child: Text(
                                          //                   item["BI_SO_DESC"] ??
                                          //                       "".toString(),
                                          //                   textAlign:
                                          //                       TextAlign.left,
                                          //                   style:
                                          //                       const TextStyle(
                                          //                     fontSize: 12,
                                          //                     //  fontWeight:
                                          //                     //      FontWeight.bold,
                                          //                     color: Colors.white,
                                          //                   ),
                                          //                 ),
                                          //               ),
                                          //             ],
                                          //           ),
                                          //         ),
                                          //         Expanded(
                                          //           // alignment: Alignment.topLeft,
                                          //           child: Column(
                                          //             children: [
                                          //               const Align(
                                          //                 alignment:
                                          //                     Alignment.topLeft,
                                          //                 child: Text(
                                          //                   "SUPERVISOR NOTES: ",
                                          //                   textAlign:
                                          //                       TextAlign.left,
                                          //                   style: TextStyle(
                                          //                     fontSize: 12,
                                          //                     fontWeight:
                                          //                         FontWeight.bold,
                                          //                     color: Colors.white,
                                          //                   ),
                                          //                 ),
                                          //               ),
                                          //               Align(
                                          //                 alignment:
                                          //                     Alignment.topLeft,
                                          //                 child: Text(
                                          //                   item["SUPERVISOR_NOTES"] ??
                                          //                       "".toString(),
                                          //                   textAlign:
                                          //                       TextAlign.left,
                                          //                   style:
                                          //                       const TextStyle(
                                          //                     fontSize: 12,
                                          //                     //  fontWeight:
                                          //                     //      FontWeight.bold,
                                          //                     color: Colors.white,
                                          //                   ),
                                          //                 ),
                                          //               ),
                                          //             ],
                                          //           ),
                                          //         ),
                                          //       ])),
                                          //   const Divider(color: Colors.grey),
                                          //   Padding(
                                          //       padding: const EdgeInsets.only(
                                          //           left: 8.0),
                                          //       child: Row(children: [
                                          //         Expanded(
                                          //           // alignment: Alignment.topLeft,
                                          //           child: Column(
                                          //             children: [
                                          //               const Align(
                                          //                 alignment:
                                          //                     Alignment.topLeft,
                                          //                 child: Text(
                                          //                   "T&M NOTES: ",
                                          //                   textAlign:
                                          //                       TextAlign.left,
                                          //                   style: TextStyle(
                                          //                     fontSize: 12,
                                          //                     fontWeight:
                                          //                         FontWeight.bold,
                                          //                     color: Colors.white,
                                          //                   ),
                                          //                 ),
                                          //               ),
                                          //               Align(
                                          //                 alignment:
                                          //                     Alignment.topLeft,
                                          //                 child: Text(
                                          //                   item["T_AND_M_NOTES"] ??
                                          //                       "".toString(),
                                          //                   textAlign:
                                          //                       TextAlign.left,
                                          //                   style:
                                          //                       const TextStyle(
                                          //                     fontSize: 12,
                                          //                     //  fontWeight:
                                          //                     //      FontWeight.bold,
                                          //                     color: Colors.white,
                                          //                   ),
                                          //                 ),
                                          //               ),
                                          //             ],
                                          //           ),
                                          //         ),
                                          //       ])),
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
        "${AppUrl.getTransmissionReadyForReview}?status=PENDING&substation=&feeder=&type=";

    print('url $url');
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();

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
          dataList = list.map((e) => ReadyForReviewData.fromJson(e)).toList();

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

          return (item.mAINTTYPE ?? "")
                  .toString()
                  .toLowerCase()
                  .contains(searchText) ||
              (item.tYPE ?? "").toString().toLowerCase().contains(searchText) ||
              (item.tOKENNO ?? "")
                  .toString()
                  .toLowerCase()
                  .contains(searchText) ||
              (item.sUBSTATION ?? "")
                  .toString()
                  .toLowerCase()
                  .contains(searchText) ||
              (item.tRANSMISSIONNAME ?? "")
                  .toString()
                  .toLowerCase()
                  .contains(searchText) ||
              (item.fDRNAME ?? "")
                  .toString()
                  .toLowerCase()
                  .contains(searchText) ||
              (item.cONTRACTOR ?? "")
                  .toString()
                  .toLowerCase()
                  .contains(searchText) ||
              (item.tOTALMILES ?? "")
                  .toString()
                  .toLowerCase()
                  .contains(searchText) ||
              (item.cONTRACTYEAR ?? "")
                  .toString()
                  .toLowerCase()
                  .contains(searchText) ||
              (item.cONTRACTORCOMPANY ?? "")
                  .toString()
                  .toLowerCase()
                  .contains(searchText) ||
              (item.cYCLE ?? "")
                  .toString()
                  .toLowerCase()
                  .contains(searchText) ||
              (item.tOTALCOST ?? "")
                  .toString()
                  .toLowerCase()
                  .contains(searchText) ||
              (item.cOSTPERMILE ?? "")
                  .toString()
                  .toLowerCase()
                  .contains(searchText) ||
              (item.nEXTMAINTDUE ?? "")
                  .toString()
                  .toLowerCase()
                  .contains(searchText);
        }).toList();
      });
    }
  }

  
  Future openDailogApprove(String idLocal, int index, String budgetType) =>
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
                              Navigator.pop(context);
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
                                if (imagePaths.isNotEmpty) {
                                  print('case where image111111111111');

                                  submitImages(imagePaths, idLocal, budgetType);
                                } else {
                                  print(
                                      'else case where no image111111111111111');

                                  fetchData();
                                  _setState(() {
                                    _isVisibleUploadingButton = false;
                                    _isVisibleUploadButton = true;
                                  });
                                  Navigator.pop(context);
                                }
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
                                        "UPLOAD & SAVE",
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
                                        color: Color.fromARGB(255, 1, 29, 62),
                                        blurRadius: 5,
                                        offset: Offset(2.0, 5.0))
                                  ],
                                  color: const Color.fromARGB(255, 1, 29, 62),
                                  gradient: const LinearGradient(
                                    colors: [
                                      AppColors.baseColor,
                                      Color.fromARGB(255, 7, 59, 120)
                                    ],
                                  )),
                              child: const Row(children: [
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "PROCESSING...",
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

  Future<void> approveUploadApi(String status, String tokenNo, String id,
      String budgetType, int index) async {
    final String apiUrl =
        "https://atsdev2test.ariespro.com/civmapi/maintenanceReportView/updateVegetation_crew_formSetStatusApprovedAndRejectedByIds?status=$status&tokenNo=$tokenNo&id=$id";
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
        var data = json.decode(response.body);
        print('api 1 success');
        print("Data: $data");
        checkForDocumentUploadApi(tokenNo, budgetType, index);
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Exception: $e");
    }
  }

  Future<void> rejectApi(
      String status, String tokenNo, String id, String budgetType) async {
    final String apiUrl =
        "https://atsdev2test.ariespro.com/civmapi/maintenanceReportView/updateVegetation_crew_formSetStatusApprovedAndRejectedByIds?status=$status&tokenNo=$tokenNo&id=$id";

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
        //       'IVM Maintenance Rejected Successfully', context);
        // }
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Exception: $e");
    }
  }

  Future<void> checkForDocumentUploadApi(
      String tokenNo, String budgetType, int index) async {
    final String apiUrl =
        "https://atsdev2test.ariespro.com/civmapi/maintenanceReportView/getMilesForChekImageUploads?tokenNo=$tokenNo";

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
          openDailogApprove(tokenNo, index, budgetType);
        } else {
          CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
              'Approved Successfully', context);
          fetchData();
          if (budgetType == 'Mid Cycle maintenance') {
            CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
                'Mid Cycle Maintenance Approved Successfully', context);
          } else {
            CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
                'IVM Maintenance Approved Successfully', context);
          }
        }
      } else {
        print("Error1111: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Exception: $e");
    }
  }

  Future<void> submitImages(
      List<String> imagePaths, String tokenNo, String budgetType) async {
    print('imagePaths: $imagePaths');
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;

    try {
      var uri = Uri.parse(
          "https://atsdev2test.ariespro.com/civmapi/contractorPanel/updateImageVEGETATION_CREW_FORMs");
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
        Navigator.pop(context);
        if (budgetType == 'Mid Cycle maintenance') {
          CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
              'Mid Cycle Maintenance Approved Successfully', context);
        } else {
          CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
              'IVM Maintenance Approved Successfully', context);
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
                                  Color.fromARGB(255, 7, 40, 97),
                                  Color.fromARGB(255, 7, 40, 97),
                                  Color.fromARGB(255, 7, 40, 97),
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
                                  'File',context);
                              Navigator.pop(context);
                            } else {
                              downloadFile(
                                  'https://pemccivm.ariespro.com/assets/clientuploads/$fileLocation',
                                  'PDF',context);
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
}
