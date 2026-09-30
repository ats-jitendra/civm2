import 'dart:convert';
import 'package:CIVM/models/add_new_row_maintenance_tabular_detail_model.dart';
import 'package:CIVM/models/log_model.dart';
import 'package:CIVM/screens/login_page.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:CIVM/repository/map_url.dart';
import 'package:CIVM/models/primary_secondary_mile_model.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/models/work_progress_model.dart';
import 'package:CIVM/screens/chat_history.dart';
import 'package:CIVM/screens/row_method_progress_widget.dart';
import 'package:CIVM/screens/work_progress_span_widget.dart';
import 'package:CIVM/utils/history_card.dart';
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
import 'package:intl/intl.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class SupervisorAddNewRowMaintenancePlanDetailsScreen extends StatefulWidget {
  String tokenNo;
  String year;
  SupervisorAddNewRowMaintenancePlanDetailsScreen({
    super.key,
    required this.tokenNo,
    required this.year,
  });

  @override
  State<SupervisorAddNewRowMaintenancePlanDetailsScreen> createState() =>
      _SupervisorAddNewRowMaintenancePlanDetailsScreenState();
}

class _SupervisorAddNewRowMaintenancePlanDetailsScreenState
    extends State<SupervisorAddNewRowMaintenancePlanDetailsScreen> {
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
  String formattedNextMaintDue = '';
  LCPDocumentApprovalPendingViewModel lCPDocumentApprovalPendingViewModel =
      LCPDocumentApprovalPendingViewModel();

  bool loading = true;
  List<WorkProgressModel> list = [];

  TextEditingController searchController = TextEditingController();
  List<dynamic> filteredReportList = [];
  List<dynamic> reportList = [];
  String crewListMaintenanceReportView = '';
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
  double mileProgress = 0.0;

  double spanProgress = 0.0;

  double primaryMileProgress = 0.0;
  double secondaryMileProgress = 0.0;

  double primarySpanProgress = 0.0;
  double secondarySpanProgress = 0.0;

  var secondaryFlex;
  var primaryFlex;

  @override
  void initState() {
    super.initState();
    // myFuture = fetchDetails(context);

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   myFuture = fetchDetails(context);
    //   imageViewModel.fetchImageApi(context, widget.tokenNo);
    // });
    myFuture = Future.wait([
      fetchDetails(context),
      imageViewModel.fetchImageApi(context, widget.tokenNo),
    ]);
    WidgetsBinding.instance.addPostFrameCallback((_) {
    //  loadData();
      fetchMaintenanceReport(context);
     _initializeScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'IVM Maintenance Job List View Details',
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
            final maintYear = getYearOrNA(item?.nextMaintDue.toString() ?? "");
            // API ERROR
            if (isError) {
              print('empty111111111111111');
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
                            Row(
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

                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  
                                  Row(
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
                                      (item!.visibilityFlag.toString() == '1' ||
                                              item!.visibilityFlag.toString() ==
                                                  '2')
                                          ? Align(
                                              alignment: Alignment.topLeft,
                                              child: InkWell(
                                                onTap: () async {},
                                                child: const Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Icon(
                                                    Icons.share,
                                                    color: Colors.green,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Align(
                                              alignment: Alignment.topLeft,
                                              child: InkWell(
                                                onTap: () async {},
                                                child: const Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Icon(
                                                    Icons.share,
                                                    color: Colors.blue,
                                                  ),
                                                ),
                                              ),
                                            ),
                                    ],
                                  ),
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

                                    await browser.open(
                                      url: WebUri(
                                        MapUrl.getSupervisorEndPoint(
                                          item!.tokenNo.toString(),
                                          id,
                                        ),
                                      ),
                                      // "https://mapapi.ariespro.com/main/supervisor/CIVM_Map/${lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].tokenNo.toString()}/USRQWXH589Z"),
                                      settings: ChromeSafariBrowserSettings(
                                        shareState: CustomTabsShareState
                                            .SHARE_STATE_OFF,
                                        barCollapsingEnabled: true,
                                      ),
                                    );
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) => MapScreenSupervisor(
                                      //       jobNo: "${item!.tokenNo}",
                                      //       substation: "${item!.substation}",
                                      //       feeder: item!.feeder!
                                      //           .split('(')
                                      //           .first
                                      //           .trim(),
                                      //     ),
                                      //   ),
                                      // );
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
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "HISTORY :",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          showHistoryDialog(
                                            context,
                                            int.parse(item!.tokenNo.toString()),
                                          ); //243 has data
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Colors.blue.shade50,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.history,
                                            color: Colors.red,
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            
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
                            _buildDetailCard(
                              icon: Icons.margin,
                              title: "Master Job No.",
                              value:
                                  (item!.masterJobNo == null ||
                                      item!.masterJobNo
                                          .toString()
                                          .trim()
                                          .isEmpty ||
                                      item!.masterJobNo
                                              .toString()
                                              .trim()
                                              .toUpperCase() ==
                                          "N/A")
                                  ? ""
                                  : item!.masterJobNo.toString(),
                            ),
                            _buildDetailCard(
                              icon: Icons.location_on,
                              title: "Substation",
                              value: item!.substation ?? "",
                            ),

                            _buildDetailCard(
                              icon: Icons.work,
                              title: "Feeder",
                              value: item!.feeder ?? "",
                            ),
                            _buildDetailCard(
                              icon: Icons.repartition,
                              title: "Maintenance Type",
                              value: item!.type ?? "",
                            ),
                            _buildDetailCard(
                              icon: Icons.business,
                              title: "Supervisor",
                              value: item!.superviser ?? "",
                            ),
                            _buildDetailCard(
                              icon: Icons.business_center,
                              title: "General Foreman",
                              value: item!.contractor ?? "",
                            ),
                            _buildDetailCard(
                              icon: Icons.numbers,
                              title: "Total Miles",
                              value: item?.totalMiles ?? "",
                            ),
                            _buildDetailCard(
                              icon: Icons.money,
                              title: "Cost Per Mile",
                              value: item!.costPerMile.toString(),
                            ),
                            _buildDetailCard(
                              icon: Icons.attach_money,
                              title: "Total Cost",
                              value: item!.totalCost.toString(),
                            ),

                            _buildDetailCard(
                              icon: Icons.apartment,
                              title: "Budget Type",
                              value: item!.budgetType ?? "",
                            ),

                            _buildDetailCard(
                              icon: Icons.currency_exchange_outlined,
                              title: "Cycle",
                              value: item?.cycle ?? "",
                            ),
                            _buildDetailCard(
                              icon: Icons.date_range_rounded,
                              title: "Maint Year",
                              value: getYearOrNA(item?.nextMaintDue.toString() ?? ""),
                              textColor: maintYear != "N/A" &&
          int.tryParse(maintYear) != null &&
          int.parse(maintYear) > DateTime.now().year
      ? Colors.red
      : Colors.black,
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

                           
                            RowMethodProgressWidget(tokenNo: widget.tokenNo),
                            WorkProgressSpanWidget(tokenNo: widget.tokenNo),
                           
                           
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Container(
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
                                                Navigator.of(context).pop();
                                                showReworkGFDialog(
                                                  context,
                                                  reworkList,
                                                );
                                              } catch (e) {
                                                // Close loader
                                                Navigator.of(context).pop();

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
                                        Expanded(
                                          child: _actionTile(
                                            icon: Icons.list_alt,
                                            label: "Failed Inspection List",
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
                                                Navigator.of(context).pop();
                                                showReworkSupervisorDialog(
                                                  context,
                                                  reworkList,
                                                );
                                              } catch (e) {
                                                // Close loader
                                                Navigator.of(context).pop();

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
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),

                            Column(
                              children: [
                                if (filteredReportList.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                      10,
                                      8,
                                      10,
                                      10,
                                    ),
                                    child: TextField(
                                      controller: searchController,
                                      onChanged: filterReports,
                                      decoration: InputDecoration(
                                        hintText: "Search by Type/Crew/Date",
                                        prefixIcon: const Icon(Icons.search),
                                        suffixIcon:
                                            searchController.text.isNotEmpty
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
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                isLoading
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        // itemCount: reportList.length,
                                        itemCount: filteredReportList.length,
                                        itemBuilder: (context, index) {
                                          // final item = reportList[index];
                                          final item =
                                              filteredReportList[index];
                                          return Card(
                                            elevation: 1,
                                            margin: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 5,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14),
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
                                                          item["rowMethod"] ??
                                                              "",
                                                          style:
                                                              const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
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
                                                          color: Colors
                                                              .green
                                                              .shade100,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                20,
                                                              ),
                                                        ),
                                                        child: Text(
                                                          formatDate(
                                                            item["createDate"] ??
                                                                "",
                                                          ),
                                                          style:
                                                              const TextStyle(
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
                                                            color: Colors
                                                                .grey
                                                                .shade700,
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
                                                          item["crewName"] ??
                                                              "",
                                                          style:
                                                              const TextStyle(
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
                          ],
                        ),
                      ),
                    ),
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
    Color? textColor = Colors.black,
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
                  style: TextStyle(fontWeight: fontWeight, color: textColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  GetAlls1? item;

  Future<void> fetchDetails(BuildContext context) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    // id = data.user!.id.toString();
    final uri = Uri.parse(AppUrl.getAlls).replace(
      queryParameters: {
        "year": widget.year.toString(),
        "tokenNo": widget.tokenNo.toString(),
      },
    );
    print("url $uri");
    print('bearer token Bearer ${data.token!}');
    var headers = {
      "Content-Type": "application/json",
      // "Authorization": "Bearer $token", //  Add this line
      "Authorization": 'Bearer ${data.token!}',
    };
    try {
      // var response = await http.get(Uri.parse(uri), headers: headers);
      var response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        var res = jsonDecode(response.body);

        List list = res["getAlls"] ?? [];

        if (list.isNotEmpty) {
          setState(() {
            item = GetAlls1.fromJson(list[0]);
          });
        } else {
          print("getAlls is empty");
        }
        // newDateFormat(item!.nextMaintDue.toString());
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

        fetchDetails(context);
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
                    "SUBMIT FOR APPROVAL",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Color.fromARGB(255, 7, 59, 120),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      "Change Order No. : $id",
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Color.fromARGB(255, 7, 59, 120),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Text(
                      "Are you sure to submit for Approval?",
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
                        onTap: () {
                          // contractorOrderPendingViewModel
                          //     .fetchStatusChangeApi(
                          //         context,
                          //         'PENDING APPROVAL',
                          //         _notes.text.toString(),
                          //         int.parse(id))
                          //     .then((value) {
                          //   print('Success');
                          //   Navigator.pop(context);
                          //   fetchData();
                          // });
                          // print(updatedCard);
                          updateSubmitForApprovalStatus(id);
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
      'status': 'PENDING LCP APPROVAL',
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
        Navigator.pop(context);
        CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
          '$tokenNo Submitted for approval successfully',
          context,
        );
        fetchDetails(context);
        // iniciatedCancelWorkForApprovalViewModel.fetchLCPWorkOrderRejectTabularListApi(
        //     context,
        //     '',
        //     '',
        //     'REJECTED',
        //     '',
        //     '',
        //     'Change Order',
        //     id,
        //     'generalforeman');
      } else {
        print('Failed to update status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void newDateFormat(String nextMaintDue) {
    String? rawNextMaintDue = nextMaintDue;
    formattedNextMaintDue = extractYear(rawNextMaintDue);
  }

  String extractYear(String? date) {
    if (date == null || date.isEmpty || date == "N/A") {
      return ""; // Handle null or invalid dates
    }
    try {
      if (date.contains('T')) {
        // ISO 8601 format (e.g., 2024-12-07T11:37:16.750+00:00)
        DateTime parsedDate = DateTime.parse(date);
        return parsedDate.year.toString();
      } else if (date.contains(' ')) {
        // Formats like "Dec  7 2024 12:00AM"
        String normalizedDate = date.replaceAll(
          RegExp(r'\s+'),
          ' ',
        ); // Remove extra spaces
        DateTime parsedDate = DateFormat(
          "MMM d yyyy h:mma",
        ).parse(normalizedDate);
        return parsedDate.year.toString();
      } else if (date.contains('/')) {
        // Format MM/dd/yyyy
        DateTime parsedDate = DateFormat("MM/dd/yyyy").parse(date);
        return parsedDate.year.toString();
      }
    } catch (e) {
      print("Error parsing date: $date, Error: $e");
    }
    return ""; // Default if parsing fails
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

  // Future<void> loadData() async {
  //   try {
  //     list = await WorkProgressApi.getWorkProgress(
  //       int.parse(widget.tokenNo.toString()),
  //       context,
  //     );

  //     setState(() {
  //       loading = false;
  //     });
  //   } catch (e) {
  //     setState(() {
  //       loading = false;
  //     });

  //     debugPrint(e.toString());
  //   }
  // }

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

  void showReworkGFDialog(
    BuildContext context,
    List<Map<String, dynamic>> reworkList,
  ) {
    showDialog(
      context: context,
      builder: (context) {
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
                          itemCount: reworkList.length,
                          itemBuilder: (context, index) {
                            final item = reworkList[index];

                            return Card(
                              elevation: 3,
                              margin: const EdgeInsets.only(bottom: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(14),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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

                                    _infoRow(
                                      Icons.groups,
                                      "Crew",
                                      item["crewName"].toString(),
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

  Future<List<Map<String, dynamic>>> getSupervisorReworkDetails() async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    final String url =
        '${AppUrl.baseUrl}maintenanceReportView/getSupervisorReworkDetails?feeder=&token=${widget.tokenNo}';
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

  void showReworkSupervisorDialog(
    BuildContext context,
    List<Map<String, dynamic>> reworkList,
  ) {
    showDialog(
      context: context,
      builder: (context) {
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
                          itemCount: reworkList.length,
                          itemBuilder: (context, index) {
                            final item = reworkList[index];

                            return Card(
                              elevation: 3,
                              margin: const EdgeInsets.only(bottom: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(14),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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

                                    _infoRow(
                                      Icons.groups,
                                      "Crew",
                                      item["crewName"].toString(),
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
          crewListMaintenanceReportView = json["crewName"] ?? "";
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


  // Future<void> loadPrimarySecondaryMiles() async {
  //   try {
  //     primarySecondaryMileModel =
  //         await WorkProgressApi.getPrimarySecondaryMileDetails(
  //           int.parse(widget.tokenNo.toString()),
  //           context,
  //         );

  //     final primarySpanCompleted =
  //         double.tryParse(
  //           primarySecondaryMileModel?.primarySpanCompleted ?? "0",
  //         ) ??
  //         0.0;

  //     final primarySpanTotal =
  //         double.tryParse(primarySecondaryMileModel?.primarySpanTotal ?? "0") ??
  //         0.0;

  //     primarySpanProgress = primarySpanTotal > 0
  //         ? primarySpanCompleted / primarySpanTotal
  //         : 0.0;

  //     // Secondary Span
  //     final secondarySpanCompleted =
  //         double.tryParse(
  //           primarySecondaryMileModel?.secondarySpanCompleted ?? "0",
  //         ) ??
  //         0.0;

  //     final secondarySpanTotal =
  //         double.tryParse(
  //           primarySecondaryMileModel?.secondarySpanTotal ?? "0",
  //         ) ??
  //         0.0;

  //     secondarySpanProgress = secondarySpanTotal > 0
  //         ? secondarySpanCompleted / secondarySpanTotal
  //         : 0.0;

  //     final totalSpan = secondarySpanTotal + primarySpanTotal;
  //     // secondaryFlex = totalSpan > 0
  //     //     ? (secondarySpanTotal / totalSpan * 1000).round()
  //     //     : 1;

  //     // primaryFlex = totalSpan > 0
  //     //     ? (primarySpanTotal / totalSpan * 1000).round()
  //     //     : 1;

  //     secondaryFlex = totalSpan > 0
  //         ? math.max(1, (secondarySpanTotal / totalSpan * 1000).round())
  //         : 1;

  //     primaryFlex = totalSpan > 0
  //         ? math.max(1, (primarySpanTotal / totalSpan * 1000).round())
  //         : 1;

  //     setState(() {});
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

}
