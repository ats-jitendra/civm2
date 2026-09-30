import 'package:CIVM/piedmont/models/ivm_model.dart';
import 'package:CIVM/piedmont/resources/app_colors.dart';
import 'package:CIVM/piedmont/resources/app_url.dart';
import 'package:CIVM/piedmont/screens/generalForeman_New_pannel/contractor_bottom_navigation.dart';
import 'package:CIVM/piedmont/screens/generalForeman_New_pannel/gf_distri_IVM_TO_pending.dart';
import 'package:CIVM/piedmont/screens/generalForeman_New_pannel/gf_distri_IVM_TO_rejected.dart';
import 'package:CIVM/piedmont/screens/generalForeman_New_pannel/gf_distri_IVM_pending_inspection.dart';
import 'package:CIVM/piedmont/screens/leaflat_map/leaf_lat_map_wakeLock.dart';
import 'package:CIVM/piedmont/screens/login_page.dart';
import 'package:CIVM/piedmont/screens/map/provider/location_provider.dart';
import 'package:CIVM/piedmont/screens/my_chrome_safari_map_recording.dart';
import 'package:CIVM/piedmont/utils/common_functions.dart';
import 'package:CIVM/piedmont/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/piedmont/utils/work_progress_api.dart';
import 'package:CIVM/sharedPrefs/constants.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/piedmont/view_model/image_code_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:CIVM/piedmont/repository/map_url.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/pdf_view.dart';
import 'package:CIVM/piedmont/screens/video_folder/fullVideo/full_screen_video_player.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

// ignore: must_be_immutable
class GFDistributionIVMcLOSED extends StatefulWidget {
  const GFDistributionIVMcLOSED({
    super.key,
  });

  @override
  State<GFDistributionIVMcLOSED> createState() =>
      _GFDistributionIVMcLOSEDState();
}

class _GFDistributionIVMcLOSEDState extends State<GFDistributionIVMcLOSED>
    with TickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  final List<Color> containerColors = [
    const Color.fromARGB(255, 252, 231, 238),
    const Color.fromARGB(255, 226, 246, 253),
    const Color.fromARGB(255, 212, 249, 212),
    const Color.fromARGB(255, 251, 251, 215),
    const Color.fromARGB(255, 251, 239, 251),
  ];

  late Future<List<FindAllTableData>> myFuture;
  List<FindAllTableData> filteredList = [];
  List<FindAllTableData> fullList = [];
  String auditId = '';
  String accountNumber = '';
  String status = '';
  bool isError = false;
  int currentYear = DateTime.now().year;

  List<FindAllTableData> ivmList = [];
  bool isLoading = true;
  final browser = MyChromeSafariBrowser();
  ImageViewViewModel imageViewModel = ImageViewViewModel();
  List<String> menu = [];
  @override
  void initState() {
    super.initState();
    myFuture = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Distribution IVM (Closed)',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.baseColor,
      ),
      drawer: DrawerManu(menu: menu),
      body: SafeArea(
        child: FutureBuilder<List<FindAllTableData>>(
          future: myFuture,
          builder: (BuildContext context,
              AsyncSnapshot<List<FindAllTableData>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            // API ERROR
            if (isError) {
              return buildNoDataWidget();
            }
            final list = snapshot.data!;
            if (fullList.isEmpty) {
              fullList = list;
              filteredList = list;
            }
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
                              "TOTAL NO OF RECORDS : ${list.length}",
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
                              // IVMModel item = filteredList[index];
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
                                                              list[index]
                                                                  .tokenNo
                                                                  .toString(),
                                                            );
                                                            await Future.delayed(
                                                                const Duration(
                                                                    seconds:
                                                                        2));
                                                            openDialogPicture(
                                                                list[index]
                                                                    .tokenNo
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
                                                          list[index].type ??
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
                                                          list[index].tokenNo ??
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
                                                          list[index].status ??
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
                                                          "SUBSTATION: ",
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
                                                          list[index]
                                                                  .substation ??
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
                                                          "FEEDER: ",
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
                                                          list[index].fdrName ??
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
                                                          list[index]
                                                                  .maintType ??
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
                                                          "CONTRACTOR: ",
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
                                                          list[index]
                                                                  .contractor ??
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
                                                          list[index]
                                                                  .totalMiles ??
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
                                                          "CONTRACT YEAR: ",
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
                                                          list[index]
                                                                  .contractYear ??
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
                                                          "CYCLE: ",
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
                                                          list[index].cycle ??
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
                                                          "CONTRACTOR COMPANY: ",
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
                                                          list[index]
                                                                  .contractorCompany ??
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
                                                          "NEXT MAINT DUE: ",
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
                                                          formatDate(list[index]
                                                              .nextMaintDue),
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
                                                          formatDate(list[index]
                                                              .createDate),
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
                                                              // Navigator.of(context).push(
                                                              //     MaterialPageRoute(
                                                              //         builder: (BuildContext
                                                              //                 context) =>
                                                              //             MapViewContractor(
                                                              //               id: lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].id.toString(),
                                                              //             )));
                                                              //       Navigator  .push(
                                                              //   context,
                                                              //   MaterialPageRoute(
                                                              //     builder:
                                                              //         (context) =>
                                                              //             MapViewPage(
                                                              //       url: MapUrl.getGfEndPoint(lCPWorkOrderPendingViewModel
                                                              //         .lcpWorkOrderPendingGetTabularData
                                                              //         .data!
                                                              //         .findAllTableData![
                                                              //             index]
                                                              //         .tokenNo
                                                              //         .toString(),id),
                                                              //     ),
                                                              //   ),
                                                              // );

                                                              await browser.open(
                                                                  url: WebUri(
                                                                      // "https://mapapi.ariespro.com/main/contractor/CIVM_Map/${lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].tokenNo.toString()}/USRQWXH589Z"),
                                                                      MapUrl.getcontractorEndPoint(
                                                                          list[index]
                                                                              .tokenNo
                                                                              .toString(),
                                                                          id)),
                                                                  settings: ChromeSafariBrowserSettings(
                                                                      shareState:
                                                                          CustomTabsShareState
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



                                               const Divider(color: Colors.grey),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Row(children: [
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
                                                              jobNo:list[index].tokenNo.toString()
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

  Future<List<FindAllTableData>> getIVMData(BuildContext context) async {
    try {
      final userPreferences = Provider.of<UserPref>(context, listen: false);

      UserModel userData = await userPreferences.getUser();
      String id = userData.user!.id.toString();
      int currentYear = DateTime.now().year;
      String token = userData.token ?? "";

      var url =
          "${AppUrl.generalForemanIVMtabdata}?status=CLOSED&budgetType=Regular IVM maintenance&maintType=RegularMaint&contractorId=$id&planType=IVM Work Plan&visibilityFlag=2&year=$currentYear&orderBy=ID&contractorCompany=Lewis Tree&visibilityFlag=2";
      print('url IVM CLOSED : $url');
      var response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token", // ✅ REQUIRED
        },
      );

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);

        // Convert to model
        IVMModel model = IVMModel.fromJson(jsonData);

        return model.findAllTableData ?? [];
      } else {
        debugPrint("API Error: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      debugPrint("Exception: $e");
      return [];
    }
  }

  Future<List<FindAllTableData>> fetchData() async {
    ivmList = await getIVMData(context);

    // Optional delay (as you asked earlier)
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });
    return await getIVMData(context);
  }

  void filterData(String query) {
    final searchText = query.toLowerCase();

    setState(() {
      if (searchText.isEmpty) {
        filteredList = fullList;
      } else {
        filteredList = fullList.where((item) {
          return
              // Basic Info
              (item.tokenNo ?? '').toLowerCase().contains(searchText) ||
                  (item.id?.toString() ?? '').contains(searchText) ||

                  // People
                  (item.supervisor ?? '').toLowerCase().contains(searchText) ||
                  (item.contractor ?? '').toLowerCase().contains(searchText) ||
                  (item.contractorCompany ?? '')
                      .toLowerCase()
                      .contains(searchText) ||
                  (item.crew ?? '').toLowerCase().contains(searchText) ||

                  // Location
                  (item.district ?? '').toLowerCase().contains(searchText) ||
                  (item.county ?? '').toLowerCase().contains(searchText) ||
                  (item.substation ?? '').toLowerCase().contains(searchText) ||
                  (item.streetAddress ?? '')
                      .toLowerCase()
                      .contains(searchText) ||

                  // Work Details
                  (item.fdrName ?? '').toLowerCase().contains(searchText) ||
                  (item.maintType ?? '').toLowerCase().contains(searchText) ||
                  (item.planType ?? '').toLowerCase().contains(searchText) ||
                  (item.type ?? '').toLowerCase().contains(searchText) ||
                  (item.workPriority ?? '')
                      .toLowerCase()
                      .contains(searchText) ||

                  // Status / Flags
                  (item.status ?? '').toLowerCase().contains(searchText) ||
                  (item.visibilityFlag ?? '')
                      .toLowerCase()
                      .contains(searchText) ||
                  (item.actionNeeded ?? '')
                      .toLowerCase()
                      .contains(searchText) ||

                  // Dates
                  (item.createDate ?? '').toLowerCase().contains(searchText) ||
                  (item.lastMaintDone ?? '')
                      .toLowerCase()
                      .contains(searchText) ||
                  (item.nextMaintDue ?? '')
                      .toLowerCase()
                      .contains(searchText) ||
                  (item.dateOfInspection ?? '')
                      .toLowerCase()
                      .contains(searchText) ||
                  (item.followUpDate ?? '')
                      .toLowerCase()
                      .contains(searchText) ||

                  // Cost / Miles
                  (item.totalMiles ?? '').toLowerCase().contains(searchText) ||
                  (item.costPerMile ?? '').toLowerCase().contains(searchText) ||
                  (item.totalCost ?? '').toLowerCase().contains(searchText) ||
                  (item.milesCompleted ?? '')
                      .toLowerCase()
                      .contains(searchText) ||
                  (item.milesInProgress ?? '')
                      .toLowerCase()
                      .contains(searchText) ||
                  (item.milesPending ?? '')
                      .toLowerCase()
                      .contains(searchText) ||

                  // Budget / Cycle
                  (item.budget ?? '').toLowerCase().contains(searchText) ||
                  (item.cycle ?? '').toLowerCase().contains(searchText) ||
                  (item.contractYear ?? '')
                      .toLowerCase()
                      .contains(searchText) ||

                  // Vegetation / IVM
                  (item.treeType ?? '').toLowerCase().contains(searchText) ||
                  (item.growthRate ?? '').toLowerCase().contains(searchText) ||
                  (item.growthScore ?? '').toLowerCase().contains(searchText) ||

                  // Notes
                  (item.adminNotes1 ?? '').toLowerCase().contains(searchText) ||
                  (item.adminNotes2 ?? '').toLowerCase().contains(searchText) ||
                  (item.contractorNotes ?? '')
                      .toLowerCase()
                      .contains(searchText);
        }).toList();
      }
    });
  }

  String formatDate(String? date) {
    if (date == null || date.isEmpty) return "";

    try {
      // Try ISO format first (2026-03-21T08:00:07.55)
      DateTime parsedDate = DateTime.parse(date);
      return DateFormat('MM/dd/yyyy').format(parsedDate);
    } catch (e) {
      try {
        // Try custom format (Mar 21 2026 12:00AM)
        DateTime parsedDate = DateFormat('MMM dd yyyy hh:mma').parse(date);
        return DateFormat('MM/dd/yyyy').format(parsedDate);
      } catch (e) {
        return date; // fallback
      }
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

// ignore: must_be_immutable
class DrawerManu extends StatefulWidget {
  List<String> menu;
  DrawerManu({Key? key, required this.menu}) : super(key: key);

  @override
  State<DrawerManu> createState() => _DrawerManuState();
}

class _DrawerManuState extends State<DrawerManu> {
  String userName = '';
  String? _imagePath;

  @override
  void initState() {
    setUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userPreferences = Provider.of<UserPref>(context);
    var provider = Provider.of<LocationProviderPemc>(context, listen: true);
    final browser = MyChromeSafariBrowser();
    return Drawer(
      child: SafeArea(
        child: Column(
          // Important: Remove any padding from the ListView.
          // padding: EdgeInsets.zero,
          children: [
            Container(
              width: double.infinity,
              height: 180,
              color: AppColors.lighterBaseColor,
              padding: const EdgeInsets.only(top: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  menuLogo(),
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
                    leading: const Icon(
                      Icons.computer,
                    ),
                    title: const Text('General Foreman Dashboard'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const ContractorBottomNavigationPannel()));
                    },
                  ),
                                  ///////////new added maps for PEMC
                  ListTile(
                    leading: const Icon(
                      Icons.vertical_distribute,
                    ),
                    title: const Text('Add ROW Distribution Map'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () async {
                      String id = '';
                      final userPreferences1 =
                          Provider.of<UserPref>(context, listen: false);
                      UserModel data = await userPreferences1.getUser();
                      id = data.user!.id.toString();
                      await browser.open(
                          url: WebUri(
                              MapUrl.getPlannerDistributionMapEndPoint(id)),
                          settings: ChromeSafariBrowserSettings(
                              shareState: CustomTabsShareState.SHARE_STATE_OFF,
                              barCollapsingEnabled: true));
                    },
                  ),
             
                  ListTile(
                    leading: const Icon(
                      Icons.pending_actions,
                    ),
                    title: const Text('Distribution IVM (Pending)'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const GFDistributionIVMpEnding()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.closed_caption_off,
                    ),
                    title: const Text('Distribution IVM (Closed)'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.block,
                    ),
                    title: const Text('Distribution IVM (Rejected)'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const GFDistributionIVMRejected()));
                    },
                  ),
                     ListTile(
                    leading: const Icon(
                      Icons.pending_actions,
                    ),
                    title: const Text('Distribution IVM (Pending Inspection)'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const MaintenanceReportViewDistriIVMNew()));
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.location_on,
                    ),
                    title: const Text('Live IVM System Map'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      provider.getLocation();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const MapScreenLeafLat()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.logout,
                    ),
                    title: const Text('Log Out'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      // // Constants.prefs.setBool("LoggedIn", false);
                      userPreferences.remove().then((value) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const LoginPagePemc()));
                      });
                      // Navigator.of(context).pushReplacement(MaterialPageRoute(
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
      'https://atsdev2test.ariespro.com/assets/clientuploads/${data.user!.profilePhoto}',
    );
    String imageUrl =
        'https://atsdev2test.ariespro.com/assets/clientuploads/${data.user!.profilePhoto}';
    _imagePath = imageUrl;
    setState(() {
      userName = '${data.user!.fName} ${data.user!.lName}';
    });
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
        String normalizedDate =
            date.replaceAll(RegExp(r'\s+'), ' '); // Remove extra spaces
        DateTime parsedDate =
            DateFormat("MMM d yyyy h:mma").parse(normalizedDate);
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
}
