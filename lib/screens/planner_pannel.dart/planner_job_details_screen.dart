import 'dart:convert';

import 'package:CIVM/models/gf_change_order_all_status_model.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/repository/map_url.dart';
import 'package:CIVM/resources/app_url.dart';
import 'package:CIVM/screens/chat_history.dart';
import 'package:CIVM/screens/login_page.dart';
import 'package:CIVM/screens/my_chrome_safari_map_recording.dart';
import 'package:CIVM/utils/common_functions.dart';
import 'package:CIVM/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/view_model/image_code_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:CIVM/screens/admin_pannel/row_maintenance_view/pdf_view.dart';

import 'package:CIVM/screens/video_folder/fullVideo/full_screen_video_player.dart';
import 'package:intl/intl.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class PlannerJobDetailsScreen extends StatefulWidget {
  String tokenNo;
  PlannerJobDetailsScreen({super.key, required this.tokenNo});

  @override
  State<PlannerJobDetailsScreen> createState() =>
      _PlannerJobDetailsScreenState();
}

class _PlannerJobDetailsScreenState extends State<PlannerJobDetailsScreen> {
  final TextEditingController _notes = TextEditingController();
  final TextEditingController _input = TextEditingController();
  Future? myFuture;
  bool isError = false;
  bool isLoading = false;
  ImageViewViewModel imageViewModel = ImageViewViewModel();
  bool _isApproveLoading = false;
  bool _isCancelLoading = false;
  List<Map<String, dynamic>> crewList = [];
  String? selectedCrew;

  String selectedCrewLoginID = '';
  String? rights;
  // bool _isVisibleChangeOrder = true;
  final browser = MyChromeSafariBrowser();
  String userTypeText = '';
  String primaryRoleText = '';

  @override
  void initState() {
    super.initState();
    // myFuture = fetchDetails(context);

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   imageViewModel.fetchImageApi(context, widget.tokenNo);
    // });
    myFuture = Future.wait([
      fetchDetails(context),
      imageViewModel.fetchImageApi(context, widget.tokenNo),
    ]);
    getUserType();
    _initializeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Change Order View Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 7, 59, 120),
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
                  // await fetchDetails(context);
                  myFuture = Future.wait([
                    fetchDetails(context),
                    imageViewModel.fetchImageApi(context, widget.tokenNo),
                  ]);
                },
                child: Column(
                  children: [
                    ///  HEADER CARD
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                        bottom: 0,
                        left: 12,
                        right: 12,
                      ),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              (primaryRoleText!=userTypeText)? Padding(
                                    padding: EdgeInsets.only(top: 2.0),
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
                                  ):Container(), 
                            Padding(
                              padding: const EdgeInsets.only(top:8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "JOB NO : ${item!.tokenNo}",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                              
                                  /// STATUS BADGE
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: getStatusColor(item!.status),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      item!.status ?? "",
                                      style: const TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  (item!.status
                                                  .toString()
                                                  .trim()
                                                  .toUpperCase() ==
                                              "PENDING ZIELIES ASSIGNMENT" ||
                                          item!.status
                                                  .toString()
                                                  .trim()
                                                  .toUpperCase() ==
                                              "ASSIGNED")
                                      ? Row(
                                          children: [
                                            const Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                "SHARE  :  ",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            (item!.maintType.toString() ==
                                                        'Change Order' ||
                                                    item!.maintType
                                                            .toString() ==
                                                        'Exception Maintenance' ||
                                                    item!.maintType
                                                            .toString() ==
                                                        'No Exception Maintenance')
                                                ? (item!.visibilityFlag
                                                              .toString() ==
                                                          '2')
                                                      ? Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: InkWell(
                                                            onTap: () async {
                                                              if (rights !=
                                                                  "READ ONLY") {
                                                                showCrewDialog(
                                                                  context,
                                                                  item!.tokenNo
                                                                      .toString(),
                                                                );
                                                                // CustomToastSnackBarProgressDialog.flushBarSuccessMessage('${lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].tokenNo.toString()} Row Maintenance Already Shared with Crew',
                                                                //     context);
                                                              } else {
                                                                CustomToastSnackBarProgressDialog.flushBarErrorMessage(
                                                                  "You are not authorized to share.",
                                                                  context,
                                                                );
                                                              }
                                                            },
                                                            child: const Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              child: Icon(
                                                                Icons.share,
                                                                color: Colors
                                                                    .green,
                                                                //getCrewList
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      : Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: InkWell(
                                                            onTap: () async {
                                                              // print(
                                                              //     'job no ${lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].id}');
                                                              // openDialogFlag(lCPWorkOrderPendingViewModel
                                                              //     .lcpWorkOrderPendingGetTabularData
                                                              //     .data!
                                                              //     .findAllTableData![index]
                                                              //     .id
                                                              //     .toString());
                                                              if (rights !=
                                                                  "READ ONLY") {
                                                                showCrewDialog(
                                                                  context,
                                                                  item!.tokenNo
                                                                      .toString(),
                                                                );
                                                              } else {
                                                                CustomToastSnackBarProgressDialog.flushBarErrorMessage(
                                                                  "You are not authorized to share.",
                                                                  context,
                                                                );
                                                              }
                                                            },
                                                            child: const Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              child: Icon(
                                                                Icons.share,
                                                                color:
                                                                    Colors.blue,
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                : const Text(
                                                    "",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                          ],
                                        )
                                      : Container(),

                                  //  const Spacer(), // pushes View Map to right WITHOUT extra gap
                                  /// VIEW MAP BUTTON
                                  InkWell(
                                    onTap: () async {
                                      String id = '';
                                      final userPreferences1 =
                                          Provider.of<UserPref>(
                                            context,
                                            listen: false,
                                          );
                                      UserModel data = await userPreferences1
                                          .getUser();
                                      id = data.user!.id.toString();
                                      print(
                                        'planner map url: ${MapUrl.getPlannerWithTokenEndPoint(item!.tokenNo.toString(), id)}',
                                      );
                                      await browser.open(
                                        url: WebUri(
                                          // "https://mapapi.ariespro.com/main/contractor/CIVM_Map/${lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].tokenNo.toString()}/USRQWXH589Z"),
                                          MapUrl.getPlannerWithTokenEndPoint(
                                            item!.tokenNo.toString(),
                                            id,
                                          ),
                                        ),
                                        settings: ChromeSafariBrowserSettings(
                                          shareState: CustomTabsShareState
                                              .SHARE_STATE_OFF,
                                          barCollapsingEnabled: true,
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 0),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 5,
                                      ),
                                      width: 90,
                                      decoration: BoxDecoration(
                                        // color: Colors.green.shade100,
                                        color: const Color.fromARGB(
                                          255,
                                          0,
                                          58,
                                          106,
                                        ),
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color.fromARGB(255, 0, 79, 215),
                                            Colors.blue,
                                            Color.fromARGB(255, 0, 79, 215),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Row(
                                        children: [
                                          Icon(
                                            Icons.map,
                                            size: 14,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            "View Map",
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            (item?.reWork != null && item?.reWork != 'N/A')
                                ? Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          item?.reWork ?? "",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            const Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                "",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                : Text(
                                    '',
                                    style: TextStyle(
                                      fontSize: 0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ),
                            // Align(
                            //     alignment: Alignment.topLeft,
                            //     child: InkWell(
                            //       onTap: () async {
                            //         String id = '';
                            //         final userPreferences1 =
                            //             Provider.of<UserPref>(context,
                            //                 listen: false);
                            //         UserModel data =
                            //             await userPreferences1.getUser();
                            //         id = data.user!.id.toString();
                            //         await browser.open(
                            //             url: WebUri(
                            //                 // "https://mapapi.ariespro.com/main/contractor/CIVM_Map/${lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].tokenNo.toString()}/USRQWXH589Z"),
                            //                 MapUrl.getGfEndPoint(
                            //                     item!.tokenNo.toString(),
                            //                     id)),
                            //             settings: ChromeSafariBrowserSettings(
                            //                 shareState: CustomTabsShareState
                            //                     .SHARE_STATE_OFF,
                            //                 barCollapsingEnabled: true));
                            //       },
                            //       child: Align(
                            //         alignment: Alignment.centerLeft,
                            //         child: Container(
                            //           // margin: const EdgeInsets.only(
                            //           //     left: 40, right: 40, bottom: 10.0),
                            //           padding: const EdgeInsets.all(8),
                            //           alignment: Alignment.centerLeft,
                            //           width: 80,
                            //           // MediaQuery.of(context).size.width,
                            //           // height: MediaQuery.of(context).size.height * 0.4,
                            //           decoration: const BoxDecoration(
                            //               // shape: BoxShape.circle,

                            //               color:
                            //                   Color.fromARGB(255, 0, 58, 106),
                            //               gradient: LinearGradient(
                            //                 colors: [
                            //                   Color.fromARGB(255, 0, 79, 215),
                            //                   Colors.blue,
                            //                   Color.fromARGB(255, 0, 79, 215),
                            //                 ],
                            //               )),
                            //           child: const Align(
                            //             alignment: Alignment.center,
                            //             child: Text(
                            //               "VIEW MAP",
                            //               style: TextStyle(
                            //                 color: Colors.white,
                            //                 fontWeight: FontWeight.bold,
                            //                 fontSize: 10,
                            //               ),
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     )),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),
                    Expanded(
                      child: SingleChildScrollView(
                        // padding: const EdgeInsets.all(12),
                        padding: const EdgeInsets.only(
                          top: 0,
                          bottom: 0,
                          left: 12,
                          right: 12,
                        ),
                        child: Column(
                          children: [
                            ///  DETAILS CARD
                            _buildDetailCard(
                              icon: Icons.location_on,
                              title: "Substation",
                              value: item?.substation ?? "",
                            ),

                            _buildDetailCard(
                              icon: Icons.work,
                              title: "Feeder",
                              value: item?.feeder ?? "",
                            ),

                            // _buildDetailCard(
                            //   icon: Icons.business,
                            //   title: "Contractor",
                            //   value: item?.contractor ?? "",
                            // ),
                            _buildDetailCard(
                              icon: Icons.apartment,
                              title: "Contractor Company",
                              value: item?.contractorCompany ?? "",
                            ),

                            // _buildDetailCard(
                            //   icon: Icons.build,
                            //   title: "Type",
                            //   value: item?.type ?? "",
                            // ),

                            // _buildDetailCard(
                            //   icon: Icons.info,
                            //   title: "Status",
                            //   value: item?.status ?? "",
                            // ),
                            _buildDetailCard(
                              icon: Icons.build,
                              title: "Type",
                              value: item?.maintType ?? "",
                            ),
                            _buildDetailCard(
                              icon: Icons.build_circle,
                              title: "Maint Type",
                              value: item?.type ?? "",
                            ),

                            // _buildDetailCard(
                            //   icon: Icons.location_city,
                            //   title: "Street Address",
                            //   value: item?.streetAddress ?? "",
                            // ),

                            // _buildDetailCard(
                            //   icon: Icons.map,
                            //   title: "Service Map Location",
                            //   value: item?.mapLocation ?? "",
                            // ),
                            _buildDetailCard(
                              icon: Icons.note,
                              title: "Admin Notes",
                              value: item?.adminNotes1 ?? "",
                            ),

                            _buildDetailCard(
                              icon: Icons.engineering,
                              title: "General Foreman Notes",
                              value: item?.contractorNotes ?? "",
                            ),

                            _buildDetailCard(
                              icon: Icons.supervisor_account,
                              title: "Supervisor Notes",
                              value: item?.supervisorNotes ?? "",
                            ),

                            _buildDetailCard(
                              icon: Icons.event_note,
                              title: "Planner Notes",
                              value: item?.plannerNotes ?? "",
                            ),

                            _buildDetailCard(
                              icon: Icons.date_range,
                              title: "Date of Inspection",
                              value: formatDate(item?.dateOfInspection ?? ""),
                            ),

                            _buildDetailCard(
                              icon: Icons.update,
                              title: "Follow Up Date",
                              value: formatDate(item?.followUpDate ?? ""),
                            ),

                            // _buildDetailCard(
                            //   icon: Icons.timer,
                            //   title: "Estimated Time",
                            //   value: item?.?.toString() ?? "",
                            // ),
                            _buildDetailCard(
                              icon: Icons.calendar_today,
                              title: "Create Date",
                              value: formatDate(
                                item?.createDate?.toString() ?? "",
                              ),
                            ),

                            _buildDetailCard(
                              icon: Icons.group,
                              title: "Shared With",
                              value: item?.crewName ?? "",
                            ),

                            _buildDetailCard(
                              icon: Icons.person,
                              title: "Initiated By",
                              value: item?.initiatedBy ?? "",
                            ),

                            _buildDetailCard(
                              icon: Icons.chat,
                              title: "Chat History",
                              value: item!.addChatNotes ?? "",
                              fontWeight: FontWeight.bold,
                              onTapValue: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (_) => ChatHistoryScreen(
                                    tokenNo: item!.tokenNo.toString(),
                                  ),
                                );
                              },
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(bottom: 6),
                            //   child: Container(
                            //     padding: const EdgeInsets.only(
                            //         top: 6, bottom: 6, right: 12, left: 12),
                            //     decoration: BoxDecoration(
                            //       color: Colors.white,
                            //       borderRadius: BorderRadius.circular(10),
                            //       boxShadow: [
                            //         BoxShadow(
                            //           color: Colors.black.withOpacity(0.1),
                            //           blurRadius: 4,
                            //         )
                            //       ],
                            //     ),
                            //     child: Row(
                            //       children: [
                            //         Icon(Icons.chat, color: Colors.blue),
                            //         const SizedBox(width: 10),
                            //         // Expanded(
                            //         //   child: RichText(
                            //         //     text: TextSpan(
                            //         //       text: "$title: ",
                            //         //       style: const TextStyle(
                            //         //         fontWeight: FontWeight.bold,
                            //         //         color: Colors.black,
                            //         //       ),
                            //         //       children: [],
                            //         //     ),
                            //         //   ),
                            //         // ),
                            //         Expanded(
                            //           flex: 3,
                            //           child: Text(
                            //             "Chat History: ",
                            //             style: const TextStyle(
                            //               fontWeight: FontWeight.bold,
                            //               color: Colors.black,
                            //             ),
                            //           ),
                            //         ),
                            //         const Expanded(
                            //           flex: 1,
                            //           child: Text(
                            //             " : ",
                            //             style: TextStyle(
                            //               fontWeight: FontWeight.bold,
                            //               color: Colors.black,
                            //             ),
                            //           ),
                            //         ),
                            //         Expanded(
                            //           flex: 3,
                            //           child: GestureDetector(
                            //             onTap: () {
                            //               showModalBottomSheet(
                            //                 context: context,
                            //                 isScrollControlled: true,
                            //                 backgroundColor:
                            //                     Colors.transparent,
                            //                 builder: (_) => ChatHistoryScreen(
                            //                     tokenNo:
                            //                         item!.tokenNo.toString()),
                            //               );
                            //             },
                            //             child: Text(
                            //               item!.addChatNotes ?? "",
                            //               style: TextStyle(
                            //                 fontWeight: FontWeight.bold,
                            //                 color: Colors.black,
                            //               ),
                            //             ),
                            //           ),
                            //         )
                            //       ],
                            //     ),
                            //   ),
                            // ),

                            // const SizedBox(height: 8),

                            ///  IMAGE SECTION TITLE
                            // Align(
                            //   alignment: Alignment.centerLeft,
                            //   child: Container(
                            //     padding: const EdgeInsets.only(
                            //         top: 6, bottom: 6, right: 12, left: 12),
                            //     decoration: BoxDecoration(
                            //       color: Colors.white,
                            //       borderRadius: BorderRadius.circular(10),
                            //       boxShadow: [
                            //         BoxShadow(
                            //           color: Colors.black.withOpacity(0.1),
                            //           blurRadius: 4,
                            //         )
                            //       ],
                            //     ),
                            //     child: Text(
                            //       "Images",
                            //       style: TextStyle(
                            //         fontSize: 16,
                            //         fontWeight: FontWeight.bold,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            // Align(
                            //   alignment: Alignment.centerLeft,
                            //   child: Container(
                            //     width: 105,
                            //     // double.infinity,
                            //     padding: const EdgeInsets.symmetric(
                            //       vertical: 8,
                            //     ),
                            //     decoration: BoxDecoration(
                            //       color: Colors.blue.shade50,
                            //       borderRadius: BorderRadius.circular(10),
                            //       border: Border.all(color: Colors.blue),
                            //     ),
                            //     child: const Row(
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       children: [
                            //         Icon(Icons.image, color: Colors.blue),
                            //         SizedBox(width: 8),
                            //         Text(
                            //           "Images",
                            //           style: TextStyle(
                            //             color: Colors.blue,
                            //             fontWeight: FontWeight.bold,
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            const SizedBox(height: 8),

                            ///  IMAGE GRID VIEW
                            // _buildImageGrid(),

                            // const SizedBox(height: 8),

                            // InkWell(
                            //   onTap: () async {
                            //     await imageViewModel.fetchImageApi(
                            //         context, item!.tokenNo.toString());

                            //     await Future.delayed(const Duration(seconds: 1));

                            //     openDialogPicture(item!.tokenNo.toString());
                            //   },
                            //   child: Container(
                            //     width: double.infinity,
                            //     padding: const EdgeInsets.symmetric(vertical: 12),
                            //     decoration: BoxDecoration(
                            //       color: Colors.blue.shade50,
                            //       borderRadius: BorderRadius.circular(10),
                            //       border: Border.all(color: Colors.blue),
                            //     ),
                            //     child: const Row(
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       children: [
                            //         Icon(Icons.image, color: Colors.blue),
                            //         SizedBox(width: 8),
                            //         Text(
                            //           "View Images",
                            //           style: TextStyle(
                            //             color: Colors.blue,
                            //             fontWeight: FontWeight.bold,
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            // const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                    if (item!.status.toString() == "PENDING ZIELIES APPROVAL")
                      ///  ACTION BUTTONS
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 12,
                          bottom: 12,
                          left: 12,
                          right: 12,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                _notes.clear();
                                openDailogPendingApproval(
                                  item!.tokenNo.toString(),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.green.withOpacity(0.3),
                                      blurRadius: 6,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  "APPROVE",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: () async {
                                _notes.clear();
                                openDailogCancel(item!.tokenNo.toString());
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.red.withOpacity(0.3),
                                      blurRadius: 6,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  "REJECT",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    // if (item!.status.toString().contains("CANCEL"))
                     if (item!.status.toString() == "CANCELLED BY PLANNER" || item!.status.toString() == "CANCELLED BY GF")
                      (rights != "READ ONLY")
                          ? (item!.maintType == 'Change Order')
                                ? const Text(
                                    "",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () async {
                                      openDailogSubmitApproval(
                                        item!.id.toString(),
                                      );
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                        top: 12,
                                        bottom: 12,
                                        left: 12,
                                        right: 12,
                                      ),
                                      width: 200,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8,
                                        horizontal: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.green.withOpacity(
                                              0.3,
                                            ),
                                            blurRadius: 6,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        "RECALL",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  )
                          : const SizedBox(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  ///  REUSABLE TILE
  Widget _buildDetailCard({
    required IconData icon,
    required String title,
    required String value,
    VoidCallback? onTapValue,
    FontWeight? fontWeight,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Container(
        padding: const EdgeInsets.only(top: 6, bottom: 6, right: 12, left: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.blue),
            const SizedBox(width: 10),
            // Expanded(
            //   child: RichText(
            //     text: TextSpan(
            //       text: "$title: ",
            //       style: const TextStyle(
            //         fontWeight: FontWeight.bold,
            //         color: Colors.black,
            //       ),
            //       children: [],
            //     ),
            //   ),
            // ),
            Expanded(
              flex: 3,
              child: Text(
                "$title: ",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const Expanded(
              flex: 1,
              child: Text(
                " : ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: GestureDetector(
                onTap: onTapValue,
                child: Text(
                  value,
                  style: TextStyle(fontWeight: fontWeight, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  GFChangeOrderAllStatusData? item;

  Future<void> fetchDetails(BuildContext context) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    // id = data.user!.id.toString();
    var url = "${AppUrl.getChangeOrderByJobNoEndPoint}?jobno=${widget.tokenNo}";

    print('url $url');

    var headers = {
      "Content-Type": "application/json",
      // "Authorization": "Bearer $token", //  Add this line
      "Authorization": 'Bearer ${data.token!}',
    };

    try {
      var response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        var res = jsonDecode(response.body);

        List list = res["data"];

        setState(() {
          item = GFChangeOrderAllStatusData.fromJson(list[0]);
          // isLoading = false;
        });
      } else {
        // setState(() => isLoading = false);
      }
    } catch (e) {
      // setState(() => isLoading = false);
    }
  }

  //////////////////////////image code////////////////////////
  Widget _buildImageGrid() {
    int length = imageViewModel.imageData.data?.images?.length ?? 0;

    if (length == 0) {
      return const Center(
        child: Text(
          "",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        String? fileLocation =
            imageViewModel.imageData.data?.images?[index].imageLocation;

        if (fileLocation == null) return const SizedBox();

        bool isVideo(String file) {
          return file.endsWith('.mp4') || file.endsWith('.mov');
        }

        return Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: Stack(
            children: [
              /// PDF
              if (isPDF(fileLocation))
                Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PDFViewer(
                            pdfUrl:
                                'https://civm.ariespro.com/assets/clientuploads/$fileLocation',
                          ),
                        ),
                      );
                    },
                    child: Image.asset('assets/pdflogo.jpg', height: 80),
                  ),
                )
              /// VIDEO
              else if (isVideo(fileLocation))
                InkWell(
                  onTap: () => openFullSizeVideoDialog(fileLocation),
                  child: VideoPlayerWidget(
                    videoUrl:
                        'https://civm.ariespro.com/assets/clientuploads/$fileLocation',
                  ),
                )
              /// IMAGE
              else
                InkWell(
                  onTap: () => openFullSizeImageDialog(fileLocation),
                  child: Image.network(
                    'https://civm.ariespro.com/assets/clientuploads/$fileLocation',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),

              /// ACTION BUTTONS
              Positioned(
                top: 5,
                left: 5,
                child: InkWell(
                  onTap: () {
                    downloadFile(
                      'https://civm.ariespro.com/assets/clientuploads/$fileLocation',
                      'File',context
                    );
                  },
                  child: const Icon(
                    Icons.download,
                    color: Colors.blue,
                    size: 18,
                  ),
                ),
              ),

              // Positioned(
              //   top: 5,
              //   right: 5,
              //   child: InkWell(
              //     onTap: () {
              //       deleteOnlineImageApi2(fileLocation, widget.tokenNo);
              //     },
              //     child: const Icon(Icons.delete, color: Colors.red, size: 18),
              //   ),
              // ),
            ],
          ),
        );
      },
    );
  }

  Future openDialogPicture(String tokenNo) => showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
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
                          "",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 7, 59, 120),
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
        },
      );
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
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Stack(
                children: [
                  if (isPDF(fileLocation))
                    Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) => PDFViewer(
                                pdfUrl:
                                    'https://civm.ariespro.com/assets/clientuploads/$fileLocation',
                              ),
                            ),
                          );
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
                          5,
                        ), // Optional rounded corners
                        child: SizedBox(
                          height: 150,
                          width: double.infinity,
                          child: VideoPlayerWidget(
                            videoUrl:
                                'https://civm.ariespro.com/assets/clientuploads/$fileLocation',
                          ),
                        ),
                      ),
                    )
                  else
                    InkWell(
                      onTap: () {
                        openFullSizeImageDialog(fileLocation);
                      },
                      child: Image.network(
                        'https://civm.ariespro.com/assets/clientuploads/$fileLocation',
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
                                'https://civm.ariespro.com/assets/clientuploads/$fileLocation',
                                'File',context
                              );
                              Navigator.pop(context);
                            } else {
                              downloadFile(
                                'https://civm.ariespro.com/assets/clientuploads/$fileLocation',
                                'PDF',context
                              );
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
                  color: Color.fromARGB(255, 7, 59, 120),
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
                backgroundDecoration: const BoxDecoration(color: Colors.black),
                onPageChanged: (index) {},
                scrollPhysics: const BouncingScrollPhysics(),
                pageOptions: [
                  PhotoViewGalleryPageOptions(
                    imageProvider: NetworkImage(
                      'https://civm.ariespro.com/assets/clientuploads/$imageUrl',
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
        "${AppUrl.baseUrl}changeOrderLcpCreateOrder/deleteFile?fileName=$fileName&tokenNo=$tokenNo";
    // 'https://civm2.ariespro.com/civm2/changeOrderLcpCreateOrder/deleteFile?fileName=$fileName&tokenNo=$tokenNo';
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
          'Image deleted Successfully',
          context,
        );
        // Navigator.pop(context);
        await Future.delayed(const Duration(seconds: 2));

        // fetchDetails(context);
        myFuture = Future.wait([
          fetchDetails(context),
          imageViewModel.fetchImageApi(context, widget.tokenNo),
        ]);
      } else {
        print('API request failed with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  /////////////////////////////////////////////////////

  Future openDailogPendingApproval(String tokenNo) => showDialog(
    context: context,
    builder: (context) {
      final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: Padding(
              padding: const EdgeInsets.only(
                top: 12,
                left: 12,
                right: 12,
                bottom: 12,
              ),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "SUBMIT FOR APPROVAL",
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Color.fromARGB(255, 7, 59, 120),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const SizedBox(
                              height: 25,
                              width: 25,
                              child: Icon(Icons.close, color: Colors.red),
                            ),
                          ),
                          // IconButton(
                          //     onPressed: () {
                          //       Navigator.pop(context);
                          //     },
                          //     icon: const Icon(
                          //       Icons.close,
                          //       color: Colors.red,
                          //     ))
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Text(
                            "Job No. : $tokenNo",
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Color.fromARGB(255, 7, 59, 120),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: Column(
                          children: [
                            // const Align(
                            //     alignment: Alignment.centerLeft,
                            //     child: Padding(
                            //       padding: EdgeInsets.all(2.0),
                            //       child: Text(
                            //         "Notes",
                            //         style: TextStyle(
                            //           fontSize: 16.0,
                            //           color: Color.fromARGB(255, 7, 59, 120),
                            //         ),
                            //       ),
                            //     )),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: TextFormField(
                                  //  key: formkey2,
                                  controller: _notes,
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
                                        color: Color.fromARGB(255, 7, 59, 120),
                                      ),
                                    ),
                                    hintText: 'notes',
                                  ),

                                  validator: (value) {
                                    if (value.toString() == '') {
                                      return "Please enter notes";
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
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              Row(
                children: [
                  CommonActionButton(
                    title: "Submit",
                    gradientColors: [Colors.green, Colors.green],
                    onTap: () {
                      setState(() {
                        _isApproveLoading = true;
                      });
                      approveOrCancelOrder(tokenNo, 'PENDING LCP APPROVAL');
                      // if (_formKey.currentState!.validate()) {
                      //   print('a');
                      //   Navigator.pop(context);
                      // }
                    },
                    isLoading: _isApproveLoading,
                  ),
                  // CommonActionButton(
                  //   title: "Cancel",
                  //   gradientColors: [Colors.red, Colors.red],
                  //   onTap: () {
                  //     Navigator.pop(context);
                  //   },
                  // ),
                ],
              ),
            ],
          );
        },
      );
    },
  );

  void approveOrCancelOrder(String tokenNo, String status) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    String id = data.user!.id.toString();
    final String url =
        '${AppUrl.baseUrl}changeOrderLcpCreateOrder/approveOrCancelByToken?tokenNo=$tokenNo&status=$status&id=$id&notes=${_notes.text}';
    print('url: $url');
    try {
      // showDialog(
      //   context: context,
      //   barrierDismissible: false,
      //   builder: (BuildContext context) {
      //     return const Center(
      //       child: CircularProgressIndicator(),
      //     );
      //   },
      // );
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${data.token}',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        print('Success: ${response.body}');
        Navigator.pop(context);
        if (status == 'PENDING LCP APPROVAL') {
          CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
            'Job no. $tokenNo Approved Successfully.',
            context,
          );
        } else if (status == 'CANCELLED') {
          CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
            'Job no. $tokenNo Rejected.',
            context,
          );
        }

        fetchDetails(context);
        await Future.delayed(const Duration(seconds: 3));
        Navigator.pop(context);
        Navigator.pop(context);
        // Navigator.pop(context);
        _input.clear();
        setState(() {
          _isApproveLoading = false;
          _isCancelLoading = false;
        });
      } else {
        setState(() {
          _isApproveLoading = false;
          _isCancelLoading = false;
        });
        print('Failed: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      setState(() {
        _isApproveLoading = false;
        _isCancelLoading = false;
      });
      print('Error: $e');
    }
  }

  Future openDailogCancel(String tokenNo) => showDialog(
    context: context,
    builder: (context) {
      final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: Padding(
              padding: const EdgeInsets.only(
                top: 12,
                left: 12,
                right: 12,
                bottom: 12,
              ),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "REJECT JOB NO.",
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Color.fromARGB(255, 7, 59, 120),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const SizedBox(
                              height: 25,
                              width: 25,
                              child: Icon(Icons.close, color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Text(
                            "Job No. : $tokenNo",
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Color.fromARGB(255, 7, 59, 120),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: Column(
                          children: [
                            // const Align(
                            //     alignment: Alignment.centerLeft,
                            //     child: Padding(
                            //       padding: EdgeInsets.all(2.0),
                            //       child: Text(
                            //         "Cancellation Notes",
                            //         style: TextStyle(
                            //           fontSize: 16.0,
                            //           color: Color.fromARGB(255, 7, 59, 120),
                            //         ),
                            //       ),
                            //     )),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: TextFormField(
                                  //  key: formkey2,
                                  controller: _notes,
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
                                        color: Color.fromARGB(255, 7, 59, 120),
                                      ),
                                    ),
                                    hintText: 'notes',
                                  ),

                                  validator: (value) {
                                    if (value.toString() == '') {
                                      return "Please enter notes";
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
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              Row(
                children: [
                  CommonActionButton(
                    title: "Submit",
                    gradientColors: [Colors.green, Colors.green],
                    onTap: () {
                      setState(() {
                        _isCancelLoading = true;
                      });
                      approveOrCancelOrder(tokenNo, 'CANCELLED');
                      // if (_formKey.currentState!.validate()) {
                      //   print('a');
                      //   Navigator.pop(context);
                      // }
                    },
                    isLoading: _isCancelLoading,
                  ),
                ],
              ),
            ],
          );
        },
      );
    },
  );

  void showCrewDialog(BuildContext context, String tokenNo) async {
    await fetchCrewList(); // Fetch crew list before showing the dialog

    String? selectedCrew; // Local state for dropdown selection
    String? errorMessage; // To show validation error message

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text("Select Crew"),
              content: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        DropdownButton<String>(
                          value: selectedCrew,
                          hint: const Text("Select Crew"),
                          isExpanded: true,
                          items: crewList.map((crew) {
                            return DropdownMenuItem(
                              value: crew["loginId"].toString(),
                              child: Text(crew["name"]),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setStateDialog(() {
                              selectedCrew = value;
                              errorMessage = null; // Clear error when selected
                            });
                            selectedCrewLoginID = value.toString();
                          },
                        ),
                        if (errorMessage != null) // Show error if exists
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
              actions: [
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      // NO Button
                      _buildDialogButton(
                        context,
                        text: "NO",
                        color: Colors.red,
                        onTap: () => Navigator.pop(dialogContext),
                      ),

                      // YES Button (with validation)
                      _buildDialogButton(
                        context,
                        text: "YES",
                        color: Colors.green,
                        onTap: () {
                          if (selectedCrew == null) {
                            setStateDialog(() {
                              errorMessage = "Please select a crew.";
                            });
                            return;
                          }
                          updateFlagValue(tokenNo, 2);
                          Navigator.pop(dialogContext);
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

  // Helper function for dialog buttons
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
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.8),
                blurRadius: 5,
                offset: const Offset(2.0, 5.0),
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

  Future<void> updateFlagValue(String token, int flag) async {
    String url = "${AppUrl.baseUrl}vma_row_custom_main_plan/updateFlagValue";
    // 'https://civm2.ariespro.com/civm2/vma_row_custom_main_plan/updateFlagValue';
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
          'token': token,
          'flag': flag.toString(),
          'crewId': selectedCrewLoginID,
          'status': 'ASSIGNED',
        },
      );
      print(
        "token testing $token, crewId $selectedCrewLoginID, flag ${flag.toString()}",
      );
      print("url testing $url");
      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);
        print('responseBody $responseBody');
        String crewEmailId = responseBody['crewEmailId'];
        print('API call successful');
        String message = '';
        // if (widget.heading == 'Total Order Pending (IVM Maintenance)') {
        //   message = 'IVM Maintenance';
        // } else if (widget.heading ==
        //     'Total Order Pending (Mid cycle Herbicide)') {
        //   message = 'Mid cycle Herbicide';
        // }
        CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
          'Job no: $token $message Successfully Shared with Crew',
          context,
        );
        print('testing $token $message Successfully Shared with Crew');
        DateTime now = DateTime.now();
        var formatter = DateFormat('MM-dd-yyyy HH:mm:ss');
        String formattedDate = formatter.format(now);
        var subject = 'CIVM ROW';
        var msg =
            'Job No. $token $message Successfully Shared with you on $formattedDate.';
        _sendMail(subject, msg, crewEmailId);
        fetchDetails(context);
        await Future.delayed(const Duration(seconds: 3));
        Navigator.pop(context);
        Navigator.pop(context);
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
    String crewEmailId,
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
        crewEmailId,
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

  Future<void> fetchCrewList() async {
    setState(() {
      isLoading = true;
    });

    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    // String contractorId = data.user!.id.toString();

    String url = AppUrl.crewList;
    // "https://civm2.ariespro.com/civm2/login_user/getAllCrewFromCREWMASTER?contractorId=$contractorId";
    print('urlCrewList gf pannel:: $url');
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
        isLoading = false;
      });
    }
  }

  Future openDailogSubmitApproval(String id) => showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    "RECALL",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Color.fromARGB(255, 7, 59, 120),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      "Job No. : $id",
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Color.fromARGB(255, 7, 59, 120),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Text(
                      "Are you sure to you want to submit this work?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Color.fromARGB(255, 7, 59, 120),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: 6,
                        right: 6,
                        bottom: 10,
                      ),
                      child: InkWell(
                        onTap: () async {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                          try {
                            await updateSubmitForApprovalStatus(id);
                            if (!mounted) return;
                            await Future.delayed(Duration(milliseconds: 100));
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.pop(context);
                          } catch (e) {
                            print(e);
                            if (mounted) {
                              Navigator.pop(context);
                            }
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10.0),
                          // padding: const EdgeInsets.all(8),
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          height: 40,
                          decoration: const BoxDecoration(
                            // shape: BoxShape.circle,
                            // borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 1, 106, 5),
                                blurRadius: 5,
                                offset: Offset(2.0, 5.0),
                              ),
                            ],
                            color: Colors.black,
                            gradient: LinearGradient(
                              colors: [Colors.green, Colors.green],
                            ),
                          ),
                          child: const Row(
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Yes",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: 6,
                        right: 6,
                        bottom: 10,
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10.0),
                          // padding: const EdgeInsets.all(8),
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          height: 40,
                          decoration: const BoxDecoration(
                            // shape: BoxShape.circle,
                            // borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 139, 10, 0),
                                blurRadius: 5,
                                offset: Offset(2.0, 5.0),
                              ),
                            ],
                            color: Colors.black,
                            gradient: LinearGradient(
                              colors: [Colors.red, Colors.red],
                            ),
                          ),
                          child: const Row(
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "No",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
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
          );
        },
      );
    },
  );

  Future<void> updateSubmitForApprovalStatus(String tokenNo) async {
    String baseUrl =
        'https://civm2.ariespro.com/civm2/workOrderPendingAndReject/updateStatusFromRejectedToPendingApproval';
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    final Map<String, String> queryParams = {
      //  'status': 'WORK FOR APPROVAL',
      'status': 'RECALL',
      // 'PENDING LCP APPROVAL',
      // 'PENDING APPROVAL',
      'tokenNo': tokenNo,
    };
    final String url = Uri.parse(
      baseUrl,
    ).replace(queryParameters: queryParams).toString();
    print('url: $url');
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": 'Bearer ${data.token!}',
    };

    try {
      final response = await http.put(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        print('Status updated successfully');
        if (context.mounted) {
          CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
            'Job No. $tokenNo Approved Successfully',
            context,
          );
        }
        fetchDetails(context);
      } else {
        print('Failed to update status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  
   Future<void> getUserType() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String userType = pref.getString('userType').toString();
    String primaryRole = pref.getString('primaryRole').toString();
    if(userType == '3'){
      userTypeText = 'General Foreman';
    }else if(userType == '6'){
      userTypeText = 'Planner';
    }
    if(primaryRole == '3'){
      primaryRoleText = 'General Foreman';
    }else if(primaryRole == '6'){
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
