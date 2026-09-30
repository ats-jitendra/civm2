import 'package:CIVM/piedmont/data/response/status.dart';
import 'package:CIVM/piedmont/models/lcp_work_order_closed_model.dart';
import 'package:CIVM/piedmont/resources/app_colors.dart';
import 'package:CIVM/piedmont/repository/map_url.dart';
import 'package:CIVM/piedmont/resources/app_url.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/pdf_view.dart';
import 'package:CIVM/piedmont/screens/my_chrome_safari_map_recording.dart';
import 'package:CIVM/piedmont/screens/video_folder/fullVideo/full_screen_video_player.dart';
import 'package:CIVM/piedmont/utils/common_functions.dart';
import 'package:CIVM/piedmont/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/piedmont/view_model/distributionIVM_inProgress_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ignore: must_be_immutable
class AdmDistributionIVmOPEN extends StatefulWidget {
  String budgetType;
  String maintenanceType;
  String heading;

  AdmDistributionIVmOPEN(
      {Key? key,
      required this.budgetType,
      required this.maintenanceType,
      required this.heading})
      : super(key: key);

  @override
  State<AdmDistributionIVmOPEN> createState() =>
      _AdmDistributionIVmOPENState();
}

class _AdmDistributionIVmOPENState
    extends State<AdmDistributionIVmOPEN> {
  List<String> menu = [];

  int substationId = 0;
  int feederId = 0;

  // ignore: prefer_typing_uninitialized_variables
  var selectedSubstation;
  // ignore: prefer_typing_uninitialized_variables
  var selectedFeeder;

  String userName = '';

  // ignore: non_constant_identifier_names
  final select_status = ['APPROVE', 'REJECT'];
  // ignore: non_constant_identifier_names
  String? status;

  DistributionivmInProgressViewmodel distributionivmInProgressViewmodel =
      DistributionivmInProgressViewmodel();

  final browser = MyChromeSafariBrowser();
  final TextEditingController _input = TextEditingController();

  String formattedContractYear = '';
  String formattedNextMaintDue = '';
  bool isLoading = false;
  String selectedCrewLoginID = '';
  List<Map<String, dynamic>> crewList = [];
  String? selectedCrew;

  @override
  void initState() {
    fetchCrewList();
    distributionivmInProgressViewmodel
        .fetchDistributionivmInProgressGetTabularListApi(
            context,
            'PENDING',
            'Regular IVM maintenance',
            'RegularMaint',
            'supervisor',
            'IVM Work Plan',
            'Lewis Tree');

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
            'Distribution-IVM (Open)',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: AppColors.baseColor,
        ),
        body: ChangeNotifierProvider<DistributionivmInProgressViewmodel>(
            create: (BuildContext context) =>
                distributionivmInProgressViewmodel,
            child: Consumer<DistributionivmInProgressViewmodel>(
                builder: (context, value, _) {
              switch (value.distributionivmInProgressGetTabularData.status) {
                // ignore: constant_pattern_never_matches_value_type
                case Status.LOADING:
                  return const Center(child: CircularProgressIndicator());
                // ignore: constant_pattern_never_matches_value_type
                case Status.ERROR:
                  return
                      // CustomToastSnackBarProgressDialog.flushBarErrorMessage(
                      //     value.distributionivmInProgressGetTabularData.message
                      //         .toString(),
                      //     context);
                      Padding(
                    padding: const EdgeInsets.only(
                        top: 16.0, bottom: 16, left: 8, right: 8),
                    child: Center(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/empty_box_pemc.png',
                              height: 200,
                              width: 200,
                              fit: BoxFit.cover,
                            ),
                            const Center(
                              child: Text(
                                'Sorry, Data Not Found!',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: AppColors.baseColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                // ignore: constant_pattern_never_matches_value_type
                case Status.COMPLETED:
                final filteredList = distributionivmInProgressViewmodel
    .distributionivmInProgressGetTabularData
    .data!
    .findAllTableData!
    .where((item) => item.visibilityFlag?.toString() == "0")
    .toList();
                  return RefreshIndicator(
                    onRefresh: () async {
                      _input.clear();
                      selectedSubstation = null;
                      selectedFeeder = null;
                      await distributionivmInProgressViewmodel
                          .fetchDistributionivmInProgressGetTabularListApi(
                              context,
                              'PENDING',
                              'Regular IVM maintenance',
                              'RegularMaint',
                              'supervisor',
                              'IVM Work Plan',
                              'Lewis Tree');
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
                          // const Align(
                          //     alignment: Alignment.centerLeft,
                          //     child: Padding(
                          //       padding: EdgeInsets.only(
                          //           left: 2.0,
                          //           right: 2.0,
                          //           bottom: 2.0,
                          //           top: 4.0),
                          //       child: Text(
                          //         "SUBSTATION",
                          //         style: TextStyle(
                          //             fontSize: 16,
                          //             color: AppColors.baseColor,
                          //             fontWeight: FontWeight.bold),
                          //       ),
                          //     )),
                          // Align(
                          //   alignment: Alignment.centerLeft,
                          //   child: DropdownButtonFormField<String>(
                          //     hint: const Text('-Select-'),
                          //     dropdownColor: Colors.white,
                          //     value: selectedSubstation,
                          //     style: const TextStyle(
                          //         color: AppColors.baseColor, fontSize: 16),
                          //     icon: const Icon(
                          //       Icons.arrow_drop_down,
                          //       color: AppColors.baseColor,
                          //       size: 40,
                          //     ),
                          //     decoration: const InputDecoration(
                          //       enabledBorder: OutlineInputBorder(
                          //         borderSide: BorderSide(
                          //           color: AppColors.baseColor,
                          //         ),
                          //         // borderRadius: BorderRadius.circular(25),
                          //       ),
                          //       focusedBorder: OutlineInputBorder(
                          //         borderSide: BorderSide(
                          //           color: AppColors.baseColor,
                          //         ),
                          //         // borderRadius: BorderRadius.circular(25),
                          //       ),
                          //     ),
                          //     isExpanded: true,
                          //     items: distributionivmInProgressViewmodel
                          //         .distributionivmInProgressGetTabularData
                          //         .data!
                          //         .findAllSubstationAndSubIdByStatus!
                          //         .map((e) {
                          //       return DropdownMenuItem(
                          //         value: e.subId.toString(),
                          //         // e.getIdAndSubstationByCountId![0].subStation.toString(),
                          //         child: Text(e.subStation.toString()),
                          //       );
                          //     }).toList(),
                          //     onChanged: (val) {
                          //       if (selectedFeeder != null) {
                          //         selectedFeeder = null;
                          //       }
                          //       print('val');
                          //       print(val);
                          //       fetchData(val!, 'PENDING', '');
                          //       substationId = int.parse(val);
                          //       print('111111111111111');
                          //       print(substationId);
                          //       setState(() {
                          //         selectedSubstation = val;
                          //       });
                          //     },
                          //     validator: (value) =>
                          //         value == null ? 'field required' : null,
                          //   ),
                          // ),
                          // const Align(
                          //     alignment: Alignment.centerLeft,
                          //     child: Padding(
                          //       padding: EdgeInsets.only(
                          //           left: 2.0,
                          //           right: 2.0,
                          //           bottom: 2.0,
                          //           top: 4.0),
                          //       child: Text(
                          //         "FEEDER",
                          //         style: TextStyle(
                          //             fontSize: 16,
                          //             color: AppColors.baseColor,
                          //             fontWeight: FontWeight.bold),
                          //       ),
                          //     )),
                          // Align(
                          //   alignment: Alignment.centerLeft,
                          //   child: DropdownButtonFormField<String>(
                          //     hint: const Text('-Select-'),
                          //     dropdownColor: Colors.white,
                          //     value: selectedFeeder,
                          //     style: const TextStyle(
                          //         color: AppColors.baseColor, fontSize: 16),
                          //     icon: const Icon(
                          //       Icons.arrow_drop_down,
                          //       color: AppColors.baseColor,
                          //       size: 40,
                          //     ),
                          //     decoration: const InputDecoration(
                          //       enabledBorder: OutlineInputBorder(
                          //         borderSide: BorderSide(
                          //           color: AppColors.baseColor,
                          //         ),
                          //         // borderRadius: BorderRadius.circular(25),
                          //       ),
                          //       focusedBorder: OutlineInputBorder(
                          //         borderSide: BorderSide(
                          //           color: AppColors.baseColor,
                          //         ),
                          //         // borderRadius: BorderRadius.circular(25),
                          //       ),
                          //     ),
                          //     isExpanded: true,
                          //     items: distributionivmInProgressViewmodel
                          //         .distributionivmInProgressGetTabularData
                          //         .data!
                          //         .findAllFeederNameAndFeederByCountyAndSubstationAndStatus!
                          //         .map((e) {
                          //       return DropdownMenuItem(
                          //         value: e.feeder.toString(),
                          //         // e.getIdAndSubstationByCountId![0].subStation.toString(),
                          //         child: Text(e.feederName.toString()),
                          //       );
                          //     }).toList(),
                          //     onChanged: (val) {
                          //       print('val');
                          //       print(val);
                          //       fetchData(
                          //           substationId.toString(), 'PENDING', val!);
                          //       feederId = int.parse(val);
                          //       print('111111111111111');
                          //       print(substationId);
                          //       setState(() {
                          //         selectedFeeder = val;
                          //       });
                          //     },
                          //     validator: (value) =>
                          //         value == null ? 'field required' : null,
                          //   ),
                          // ),

                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                "TOTAL NO OF RECORDS : ${filteredList.length.toString()}",
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
                                      onChanged: (value) => _filterData(value, filteredList),
                                      //  key: formkey2,
                                      controller: _input,
                                      style: const TextStyle(
                                          color: AppColors.baseColor,
                                          fontSize: 16),
                                      obscureText: false,

                                      // keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color:
                                                Color.fromARGB(255, 23, 1, 88),
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
                                itemCount: filteredList
                                    .length,
                                itemBuilder: (BuildContext ctxt, int index) {
                                  String? dateStringCreateDate =
                                      filteredList[index]
                                          .createDate
                                          .toString();
                                  DateTime date =
                                      DateTime.parse(dateStringCreateDate);
                                  String formattedDateCreateDate =
                                      DateFormat('MM/dd/yyyy').format(date);
                                  newDateFormat(index);
                                  final item = filteredList[index];
                                  return Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 4.0, bottom: 4, left: 4),
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
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ),
                                            border: Border.all(
                                              color: Colors.white,
                                            ),
                                            borderRadius:
                                                const BorderRadius.only(
                                              topRight: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                              topLeft: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                            ),
                                          ),
                                          child: Column(children: [
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
                                                            "SHARE: ",
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                     if (item
                                                                    .visibilityFlag
                                                                    .toString() ==
                                                                '2') {
                                                              CustomToastSnackBarProgressDialog
                                                                  .flushBarSuccessMessage(
                                                                      'Job no: ${item.tokenNo} already shared with ${item.contractor}',
                                                                      context);
                                                            } else {
                                                              showCrewDialog(
                                                                  context,
                                                                  item
                                                                      .tokenNo
                                                                      .toString());
                                                            }     },
                                                          child: Align(
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: Icon(
                                                              Icons.share,
                                                              color: (item
                                                                          .visibilityFlag
                                                                          .toString() ==
                                                                      '2')
                                                                  ? Colors.green
                                                                  : Colors.blue,
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
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: InkWell(
                                                            onTap: () async {
                                                              await distributionivmInProgressViewmodel
                                                                  .fetchImageApi(
                                                                context,
                                                                item
                                                                    .tokenNo
                                                                    .toString(),
                                                              );
                                                              await Future.delayed(
                                                                  const Duration(
                                                                      seconds:
                                                                          2));
                                                              openDialogPicture(
                                                                  item
                                                                      .tokenNo
                                                                      .toString());
                                                            },
                                                            child: const Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child: Icon(
                                                                  Icons.image,
                                                                  color: Colors
                                                                      .blue,
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
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Text(
                                                            (item
                                                                            .type ==
                                                                        null ||
                                                                    item
                                                                            .type
                                                                            .toString() ==
                                                                        'null')
                                                                ? ''
                                                                : item
                                                                    .type
                                                                    .toString(),
                                                            textAlign:
                                                                TextAlign.left,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 12,
                                                              //  fontWeight:
                                                              //      FontWeight.bold,
                                                              color:
                                                                  Colors.white,
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
                                                            "JOB NO: ",
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Text(
                                                            (item
                                                                            .tokenNo ==
                                                                        null ||
                                                                    item
                                                                            .tokenNo
                                                                            .toString() ==
                                                                        'null')
                                                                ? ''
                                                                : item
                                                                    .tokenNo
                                                                    .toString(),
                                                            textAlign:
                                                                TextAlign.left,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 12,
                                                              //  fontWeight:
                                                              //      FontWeight.bold,
                                                              color:
                                                                  Colors.white,
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
                                                          (item
                                                                          .createdBy ==
                                                                      null ||
                                                                  item
                                                                          .createdBy
                                                                          .toString() ==
                                                                      'null')
                                                              ? ''
                                                              : distributionivmInProgressViewmodel
                                                                  .distributionivmInProgressGetTabularData
                                                                  .data!
                                                                  .findAllTableData![
                                                                      index]
                                                                  .createdBy
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
                                                            "SUBSTATION: ",
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Text(
                                                            (item
                                                                            .substation ==
                                                                        null ||
                                                                    item
                                                                            .substation
                                                                            .toString() ==
                                                                        'null')
                                                                ? ''
                                                                : item
                                                                    .substation
                                                                    .toString(),
                                                            textAlign:
                                                                TextAlign.left,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 12,
                                                              //  fontWeight:
                                                              //      FontWeight.bold,
                                                              color:
                                                                  Colors.white,
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
                                                            "FEEDER: ",
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Text(
                                                            (item
                                                                            .fdrName ==
                                                                        null ||
                                                                    item
                                                                            .fdrName
                                                                            .toString() ==
                                                                        'null')
                                                                ? ''
                                                                : item
                                                                    .fdrName
                                                                    .toString(),
                                                            textAlign:
                                                                TextAlign.left,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 12,
                                                              //  fontWeight:
                                                              //      FontWeight.bold,
                                                              color:
                                                                  Colors.white,
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
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Text(
                                                            (item
                                                                            .maintType ==
                                                                        null ||
                                                                    item
                                                                            .maintType
                                                                            .toString() ==
                                                                        'null')
                                                                ? ''
                                                                : item
                                                                    .maintType
                                                                    .toString(),
                                                            textAlign:
                                                                TextAlign.left,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 12,
                                                              //  fontWeight:
                                                              //      FontWeight.bold,
                                                              color:
                                                                  Colors.white,
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
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Text(
                                                            (item
                                                                            .contractor ==
                                                                        null ||
                                                                    item
                                                                            .contractor
                                                                            .toString() ==
                                                                        'null')
                                                                ? ''
                                                                : item
                                                                    .contractor
                                                                    .toString(),
                                                            textAlign:
                                                                TextAlign.left,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 12,
                                                              //  fontWeight:
                                                              //      FontWeight.bold,
                                                              color:
                                                                  Colors.white,
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
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Text(
                                                            (item
                                                                            .totalMiles ==
                                                                        null ||
                                                                    item
                                                                            .totalMiles
                                                                            .toString() ==
                                                                        'null')
                                                                ? ''
                                                                : item
                                                                    .totalMiles
                                                                    .toString(),
                                                            textAlign:
                                                                TextAlign.left,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 12,
                                                              //  fontWeight:
                                                              //      FontWeight.bold,
                                                              color:
                                                                  Colors.white,
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
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Text(
                                                            (item
                                                                            .contractYear ==
                                                                        null ||
                                                                    item
                                                                            .contractYear
                                                                            .toString() ==
                                                                        'null')
                                                                ? ''
                                                                : formattedContractYear,
                                                            textAlign:
                                                                TextAlign.left,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 12,
                                                              //  fontWeight:
                                                              //      FontWeight.bold,
                                                              color:
                                                                  Colors.white,
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
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Text(
                                                            (item
                                                                            .contractorCompany ==
                                                                        null ||
                                                                    item
                                                                            .contractorCompany
                                                                            .toString() ==
                                                                        'null')
                                                                ? ''
                                                                : item
                                                                    .contractorCompany
                                                                    .toString(),
                                                            textAlign:
                                                                TextAlign.left,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 12,
                                                              //  fontWeight:
                                                              //      FontWeight.bold,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // const Divider(
                                            //   color: Colors.grey,
                                            // ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Row(
                                                children: [
                                                  (widget.heading == 'CO')
                                                      ? Expanded(
                                                          // alignment: Alignment.topLeft,
                                                          child: Column(
                                                            children: [
                                                              const Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child: Text(
                                                                  "GENERAL FOREMAN NOTES 2: ",
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
                                                                  (item.contractorNotes ==
                                                                              null ||
                                                                          item.contractorNotes.toString() ==
                                                                              'null')
                                                                      ? ''
                                                                      : item
                                                                          .contractorNotes
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
                                                        )
                                                      : const Text(
                                                          "",
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                            fontSize: 0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: (widget.heading == 'CO')
                                                  ? Column(
                                                      children: [
                                                        const Divider(
                                                          color: Colors.grey,
                                                        ),
                                                        Row(
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
                                                                      "DATE OF INSPECTION: ",
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
                                                                      (item.dateOfInspection == null ||
                                                                              item.dateOfInspection.toString() ==
                                                                                  'null')
                                                                          ? ''
                                                                          : item
                                                                              .dateOfInspection
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
                                                                      "FOLLOW UP DATE: ",
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
                                                                      (item.followUpDate == null ||
                                                                              item.followUpDate.toString() ==
                                                                                  'null')
                                                                          ? ''
                                                                          : item
                                                                              .followUpDate
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
                                                                      "SERVICE MAP LOCATION: ",
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
                                                                      (item.mapLocation == null ||
                                                                              item.mapLocation.toString() ==
                                                                                  'null')
                                                                          ? ''
                                                                          : item
                                                                              .mapLocation
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
                                                      ],
                                                    )
                                                  : const Text(
                                                      "",
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontSize: 0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                            ),
                                            (widget.heading == 'CO')
                                                ? Column(
                                                    children: [
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
                                                                      "SERVICE STREET ADDRESS: ",
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
                                                                      (item.streetAddress == null ||
                                                                              item.streetAddress.toString() ==
                                                                                  'null')
                                                                          ? ''
                                                                          : item
                                                                              .streetAddress
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
                                                                      "ADMIN NOTES 1: ",
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
                                                                      (item.adminNotes1 == null ||
                                                                              item.adminNotes1.toString() ==
                                                                                  'null')
                                                                          ? ''
                                                                          : item
                                                                              .adminNotes1
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
                                                                      "ESTIMATED TIME: ",
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
                                                                      (item.estTime == null ||
                                                                              item.estTime.toString() ==
                                                                                  'null')
                                                                          ? ''
                                                                          : item
                                                                              .estTime
                                                                              .toString(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            12,
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
                                                  )
                                                : const Text('',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      fontSize: 0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                    )),
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
                                                            "CREATE DATE: ",
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Text(
                                                            (item
                                                                            .createDate ==
                                                                        null ||
                                                                    item
                                                                            .createDate
                                                                            .toString() ==
                                                                        'null')
                                                                ? ''
                                                                : formattedDateCreateDate,
                                                            textAlign:
                                                                TextAlign.left,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 12,
                                                              //  fontWeight:
                                                              //      FontWeight.bold,
                                                              color:
                                                                  Colors.white,
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
                                                            "TOTAL MILES COMPLETED: ",
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Text(
                                                            (item
                                                                            .milesCompleted ==
                                                                        null ||
                                                                    item
                                                                            .milesCompleted
                                                                            .toString() ==
                                                                        'null')
                                                                ? ''
                                                                : item
                                                                    .milesCompleted
                                                                    .toString(),
                                                            textAlign:
                                                                TextAlign.left,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 12,
                                                              //  fontWeight:
                                                              //      FontWeight.bold,
                                                              color:
                                                                  Colors.white,
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
                                                            "REMAINING MILES: ",
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Text(
                                                            (item
                                                                            .milesPending ==
                                                                        null ||
                                                                    item
                                                                            .milesPending
                                                                            .toString() ==
                                                                        'null')
                                                                ? ''
                                                                : item
                                                                    .milesPending
                                                                    .toString(),
                                                            textAlign:
                                                                TextAlign.left,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 12,
                                                              //  fontWeight:
                                                              //      FontWeight.bold,
                                                              color:
                                                                  Colors.white,
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
                                                    // flex: 2,
                                                    child: Column(
                                                      children: [
                                                        Align(
                                                            alignment: Alignment
                                                                .topLeft,
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
                                                                id = data
                                                                    .user!.id
                                                                    .toString();
                                                                await browser
                                                                    .open(
                                                                        url: WebUri(MapUrl.getSupervisorEndPoint(
                                                                            item.tokenNo
                                                                                .toString(),
                                                                            id)),
                                                                        // "https://mapapi.ariespro.com/main/supervisor/CIVM_Map/${item.tokenNo.toString()}/USRQWXH589Z"),
                                                                        settings: ChromeSafariBrowserSettings(
                                                                            shareState:
                                                                                CustomTabsShareState.SHARE_STATE_OFF,
                                                                            barCollapsingEnabled: true));
                                                              },
                                                              child: Align(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child:
                                                                    Container(
                                                                  // margin: const EdgeInsets.only(
                                                                  //     left: 40, right: 40, bottom: 10.0),
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8),
                                                                  alignment:
                                                                      Alignment
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
                                                                              Color.fromARGB(255, 0, 79, 215),
                                                                              Colors.blue,
                                                                              Color.fromARGB(255, 0, 79, 215),
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
                                                                            FontWeight.bold,
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
                                                  flex: 2,
                                                  child: Column(
                                                    children: [
                                                      Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: InkWell(
                                                          onTap: () async {
                                                            showDeleteConfirmationDialog(
                                                              item.tokenNo
                                                                  .toString(),
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
                                                                      150,
                                                                      11,
                                                                      1,
                                                                    ),
                                                                gradient:
                                                                    LinearGradient(
                                                                      colors: [
                                                                        Colors
                                                                            .red,
                                                                        Colors
                                                                            .red,
                                                                        Colors
                                                                            .red,
                                                                      ],
                                                                    ),
                                                              ),
                                                              child: const Align(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Text(
                                                                  "DELETE",
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

                                 
                                          ]),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                  );

                default:
                  return const Text('');
              }
            })));
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(item,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 20,
          )));

  Future<void> setUserName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      userName =
          '${preferences.getString('FIRST_NAME')} ${preferences.getString('LAST_NAME')!}';
    });
  }

  //
  void fetchData(String substationId, String status, String feeder) {
    distributionivmInProgressViewmodel
        .fetchDistributionivmInProgressGetTabularListApi(
            context,
            'PENDING',
            'Regular IVM maintenance',
            'RegularMaint',
            'supervisor',
            'IVM Work Plan',
            'Lewis Tree');
  }

  Future openDialogPicture(String tokenNo) => showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            // lCPWorkOrdersClosedViewModel.fetchImageApi(
            //     context,
            //     //  '1');
            //     tokenNo.toString());
            int length = distributionivmInProgressViewmodel
                    .imageData.data?.images?.length ??
                0;

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
    String? fileLocation = distributionivmInProgressViewmodel
        .imageData.data?.images![i].imageLocation;

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
                        // openFullSizeImageDialog(imageLocation);
                        openFullSizeImageDialog(fileLocation);
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => ImagePaintScreen(
                        //             imageUrl: fileLocation, tokenNo: tokenNo)));
                      },
                      child: Image.network(
                        'https://pemccivm.ariespro.com/assets/clientuploads/$fileLocation',
                        // height: 400,
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
                            deleteOnlineImageApi(fileLocation, tokenNo);
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


  bool isPDF(String fileLocation) {
    return fileLocation.toLowerCase().endsWith('.pdf');
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
        distributionivmInProgressViewmodel
            .fetchDistributionivmInProgressGetTabularListApi(
                context,
                'PENDING',
                'Regular IVM maintenance',
                'RegularMaint',
                'supervisor',
                'IVM Work Plan',
                'Lewis Tree');
      } else {
        print('API request failed with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void _filterData(String query, List<DistriIVMFindAllTableData> filteredList) {
    if (query.isEmpty) {
      selectedSubstation = null;
      selectedFeeder = null;
      distributionivmInProgressViewmodel
          .fetchDistributionivmInProgressGetTabularListApi(
              context,
              'PENDING',
              'Regular IVM maintenance',
              'RegularMaint',
              'supervisor',
              'IVM Work Plan',
              'Lewis Tree');
    } else {
      // distributionivmInProgressViewmodel.distributionivmInProgressGetTabularData.data!.findAllTableData = distributionivmInProgressViewmodel
      //     .distributionivmInProgressGetTabularData.data!.findAllTableData!
      filteredList = filteredList
          .where((item) =>
              item.tokenNo.toString().toLowerCase().contains(query.toLowerCase()) ||
              item.maintType
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              item.status
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              item.substation
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              item.fdrName
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              item.createDate
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              item.type
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              item.contractorCompany
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              item.adminNotes1
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              item.totalMiles.toString().toLowerCase().contains(query.toLowerCase()) ||
              item.contractYear.toString().toLowerCase().contains(query.toLowerCase()) ||
              item.cycle.toString().toLowerCase().contains(query.toLowerCase()) ||
              item.streetAddress.toString().toLowerCase().contains(query.toLowerCase()) ||
              item.mapLocation.toString().toLowerCase().contains(query.toLowerCase()) ||
              item.adminNotes1.toString().toLowerCase().contains(query.toLowerCase()) ||
              item.dateOfInspection.toString().toLowerCase().contains(query.toLowerCase()) ||
              item.followUpDate.toString().toLowerCase().contains(query.toLowerCase()) ||
              item.costPerMile.toString().toLowerCase().contains(query.toLowerCase()) ||
              item.totalCost.toString().toLowerCase().contains(query.toLowerCase()) ||
              item.nextMaintDue.toString().toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    setState(() {});
  }

  void newDateFormat(
    int index,
  ) {
    String? rawCreateDate = distributionivmInProgressViewmodel
        .distributionivmInProgressGetTabularData
        .data!
        .findAllTableData![index]
        .contractYear
        ?.toString();

    String? rawNextMaintDue = distributionivmInProgressViewmodel
        .distributionivmInProgressGetTabularData
        .data!
        .findAllTableData![index]
        .nextMaintDue
        ?.toString();
    formattedContractYear = extractYear(rawCreateDate);
    formattedNextMaintDue = extractYear(rawNextMaintDue);
    print('rawCreateDate $rawCreateDate');
    print('formattedContractYear: $formattedContractYear');
    print('formattedNextMaintDue: $formattedNextMaintDue');
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

  Future<void> shareJobNoWithGF(int tokenNo) async {
    setState(() {
      isLoading = true;
    });

    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();

    String url = AppUrl.updateShareJobNoGF;
    // "https://atsdev2test.ariespro.com/civmapi/update_Share_JobNo_GF";

    print("URL: $url");
    print("TokenNo: $tokenNo");

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${data.token}", // remove if not required
        },
        body: jsonEncode({
          "tokenNo": tokenNo,
          "shareType": "GF",
        }),
      );

      print("Status Code: ${response.statusCode}");
      print("Response: ${response.body}");

      if (response.statusCode == 200) {
        CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
            'Job no: $tokenNo successfully shared with General Foreman',
            context);
        await Future.delayed(const Duration(seconds: 2));
        distributionivmInProgressViewmodel
            .fetchDistributionivmInProgressGetTabularListApi(
                context,
                'PENDING',
                'Regular IVM maintenance',
                'RegularMaint',
                'supervisor',
                'IVM Work Plan',
                'Lewis Tree');
      } else {
        print("Error: ${response.statusCode}");

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to share job")),
        );
      }
    } catch (e) {
      print("Exception: $e");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Something went wrong")),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchCrewList() async {
    setState(() {
      isLoading = true;
    });

    // final userPreferences = Provider.of<UserPref>(context, listen: false);
//       UserModel userData = await userPreferences.getUser();
    String userType = "3,6";
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
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: "with:", style: TextStyle()),
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
                            contentPadding: EdgeInsets.symmetric(
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
                                style: TextStyle(fontSize: 14),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setStateDialog(() {
                              selectedCrew = value;
                              //  errorMessage = null; // Clear error when user selects
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
                              //   errorMessage = "Please select a crew.";
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

  Future<void> updateFlagValue(String token, String selectedCrew) async {
    String url = "${AppUrl.distributionIVMShareApiNew}?token=$token&flag=2&id=$selectedCrew";
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
        distributionivmInProgressViewmodel
            .fetchDistributionivmInProgressGetTabularListApi(
                context,
                'PENDING',
                'Regular IVM maintenance',
                'RegularMaint',
                'supervisor',
                'IVM Work Plan',
                'Lewis Tree');
        // await Future.delayed(const Duration(seconds: 3));
        // Navigator.pop(context);
        // Navigator.pop(context);
      } else {
        print('Failed to update flag: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
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
  
   Future<void> deleteDistributionIVM(String tokenNo) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String loginId = pref.getString('id').toString();
    String url =
        "${AppUrl.deleteRecordCivm}?token_no=$tokenNo&deleteBy=$loginId";
    final uri = Uri.parse(url);
    print("Delete URL : $uri");
    try {
      final response = await http.post(
        uri,
        headers: {"Authorization": "Bearer ${data.token}"},
      );
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        await distributionivmInProgressViewmodel
            .fetchDistributionivmInProgressGetTabularListApi(
              context,
              'PENDING',
              'Regular IVM maintenance',
              'RegularMaint',
              'supervisor',
              'IVM Work Plan',
              'Lewis Tree',
            );

        if (mounted) {
          Navigator.of(context).pop(); // Close dialog
        }

        CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
          "Distribution IVM deleted successfully.",
          context,
        );
      } else {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
          "Failed to delete record.",
          context,
        );
      }
    } catch (e) {
      print(e);

      CustomToastSnackBarProgressDialog.flushBarErrorMessage(
        "Something went wrong.",
        context,
      );
    }
  }

  Future<void> showDeleteConfirmationDialog(String tokenNo) async {
    bool isDeleting = false;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              title: const Text(
                "Delete Distribution IVM",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.baseColor,
                  fontSize: 18,
                ),
              ),
              content: Text(
                "Are you sure you want to delete Job No. $tokenNo?",
                style: const TextStyle(
                  color: AppColors.baseColor,
                  fontSize: 16,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: isDeleting
                      ? null
                      : () {
                          Navigator.pop(context);
                        },
                  child: const Text(
                    "No",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.baseColor,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: isDeleting
                      ? null
                      : () async {
                          setState(() {
                            isDeleting = true;
                          });

                          await deleteDistributionIVM(tokenNo);

                          if (mounted) {
                            setState(() {
                              isDeleting = false;
                            });
                          }
                        },
                  child: isDeleting
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          "Yes",
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              ],
            );
          },
        );
      },
    );
  }

 }
