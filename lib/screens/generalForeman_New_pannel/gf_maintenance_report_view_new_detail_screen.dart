import 'dart:convert';
import 'dart:math' as math;
import 'package:CIVM/models/primary_secondary_mile_model.dart';
import 'package:CIVM/repository/map_url.dart';
import 'package:CIVM/screens/login_page.dart';
import 'package:CIVM/screens/offline_map/map_screen_gf.dart';
import 'package:CIVM/screens/work_progress_span_widget.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:intl/intl.dart';
import 'package:CIVM/models/ivm_all_status_model.dart';
import 'package:CIVM/models/log_model.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/models/work_progress_model.dart';
import 'package:CIVM/screens/row_method_progress_widget_gf_maintenance_report_view.dart';
import 'package:CIVM/utils/history_card.dart';
import 'package:CIVM/utils/work_progress_api.dart';
import 'package:CIVM/view_model/lcp_document_approval_view_model.dart';
import 'package:CIVM/resources/app_url.dart';
import 'package:CIVM/screens/my_chrome_safari_map_recording.dart';
import 'package:CIVM/utils/common_functions.dart';
import 'package:CIVM/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/view_model/image_code_view_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:CIVM/screens/admin_pannel/row_maintenance_view/pdf_view.dart';
import 'package:CIVM/screens/video_folder/fullVideo/full_screen_video_player.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class GFMaintenanceReportViewDetailsScreen extends StatefulWidget {
  String tokenNo;
  GFMaintenanceReportViewDetailsScreen({super.key, required this.tokenNo});

  @override
  State<GFMaintenanceReportViewDetailsScreen> createState() =>
      _GFMaintenanceReportViewDetailsScreenState();
}

class _GFMaintenanceReportViewDetailsScreenState
    extends State<GFMaintenanceReportViewDetailsScreen> {
  final TextEditingController _notes = TextEditingController();
  final TextEditingController _input = TextEditingController();
  Future? myFuture;
  bool isError = false;
  bool isLoading = false;
  ImageViewViewModel imageViewModel = ImageViewViewModel();
  bool _isApproveLoading = false;
  bool _isCancelLoading = false;
  String crewList = '';
  List<Map<String, dynamic>> crewList1 = [];
  String? selectedCrew;
  bool isSubmittingMasterJob = false;
  String selectedCrewLoginID = '';
  String? rights;
  // bool _isVisibleChangeOrder = true;
  final browser = MyChromeSafariBrowser();
  String formattedNextMaintDue = '';
  LCPDocumentApprovalPendingViewModel lCPDocumentApprovalPendingViewModel =
      LCPDocumentApprovalPendingViewModel();

  List<dynamic> foremanList = [];

  String? selectedForemanName;
  int? selectedLoginId;
  bool isUpdatingMasterJob = false;
  String oldMasterJobNo = '';
  String userTypeText = '';
  String primaryRoleText = '';

  bool loading = true;
  List<WorkProgressModel> list = [];
  FindAllTableData1? item;
  List<dynamic> reportList = [];
  String status = '';
  TextEditingController searchController = TextEditingController();
  List<dynamic> filteredReportList = [];
  bool isSendingForLcp = false;
  Map<int, String> selectedCrewMap = {};
  PrimarySecondaryMileModel? primarySecondaryMileModel;

  final Map<String, Color> methodColors = {
    "JARRAFF": const Color.fromARGB(255, 96, 0, 113),
    "MOWING": const Color.fromARGB(255, 113, 68, 1),
    "MINI JARRAFF": const Color.fromARGB(255, 247, 19, 2),
    "BYL": const Color.fromARGB(255, 2, 212, 249),
    "BUCKET": Colors.orange,
    "GROUND": Colors.yellow,
    "CROSS-COUNTRY SPRAY": const Color.fromARGB(255, 38, 1, 247),
    "ROADSIDE SPRAY": const Color.fromARGB(255, 1, 127, 5),
    "NO SPRAY": const Color.fromARGB(255, 252, 199, 249),
  };

  double primaryMileProgress = 0.0;
  double secondaryMileProgress = 0.0;
  var secondaryFlex;
  var primaryFlex;

  double primarySpanProgress = 0.0;
  double secondarySpanProgress = 0.0;

  var secondaryFlexSpan;
  var primaryFlexSpan;

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      setState(() {});
    });
    myFuture = Future.wait([
      fetchMaintenanceReport(context),
      imageViewModel.fetchImageApi(context, widget.tokenNo),
    ]);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadData();
      loadPrimarySecondaryMiles();
    });
    getUserType();
    _initializeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Maintenance Report View Details',
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
                  // await fetchMaintenanceReport(context);
                  myFuture = Future.wait([
                    fetchMaintenanceReport(context),
                    imageViewModel.fetchImageApi(context, widget.tokenNo),
                  ]);
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ///  HEADER CARD
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8,
                          bottom: 0,
                          left: 8,
                          right: 8,
                        ),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(0),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  children: [
                                    /// Header
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Job No. ${widget.tokenNo}",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                ),
                                              ),

                                              Text(
                                                "Master Job No. ${reportList[0]["masterJobNo"]}",
                                                style: TextStyle(
                                                  color: Colors.grey.shade600,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 5,
                                          ),
                                          decoration: BoxDecoration(
                                            color: getStatusColor(
                                              reportList[0]["status"],
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              30,
                                            ),
                                          ),
                                          child: Text(
                                            reportList[0]["status"],
                                            style: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    if (reportList[0]["showICon"] == "TRUE")
                                      Row(
                                        children: [
                                          Spacer(),

                                          InkWell(
                                            onTap: isSendingForLcp
                                                ? null
                                                : () async {
                                                    await sendForLcpInspection();
                                                  },
                                            child: Container(
                                              constraints: const BoxConstraints(
                                                minWidth: 150,
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 5,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              child: isSendingForLcp
                                                  ? Center(
                                                      child: const SizedBox(
                                                        height: 18,
                                                        width: 18,
                                                        child: CircularProgressIndicator(
                                                          strokeWidth: 2.2,
                                                          valueColor:
                                                              AlwaysStoppedAnimation<
                                                                Color
                                                              >(Colors.white),
                                                        ),
                                                      ),
                                                    )
                                                  : Center(
                                                      child: Text(
                                                        'Send For LCP Inspection',
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                            ),
                                          ),
                                        ],
                                      ),

                                    const Divider(height: 20),

                                    Row(
                                      children: [
                                        Expanded(
                                          child: infoTile(
                                            Icons.location_city,
                                            "Substation",
                                            reportList[0]["subStateName"],
                                          ),
                                        ),

                                        Expanded(
                                          child: infoTile(
                                            Icons.electrical_services,
                                            "Feeder",
                                            reportList[0]["feederName"],
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 10),

                                    Row(
                                      children: [
                                        Expanded(
                                          child: infoTile(
                                            Icons.groups,
                                            "Crew",
                                            crewList.toString(),
                                          ),
                                        ),

                                        Expanded(
                                          child: infoTile(
                                            Icons.person,
                                            "Initiated By",
                                            reportList[0]["initiatedBy"],
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 10),

                                    Row(
                                      children: [
                                        Expanded(
                                          child: infoTile(
                                            Icons.account_tree,
                                            "Maintenance Type",
                                            reportList[0]["budgetType"],
                                          ),
                                        ),
                                        Expanded(
                                          child: infoTile(
                                            Icons.account_tree,
                                            "Maint Year",
                                            getYearOrNA(
                                              reportList[0]["contractYear"],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    //                 Padding(
                                    //   padding: const EdgeInsets.only(
                                    //     top: 8.0,
                                    //     bottom: 8,
                                    //   ),
                                    //   child: Container(
                                    //     width: double.infinity,
                                    //     padding: const EdgeInsets.all(16),
                                    //     decoration: BoxDecoration(
                                    //       color: Colors.white,
                                    //       borderRadius: BorderRadius.circular(12),
                                    //       boxShadow: [
                                    //         BoxShadow(
                                    //           color: Colors.black12,
                                    //           blurRadius: 5,
                                    //         ),
                                    //       ],
                                    //     ),
                                    //     child: Column(
                                    //       crossAxisAlignment: CrossAxisAlignment.start,
                                    //       children: [
                                    //         const Text(
                                    //           "Mileage and Span Count (Secondary/Primary/Total)",
                                    //           style: TextStyle(
                                    //             fontSize: 16,
                                    //             fontWeight: FontWeight.bold,
                                    //             color: Color(0xff073B78),
                                    //           ),
                                    //         ),

                                    //         const SizedBox(height: 15),

                                    //         Row(
                                    //           children: [
                                    //             Text(
                                    //               "MILES : ",
                                    //               style: TextStyle(
                                    //                 fontWeight: FontWeight.bold,
                                    //                 fontSize: 14,
                                    //               ),
                                    //             ),

                                    //             Text(
                                    //               primarySecondaryMileModel?.mileage ??
                                    //                   "-",
                                    //             ),
                                    //           ],
                                    //         ),

                                    //         const SizedBox(height: 10),

                                    //         Row(
                                    //           children: [
                                    //             Text(
                                    //               "SPAN : ",
                                    //               style: TextStyle(
                                    //                 fontWeight: FontWeight.bold,
                                    //                 fontSize: 14,
                                    //               ),
                                    //             ),

                                    //             Text(
                                    //               primarySecondaryMileModel?.span ??
                                    //                   "-",
                                    //             ),
                                    //           ],
                                    //         ),
                                    //       ],
                                    //     ),
                                    //   ),
                                    // ),
                                    GestureDetector(
                                      onTap: () {
                                        _showMainSpanDialog(
                                          context,
                                          methodName: "TOTAL MILES",
                                          primaryCompleted:
                                              primarySecondaryMileModel
                                                  ?.primaryMilesCompleted ??
                                              "0",
                                          primarySpans:
                                              primarySecondaryMileModel
                                                  ?.primaryMilesTotal ??
                                              "0",
                                          secondaryCompleted:
                                              primarySecondaryMileModel
                                                  ?.secondaryMilesCompleted ??
                                              "0",
                                          secondarySpans:
                                              primarySecondaryMileModel
                                                  ?.secondaryMilesTotal ??
                                              "0",
                                          completedSpans:
                                              primarySecondaryMileModel
                                                  ?.totalMilesCompleted ??
                                              "0",
                                          totalSpans:
                                              primarySecondaryMileModel
                                                  ?.totalMilesTotal ??
                                              "0",
                                        );
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                          bottom: 6,
                                          left: 2,
                                          right: 2,
                                        ),
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            14,
                                          ),
                                          border: Border.all(
                                            color: Colors.grey.shade200,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(
                                                0.08,
                                              ),
                                              blurRadius: 5,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: const SizedBox(
                                                width: 130,
                                                child: Text(
                                                  "TOTAL MILES",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromARGB(
                                                      255,
                                                      7,
                                                      59,
                                                      120,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 2),
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: secondaryFlex,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                  10,
                                                                ),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                  10,
                                                                ),
                                                          ),
                                                      child: LinearProgressIndicator(
                                                        value:
                                                            secondaryMileProgress,
                                                        minHeight: 10,
                                                        backgroundColor: Colors
                                                            .grey
                                                            .shade300,
                                                        valueColor:
                                                            const AlwaysStoppedAnimation<
                                                              Color
                                                            >(Colors.blue),
                                                      ),
                                                    ),
                                                  ),
                                                  if ((primarySecondaryMileModel
                                                                  ?.primaryMilesTotal ??
                                                              "0.0") !=
                                                          "0.0" &&
                                                      (primarySecondaryMileModel
                                                                  ?.secondaryMilesTotal ??
                                                              "0.0") !=
                                                          "0.0")
                                                    Container(
                                                      width: 2,
                                                      height: 10,
                                                      color: Colors.black,
                                                    ),
                                                  Expanded(
                                                    flex: primaryFlex,
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius.only(
                                                        topLeft:
                                                            (primarySecondaryMileModel
                                                                    ?.secondaryMilesTotal ==
                                                                "0.0")
                                                            ? Radius.circular(
                                                                10,
                                                              )
                                                            : Radius.circular(
                                                                0,
                                                              ),
                                                        bottomLeft:
                                                            (primarySecondaryMileModel
                                                                    ?.secondaryMilesTotal ==
                                                                "0.0")
                                                            ? Radius.circular(
                                                                10,
                                                              )
                                                            : Radius.circular(
                                                                0,
                                                              ),
                                                        topRight:
                                                            Radius.circular(10),
                                                        bottomRight:
                                                            Radius.circular(10),
                                                      ),
                                                      child: LinearProgressIndicator(
                                                        value:
                                                            primaryMileProgress,
                                                        minHeight: 10,
                                                        backgroundColor: Colors
                                                            .grey
                                                            .shade300,
                                                        valueColor:
                                                            const AlwaysStoppedAnimation<
                                                              Color
                                                            >(Colors.blue),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              "${primarySecondaryMileModel?.secondaryMilesTotal ?? "0"}/"
                                              "${primarySecondaryMileModel?.primaryMilesTotal ?? "0"}/"
                                              "${primarySecondaryMileModel?.totalMilesTotal ?? "0"}",
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    WorkProgressSpanWidget(
                                      tokenNo: widget.tokenNo,
                                    ),

                                    // Padding(
                                    //   padding: const EdgeInsets.only(top: 8.0),
                                    //   child: Row(
                                    //     children: [
                                    //       Container(
                                    //         padding: const EdgeInsets.all(6),
                                    //         decoration: BoxDecoration(
                                    //           color: const Color(
                                    //             0xff073B78,
                                    //           ).withOpacity(0.1),
                                    //           borderRadius:
                                    //               BorderRadius.circular(8),
                                    //         ),
                                    //         child: const Icon(
                                    //           Icons.analytics_outlined,
                                    //           size: 18,
                                    //           color: Color(0xff073B78),
                                    //         ),
                                    //       ),
                                    //       const SizedBox(width: 8),

                                    //       const Text(
                                    //         "Work Progress by Span",
                                    //         style: TextStyle(
                                    //           fontSize: 15,
                                    //           fontWeight: FontWeight.bold,
                                    //           color: Color(0xff073B78),
                                    //         ),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                    // const SizedBox(height: 10),
                                    // Tooltip(
                                    //   message:
                                    //       "Secondary: ${primarySecondaryMileModel?.secondarySpanCompleted ?? "0"} / ${primarySecondaryMileModel?.secondarySpanTotal ?? "0"}"
                                    //       "\nPrimary: ${primarySecondaryMileModel?.primarySpanCompleted ?? "0"} / ${primarySecondaryMileModel?.primarySpanTotal ?? "0"}"
                                    //       "\nTotal: ${primarySecondaryMileModel?.totalSpanCompleted ?? "0"} / ${primarySecondaryMileModel?.totalSpanTotal ?? "0"}",
                                    //   triggerMode: TooltipTriggerMode.tap,
                                    //   child: Container(
                                    //     margin: const EdgeInsets.only(
                                    //       bottom: 6,
                                    //       left: 2,
                                    //       right: 2,
                                    //     ),
                                    //     padding: const EdgeInsets.all(10),
                                    //     decoration: BoxDecoration(
                                    //       color: Colors.white,
                                    //       borderRadius: BorderRadius.circular(
                                    //         14,
                                    //       ),
                                    //       border: Border.all(
                                    //         color: Colors.grey.shade200,
                                    //       ),
                                    //       boxShadow: [
                                    //         BoxShadow(
                                    //           color: Colors.black.withOpacity(
                                    //             0.08,
                                    //           ),
                                    //           blurRadius: 5,
                                    //           offset: const Offset(0, 3),
                                    //         ),
                                    //       ],
                                    //     ),
                                    //     child: Row(
                                    //       children: [
                                    //         Expanded(
                                    //           child: const SizedBox(
                                    //             width: 130,
                                    //             child: Text(
                                    //               "TOTAL SPAN",
                                    //               style: TextStyle(
                                    //                 fontSize: 16,
                                    //                 fontWeight: FontWeight.bold,
                                    //                 color: Color.fromARGB(
                                    //                   255,
                                    //                   7,
                                    //                   59,
                                    //                   120,
                                    //                 ),
                                    //               ),
                                    //             ),
                                    //           ),
                                    //         ),
                                    //         SizedBox(width: 2),
                                    //         Expanded(
                                    //           child: Row(
                                    //             children: [
                                    //               Expanded(
                                    //                 flex: secondaryFlexSpan,
                                    //                 child: ClipRRect(
                                    //                   borderRadius:
                                    //                       const BorderRadius.only(
                                    //                         topLeft:
                                    //                             Radius.circular(
                                    //                               10,
                                    //                             ),
                                    //                         bottomLeft:
                                    //                             Radius.circular(
                                    //                               10,
                                    //                             ),
                                    //                       ),
                                    //                   child: LinearProgressIndicator(
                                    //                     value:
                                    //                         secondarySpanProgress,
                                    //                     minHeight: 10,
                                    //                     backgroundColor: Colors
                                    //                         .grey
                                    //                         .shade300,
                                    //                     valueColor:
                                    //                         const AlwaysStoppedAnimation<
                                    //                           Color
                                    //                         >(Colors.blue),
                                    //                   ),
                                    //                 ),
                                    //               ),
                                    //               Container(
                                    //                 width: 2,
                                    //                 height: 10,
                                    //                 color: Colors.black,
                                    //               ),
                                    //               Expanded(
                                    //                 flex: primaryFlexSpan,
                                    //                 child: ClipRRect(
                                    //                   borderRadius:
                                    //                       const BorderRadius.only(
                                    //                         topRight:
                                    //                             Radius.circular(
                                    //                               10,
                                    //                             ),
                                    //                         bottomRight:
                                    //                             Radius.circular(
                                    //                               10,
                                    //                             ),
                                    //                       ),
                                    //                   child: LinearProgressIndicator(
                                    //                     value:
                                    //                         primarySpanProgress,
                                    //                     minHeight: 10,
                                    //                     backgroundColor: Colors
                                    //                         .grey
                                    //                         .shade300,
                                    //                     valueColor:
                                    //                         const AlwaysStoppedAnimation<
                                    //                           Color
                                    //                         >(Colors.blue),
                                    //                   ),
                                    //                 ),
                                    //               ),
                                    //             ],
                                    //           ),
                                    //         ),
                                    //         SizedBox(width: 10),
                                    //         Text(
                                    //           "${primarySecondaryMileModel?.secondarySpanTotal ?? "0"}/"
                                    //           "${primarySecondaryMileModel?.primarySpanTotal ?? "0"}/"
                                    //           "${primarySecondaryMileModel?.totalSpanTotal ?? "0"}",
                                    //           style: const TextStyle(
                                    //             fontSize: 15,
                                    //             fontWeight: FontWeight.w500,
                                    //           ),
                                    //         ),
                                    //       ],
                                    //     ),
                                    //   ),
                                    // ),

                                    // GridView.builder(
                                    //   shrinkWrap: true,
                                    //   physics:
                                    //       const NeverScrollableScrollPhysics(),
                                    //   itemCount: list.length,
                                    //   gridDelegate:
                                    //       const SliverGridDelegateWithFixedCrossAxisCount(
                                    //         crossAxisCount: 2, // 👈 2 in a row
                                    //         mainAxisSpacing: 2,
                                    //         crossAxisSpacing: 2,
                                    //         // childAspectRatio:
                                    //         //     2.2, // adjust height
                                    //         mainAxisExtent: 75,
                                    //       ),
                                    //   itemBuilder: (context, index) {
                                    //     final item = list[index];

                                    //     final progress = item.totalSpans == 0
                                    //         ? 0.0
                                    //         : item.completedSpans /
                                    //               item.totalSpans;
                                    //     final Color methodColor =
                                    //         methodColors[item.maintType
                                    //             .toUpperCase()] ??
                                    //         Colors.blue;
                                    //     return Container(
                                    //       padding: const EdgeInsets.all(10),
                                    //       decoration: BoxDecoration(
                                    //         borderRadius: BorderRadius.circular(
                                    //           14,
                                    //         ),
                                    //         border: Border.all(
                                    //           color: Colors.grey.shade200,
                                    //         ),
                                    //         color: Colors.white,
                                    //         boxShadow: [
                                    //           BoxShadow(
                                    //             color: Colors.black.withOpacity(
                                    //               0.04,
                                    //             ),
                                    //             blurRadius: 8,
                                    //             offset: const Offset(0, 3),
                                    //           ),
                                    //         ],
                                    //       ),
                                    //       child: Column(
                                    //         mainAxisSize: MainAxisSize.min,
                                    //         crossAxisAlignment:
                                    //             CrossAxisAlignment.start,
                                    //         children: [
                                    //           /// ICON + TITLE
                                    //           Row(
                                    //             children: [
                                    //               const Icon(
                                    //                 Icons.engineering,
                                    //                 color: Color(0xff073B78),
                                    //                 size: 18,
                                    //               ),
                                    //               const SizedBox(width: 6),
                                    //               Expanded(
                                    //                 child: Text(
                                    //                   item.maintType,
                                    //                   maxLines: 1,
                                    //                   overflow:
                                    //                       TextOverflow.ellipsis,
                                    //                   style: const TextStyle(
                                    //                     fontWeight:
                                    //                         FontWeight.w600,
                                    //                     fontSize: 10,
                                    //                   ),
                                    //                 ),
                                    //               ),
                                    //             ],
                                    //           ),

                                    //           const SizedBox(height: 10),

                                    //           /// PROGRESS BAR
                                    //           Row(
                                    //             children: [
                                    //               Expanded(
                                    //                 child: ClipRRect(
                                    //                   borderRadius:
                                    //                       BorderRadius.circular(
                                    //                         10,
                                    //                       ),
                                    //                   child: LinearProgressIndicator(
                                    //                     value: progress,
                                    //                     minHeight: 5,
                                    //                     backgroundColor: Colors
                                    //                         .grey
                                    //                         .shade200,
                                    //                     valueColor:
                                    //                         AlwaysStoppedAnimation(
                                    //                           methodColor,
                                    //                         ),
                                    //                   ),
                                    //                 ),
                                    //               ),

                                    //               const SizedBox(width: 8),

                                    //               /// COUNT
                                    //               SizedBox(
                                    //                 width: 55,
                                    //                 child: Text(
                                    //                   "${item.completedSpans}/${item.totalSpans}",
                                    //                   textAlign: TextAlign.end,
                                    //                   style: TextStyle(
                                    //                     fontSize: 11,
                                    //                     color: Colors
                                    //                         .grey
                                    //                         .shade700,
                                    //                     fontWeight:
                                    //                         FontWeight.w500,
                                    //                   ),
                                    //                 ),
                                    //               ),
                                    //             ],
                                    //           ),
                                    //         ],
                                    //       ),
                                    //     );
                                    //   },
                                    // ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.shade200,
                                            blurRadius: 10,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          /// ROW 1
                                          Row(
                                            children: [
                                              Expanded(
                                                child: _actionTile(
                                                  icon: Icons.history,
                                                  label: "History",
                                                  color: Colors.orange,
                                                  onTap: () {
                                                    showHistoryDialog(
                                                      context,
                                                      int.parse(
                                                        widget.tokenNo
                                                            .toString(),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: _actionTile(
                                                  icon: Icons.map,
                                                  label: "View Map",
                                                  color: Colors.blue,
                                                  onTap: () async {
                                                    // String id = '';
                                                    // final userPreferences1 =
                                                    //     Provider.of<UserPref>(
                                                    //       context,
                                                    //       listen: false,
                                                    //     );
                                                    // UserModel data =
                                                    //     await userPreferences1
                                                    //         .getUser();
                                                    // id = data.user!.id
                                                    //     .toString();
                                                    // print(
                                                    //   'map url:: ${MapUrl.getGfEndPoint(widget.tokenNo.toString(), id)}',
                                                    // );
                                                    // await browser.open(
                                                    //   url: WebUri(
                                                    //     MapUrl.getGfEndPoint(
                                                    //       widget.tokenNo
                                                    //           .toString(),
                                                    //       id,
                                                    //     ),
                                                    //   ),
                                                    //   settings: ChromeSafariBrowserSettings(
                                                    //     shareState:
                                                    //         CustomTabsShareState
                                                    //             .SHARE_STATE_OFF,
                                                    //     barCollapsingEnabled:
                                                    //         true,
                                                    //   ),
                                                    // );
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            MapScreenGF(
                                                              jobNo: widget
                                                                  .tokenNo,
                                                              substation:
                                                                  "${reportList[0]["subStateName"]}",
                                                              feeder:
                                                                  reportList[0]["feederName"]
                                                                      .split(
                                                                        '(',
                                                                      )
                                                                      .first
                                                                      .trim(),
                                                              visibilityFlag:  "1",
                                                              type:  "${reportList[0]["type"]}",
                                                              sourcePage: "maintenanceReportView",
                                                              crew: item!.crew.toString(),
                                                            ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),

                                          const SizedBox(height: 10),

                                          /// ROW 2
                                          Row(
                                            children: [
                                              Expanded(
                                                child: _actionTile(
                                                  icon:
                                                      Icons.analytics_outlined,
                                                  label: "Progress by Miles",
                                                  color: Colors.green,
                                                  onTap: () {
                                                    showRowMethodProgressDialog(
                                                      context,
                                                      widget.tokenNo.toString(),
                                                    );
                                                  },
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: _actionTile(
                                                  icon: Icons.list_alt,
                                                  label:
                                                      "Failed Inspection List",
                                                  color: Colors.pink,
                                                  onTap: () async {
                                                    // Show loader
                                                    showDialog(
                                                      context: context,
                                                      barrierDismissible: false,
                                                      builder: (_) => const Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      ),
                                                    );

                                                    try {
                                                      final reworkList =
                                                          await getSupervisorReworkDetails();

                                                      // Close loader
                                                      Navigator.of(
                                                        context,
                                                      ).pop();
                                                      showReworkSupervisorDialog(
                                                        context,
                                                        reworkList,
                                                      );
                                                    } catch (e) {
                                                      // Close loader
                                                      Navigator.of(
                                                        context,
                                                      ).pop();

                                                      ScaffoldMessenger.of(
                                                        context,
                                                      ).showSnackBar(
                                                        const SnackBar(
                                                          content: Text(
                                                            "Failed to load rework details.",
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),

                                          const SizedBox(height: 10),

                                          /// ROW 3
                                          Row(
                                            children: [
                                              Expanded(
                                                child: _actionTile(
                                                  icon: Icons.list_alt,
                                                  label: "Rework List",
                                                  color: Colors.purple,
                                                  onTap: () async {
                                                    // Show loader
                                                    showDialog(
                                                      context: context,
                                                      barrierDismissible: false,
                                                      builder: (_) => const Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      ),
                                                    );

                                                    try {
                                                      final reworkList =
                                                          await getGFReworkDetails();

                                                      // Close loader
                                                      Navigator.of(
                                                        context,
                                                      ).pop();
                                                      showReworkGFDialog(
                                                        context,
                                                        reworkList,
                                                      );
                                                    } catch (e) {
                                                      // Close loader
                                                      Navigator.of(
                                                        context,
                                                      ).pop();

                                                      ScaffoldMessenger.of(
                                                        context,
                                                      ).showSnackBar(
                                                        const SnackBar(
                                                          content: Text(
                                                            "Failed to load rework details.",
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  },
                                                ),
                                              ),
                                              const SizedBox(width: 10),

                                              Expanded(child: Container()),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
                            child: TextField(
                              controller: searchController,
                              onChanged: filterReports,
                              decoration: InputDecoration(
                                hintText: "Search by Type/Crew/Date",
                                prefixIcon: const Icon(Icons.search),
                                suffixIcon: searchController.text.isNotEmpty
                                    ? IconButton(
                                        icon: const Icon(Icons.clear),
                                        onPressed: () {
                                          searchController.clear();
                                          filterReports("");
                                        },
                                      )
                                    : null,
                                filled: true,
                                fillColor: Colors.grey.shade100,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  // itemCount: reportList.length,
                                  itemCount: filteredReportList.length,
                                  itemBuilder: (context, index) {
                                    // final item = reportList[index];
                                    final item = filteredReportList[index];
                                    return Card(
                                      elevation: 1,
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 5,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                CircleAvatar(
                                                  backgroundColor:
                                                      Colors.blue.shade50,
                                                  child: const Icon(
                                                    Icons.route,
                                                    color: Colors.blue,
                                                  ),
                                                ),

                                                const SizedBox(width: 10),

                                                Expanded(
                                                  child: Text(
                                                    item["rowMethod"] ?? "",
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),

                                                Container(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 4,
                                                      ),
                                                  decoration: BoxDecoration(
                                                    color:
                                                        Colors.green.shade100,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          20,
                                                        ),
                                                  ),
                                                  child: Text(
                                                    formatDate(
                                                      item["createDate"] ?? "",
                                                    ),
                                                    style: const TextStyle(
                                                      fontSize: 11,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 6),

                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    "Completed : ${item["milesCompleted"]} / Pending : ${item["milesPending"]} Miles",
                                                    style: TextStyle(
                                                      color:
                                                          Colors.grey.shade700,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        right: 8.0,
                                                      ),
                                                  child: Text(
                                                    item["crewName"] ?? "",
                                                    style: const TextStyle(
                                                      fontSize: 11,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),

                                            const SizedBox(height: 6),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                        ],
                      ),

                      // Align(
                      //   alignment: Alignment.centerLeft,
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(left: 8.0),
                      //     child: Container(
                      //       width: 105,
                      //       // double.infinity,
                      //       padding: const EdgeInsets.symmetric(vertical: 8),
                      //       decoration: BoxDecoration(
                      //         color: Colors.blue.shade50,
                      //         borderRadius: BorderRadius.circular(10),
                      //         border: Border.all(color: Colors.blue),
                      //       ),
                      //       child: const Row(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           Icon(Icons.image, color: Colors.blue),
                      //           SizedBox(width: 8),
                      //           Text(
                      //             "Images",
                      //             style: TextStyle(
                      //               color: Colors.blue,
                      //               fontWeight: FontWeight.bold,
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(height: 8),

                      ///  IMAGE GRID VIEW
                      // Padding(
                      //   padding: const EdgeInsets.only(left:8.0),
                      //   child: _buildImageGrid(),
                      // ),

                      // const SizedBox(height: 8),
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

  Future<void> fetchMaintenanceReport(BuildContext context) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();

    final uri = Uri.parse(AppUrl.supervisorMaintenanceReportViewEndPoint)
        .replace(
          queryParameters: {
            "type": "",
            "substation": "",
            "feeder": "",
            "id": "",
            "tokenNo": widget.tokenNo.toString(),
          },
        );

    print("URL : $uri");

    var headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${data.token!}",
    };

    try {
      setState(() {
        isLoading = true;
      });

      final response = await http.get(uri, headers: headers);

      print(response.body);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        setState(() {
          reportList = json["findAllJoinDatas"] ?? [];
          crewList = json["crewName"] ?? "";
          filteredReportList = List.from(reportList);
          isLoading = false;
        });
        print("Report List Length: ${reportList.length}");
      } else {
        setState(() {
          isLoading = false;
        });

        print("Error : ${response.statusCode}");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      print(e);
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
                      'File',
                      context,
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
                                'File',
                                context,
                              );
                              Navigator.pop(context);
                            } else {
                              downloadFile(
                                'https://civm.ariespro.com/assets/clientuploads/$fileLocation',
                                'PDF',
                                context,
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

        // fetchMaintenanceReport(context);
        myFuture = Future.wait([
          fetchMaintenanceReport(context),
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

  Future openDailogPendingApproval(
    String tokenNo,
    String status,
    String reWork,
  ) => showDialog(
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
                            "Chage Order No. : $tokenNo",
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
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.all(2.0),
                                child: Text(
                                  "Notes",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Color.fromARGB(255, 7, 59, 120),
                                  ),
                                ),
                              ),
                            ),
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
                      approveOrCancelOrder(tokenNo, status, reWork);
                      // if (_formKey.currentState!.validate()) {
                      //   print('a');
                      //   Navigator.pop(context);
                      // }
                    },
                    isLoading: _isApproveLoading,
                  ),
                  CommonActionButton(
                    title: "Cancel",
                    gradientColors: [Colors.red, Colors.red],
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          );
        },
      );
    },
  );

  void approveOrCancelOrder(
    String tokenNo,
    String status,
    String reWork,
  ) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    String id = data.user!.id.toString();
    final String url =
        '${AppUrl.baseUrl}changeOrderLcpCreateOrder/approveOrCancelByToken?tokenNo=$tokenNo&status=$status&id=$id&notes=${_notes.text}&reWork=$reWork';
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
        if (status == 'WORK FOR APPROVAL') {
          CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
            'Status of $tokenNo successfully changed to Work For Approval',
            context,
          );
        } else if (status == 'CANCELLED') {
          CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
            'Status of $tokenNo successfully changed to Cancelled',
            context,
          );
        }

        fetchMaintenanceReport(context);
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

  Future openDailogCancel(String tokenNo, String status, String reWork) =>
      showDialog(
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
                                "CANCEL JOB NO.",
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
                                "Token No. : $tokenNo",
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
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.all(2.0),
                                    child: Text(
                                      "Cancellation Notes",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Color.fromARGB(255, 7, 59, 120),
                                      ),
                                    ),
                                  ),
                                ),
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
                                            color: Color.fromARGB(
                                              255,
                                              7,
                                              59,
                                              120,
                                            ),
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
                          approveOrCancelOrder(tokenNo, status, reWork);
                          // if (_formKey.currentState!.validate()) {
                          //   print('a');
                          //   Navigator.pop(context);
                          // }
                        },
                        isLoading: _isCancelLoading,
                      ),
                      CommonActionButton(
                        title: "Cancel",
                        gradientColors: [Colors.red, Colors.red],
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
      );

  Widget buildInfoTile({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(icon, color: const Color(0xFF2575FC), size: 22),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void showHistoryDialog(BuildContext context, int tokenNo) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            height: 550,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: const BoxDecoration(
                    color: Color(0xff073B78),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.history, color: Colors.white),
                      const SizedBox(width: 10),
                      const Text(
                        "Activity History",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 18,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: FutureBuilder<List<LogModel>>(
                    future: getLogs(tokenNo),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text("No History Found"));
                      }

                      final logs = snapshot.data!;

                      return ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: logs.length,
                        itemBuilder: (context, index) {
                          // final log = logs[index];
                          return historyCard(logs[index], index);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<List<LogModel>> getLogs(int tokenNo) async {
    try {
      final userPreferences = Provider.of<UserPref>(context, listen: false);
      UserModel data = await userPreferences.getUser();
      final response = await http.get(
        Uri.parse(
          AppUrl.getAllLogs,
        ).replace(queryParameters: {"tokenNo": tokenNo.toString()}),
        headers: {"Authorization": "Bearer ${data.token!}"},
      );

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);

        return data.map((e) => LogModel.fromJson(e)).toList();
      }

      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<bool> addLog(
    BuildContext context,
    String action,
    String description,
    int performedBy,
    int tokenNo,
  ) async {
    try {
      final userPreferences = Provider.of<UserPref>(context, listen: false);

      UserModel user = await userPreferences.getUser();

      final Map<String, dynamic> mappedData = {
        "action": action,
        "description": description,
        "performedBy": performedBy,
        "tokenNo": tokenNo,
      };

      print("Log Request: ${jsonEncode(mappedData)}");

      final response = await http.post(
        Uri.parse(AppUrl.logs),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${user.token}",
        },
        body: jsonEncode(mappedData),
      );

      print("Log Status Code: ${response.statusCode}");
      print("Log Response: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }

      return false;
    } catch (e) {
      print("Add Log Error: $e");
      return false;
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

  Future<void> loadData() async {
    try {
      list = await WorkProgressApi.getWorkProgress(
        int.parse(widget.tokenNo.toString()),
        context,
      );

      setState(() {
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });

      debugPrint(e.toString());
    }
  }

  Widget infoTile(IconData icon, String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: Colors.blue),

        const SizedBox(width: 6),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 11),
              ),

              Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color:
                      (title == 'Maint Year' &&
                          (value != "N/A" &&
                              int.tryParse(value) != null &&
                              int.parse(value) > DateTime.now().year))
                      ? Colors.red
                      : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void showRowMethodProgressDialog(BuildContext context, String tokenNo) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
          child: Container(
            width: double.maxFinite,
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.8,
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// Header
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "PROGRESS DETAILS",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff073B78),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),

                const Divider(),

                /// Content
                Expanded(
                  child: SingleChildScrollView(
                    child: RowMethodProgressWidgetGfMaintenanceReportView(
                      tokenNo: tokenNo,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _actionTile({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String formatDate(String dateStr) {
    DateTime date = DateTime.parse(dateStr);
    return DateFormat('MM/dd/yyyy').format(date);
  }

  void filterReports(String query) {
    query = query.toLowerCase().trim();

    setState(() {
      if (query.isEmpty) {
        filteredReportList = List.from(reportList);
        return;
      }

      filteredReportList = reportList.where((item) {
        final rowMethod = (item["rowMethod"] ?? "").toString().toLowerCase();
        final crewName = (item["crewName"] ?? "").toString().toLowerCase();
        final date = formatDate(item["createDate"] ?? "").toLowerCase();

        return rowMethod.contains(query) ||
            crewName.contains(query) ||
            date.contains(query);
      }).toList();
    });
  }

  Future<void> sendForLcpInspection() async {
    setState(() {
      isSendingForLcp = true;
    });
    try {
      final userPreferences = Provider.of<UserPref>(context, listen: false);
      UserModel data = await userPreferences.getUser();

      var api =
          "${AppUrl.baseUrl}work_order_pending_approval/updateStatusByTokenNo?tokenNo=${widget.tokenNo}&status=PENDING LCP INSPECTION";
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
        fetchMaintenanceReport(context);
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
          isSendingForLcp = false;
        });
      }
    }
  }

  void showReworkSupervisorDialog(
    BuildContext context,
    List<Map<String, dynamic>> reworkList,
  ) {
    List<Map<String, dynamic>> dialogReworkList =
        List<Map<String, dynamic>>.from(reworkList);
    Map<int, bool> isEditingCrew = {};
    final scaffoldContext = context;
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                constraints: const BoxConstraints(maxHeight: 550),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.list_alt, color: Colors.pink),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: Text(
                            "Failed Inspection List",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),

                    const Divider(),

                    Expanded(
                      child: reworkList.isEmpty
                          ? const Center(
                              child: Text(
                                "No Failed Inspection Found",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          : ListView.builder(
                              itemCount: dialogReworkList.length,
                              // reworkList.length,
                              itemBuilder: (context, index) {
                                final item = dialogReworkList[index];
                                final bool hasCrew = (item["crewName"] ?? "")
                                    .toString()
                                    .trim()
                                    .isNotEmpty;
                                final String status = (item["status"] ?? "")
                                    .toString()
                                    .trim()
                                    .toLowerCase();
                                final bool canEdit =
                                    (status == "rework" ||
                                    status == "failed" ||
                                    status == "rejected");
                                return Card(
                                  elevation: 3,
                                  margin: const EdgeInsets.only(bottom: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(14),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _infoRow(
                                          Icons.route,
                                          "Span Name",
                                          item["spanName"]?.toString() ?? "",
                                        ),
                                        const SizedBox(height: 8),
                                        _infoRow(
                                          Icons.settings,
                                          "Maintenance Type",
                                          item["maintType"]?.toString() ?? "",
                                        ),

                                        const SizedBox(height: 8),

                                        _infoRow(
                                          Icons.info,
                                          "Status",
                                          item["status"]?.toString() ?? "",
                                        ),

                                        const SizedBox(height: 8),

                                        _infoRow(
                                          Icons.access_time,
                                          "Date",
                                          formatDate1(
                                            item["supervisorTime"]?.toString(),
                                          ),
                                        ),

                                        const SizedBox(height: 8),
                                        Visibility(
                                          visible:
                                              hasCrew &&
                                              !(isEditingCrew[index] ?? false),
                                          // !(isEditingCrew[index] ?? false),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: _infoRow(
                                                  Icons.groups,
                                                  "Crew",
                                                  item["crewName"].toString(),
                                                ),
                                              ),
                                              if (canEdit)
                                                IconButton(
                                                  icon: const Icon(
                                                    Icons.edit,
                                                    color: Colors.blue,
                                                    size: 20,
                                                  ),
                                                  tooltip: "Edit Crew",
                                                  // onPressed: () async {
                                                  //   setDialogState(() {
                                                  //     isEditingCrew[index] = true;
                                                  //   });
                                                  // },
                                                  onPressed: () async {
                                                    await fetchCrewList(
                                                      item["maintType"]
                                                          .toString(),
                                                    );

                                                    await Future.delayed(
                                                      const Duration(
                                                        milliseconds: 300,
                                                      ),
                                                    );

                                                    setDialogState(() {
                                                      isEditingCrew[index] =
                                                          true;
                                                    });
                                                  },
                                                ),
                                            ],
                                          ),
                                        ),
                                        Visibility(
                                          visible:
                                              !hasCrew ||
                                              (isEditingCrew[index] ?? false),
                                          // isEditingCrew[index] ?? false,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.groups,
                                                color: Colors.blue,
                                                size: 20,
                                              ),
                                              const SizedBox(width: 10),
                                              const Text(
                                                "Crew : ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              const SizedBox(width: 8),

                                              Expanded(
                                                child: FutureBuilder(
                                                  future: fetchCrewList(
                                                    item["maintType"]
                                                        .toString(),
                                                  ),
                                                  builder: (context, snapshot) {
                                                    if (selectedCrewMap[index] ==
                                                            null &&
                                                        item["crewId"] !=
                                                            null &&
                                                        item["crewId"]
                                                            .toString()
                                                            .isNotEmpty) {
                                                      selectedCrewMap[index] =
                                                          item["crewId"]
                                                              .toString();
                                                    }

                                                    return DropdownButtonFormField<
                                                      String
                                                    >(
                                                      isExpanded: true,
                                                      value:
                                                          selectedCrewMap[index],
                                                      hint: const Text(
                                                        "Select Crew",
                                                      ),
                                                      decoration: InputDecoration(
                                                        border: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                8,
                                                              ),
                                                        ),
                                                        contentPadding:
                                                            const EdgeInsets.symmetric(
                                                              horizontal: 12,
                                                              vertical: 10,
                                                            ),
                                                      ),
                                                      items: crewList1.map((
                                                        crew,
                                                      ) {
                                                        return DropdownMenuItem<
                                                          String
                                                        >(
                                                          value: crew["loginId"]
                                                              .toString(),
                                                          child: Text(
                                                            crew["name"]
                                                                .toString(),
                                                          ),
                                                        );
                                                      }).toList(),
                                                      onChanged: (value) async {
                                                        if (value == null)
                                                          return;

                                                        setDialogState(() {
                                                          selectedCrewMap[index] =
                                                              value;
                                                        });

                                                        showDialog(
                                                          context: context,
                                                          barrierDismissible:
                                                              false,
                                                          builder: (_) =>
                                                              const Center(
                                                                child:
                                                                    CircularProgressIndicator(),
                                                              ),
                                                        );

                                                        bool success =
                                                            await assignCrewToSpan(
                                                              spanName:
                                                                  item["spanName"]
                                                                      .toString(),
                                                              crewIds: [value],
                                                            );
                                                        print("1. Before API");

                                                        print(
                                                          "2. After API : $success",
                                                        );

                                                        Navigator.of(
                                                          context,
                                                          rootNavigator: true,
                                                        ).pop();

                                                        print(
                                                          "3. Loader closed",
                                                        );

                                                        if (success) {
                                                          print(
                                                            "4. Inside success",
                                                          );

                                                          final updatedList =
                                                              await getSupervisorReworkDetails();

                                                          print(
                                                            "5. Updated list length: ${updatedList.length}",
                                                          );

                                                          setDialogState(() {
                                                            dialogReworkList =
                                                                List<
                                                                  Map<
                                                                    String,
                                                                    dynamic
                                                                  >
                                                                >.from(
                                                                  updatedList,
                                                                );

                                                            isEditingCrew[index] =
                                                                false;

                                                            selectedCrewMap[index] =
                                                                updatedList[index]["crewId"]
                                                                    .toString();
                                                          });

                                                          print(
                                                            "6. After setDialogState",
                                                          );

                                                          ScaffoldMessenger.of(
                                                            scaffoldContext,
                                                          ).showSnackBar(
                                                            const SnackBar(
                                                              content: Text(
                                                                "Crew updated successfully",
                                                              ),
                                                            ),
                                                          );

                                                          print(
                                                            "7. SnackBar called",
                                                          );
                                                        }
                                                      },
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
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
          },
        );
      },
    );
  }

  Future<List<Map<String, dynamic>>> getSupervisorReworkDetails() async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    final String url =
        '${AppUrl.baseUrl}maintenanceReportView/getSupervisorReworkDetails?feeder=&token=${widget.tokenNo}';
    print('url rework by supervisor:: $url');
    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Authorization": "Bearer ${data.token}",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      return List<Map<String, dynamic>>.from(body["reworkDetails"] ?? []);
    } else {
      throw Exception("Failed to load rework details");
    }
  }

  String formatDate1(String? date) {
    if (date == null || date.trim().isEmpty) {
      return "-";
    }

    try {
      final DateTime dt = DateTime.parse(date);
      return DateFormat('MM/dd/yyyy').format(dt);
    } catch (e) {
      return date; // Return original value if parsing fails
    }
  }

  Widget _infoRow(IconData icon, String title, String value) {
    Color valueColor = Colors.black87;
    String displayValue = value;

    bool isStatus = title == "Status";

    if (isStatus) {
      final status = value.trim().toLowerCase();

      if (status == "rejected" || status == "rework" || status == "failed") {
        displayValue = "Failed";
        valueColor = Colors.red;
      } else {
        valueColor = Colors.green;
      }
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.blue, size: 20),
        const SizedBox(width: 10),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black87, fontSize: 14),
              children: [
                TextSpan(
                  text: "$title : ",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: displayValue,
                  style: isStatus
                      ? TextStyle(
                          color: valueColor,
                          fontWeight: FontWeight.w600,
                        )
                      : null, // Uses default style for all other fields
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> fetchCrewList(String maintType) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    final uri = Uri.parse(
      AppUrl.getCrewBySpanName,
    ).replace(queryParameters: {"maintType": maintType});

    print(uri.toString());
    try {
      final response = await http.get(
        Uri.parse(
          AppUrl.getCrewBySpanName,
        ).replace(queryParameters: {"maintType": maintType}),
        headers: {
          "Authorization": 'Bearer ${data.token!}',
          "Content-Type": "application/json",
        },
      );
      print(uri.toString());
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse.containsKey("crewList") &&
            jsonResponse["crewList"] is List) {
          final List<dynamic> crewData = jsonResponse["crewList"];

          print('dataCrewList $crewData');
          print("Status Code: ${response.statusCode}");
          print("Response Body222: ${response.body}");

          setState(() {
            crewList1 = crewData
                .map((e) => {"loginId": e["id"], "name": e["name"]})
                .toList();
            // Optionally set a default value for selectedCrew (e.g., the first crew in the list)
            if (crewList1.isNotEmpty) {
              selectedCrew = crewList1[0]["id"].toString();
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
    }
  }

  Future<bool> assignCrewToSpan({
    required String spanName,
    required List<String> crewIds,
  }) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();

    final uri = Uri.parse(AppUrl.assignCrewToSpan).replace(
      queryParameters: {
        "feeder": "",
        "spanName": spanName,
        "tokenNo": widget.tokenNo.toString(),
        "crewIds": crewIds.join(","),
      },
    );
    print("Request URL: ${uri.toString()}");
    try {
      final response = await http.post(
        uri,
        headers: {
          "Authorization": "Bearer ${data.token!}",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        print("Status Code1: ${response.statusCode}");
        print("Response Body1: ${response.body}");
        final json = jsonDecode(response.body);
        return json["status"] == "success";
      }
    } catch (e) {
      print(e);
    }

    return false;
  }

  void showReworkGFDialog(
    BuildContext context,
    List<Map<String, dynamic>> reworkList,
  ) {
    List<Map<String, dynamic>> dialogReworkList =
        List<Map<String, dynamic>>.from(reworkList);
    Map<int, bool> isEditingCrew = {};
    final scaffoldContext = context;
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                constraints: const BoxConstraints(maxHeight: 550),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.list_alt, color: Colors.purple),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: Text(
                            "Rework List",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),

                    const Divider(),

                    Expanded(
                      child: reworkList.isEmpty
                          ? const Center(
                              child: Text(
                                "No Rework Found",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          : ListView.builder(
                              itemCount: dialogReworkList.length,
                              // reworkList.length,
                              itemBuilder: (context, index) {
                                final item = dialogReworkList[index];
                                final bool hasCrew = (item["crewName"] ?? "")
                                    .toString()
                                    .trim()
                                    .isNotEmpty;
                                final String status = (item["status"] ?? "")
                                    .toString()
                                    .trim()
                                    .toLowerCase();
                                final bool canEdit =
                                    (status == "rework" ||
                                    status == "failed" ||
                                    status == "rejected");
                                return Card(
                                  elevation: 3,
                                  margin: const EdgeInsets.only(bottom: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(14),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _infoRow(
                                          Icons.route,
                                          "Span Name",
                                          item["spanName"]?.toString() ?? "",
                                        ),
                                        const SizedBox(height: 8),
                                        _infoRow(
                                          Icons.settings,
                                          "Maintenance Type",
                                          item["maintType"]?.toString() ?? "",
                                        ),

                                        const SizedBox(height: 8),

                                        _infoRow(
                                          Icons.info,
                                          "Status",
                                          item["status"]?.toString() ?? "",
                                        ),

                                        const SizedBox(height: 8),

                                        _infoRow(
                                          Icons.access_time,
                                          "Date",
                                          formatDate1(
                                            item["supervisorTime"]?.toString(),
                                          ),
                                        ),

                                        const SizedBox(height: 8),
                                        Visibility(
                                          visible:
                                              hasCrew &&
                                              !(isEditingCrew[index] ?? false),
                                          // !(isEditingCrew[index] ?? false),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: _infoRow(
                                                  Icons.groups,
                                                  "Crew",
                                                  item["crewName"].toString(),
                                                ),
                                              ),
                                              if (canEdit)
                                                IconButton(
                                                  icon: const Icon(
                                                    Icons.edit,
                                                    color: Colors.blue,
                                                    size: 20,
                                                  ),
                                                  tooltip: "Edit Crew",
                                                  // onPressed: () async {
                                                  //   setDialogState(() {
                                                  //     isEditingCrew[index] = true;
                                                  //   });
                                                  // },
                                                  onPressed: () async {
                                                    await fetchCrewList(
                                                      item["maintType"]
                                                          .toString(),
                                                    );

                                                    await Future.delayed(
                                                      const Duration(
                                                        milliseconds: 300,
                                                      ),
                                                    );

                                                    setDialogState(() {
                                                      isEditingCrew[index] =
                                                          true;
                                                    });
                                                  },
                                                ),
                                            ],
                                          ),
                                        ),
                                        Visibility(
                                          visible:
                                              !hasCrew ||
                                              (isEditingCrew[index] ?? false),
                                          // isEditingCrew[index] ?? false,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.groups,
                                                color: Colors.blue,
                                                size: 20,
                                              ),
                                              const SizedBox(width: 10),
                                              const Text(
                                                "Crew : ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              const SizedBox(width: 8),

                                              Expanded(
                                                child: FutureBuilder(
                                                  future: fetchCrewList(
                                                    item["maintType"]
                                                        .toString(),
                                                  ),
                                                  builder: (context, snapshot) {
                                                    if (selectedCrewMap[index] ==
                                                            null &&
                                                        item["crewId"] !=
                                                            null &&
                                                        item["crewId"]
                                                            .toString()
                                                            .isNotEmpty) {
                                                      selectedCrewMap[index] =
                                                          item["crewId"]
                                                              .toString();
                                                    }

                                                    return DropdownButtonFormField<
                                                      String
                                                    >(
                                                      isExpanded: true,
                                                      value:
                                                          selectedCrewMap[index],
                                                      hint: const Text(
                                                        "Select Crew",
                                                      ),
                                                      decoration: InputDecoration(
                                                        border: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                8,
                                                              ),
                                                        ),
                                                        contentPadding:
                                                            const EdgeInsets.symmetric(
                                                              horizontal: 12,
                                                              vertical: 10,
                                                            ),
                                                      ),
                                                      items: crewList1.map((
                                                        crew,
                                                      ) {
                                                        return DropdownMenuItem<
                                                          String
                                                        >(
                                                          value: crew["loginId"]
                                                              .toString(),
                                                          child: Text(
                                                            crew["name"]
                                                                .toString(),
                                                          ),
                                                        );
                                                      }).toList(),
                                                      onChanged: (value) async {
                                                        if (value == null)
                                                          return;

                                                        setDialogState(() {
                                                          selectedCrewMap[index] =
                                                              value;
                                                        });

                                                        showDialog(
                                                          context: context,
                                                          barrierDismissible:
                                                              false,
                                                          builder: (_) =>
                                                              const Center(
                                                                child:
                                                                    CircularProgressIndicator(),
                                                              ),
                                                        );

                                                        bool success =
                                                            await assignCrewToSpan(
                                                              spanName:
                                                                  item["spanName"]
                                                                      .toString(),
                                                              crewIds: [value],
                                                            );
                                                        print("1. Before API");

                                                        print(
                                                          "2. After API : $success",
                                                        );

                                                        Navigator.of(
                                                          context,
                                                          rootNavigator: true,
                                                        ).pop();

                                                        print(
                                                          "3. Loader closed",
                                                        );

                                                        if (success) {
                                                          print(
                                                            "4. Inside success",
                                                          );

                                                          final updatedList =
                                                              await getGFReworkDetails();

                                                          print(
                                                            "5. Updated list length: ${updatedList.length}",
                                                          );

                                                          setDialogState(() {
                                                            dialogReworkList =
                                                                List<
                                                                  Map<
                                                                    String,
                                                                    dynamic
                                                                  >
                                                                >.from(
                                                                  updatedList,
                                                                );

                                                            isEditingCrew[index] =
                                                                false;

                                                            selectedCrewMap[index] =
                                                                updatedList[index]["crewId"]
                                                                    .toString();
                                                          });

                                                          print(
                                                            "6. After setDialogState",
                                                          );

                                                          ScaffoldMessenger.of(
                                                            scaffoldContext,
                                                          ).showSnackBar(
                                                            const SnackBar(
                                                              content: Text(
                                                                "Crew updated successfully",
                                                              ),
                                                            ),
                                                          );

                                                          print(
                                                            "7. SnackBar called",
                                                          );
                                                        }
                                                      },
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
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
          },
        );
      },
    );
  }

  Future<List<Map<String, dynamic>>> getGFReworkDetails() async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    final String url =
        '${AppUrl.baseUrl}maintenanceReportView/getGFReworkDetails?feeder=&token=${widget.tokenNo}';
    print('url rework by supervisor:: $url');
    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Authorization": "Bearer ${data.token}",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      return List<Map<String, dynamic>>.from(body["reworkDetails"] ?? []);
    } else {
      throw Exception("Failed to load rework details");
    }
  }

  Future<void> loadPrimarySecondaryMiles() async {
    try {
      primarySecondaryMileModel =
          await WorkProgressApi.getPrimarySecondaryMileDetails(
            int.parse(widget.tokenNo.toString()),
            context,
          );

      // Primary Miles
      final primaryMilesCompleted =
          double.tryParse(
            primarySecondaryMileModel?.primaryMilesCompleted ?? "0",
          ) ??
          0.0;

      final primaryMilesTotal =
          double.tryParse(
            primarySecondaryMileModel?.primaryMilesTotal ?? "0",
          ) ??
          0.0;

      primaryMileProgress = primaryMilesTotal > 0
          ? primaryMilesCompleted / primaryMilesTotal
          : 0.0;

      // Secondary Miles
      final secondaryMilesCompleted =
          double.tryParse(
            primarySecondaryMileModel?.secondaryMilesCompleted ?? "0",
          ) ??
          0.0;

      final secondaryMilesTotal =
          double.tryParse(
            primarySecondaryMileModel?.secondaryMilesTotal ?? "0",
          ) ??
          0.0;

      secondaryMileProgress = secondaryMilesTotal > 0
          ? secondaryMilesCompleted / secondaryMilesTotal
          : 0.0;
      final totalMiles = secondaryMilesTotal + primaryMilesTotal;

      secondaryFlex = totalMiles > 0
          ? math.max(1, (secondaryMilesTotal / totalMiles * 1000).round())
          : 1;

      primaryFlex = totalMiles > 0
          ? math.max(1, (primaryMilesTotal / totalMiles * 1000).round())
          : 1;
      setState(() {});
      print('flex value Miles: $secondaryFlex : $primaryFlex');

      final primarySpanCompleted =
          double.tryParse(
            primarySecondaryMileModel?.primarySpanCompleted ?? "0",
          ) ??
          0.0;

      final primarySpanTotal =
          double.tryParse(primarySecondaryMileModel?.primarySpanTotal ?? "0") ??
          0.0;

      primarySpanProgress = primarySpanTotal > 0
          ? primarySpanCompleted / primarySpanTotal
          : 0.0;

      // Secondary Span
      final secondarySpanCompleted =
          double.tryParse(
            primarySecondaryMileModel?.secondarySpanCompleted ?? "0",
          ) ??
          0.0;

      final secondarySpanTotal =
          double.tryParse(
            primarySecondaryMileModel?.secondarySpanTotal ?? "0",
          ) ??
          0.0;

      secondarySpanProgress = secondarySpanTotal > 0
          ? secondarySpanCompleted / secondarySpanTotal
          : 0.0;

      final totalSpan = secondarySpanTotal + primarySpanTotal;
      secondaryFlexSpan = totalSpan > 0
          ? math.max(1, (secondarySpanTotal / totalSpan * 1000).round())
          : 1;

      primaryFlexSpan = totalSpan > 0
          ? math.max(1, (primarySpanTotal / totalSpan * 1000).round())
          : 1;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _showMainSpanDialog(
    BuildContext context, {
    required String methodName,
    required String primaryCompleted,
    required String primarySpans,
    required String secondaryCompleted,
    required String secondarySpans,
    required String completedSpans,
    required String totalSpans,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// Header
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        methodName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff073B78),
                        ),
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () => Navigator.pop(context),
                      child: const Padding(
                        padding: EdgeInsets.all(4),
                        child: Icon(Icons.close, color: Colors.red),
                      ),
                    ),
                  ],
                ),

                const Divider(height: 20),
                _spanMainRow(
                  title: "Secondary",
                  completed: secondaryCompleted,
                  total: secondarySpans,
                  color: Colors.orange,
                ),

                const SizedBox(height: 12),
                _spanMainRow(
                  title: "Primary",
                  completed: primaryCompleted,
                  total: primarySpans,
                  color: Colors.blue,
                ),

                const SizedBox(height: 12),

                _spanMainRow(
                  title: "Total",
                  completed: completedSpans,
                  total: totalSpans,
                  color: Colors.green,
                  isBold: true,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _spanMainRow({
    required String title,
    required String completed,
    required String total,
    required Color color,
    bool isBold = false,
  }) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 10),

        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
            ),
          ),
        ),

        Text(
          "$completed / $total",
          style: TextStyle(
            fontSize: 15,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ],
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
