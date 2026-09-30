
import 'package:CIVM/piedmont/models/transmission_herbicide_inprogress_model.dart';
import 'package:CIVM/piedmont/repository/map_url.dart';
import 'package:CIVM/piedmont/resources/app_colors.dart';
import 'package:CIVM/piedmont/resources/app_url.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/pdf_view.dart';
import 'package:CIVM/piedmont/screens/my_chrome_safari_map_recording.dart';
import 'package:CIVM/piedmont/screens/supervisor_pannel/sup_job_list_tab3_trans_herbicide_edit.dart';
import 'package:CIVM/piedmont/screens/video_folder/fullVideo/full_screen_video_player.dart';
import 'package:CIVM/piedmont/utils/common_functions.dart';
import 'package:CIVM/piedmont/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/piedmont/view_model/image_code_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class AdmAddNewRowMaintenancePlanTableTransmissionHerbicide
    extends StatefulWidget {
  AdmAddNewRowMaintenancePlanTableTransmissionHerbicide({
    super.key,
  });

  @override
  State<AdmAddNewRowMaintenancePlanTableTransmissionHerbicide> createState() =>
      _AdmAddNewRowMaintenancePlanTableTransmissionHerbicideState();
}

class _AdmAddNewRowMaintenancePlanTableTransmissionHerbicideState
    extends State<AdmAddNewRowMaintenancePlanTableTransmissionHerbicide>
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
  List<TransHerbicideFindAllTableData> dataList = [];
  List<TransHerbicideFindAllTableData> filteredList = [];
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
  String selectedYear = "2026";
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
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: DropdownButtonFormField<String>(
                              hint: const Text('-Select Year-'),
                              dropdownColor: Colors.white,
                              value: selectedYear,
                              style: const TextStyle(
                                  color: AppColors.baseColor, fontSize: 16),
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: AppColors.baseColor,
                                size: 40,
                              ),
                              decoration: const InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.baseColor,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.baseColor,
                                  ),
                                ),
                              ),
                              isExpanded: true,
                              //  Dynamic year list
                              items: List.generate(4, (index) {
                                int year = 2024 + index;
                                return DropdownMenuItem(
                                  value: year.toString(),
                                  child: Text(year.toString()),
                                );
                              }),
                              onChanged: (val) {
                                setState(() {
                                  selectedYear = val!;
                                });

                                fetchData();
                              },
                              validator: (value) =>
                                  value == null ? 'field required' : null,
                            ),
                          ),
                        ),
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
                                          0.88,
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
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      const Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          "EDIT: ",
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
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          SupJobListTransHerbicideEdit(
                                                                            tokenNo:
                                                                                item.tokenNo.toString(),
                                                                          )));
                                                        },
                                                        child: const Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Icon(
                                                              Icons.edit,
                                                              color:
                                                                  Colors.green),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                //   Expanded(
                                                //   child: Column(
                                                //     children: [
                                                //       const Align(
                                                //         alignment:
                                                //             Alignment
                                                //                 .topLeft,
                                                //         child: Text(
                                                //           "VIEW: ",
                                                //           textAlign:
                                                //               TextAlign
                                                //                   .left,
                                                //           style:
                                                //               TextStyle(
                                                //             fontSize:
                                                //                 12,
                                                //             fontWeight:
                                                //                 FontWeight.bold,
                                                //             color: Colors
                                                //                 .white,
                                                //           ),
                                                //         ),
                                                //       ),
                                                //       InkWell(
                                                //           onTap:
                                                //               () {

                                                //               Navigator.push(
                                                //                   context,
                                                //                   MaterialPageRoute(
                                                //                       builder: (context) => AdmJobListtransHerbicideView(
                                                //                             tokenNo:  item.tokenNo.toString(),
                                                //                           )));

                                                //           },
                                                //           child:
                                                //               const Align(
                                                //             alignment:
                                                //                 Alignment.topLeft,
                                                //             child:
                                                //                 Icon(
                                                //               Icons
                                                //                   .visibility,
                                                //               color: Color.fromARGB(
                                                //                   255,
                                                //                   151,
                                                //                   249,
                                                //                   154),
                                                //             ),
                                                //           )),
                                                //     ],
                                                //   ),
                                                // ),

                                                Expanded(
                                                  // alignment: Alignment.topLeft,
                                                  child: Column(
                                                    children: [
                                                      const Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          "SHARE: ",
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
                                                      InkWell(
                                                        onTap: () {
                                                          if (item.visibilityFlag
                                                                  .toString() ==
                                                              '2') {
                                                            CustomToastSnackBarProgressDialog
                                                                .flushBarSuccessMessage(
                                                                    'Job no: ${item.tokenNo} already shared with ${item.contractor}',
                                                                    context);
                                                          } else {
                                                            showCrewDialog(
                                                                context,
                                                                item.tokenNo
                                                                    .toString());
                                                          }
                                                        },
                                                        child: Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Icon(
                                                            Icons.share,
                                                            color:
                                                                (item.visibilityFlag ==
                                                                        "2")
                                                                    ? Colors
                                                                        .green
                                                                    : Colors
                                                                        .blue,
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
                                                              item.tokenNo
                                                                  .toString(),
                                                            );
                                                            await Future.delayed(
                                                                const Duration(
                                                                    seconds:
                                                                        2));
                                                            openDialogPicture(
                                                                item.id
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
                                                          item.tokenNo
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
                                                          item.maintType
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
                                                          item.contractor
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
                                                          item.transmissionName
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
                                                          item.totalMiles
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
                                                          getYearOrNA(item
                                                              .contractYear
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
                                                          item.contractorCompany
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
                                                          getYearOrNA(item
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
                                                          formatDateIfNeeded(
                                                              item.createDate
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
                                                                      url: WebUri(MapUrl.getsupervisorTransEndPoint(
                                                                          item.tokenNo
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
        "${AppUrl.getTransmissionHerbicideData}?status=PENDING&budgetType=Mid Transmission maintenance&maintType=RegularMaint&panel=supervisor&planType=MID Transmission Map&contractorCompany=Edko LLC&year=$selectedYear";

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
              .map((e) => TransHerbicideFindAllTableData.fromJson(e))
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

          return (item.maintType ?? "")
                  .toString()
                  .toLowerCase()
                  .contains(searchText) ||
              (item.type ?? "").toString().toLowerCase().contains(searchText) ||
              (item.tokenNo ?? "")
                  .toString()
                  .toLowerCase()
                  .contains(searchText) ||
              (item.substation ?? "")
                  .toString()
                  .toLowerCase()
                  .contains(searchText) ||
              (item.fdrName ?? "")
                  .toString()
                  .toLowerCase()
                  .contains(searchText) ||
              (item.contractor ?? "")
                  .toString()
                  .toLowerCase()
                  .contains(searchText) ||
              (item.totalMiles ?? "")
                  .toString()
                  .toLowerCase()
                  .contains(searchText) ||
              (item.contractYear ?? "")
                  .toString()
                  .toLowerCase()
                  .contains(searchText) ||
              (item.contractorCompany ?? "")
                  .toString()
                  .toLowerCase()
                  .contains(searchText) ||
              (item.cycle ?? "")
                  .toString()
                  .toLowerCase()
                  .contains(searchText) ||
              (item.totalCost ?? "")
                  .toString()
                  .toLowerCase()
                  .contains(searchText) ||
              (item.costPerMile ?? "")
                  .toString()
                  .toLowerCase()
                  .contains(searchText) ||
              (item.nextMaintDue ?? "")
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
        //   String responceMessage = responseBody['message'];
        print('API call successful');

        CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
            'Job no: $token  Successfully Shared', context);
        print('Job no: $token  Successfully Shared');
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
    //  "https://atsdev2test.ariespro.com/civmapi/login_user/getAllSupervisorsAndContractors";

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
