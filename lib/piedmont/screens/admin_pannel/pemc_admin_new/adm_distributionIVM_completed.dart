import 'package:CIVM/piedmont/data/response/status.dart';
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
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

// ignore: must_be_immutable
class AdmDistributionIVmCompleted extends StatefulWidget {
  String budgetType;
  String maintenanceType;
  String heading;

  AdmDistributionIVmCompleted(
      {Key? key,
      required this.budgetType,
      required this.maintenanceType,
      required this.heading})
      : super(key: key);

  @override
  State<AdmDistributionIVmCompleted> createState() =>
      _AdmDistributionIVmCompletedState();
}

class _AdmDistributionIVmCompletedState
    extends State<AdmDistributionIVmCompleted> {
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
            'closed',
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
            'Distribution-IVM (Closed)',
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
                  return RefreshIndicator(
                    onRefresh: () async {
                      _input.clear();
                      selectedSubstation = null;
                      selectedFeeder = null;
                      await distributionivmInProgressViewmodel
                          .fetchDistributionivmInProgressGetTabularListApi(
                              context,
                              'closed',
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
                          //       fetchData(val!, 'closed', '');
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
                          //           substationId.toString(), 'closed', val!);
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
                                "TOTAL NO OF RECORDS : ${distributionivmInProgressViewmodel.distributionivmInProgressGetTabularData.data!.findAllTableData!.length.toString()}",
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
                                      onChanged: (value) => _filterData(value),
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
                                itemCount: distributionivmInProgressViewmodel
                                    .distributionivmInProgressGetTabularData
                                    .data!
                                    .findAllTableData!
                                    .length,
                                itemBuilder: (BuildContext ctxt, int index) {
                                  String? dateStringCreateDate =
                                      distributionivmInProgressViewmodel
                                          .distributionivmInProgressGetTabularData
                                          .data!
                                          .findAllTableData![index]
                                          .createDate
                                          .toString();
                                  DateTime date =
                                      DateTime.parse(dateStringCreateDate);
                                  String formattedDateCreateDate =
                                      DateFormat('MM/dd/yyyy').format(date);
                                  newDateFormat(index);
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
                                                                distributionivmInProgressViewmodel
                                                                    .distributionivmInProgressGetTabularData
                                                                    .data!
                                                                    .findAllTableData![
                                                                        index]
                                                                     .tokenNo
                                                                    .toString(),
                                                              );
                                                              await Future.delayed(
                                                                  const Duration(
                                                                      seconds:
                                                                          2));
                                                              openDialogPicture(
                                                                  distributionivmInProgressViewmodel
                                                                      .distributionivmInProgressGetTabularData
                                                                      .data!
                                                                      .findAllTableData![
                                                                          index]
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
                                                            (distributionivmInProgressViewmodel
                                                                            .distributionivmInProgressGetTabularData
                                                                            .data!
                                                                            .findAllTableData![
                                                                                index]
                                                                            .maintType ==
                                                                        null ||
                                                                    distributionivmInProgressViewmodel
                                                                            .distributionivmInProgressGetTabularData
                                                                            .data!
                                                                            .findAllTableData![
                                                                                index]
                                                                            .maintType
                                                                            .toString() ==
                                                                        'null')
                                                                ? ''
                                                                : distributionivmInProgressViewmodel
                                                                    .distributionivmInProgressGetTabularData
                                                                    .data!
                                                                    .findAllTableData![
                                                                        index]
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
                                                            (distributionivmInProgressViewmodel
                                                                            .distributionivmInProgressGetTabularData
                                                                            .data!
                                                                            .findAllTableData![
                                                                                index]
                                                                            .tokenNo ==
                                                                        null ||
                                                                    distributionivmInProgressViewmodel
                                                                            .distributionivmInProgressGetTabularData
                                                                            .data!
                                                                            .findAllTableData![
                                                                                index]
                                                                            .tokenNo
                                                                            .toString() ==
                                                                        'null')
                                                                ? ''
                                                                : distributionivmInProgressViewmodel
                                                                    .distributionivmInProgressGetTabularData
                                                                    .data!
                                                                    .findAllTableData![
                                                                        index]
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
                                                            "STATUS: ",
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
                                                            (distributionivmInProgressViewmodel
                                                                            .distributionivmInProgressGetTabularData
                                                                            .data!
                                                                            .findAllTableData![
                                                                                index]
                                                                            .status ==
                                                                        null ||
                                                                    distributionivmInProgressViewmodel
                                                                            .distributionivmInProgressGetTabularData
                                                                            .data!
                                                                            .findAllTableData![
                                                                                index]
                                                                            .status
                                                                            .toString() ==
                                                                        'null')
                                                                ? ''
                                                                : distributionivmInProgressViewmodel
                                                                    .distributionivmInProgressGetTabularData
                                                                    .data!
                                                                    .findAllTableData![
                                                                        index]
                                                                    .status
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
                                                            (distributionivmInProgressViewmodel
                                                                            .distributionivmInProgressGetTabularData
                                                                            .data!
                                                                            .findAllTableData![
                                                                                index]
                                                                            .substation ==
                                                                        null ||
                                                                    distributionivmInProgressViewmodel
                                                                            .distributionivmInProgressGetTabularData
                                                                            .data!
                                                                            .findAllTableData![
                                                                                index]
                                                                            .substation
                                                                            .toString() ==
                                                                        'null')
                                                                ? ''
                                                                : distributionivmInProgressViewmodel
                                                                    .distributionivmInProgressGetTabularData
                                                                    .data!
                                                                    .findAllTableData![
                                                                        index]
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
                                                            (distributionivmInProgressViewmodel
                                                                            .distributionivmInProgressGetTabularData
                                                                            .data!
                                                                            .findAllTableData![
                                                                                index]
                                                                            .fdrName ==
                                                                        null ||
                                                                    distributionivmInProgressViewmodel
                                                                            .distributionivmInProgressGetTabularData
                                                                            .data!
                                                                            .findAllTableData![
                                                                                index]
                                                                            .fdrName
                                                                            .toString() ==
                                                                        'null')
                                                                ? ''
                                                                : distributionivmInProgressViewmodel
                                                                    .distributionivmInProgressGetTabularData
                                                                    .data!
                                                                    .findAllTableData![
                                                                        index]
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
                                                            (distributionivmInProgressViewmodel
                                                                            .distributionivmInProgressGetTabularData
                                                                            .data!
                                                                            .findAllTableData![
                                                                                index]
                                                                            .maintType ==
                                                                        null ||
                                                                    distributionivmInProgressViewmodel
                                                                            .distributionivmInProgressGetTabularData
                                                                            .data!
                                                                            .findAllTableData![
                                                                                index]
                                                                            .maintType
                                                                            .toString() ==
                                                                        'null')
                                                                ? ''
                                                                : distributionivmInProgressViewmodel
                                                                    .distributionivmInProgressGetTabularData
                                                                    .data!
                                                                    .findAllTableData![
                                                                        index]
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
                                                            (distributionivmInProgressViewmodel
                                                                            .distributionivmInProgressGetTabularData
                                                                            .data!
                                                                            .findAllTableData![
                                                                                index]
                                                                            .contractor ==
                                                                        null ||
                                                                    distributionivmInProgressViewmodel
                                                                            .distributionivmInProgressGetTabularData
                                                                            .data!
                                                                            .findAllTableData![
                                                                                index]
                                                                            .contractor
                                                                            .toString() ==
                                                                        'null')
                                                                ? ''
                                                                : distributionivmInProgressViewmodel
                                                                    .distributionivmInProgressGetTabularData
                                                                    .data!
                                                                    .findAllTableData![
                                                                        index]
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
                                                            (distributionivmInProgressViewmodel
                                                                            .distributionivmInProgressGetTabularData
                                                                            .data!
                                                                            .findAllTableData![
                                                                                index]
                                                                            .createDate ==
                                                                        null ||
                                                                    distributionivmInProgressViewmodel
                                                                            .distributionivmInProgressGetTabularData
                                                                            .data!
                                                                            .findAllTableData![index]
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
                                                            (distributionivmInProgressViewmodel
                                                                            .distributionivmInProgressGetTabularData
                                                                            .data!
                                                                            .findAllTableData![
                                                                                index]
                                                                            .contractYear ==
                                                                        null ||
                                                                    distributionivmInProgressViewmodel
                                                                            .distributionivmInProgressGetTabularData
                                                                            .data!
                                                                            .findAllTableData![index]
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
                                                            (distributionivmInProgressViewmodel
                                                                            .distributionivmInProgressGetTabularData
                                                                            .data!
                                                                            .findAllTableData![
                                                                                index]
                                                                            .contractorCompany ==
                                                                        null ||
                                                                    distributionivmInProgressViewmodel
                                                                            .distributionivmInProgressGetTabularData
                                                                            .data!
                                                                            .findAllTableData![
                                                                                index]
                                                                            .contractorCompany
                                                                            .toString() ==
                                                                        'null')
                                                                ? ''
                                                                : distributionivmInProgressViewmodel
                                                                    .distributionivmInProgressGetTabularData
                                                                    .data!
                                                                    .findAllTableData![
                                                                        index]
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
                                                            (distributionivmInProgressViewmodel
                                                                            .distributionivmInProgressGetTabularData
                                                                            .data!
                                                                            .findAllTableData![
                                                                                index]
                                                                            .cycle ==
                                                                        null ||
                                                                    distributionivmInProgressViewmodel
                                                                            .distributionivmInProgressGetTabularData
                                                                            .data!
                                                                            .findAllTableData![
                                                                                index]
                                                                            .cycle
                                                                            .toString() ==
                                                                        'null')
                                                                ? ''
                                                                : distributionivmInProgressViewmodel
                                                                    .distributionivmInProgressGetTabularData
                                                                    .data!
                                                                    .findAllTableData![
                                                                        index]
                                                                    .cycle
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
                                                                "TOTAL COST: ",
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
                                                                (distributionivmInProgressViewmodel.distributionivmInProgressGetTabularData.data!.findAllTableData![index].totalCost ==
                                                                            null ||
                                                                        distributionivmInProgressViewmodel.distributionivmInProgressGetTabularData.data!.findAllTableData![index].totalCost.toString() ==
                                                                            'null')
                                                                    ? ''
                                                                    : distributionivmInProgressViewmodel
                                                                        .distributionivmInProgressGetTabularData
                                                                        .data!
                                                                        .findAllTableData![
                                                                            index]
                                                                        .totalCost
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
                                                                "COST PER MILE: ",
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
                                                                (distributionivmInProgressViewmodel.distributionivmInProgressGetTabularData.data!.findAllTableData![index].costPerMile ==
                                                                            null ||
                                                                        distributionivmInProgressViewmodel.distributionivmInProgressGetTabularData.data!.findAllTableData![index].costPerMile.toString() ==
                                                                            'null')
                                                                    ? ''
                                                                    : distributionivmInProgressViewmodel
                                                                        .distributionivmInProgressGetTabularData
                                                                        .data!
                                                                        .findAllTableData![
                                                                            index]
                                                                        .costPerMile
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
                                                                "NEXT MAINT DUE: ",
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
                                                                (distributionivmInProgressViewmodel.distributionivmInProgressGetTabularData.data!.findAllTableData![index].nextMaintDue ==
                                                                            null ||
                                                                        distributionivmInProgressViewmodel.distributionivmInProgressGetTabularData.data!.findAllTableData![index].nextMaintDue.toString() ==
                                                                            'null')
                                                                    ? ''
                                                                    : formattedNextMaintDue,
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
                                                            (distributionivmInProgressViewmodel
                                                                            .distributionivmInProgressGetTabularData
                                                                            .data!
                                                                            .findAllTableData![
                                                                                index]
                                                                            .totalMiles ==
                                                                        null ||
                                                                    distributionivmInProgressViewmodel
                                                                            .distributionivmInProgressGetTabularData
                                                                            .data!
                                                                            .findAllTableData![
                                                                                index]
                                                                            .totalMiles
                                                                            .toString() ==
                                                                        'null')
                                                                ? ''
                                                                : distributionivmInProgressViewmodel
                                                                    .distributionivmInProgressGetTabularData
                                                                    .data!
                                                                    .findAllTableData![
                                                                        index]
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
                                                            (distributionivmInProgressViewmodel
                                                                            .distributionivmInProgressGetTabularData
                                                                            .data!
                                                                            .findAllTableData![
                                                                                index]
                                                                            .milesCompleted ==
                                                                        null ||
                                                                    distributionivmInProgressViewmodel
                                                                            .distributionivmInProgressGetTabularData
                                                                            .data!
                                                                            .findAllTableData![
                                                                                index]
                                                                            .milesCompleted
                                                                            .toString() ==
                                                                        'null')
                                                                ? ''
                                                                : distributionivmInProgressViewmodel
                                                                    .distributionivmInProgressGetTabularData
                                                                    .data!
                                                                    .findAllTableData![
                                                                        index]
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
                                                            (distributionivmInProgressViewmodel
                                                                            .distributionivmInProgressGetTabularData
                                                                            .data!
                                                                            .findAllTableData![
                                                                                index]
                                                                            .milesPending ==
                                                                        null ||
                                                                    distributionivmInProgressViewmodel
                                                                            .distributionivmInProgressGetTabularData
                                                                            .data!
                                                                            .findAllTableData![
                                                                                index]
                                                                            .milesPending
                                                                            .toString() ==
                                                                        'null')
                                                                ? ''
                                                                : distributionivmInProgressViewmodel
                                                                    .distributionivmInProgressGetTabularData
                                                                    .data!
                                                                    .findAllTableData![
                                                                        index]
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
                                                          // alignment: Alignment.topLeft,
                                                          child: Column(
                                                            children: [
                                                              const Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child: Text(
                                                                  "CREATED BY: ",
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
                                                                  (distributionivmInProgressViewmodel
                                                                    .distributionivmInProgressGetTabularData
                                                                    .data!
                                                                    .findAllTableData![
                                                                        index].createdBy ==
                                                                              null ||
                                                                         distributionivmInProgressViewmodel
                                                                    .distributionivmInProgressGetTabularData
                                                                    .data!
                                                                    .findAllTableData![
                                                                        index].createdBy.toString() ==
                                                                              'null')
                                                                      ? ''
                                                                      : distributionivmInProgressViewmodel
                                                                    .distributionivmInProgressGetTabularData
                                                                    .data!
                                                                    .findAllTableData![
                                                                        index].createdBy.toString(),
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
                                                    flex: 2,
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
                                                                // Navigator.of(context).push(MaterialPageRoute(
                                                                //     builder: (BuildContext context) => MapViewSupervisor(
                                                                //           id: distributionivmInProgressViewmodel.distributionivmInProgressGetTabularData.data!.findAllTableData![index].id.toString(),
                                                                //         )));
                                                                // Navigator
                                                                //         .push(
                                                                //       context,
                                                                //       MaterialPageRoute(
                                                                //         builder:
                                                                //             (context) =>
                                                                //                 MapViewPage(
                                                                //           url:MapUrl.getSupervisorEndPoint(distributionivmInProgressViewmodel.distributionivmInProgressGetTabularData.data!.findAllTableData![index].tokenNo.toString(),id),
                                                                //         ),
                                                                //       ),
                                                                //     );

                                                                await browser
                                                                    .open(
                                                                        url: WebUri(MapUrl.getSupervisorEndPoint(
                                                                            distributionivmInProgressViewmodel.distributionivmInProgressGetTabularData.data!.findAllTableData![index].tokenNo
                                                                                .toString(),
                                                                            id)),
                                                                        // "https://mapapi.ariespro.com/main/supervisor/CIVM_Map/${distributionivmInProgressViewmodel.distributionivmInProgressGetTabularData.data!.findAllTableData![index].tokenNo.toString()}/USRQWXH589Z"),
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
            'closed',
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
                'closed',
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

  void _filterData(String query) {
    if (query.isEmpty) {
      selectedSubstation = null;
      selectedFeeder = null;
      distributionivmInProgressViewmodel
          .fetchDistributionivmInProgressGetTabularListApi(
              context,
              'closed',
              'Regular IVM maintenance',
              'RegularMaint',
              'supervisor',
              'IVM Work Plan',
                              'Lewis Tree');
    } else {
      distributionivmInProgressViewmodel.distributionivmInProgressGetTabularData.data!.findAllTableData = distributionivmInProgressViewmodel
          .distributionivmInProgressGetTabularData.data!.findAllTableData!
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

  Future<void> fetchCrewList() async {
    setState(() {
      isLoading = true;
    });

    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    // String contractorId = data.user!.id.toString();

    String url = AppUrl.crewList;
    // "https://atsdev2test.ariespro.com/civmapi/login_user/getAllCrewFromCREWMASTER?contractorId=$contractorId";
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

  Future<void> updateFlagValue(String token, int flag) async {
    const String url =
        'https://atsdev2test.ariespro.com/civmapi/vma_row_custom_main_plan/updateFlagValue';
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
        },
      );
      print(
          "token testing $token, crewId $selectedCrewLoginID, flag ${flag.toString()}");
      print("url testing $url");
      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);
        print('responseBody $responseBody');
        String crewEmailId = responseBody['crewEmailId'];
        print('API call successful');
        String message = '';
        if (widget.heading == 'Total Order Pending (IVM Maintenance)') {
          message = 'IVM Maintenance';
        } else if (widget.heading ==
            'Total Order Pending (Mid cycle Herbicide)') {
          message = 'Mid cycle Herbicide';
        }
        CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
            'Job no: $token $message Successfully Shared with Crew', context);
        print('testing $token $message Successfully Shared with Crew');
        DateTime now = DateTime.now();
        var formatter = DateFormat('MM-dd-yyyy HH:mm:ss');
        String formattedDate = formatter.format(now);
        var subject = 'CIVM ROW';
        var msg =
            'Job No. $token $message Successfully Shared with you on $formattedDate.';
        _sendMail(subject, msg, crewEmailId);
        distributionivmInProgressViewmodel
            .fetchDistributionivmInProgressGetTabularListApi(
                context,
                'closed',
                'Regular IVM maintenance',
                'RegularMaint',
                'supervisor',
                'IVM Work Plan',
                              'Lewis Tree');
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

  Future<void> _sendMail(
      String subject, String content, String crewEmailId) async {
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
        crewEmailId
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
}
