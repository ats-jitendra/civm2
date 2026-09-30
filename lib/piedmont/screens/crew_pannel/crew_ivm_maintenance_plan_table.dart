import 'dart:io';
import 'package:CIVM/piedmont/data/response/status.dart';
import 'package:CIVM/piedmont/repository/map_url.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/pdf_view.dart';
import 'package:CIVM/piedmont/screens/crew_pannel/change_order_crew.dart';
import 'package:CIVM/piedmont/screens/crew_pannel/crew_bottom_navigation_pannel.dart';
import 'package:CIVM/piedmont/screens/crew_pannel/crew_ivm_maintenance_form_final.dart';
import 'package:CIVM/piedmont/screens/leaflat_map/leaf_lat_map_wakeLock.dart';
import 'package:CIVM/piedmont/screens/login_page.dart';
import 'package:CIVM/piedmont/screens/map/provider/location_provider.dart';
import 'package:CIVM/piedmont/resources/app_colors.dart';
import 'package:CIVM/piedmont/screens/my_chrome_safari_map_recording.dart';
import 'package:CIVM/piedmont/screens/video_folder/fullVideo/full_screen_video_player.dart';
import 'package:CIVM/piedmont/utils/common_functions.dart';
import 'package:CIVM/sharedPrefs/constants.dart';
import 'package:CIVM/piedmont/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/piedmont/view_model/ivm_maintenance_progress_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;

class CrewIVMMaintenancePlanTable extends StatefulWidget {
  const CrewIVMMaintenancePlanTable({Key? key}) : super(key: key);
  @override
  State<CrewIVMMaintenancePlanTable> createState() =>
      _CrewIVMMaintenancePlanTableState();
}

class _CrewIVMMaintenancePlanTableState
    extends State<CrewIVMMaintenancePlanTable> {
  List<String> menu = [];

  int workOrderNoId = 0;
  // ignore: prefer_typing_uninitialized_variables
  var selectedWorkOrderNo;

  String userName = '';
  final browser = MyChromeSafariBrowser();
  IVMMaintenancePlanViewModel ivmMiantenanceTableViewModel =
      IVMMaintenancePlanViewModel();

  final TextEditingController _input = TextEditingController();
  String id = '';

  @override
  void initState() {
    // ivmMiantenanceTableViewModel.fetchIVMMaintenancePlanTabularListApi(
    //     context, 'PENDING', '', '', '', '');
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'IVM Maintenance Job List',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: AppColors.baseColor,
        ),
        drawer: DrawerManu(menu: menu),
        body: ChangeNotifierProvider<IVMMaintenancePlanViewModel>(
            create: (BuildContext context) => ivmMiantenanceTableViewModel,
            child: Consumer<IVMMaintenancePlanViewModel>(
                builder: (context, value, _) {
              switch (value.iVMMaintenancePlanGetTabularData.status) {
                case Status.LOADING:
                  return const Center(child: CircularProgressIndicator());
                case Status.ERROR:
                  return
                      // CustomToastSnackBarProgressDialog.flushBarErrorMessage(
                      //     value.iVMMaintenancePlanGetTabularData.message.toString(),
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
                case Status.COMPLETED:
                  return RefreshIndicator(
                    onRefresh: () async {
                      _input.clear();
                      await getData();
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
                                              color: AppColors.baseColor),
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
                                itemCount: ivmMiantenanceTableViewModel
                                    .iVMMaintenancePlanGetTabularData
                                    .data!
                                    .getAllTableData!
                                    .length,
                                // itemCount: historyList.length,
                                itemBuilder: (BuildContext ctxt, int index) {
                                  String? dateString =
                                      ivmMiantenanceTableViewModel
                                          .iVMMaintenancePlanGetTabularData
                                          .data!
                                          .getAllTableData![index]
                                          .createDate;
                                  String formattedDate = '';

                                  if (dateString != null) {
                                    DateTime date = DateTime.parse(dateString);
                                    formattedDate =
                                        DateFormat('MM/dd/yyyy').format(date);
                                  } else {
                                    formattedDate = '';
                                  }

                                  ///////////////////////////////////////
                                  final dateStringNextMaintDue =
                                      ivmMiantenanceTableViewModel
                                          .iVMMaintenancePlanGetTabularData
                                          .data!
                                          .getAllTableData![index]
                                          .nextMaintDue;
                                  final cleanedDateString =
                                      dateStringNextMaintDue
                                          .toString()
                                          .replaceAll(RegExp(r'\s+'), ' ');
                                  final parsedDateNextMaintDue =
                                      DateFormat('MMM d yyyy hh:mma')
                                          .parse(cleanedDateString);
                                  final nextMaintYear =
                                      parsedDateNextMaintDue.year;
                                  print('YearNew: $nextMaintYear');
                                  /////////////////////////////////////////////////////////////////////////////////
                                  print(
                                      'contract year: ${ivmMiantenanceTableViewModel.iVMMaintenancePlanGetTabularData.data!.getAllTableData![index].contractYear}');
                                  final contractDateString =
                                      ivmMiantenanceTableViewModel
                                          .iVMMaintenancePlanGetTabularData
                                          .data!
                                          .getAllTableData![index]
                                          .contractYear;
                                  final parsedContractDate =
                                      DateFormat('MM/dd/yyyy')
                                          .parse(contractDateString.toString());
                                  final contractYear = parsedContractDate.year;
                                  print('Contract YearNew: $contractYear');
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
                                          // height:
                                          //     MediaQuery.of(context).size.height *
                                          //         0.73,
                                          // margin:  EdgeInsets.only(
                                          //     top: 5.0, bottom: 5.0, left: 2,right: 2),
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
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                        Align(
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: InkWell(
                                                              onTap: () {
                                                                Navigator.of(context).push(MaterialPageRoute(
                                                                    builder: (BuildContext context) => CrewTempRowMaintenanceProgressContractorNew(
                                                                        jobNo: ivmMiantenanceTableViewModel
                                                                            .iVMMaintenancePlanGetTabularData
                                                                            .data!
                                                                            .getAllTableData![
                                                                                index]
                                                                            .tokenNo
                                                                            .toString(),
                                                                        substation: ivmMiantenanceTableViewModel
                                                                            .iVMMaintenancePlanGetTabularData
                                                                            .data!
                                                                            .getAllTableData![
                                                                                index]
                                                                            .substation
                                                                            .toString(),
                                                                        feeder: ivmMiantenanceTableViewModel
                                                                            .iVMMaintenancePlanGetTabularData
                                                                            .data!
                                                                            .getAllTableData![index]
                                                                            .fdrName
                                                                            .toString(),
                                                                        substationId: ivmMiantenanceTableViewModel.iVMMaintenancePlanGetTabularData.data!.getAllTableData![index].substationId.toString(),
                                                                        feederId: ivmMiantenanceTableViewModel.iVMMaintenancePlanGetTabularData.data!.getAllTableData![index].feederId.toString(),
                                                                        maintenanceType: ivmMiantenanceTableViewModel.iVMMaintenancePlanGetTabularData.data!.getAllTableData![index].type.toString())));
                                                              },
                                                              child: const Icon(
                                                                Icons.edit,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        151,
                                                                        249,
                                                                        154),
                                                              ),
                                                            )),
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
                                                        InkWell(
                                                          onTap: () async {
                                                            await ivmMiantenanceTableViewModel
                                                                .fetchImageApi(
                                                              context,
                                                              ivmMiantenanceTableViewModel
                                                                  .iVMMaintenancePlanGetTabularData
                                                                  .data!
                                                                  .getAllTableData![
                                                                      index]
                                                                  .id
                                                                  .toString(),
                                                            );
                                                            await Future.delayed(
                                                                const Duration(
                                                                    seconds:
                                                                        2));
                                                            openDialogPicture(
                                                                ivmMiantenanceTableViewModel
                                                                    .iVMMaintenancePlanGetTabularData
                                                                    .data!
                                                                    .getAllTableData![
                                                                        index]
                                                                    .id
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
                                                            (ivmMiantenanceTableViewModel
                                                                            .iVMMaintenancePlanGetTabularData
                                                                            .data!
                                                                            .getAllTableData![
                                                                                index]
                                                                            .maintType ==
                                                                        null ||
                                                                    ivmMiantenanceTableViewModel
                                                                            .iVMMaintenancePlanGetTabularData
                                                                            .data!
                                                                            .getAllTableData![
                                                                                index]
                                                                            .maintType
                                                                            .toString() ==
                                                                        'null')
                                                                ? ''
                                                                : ivmMiantenanceTableViewModel
                                                                    .iVMMaintenancePlanGetTabularData
                                                                    .data!
                                                                    .getAllTableData![
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
                                                            (ivmMiantenanceTableViewModel
                                                                            .iVMMaintenancePlanGetTabularData
                                                                            .data!
                                                                            .getAllTableData![
                                                                                index]
                                                                            .tokenNo ==
                                                                        null ||
                                                                    ivmMiantenanceTableViewModel
                                                                            .iVMMaintenancePlanGetTabularData
                                                                            .data!
                                                                            .getAllTableData![
                                                                                index]
                                                                            .tokenNo
                                                                            .toString() ==
                                                                        'null')
                                                                ? ''
                                                                : ivmMiantenanceTableViewModel
                                                                    .iVMMaintenancePlanGetTabularData
                                                                    .data!
                                                                    .getAllTableData![
                                                                        index]
                                                                    .tokenNo
                                                                    .toString(),
                                                            textAlign:
                                                                TextAlign.left,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 12,
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
                                                            "STATUS:",
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
                                                            (ivmMiantenanceTableViewModel
                                                                            .iVMMaintenancePlanGetTabularData
                                                                            .data!
                                                                            .getAllTableData![
                                                                                index]
                                                                            .status ==
                                                                        null ||
                                                                    ivmMiantenanceTableViewModel
                                                                            .iVMMaintenancePlanGetTabularData
                                                                            .data!
                                                                            .getAllTableData![
                                                                                index]
                                                                            .status
                                                                            .toString() ==
                                                                        'null')
                                                                ? ''
                                                                : ivmMiantenanceTableViewModel
                                                                    .iVMMaintenancePlanGetTabularData
                                                                    .data!
                                                                    .getAllTableData![
                                                                        index]
                                                                    .status
                                                                    .toString(),
                                                            textAlign:
                                                                TextAlign.left,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 12,
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
                                                            (ivmMiantenanceTableViewModel
                                                                            .iVMMaintenancePlanGetTabularData
                                                                            .data!
                                                                            .getAllTableData![
                                                                                index]
                                                                            .substation ==
                                                                        null ||
                                                                    ivmMiantenanceTableViewModel
                                                                            .iVMMaintenancePlanGetTabularData
                                                                            .data!
                                                                            .getAllTableData![
                                                                                index]
                                                                            .substation
                                                                            .toString() ==
                                                                        'null')
                                                                ? ''
                                                                : ivmMiantenanceTableViewModel
                                                                    .iVMMaintenancePlanGetTabularData
                                                                    .data!
                                                                    .getAllTableData![
                                                                        index]
                                                                    .substation
                                                                    .toString(),
                                                            textAlign:
                                                                TextAlign.left,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 12,
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
                                                            (ivmMiantenanceTableViewModel
                                                                            .iVMMaintenancePlanGetTabularData
                                                                            .data!
                                                                            .getAllTableData![
                                                                                index]
                                                                            .fdrName ==
                                                                        null ||
                                                                    ivmMiantenanceTableViewModel
                                                                            .iVMMaintenancePlanGetTabularData
                                                                            .data!
                                                                            .getAllTableData![
                                                                                index]
                                                                            .fdrName
                                                                            .toString() ==
                                                                        'null')
                                                                ? ''
                                                                : ivmMiantenanceTableViewModel
                                                                    .iVMMaintenancePlanGetTabularData
                                                                    .data!
                                                                    .getAllTableData![
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
                                                            (ivmMiantenanceTableViewModel
                                                                            .iVMMaintenancePlanGetTabularData
                                                                            .data!
                                                                            .getAllTableData![
                                                                                index]
                                                                            .type ==
                                                                        null ||
                                                                    ivmMiantenanceTableViewModel
                                                                            .iVMMaintenancePlanGetTabularData
                                                                            .data!
                                                                            .getAllTableData![
                                                                                index]
                                                                            .type
                                                                            .toString() ==
                                                                        'null')
                                                                ? ''
                                                                : ivmMiantenanceTableViewModel
                                                                    .iVMMaintenancePlanGetTabularData
                                                                    .data!
                                                                    .getAllTableData![
                                                                        index]
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
                                                            (ivmMiantenanceTableViewModel
                                                                            .iVMMaintenancePlanGetTabularData
                                                                            .data!
                                                                            .getAllTableData![
                                                                                index]
                                                                            .contractor ==
                                                                        null ||
                                                                    ivmMiantenanceTableViewModel
                                                                            .iVMMaintenancePlanGetTabularData
                                                                            .data!
                                                                            .getAllTableData![
                                                                                index]
                                                                            .contractor
                                                                            .toString() ==
                                                                        'null')
                                                                ? ''
                                                                : ivmMiantenanceTableViewModel
                                                                    .iVMMaintenancePlanGetTabularData
                                                                    .data!
                                                                    .getAllTableData![
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
                                                            (ivmMiantenanceTableViewModel
                                                                            .iVMMaintenancePlanGetTabularData
                                                                            .data!
                                                                            .getAllTableData![
                                                                                index]
                                                                            .totalMiles ==
                                                                        null ||
                                                                    ivmMiantenanceTableViewModel
                                                                            .iVMMaintenancePlanGetTabularData
                                                                            .data!
                                                                            .getAllTableData![
                                                                                index]
                                                                            .totalMiles
                                                                            .toString() ==
                                                                        'null')
                                                                ? ''
                                                                : ivmMiantenanceTableViewModel
                                                                    .iVMMaintenancePlanGetTabularData
                                                                    .data!
                                                                    .getAllTableData![
                                                                        index]
                                                                    .totalMiles
                                                                    .toString(),
                                                            textAlign:
                                                                TextAlign.left,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 12,
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
                                                            (ivmMiantenanceTableViewModel
                                                                            .iVMMaintenancePlanGetTabularData
                                                                            .data!
                                                                            .getAllTableData![
                                                                                index]
                                                                            .contractYear ==
                                                                        null ||
                                                                    ivmMiantenanceTableViewModel
                                                                            .iVMMaintenancePlanGetTabularData
                                                                            .data!
                                                                            .getAllTableData![
                                                                                index]
                                                                            .contractYear
                                                                            .toString() ==
                                                                        'null')
                                                                ? ''
                                                                : contractYear
                                                                    .toString(),
                                                            textAlign:
                                                                TextAlign.left,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 12,
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
                                                            (ivmMiantenanceTableViewModel
                                                                            .iVMMaintenancePlanGetTabularData
                                                                            .data!
                                                                            .getAllTableData![
                                                                                index]
                                                                            .cycle ==
                                                                        null ||
                                                                    ivmMiantenanceTableViewModel
                                                                            .iVMMaintenancePlanGetTabularData
                                                                            .data!
                                                                            .getAllTableData![
                                                                                index]
                                                                            .cycle
                                                                            .toString() ==
                                                                        'null')
                                                                ? ''
                                                                : ivmMiantenanceTableViewModel
                                                                    .iVMMaintenancePlanGetTabularData
                                                                    .data!
                                                                    .getAllTableData![
                                                                        index]
                                                                    .cycle
                                                                    .toString(),
                                                            textAlign:
                                                                TextAlign.left,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 12,
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
                                                            (ivmMiantenanceTableViewModel
                                                                            .iVMMaintenancePlanGetTabularData
                                                                            .data!
                                                                            .getAllTableData![
                                                                                index]
                                                                            .contractorCompany ==
                                                                        null ||
                                                                    ivmMiantenanceTableViewModel
                                                                            .iVMMaintenancePlanGetTabularData
                                                                            .data!
                                                                            .getAllTableData![
                                                                                index]
                                                                            .contractorCompany
                                                                            .toString() ==
                                                                        'null')
                                                                ? ''
                                                                : ivmMiantenanceTableViewModel
                                                                    .iVMMaintenancePlanGetTabularData
                                                                    .data!
                                                                    .getAllTableData![
                                                                        index]
                                                                    .contractorCompany
                                                                    .toString(),
                                                            textAlign:
                                                                TextAlign.left,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 12,
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
                                                            "NEXT MAINT DUE: ",
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
                                                            (ivmMiantenanceTableViewModel
                                                                            .iVMMaintenancePlanGetTabularData
                                                                            .data!
                                                                            .getAllTableData![
                                                                                index]
                                                                            .nextMaintDue ==
                                                                        null ||
                                                                    ivmMiantenanceTableViewModel
                                                                            .iVMMaintenancePlanGetTabularData
                                                                            .data!
                                                                            .getAllTableData![
                                                                                index]
                                                                            .nextMaintDue
                                                                            .toString() ==
                                                                        'null')
                                                                ? ''
                                                                : nextMaintYear
                                                                    .toString(),
                                                            textAlign:
                                                                TextAlign.left,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 12,
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
                                                            (ivmMiantenanceTableViewModel
                                                                            .iVMMaintenancePlanGetTabularData
                                                                            .data!
                                                                            .getAllTableData![
                                                                                index]
                                                                            .createDate ==
                                                                        null ||
                                                                    ivmMiantenanceTableViewModel
                                                                            .iVMMaintenancePlanGetTabularData
                                                                            .data!
                                                                            .getAllTableData![index]
                                                                            .createDate
                                                                            .toString() ==
                                                                        'null')
                                                                ? ''
                                                                : formattedDate,
                                                            textAlign:
                                                                TextAlign.left,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 12,
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
                                              padding:
                                                  EdgeInsets.only(left: 8.0),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    // alignment: Alignment.topLeft,
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
                                                                //  Navigator.push(
                                                                //                               context,
                                                                //                               MaterialPageRoute(
                                                                //                                 builder: (context) =>
                                                                //                                     MapViewPage(
                                                                //                                   url: MapUrl
                                                                //                                               .getCrewWithWorkOrderNoEndPoint(
                                                                //                                                   selectedChangeOrderNo,id),
                                                                //                                 ),
                                                                //                               ),
                                                                //                             );
                                                                await browser
                                                                    .open(
                                                                        url: WebUri(MapUrl.getCrewWithWorkOrderNoEndPoint(
                                                                            ivmMiantenanceTableViewModel.iVMMaintenancePlanGetTabularData.data!.getAllTableData![index].tokenNo
                                                                                .toString(),
                                                                            id)),
                                                                        // "https://mapapi.ariespro.com/main/crew/CIVM_Map/$selectedChangeOrderNo/USRQWXH589Z"),
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
                                                    // alignment: Alignment.topLeft,
                                                    child: Column(
                                                      children: [],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    // alignment: Alignment.topLeft,
                                                    child: Column(
                                                      children: [],
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
                  return const Text('data');
              }
            })));
  }

  Future<void> _filterData(String query) async {
    if (query.isEmpty) {
      final userPreferences = Provider.of<UserPref>(context, listen: false);
      UserModel data = await userPreferences.getUser();

      id = data.user!.id.toString();

      ivmMiantenanceTableViewModel.fetchIVMMaintenancePlanTabularListApi(
          context, id);
    } else {
      ivmMiantenanceTableViewModel.iVMMaintenancePlanGetTabularData.data!.getAllTableData = ivmMiantenanceTableViewModel
          .iVMMaintenancePlanGetTabularData.data!.getAllTableData!
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
              item.totalMiles
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
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

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(item,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 20,
          )));

  Future openDialogPicture(String tokenNo) => showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            // lCPWorkOrdersClosedViewModel.fetchImageApi(
            //     context,
            //     //  '1');
            //     tokenNo.toString());
            int length =
                ivmMiantenanceTableViewModel.imageData.data?.images?.length ??
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
    String? fileLocation =
        ivmMiantenanceTableViewModel.imageData.data?.images![i].imageLocation;
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
        'http://civmapi.ariespro.com/civmapi/changeOrderLcpCreateOrder/deleteFile?fileName=$fileName&tokenNo=$tokenNo';
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
        final userPreferences =
            Provider.of<UserPref>(context, listen: false);
        UserModel data = await userPreferences.getUser();

        id = data.user!.id.toString();

        ivmMiantenanceTableViewModel.fetchIVMMaintenancePlanTabularListApi(
            context, id);
      } else {
        print('API request failed with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> getData() async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();

    id = data.user!.id.toString();

    ivmMiantenanceTableViewModel.fetchIVMMaintenancePlanTabularListApi(
        context, id);
  }
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
  final browser = MyChromeSafariBrowser();
  @override
  void initState() {
    setUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userPreferences = Provider.of<UserPref>(context);
    var provider = Provider.of<LocationProviderPemc>(context, listen: true);
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
                  ClipOval(
                      child: _imagePath != null
                          ? Image.network(
                              _imagePath!,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/person_icon.jpg',
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            )),
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
                    title: const Text('Crew Dashboard'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const CrewBottomNavigationPannel()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.running_with_errors,
                    ),
                    title: const Text('IVM Maintenance Job List'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.table_view,
                    ),
                    title: const Text('View Change Order'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => ChangeOrderCrew(
                              // budgetType: "",
                              // heading: "Change order",
                              // maintenanceType: "",
                              )));
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.location_on,
                    ),
                    title: const Text('LCP System Map'),
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
      'https://pemccivm.ariespro.com/assets/clientuploads/${data.user!.profilePhoto}',
    );
    String imageUrl =
        'https://pemccivm.ariespro.com/assets/clientuploads/${data.user!.profilePhoto}';
    _imagePath = imageUrl;
    setState(() {
      String fName =
          (data.user!.fName == 'null') ? '' : data.user!.fName.toString();
      String lName =
          (data.user!.lName == 'null') ? '' : data.user!.lName.toString();
      // userName = '${data.user!.fName} ${(data.user!.lName) != null? data.user!.lName :''}';
      userName = '$fName $lName';
    });
  }
}
