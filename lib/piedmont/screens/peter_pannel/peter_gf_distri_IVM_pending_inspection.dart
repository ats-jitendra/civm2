import 'dart:convert';
import 'package:CIVM/piedmont/resources/app_colors.dart';
import 'package:CIVM/piedmont/repository/map_url.dart';
import 'package:CIVM/piedmont/screens/leaflat_map/leaf_lat_map_wakeLock.dart';
import 'package:CIVM/piedmont/screens/login_page.dart';
import 'package:CIVM/piedmont/screens/map/provider/location_provider.dart';
import 'package:CIVM/piedmont/screens/peter_pannel/peter_contractor_bottom_navigation.dart';
import 'package:CIVM/piedmont/screens/peter_pannel/peter_gf_distri_IVM_TO_pending.dart';
import 'package:CIVM/piedmont/screens/peter_pannel/peter_gf_distri_IVM_TO_rejected.dart';
import 'package:CIVM/piedmont/screens/video_folder/fullVideo/full_screen_video_player.dart';
import 'package:CIVM/piedmont/utils/common_functions.dart';
import 'package:CIVM/sharedPrefs/constants.dart';
import 'package:camera/camera.dart';
import 'package:CIVM/piedmont/data/response/status.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/pdf_view.dart';
import 'package:CIVM/piedmont/screens/my_chrome_safari_map_recording.dart';
import 'package:CIVM/piedmont/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/piedmont/view_model/maintenance_report_view_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';
import 'dart:io';
// import 'package:device_info_plus/device_info_plus.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;

class PeterMaintenanceReportViewDistriIVMNew extends StatefulWidget {
  const PeterMaintenanceReportViewDistriIVMNew({super.key});

  @override
  State<PeterMaintenanceReportViewDistriIVMNew> createState() =>
      _PeterMaintenanceReportViewDistriIVMNewState();
}

class _PeterMaintenanceReportViewDistriIVMNewState extends State<PeterMaintenanceReportViewDistriIVMNew> {
  // final List<Widget> _children = [
  //   RowMaintenancePlan(),
  //   // BottomNavigationHomePage(),
  //   // BottomNavigationAccountPage()
  // ];

  final TextEditingController _input = TextEditingController();

  List<String> menu = [];
  var _setState;

  onTappedBar(int index) {
    setState(() {
      // _currentIndex = index;
    });
  }

  MaintenanceReportViewViewModel maintenanceReportViewViewModel =
      MaintenanceReportViewViewModel();

  // ignore: prefer_typing_uninitialized_variables
  var selectedSubstation;
  late int subId;
  // ignore: prefer_typing_uninitialized_variables
  var selectedFeeder;
  late int feederId;
  // ignore: prefer_typing_uninitialized_variables
  var selectedType;

  final browser = MyChromeSafariBrowser();

  bool _isVisibleImage = false;
  // bool _isVisibleImage2 = false;
  // bool _isVisibleImage3 = false;

  // ignore: prefer_typing_uninitialized_variables
  var deleteImage1;
  // ignore: prefer_typing_uninitialized_variables
  var deleteImage2;
  // ignore: prefer_typing_uninitialized_variables
  var deleteImage3;

  String id = '';

  late List<CameraDescription> _cameras;
  late CameraController _camerasController;
  String imagePath = '';
  String imagePath2 = '';
  String imagePath3 = '';
  var image1;
  var image2;
  var image3;

  //   File? image1;
  // File? image2;
  // File? image3;
  // String _imagePath = '';
  // String _imagePath2 = '';
  // String _imagePath3 = '';

  List<String> imagePaths = [];
  List<XFile> images = [];

  String formattedNextRowMaintenanceDue = '';
  String newFormatedOrderDate = '';

  bool _isVisibleUploadingButton = false;
  bool _isVisibleUploadButton = true;
  String? rights;
  @override
  void initState() {
    getInitData();
    cameraInit();
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
            'Pending Inspection',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: AppColors.baseColor,
        ),
        //  drawer: DrawerManu(menu: menu),
        body: ChangeNotifierProvider<MaintenanceReportViewViewModel>(
            create: (BuildContext context) => maintenanceReportViewViewModel,
            child: Consumer<MaintenanceReportViewViewModel>(
                builder: (context, value, _) {
              switch (value.maintenanceReportViewGetTabularData.status) {
                case Status.LOADING:
                  return const Center(child: CircularProgressIndicator());
                case Status.ERROR:
                  return
                      // CustomToastSnackBarProgressDialog.flushBarErrorMessage(
                      //     value.maintenanceReportViewGetTabularData.message
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
                case Status.COMPLETED:
                  return RefreshIndicator(
                    onRefresh: () async {
                      _input.clear();
                      selectedSubstation = null;
                      selectedFeeder = null;
                      selectedType = null;
                      await getInitData();
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
                          // SingleChildScrollView(
                          //   scrollDirection: Axis.horizontal,
                          //   child: Row(
                          //     children: [
                          //       Container(
                          //         margin: const EdgeInsets.only(top: 10),
                          //         child: Column(
                          //           children: [
                          //             const Align(
                          //                 alignment: Alignment.centerLeft,
                          //                 child: Padding(
                          //                   padding: EdgeInsets.all(2.0),
                          //                   child: Text(
                          //                     "Substation",
                          //                     style: TextStyle(
                          //                         fontSize: 16.0,
                          //                         color: AppColors.baseColor,
                          //                         fontWeight: FontWeight.bold),
                          //                   ),
                          //                 )),
                          //             Align(
                          //               alignment: Alignment.centerLeft,
                          //               child: Padding(
                          //                 padding: const EdgeInsets.all(2.0),
                          //                 child: SizedBox(
                          //                   width: 200,
                          //                   child:
                          //                       DropdownButtonFormField<String>(
                          //                     hint: const Text('-Select-'),
                          //                     dropdownColor: Colors.white,
                          //                     value: selectedSubstation,
                          //                     style: const TextStyle(
                          //                         color: AppColors.baseColor,
                          //                         fontSize: 16),
                          //                     icon: const Icon(
                          //                       Icons.arrow_drop_down,
                          //                       color: AppColors.baseColor,
                          //                       size: 40,
                          //                     ),
                          //                     decoration: const InputDecoration(
                          //                       enabledBorder:
                          //                           OutlineInputBorder(
                          //                         borderSide: BorderSide(
                          //                           color: AppColors.baseColor,
                          //                         ),
                          //                       ),
                          //                       focusedBorder:
                          //                           OutlineInputBorder(
                          //                         borderSide: BorderSide(
                          //                           color: AppColors.baseColor,
                          //                         ),
                          //                       ),
                          //                     ),
                          //                     isExpanded: true,
                          //                     items: maintenanceReportViewViewModel
                          //                         .maintenanceReportViewGetTabularData
                          //                         .data!
                          //                         .findSubstationAndSubIds!
                          //                         .map((e) {
                          //                       return DropdownMenuItem(
                          //                         value: e.subId.toString(),
                          //                         // e.getIdAndSubstationByCountId![0].subStation.toString(),
                          //                         child: Text(
                          //                             e.subStation.toString()),
                          //                       );
                          //                     }).toList(),
                          //                     onChanged: (val) {
                          //                       if (selectedFeeder != null ||
                          //                           selectedType != null) {
                          //                         selectedFeeder = null;
                          //                       }
                          //                       fetchData('', val!, '');
                          //                       subId = int.parse(val);
                          //                       setState(() {
                          //                         selectedSubstation = val;
                          //                       });
                          //                     },
                          //                     validator: (value) =>
                          //                         value == null
                          //                             ? 'field required'
                          //                             : null,
                          //                   ),
                          //                 ),
                          //               ),
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //       Container(
                          //         margin: const EdgeInsets.only(top: 10),
                          //         child: Column(
                          //           children: [
                          //             const Align(
                          //                 alignment: Alignment.centerLeft,
                          //                 child: Padding(
                          //                   padding: EdgeInsets.all(2.0),
                          //                   child: Text(
                          //                     "Feeder",
                          //                     style: TextStyle(
                          //                         fontSize: 16.0,
                          //                         color: AppColors.baseColor,
                          //                         fontWeight: FontWeight.bold),
                          //                   ),
                          //                 )),
                          //             Align(
                          //               alignment: Alignment.centerLeft,
                          //               child: Padding(
                          //                 padding: const EdgeInsets.all(2.0),
                          //                 child: SizedBox(
                          //                   width: 200,
                          //                   child:
                          //                       DropdownButtonFormField<String>(
                          //                     hint: const Text('-Select-'),
                          //                     dropdownColor: Colors.white,
                          //                     value: selectedFeeder,
                          //                     style: const TextStyle(
                          //                         color: AppColors.baseColor,
                          //                         fontSize: 16),
                          //                     icon: const Icon(
                          //                       Icons.arrow_drop_down,
                          //                       color: AppColors.baseColor,
                          //                       size: 40,
                          //                     ),
                          //                     decoration: const InputDecoration(
                          //                       enabledBorder:
                          //                           OutlineInputBorder(
                          //                         borderSide: BorderSide(
                          //                           color: AppColors.baseColor,
                          //                         ),
                          //                       ),
                          //                       focusedBorder:
                          //                           OutlineInputBorder(
                          //                         borderSide: BorderSide(
                          //                           color: AppColors.baseColor,
                          //                         ),
                          //                       ),
                          //                     ),
                          //                     isExpanded: true,
                          //                     items: maintenanceReportViewViewModel
                          //                         .maintenanceReportViewGetTabularData
                          //                         .data!
                          //                         .findAllFdrBySubstation!
                          //                         .map((e) {
                          //                       return DropdownMenuItem(
                          //                         value: e.feedrId.toString(),
                          //                         // e.getIdAndSubstationByCountId![0].subStation.toString(),
                          //                         child: Text(
                          //                             e.feederName.toString()),
                          //                       );
                          //                     }).toList(),
                          //                     onChanged: (val) {
                          //                       if (selectedType != null) {
                          //                         selectedType = null;
                          //                       }
                          //                       fetchData('',
                          //                           selectedSubstation, val!);
                          //                       feederId = int.parse(val);
                          //                       setState(() {
                          //                         selectedFeeder = val;
                          //                       });
                          //                     },
                          //                     validator: (value) =>
                          //                         value == null
                          //                             ? 'field required'
                          //                             : null,
                          //                   ),
                          //                 ),
                          //               ),
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //       Container(
                          //         margin: const EdgeInsets.only(top: 10),
                          //         child: Column(
                          //           children: [
                          //             const Align(
                          //                 alignment: Alignment.centerLeft,
                          //                 child: Padding(
                          //                   padding: EdgeInsets.all(2.0),
                          //                   child: Text(
                          //                     "Type",
                          //                     style: TextStyle(
                          //                         fontSize: 16.0,
                          //                         color: AppColors.baseColor,
                          //                         fontWeight: FontWeight.bold),
                          //                   ),
                          //                 )),
                          //             Align(
                          //               alignment: Alignment.centerLeft,
                          //               child: Padding(
                          //                 padding: const EdgeInsets.all(2.0),
                          //                 child: SizedBox(
                          //                   width: 400,
                          //                   child:
                          //                       DropdownButtonFormField<String>(
                          //                     hint: const Text('-Select-'),
                          //                     dropdownColor: Colors.white,
                          //                     value: selectedType,
                          //                     style: const TextStyle(
                          //                         color: AppColors.baseColor,
                          //                         fontSize: 16),
                          //                     icon: const Icon(
                          //                       Icons.arrow_drop_down,
                          //                       color: AppColors.baseColor,
                          //                       size: 40,
                          //                     ),
                          //                     decoration: const InputDecoration(
                          //                       enabledBorder:
                          //                           OutlineInputBorder(
                          //                         borderSide: BorderSide(
                          //                           color: AppColors.baseColor,
                          //                         ),
                          //                       ),
                          //                       focusedBorder:
                          //                           OutlineInputBorder(
                          //                         borderSide: BorderSide(
                          //                           color: AppColors.baseColor,
                          //                         ),
                          //                       ),
                          //                     ),
                          //                     isExpanded: true,
                          //                     items: maintenanceReportViewViewModel
                          //                         .maintenanceReportViewGetTabularData
                          //                         .data!
                          //                         .findAllTypeBySubstations!
                          //                         .map((e) {
                          //                       return DropdownMenuItem(
                          //                         value: e.type.toString(),
                          //                         // e.getIdAndSubstationByCountId![0].subStation.toString(),
                          //                         child:
                          //                             Text(e.type.toString()),
                          //                       );
                          //                     }).toList(),
                          //                     onChanged: (val) {
                          //                       fetchData(
                          //                           val!,
                          //                           selectedSubstation,
                          //                           selectedFeeder);
                          //                       // workOrderNoId = int.parse(val);
                          //                       setState(() {
                          //                         selectedType = val;
                          //                       });
                          //                     },
                          //                     validator: (value) =>
                          //                         value == null
                          //                             ? 'field required'
                          //                             : null,
                          //                   ),
                          //                 ),
                          //               ),
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 2.0, right: 2.0, top: 8),
                              child: TextFormField(
                                onChanged: (value) => _filterData(value),
                                //  key: formkey2,
                                controller: _input,
                                style: const TextStyle(
                                    color: AppColors.baseColor, fontSize: 16),
                                obscureText: false,
                                //keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      // borderRadius:
                                      //     BorderRadius.circular(25),
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.baseColor,
                                    ),
                                  ),
                                  hintText: 'Search your input...',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please search your input";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                                itemCount: maintenanceReportViewViewModel
                                    .maintenanceReportViewGetTabularData
                                    .data!
                                    .findAllJoinDatas!
                                    .length,
                                // itemCount: historyList.length,
                                itemBuilder: (BuildContext ctxt, int index) {
                                  print(
                                      "Length ${maintenanceReportViewViewModel.maintenanceReportViewGetTabularData.data!.findAllJoinDatas!.length}");
                                  dateFormat(index);
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
                                            //                       FontWeight
                                            //                           .bold,
                                            //                   color:
                                            //                       Colors.white,
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
                                            //                   color:
                                            //                       Colors.white,
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
                                            //                       FontWeight
                                            //                           .bold,
                                            //                   color:
                                            //                       Colors.white,
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
                                            //                               maintenanceReportViewViewModel
                                            //                                   .maintenanceReportViewGetTabularData
                                            //                                   .data!
                                            //                                   .findAllJoinDatas![
                                            //                                       index]
                                            //                                   .tblSubMilesCostId
                                            //                                   .toString(),
                                            //                               maintenanceReportViewViewModel
                                            //                                   .maintenanceReportViewGetTabularData
                                            //                                   .data!
                                            //                                   .findAllJoinDatas![
                                            //                                       index]
                                            //                                   .id
                                            //                                   .toString(),
                                            //                               maintenanceReportViewViewModel
                                            //                                   .maintenanceReportViewGetTabularData
                                            //                                   .data!
                                            //                                   .findAllJoinDatas![index]
                                            //                                   .budgetType
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
                                            //                                   Color.fromARGB(255, 0, 79, 215),
                                            //                                   Colors.blue,
                                            //                                   Color.fromARGB(255, 0, 79, 215),
                                            //                                 ],
                                            //                               )),
                                            //                           child:
                                            //                               const Text(
                                            //                             "Approve",
                                            //                             style:
                                            //                                 TextStyle(
                                            //                               color:
                                            //                                   Colors.white,
                                            //                               fontWeight:
                                            //                                   FontWeight.bold,
                                            //                               fontSize:
                                            //                                   10,
                                            //                             ),
                                            //                           ),
                                            //                         ),
                                            //                       ),
                                            //                       Padding(
                                            //                         padding: const EdgeInsets
                                            //                             .only(
                                            //                             left:
                                            //                                 8.0,
                                            //                             right:
                                            //                                 8),
                                            //                         child:
                                            //                             InkWell(
                                            //                           onTap:
                                            //                               () async {
                                            //                             await maintenanceReportViewViewModel
                                            //                                 .fetchMaintenanceReportViewUpdateListApi(
                                            //                               context,
                                            //                               'REJECTED',
                                            //                               maintenanceReportViewViewModel
                                            //                                   .maintenanceReportViewGetTabularData
                                            //                                   .data!
                                            //                                   .findAllJoinDatas![index]
                                            //                                   .tblSubMilesCostId
                                            //                                   .toString(),
                                            //                               maintenanceReportViewViewModel
                                            //                                   .maintenanceReportViewGetTabularData
                                            //                                   .data!
                                            //                                   .findAllJoinDatas![index]
                                            //                                   .id
                                            //                                   .toString(),
                                            //                               maintenanceReportViewViewModel
                                            //                                   .maintenanceReportViewGetTabularData
                                            //                                   .data!
                                            //                                   .findAllJoinDatas![index]
                                            //                                   .budgetType
                                            //                                   .toString(),
                                            //                             );
                                            //                             await Future.delayed(const Duration(
                                            //                                 seconds:
                                            //                                     2));
                                            //                             // maintenanceReportViewViewModel
                                            //                             //     .fetchMaintenanceReportViewTabularListApi(
                                            //                             //         context,
                                            //                             //         '',
                                            //                             //         '',
                                            //                             //         '',
                                            //                             //         id);
                                            //                             maintenanceReportViewViewModel.fetchMaintenanceReportViewTabularListApi(
                                            //                                 context,
                                            //                                 '',
                                            //                                 '',
                                            //                                 '',
                                            //                                 '');
                                            //                           },
                                            //                           child:
                                            //                               Container(
                                            //                             // margin: const EdgeInsets.only(
                                            //                             //     left: 40, right: 40, bottom: 10.0),
                                            //                             padding: const EdgeInsets
                                            //                                 .all(
                                            //                                 8),
                                            //                             alignment:
                                            //                                 Alignment.center,
                                            //                             width:
                                            //                                 80,
                                            //                             // MediaQuery.of(context).size.width,
                                            //                             // height: MediaQuery.of(context).size.height * 0.4,
                                            //                             decoration: const BoxDecoration(
                                            //                                 // shape: BoxShape.circle,
                                            //                                 boxShadow: [
                                            //                                   BoxShadow(color: Color.fromARGB(255, 104, 8, 1), blurRadius: 5, offset: Offset(2.0, 5.0))
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
                                                            "IMAGE:",
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
                                                            await maintenanceReportViewViewModel
                                                                .fetchImageApi(
                                                              context,
                                                              maintenanceReportViewViewModel
                                                                  .maintenanceReportViewGetTabularData
                                                                  .data!
                                                                  .findAllJoinDatas![
                                                                      index]
                                                                  .tokenNo
                                                                  .toString(),
                                                            );
                                                            await Future.delayed(
                                                                const Duration(
                                                                    seconds:
                                                                        2));
                                                            openDialogPicture(
                                                                maintenanceReportViewViewModel
                                                                    .maintenanceReportViewGetTabularData
                                                                    .data!
                                                                    .findAllJoinDatas![
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
                                                            (maintenanceReportViewViewModel
                                                                            .maintenanceReportViewGetTabularData
                                                                            .data!
                                                                            .findAllJoinDatas![
                                                                                index]
                                                                            .tokenNo ==
                                                                        null ||
                                                                    maintenanceReportViewViewModel
                                                                            .maintenanceReportViewGetTabularData
                                                                            .data!
                                                                            .findAllJoinDatas![
                                                                                index]
                                                                            .tokenNo
                                                                            .toString() ==
                                                                        'null')
                                                                ? ''
                                                                : maintenanceReportViewViewModel
                                                                    .maintenanceReportViewGetTabularData
                                                                    .data!
                                                                    .findAllJoinDatas![
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
                                                            (maintenanceReportViewViewModel
                                                                            .maintenanceReportViewGetTabularData
                                                                            .data!
                                                                            .findAllJoinDatas![
                                                                                index]
                                                                            .status ==
                                                                        null ||
                                                                    maintenanceReportViewViewModel
                                                                            .maintenanceReportViewGetTabularData
                                                                            .data!
                                                                            .findAllJoinDatas![
                                                                                index]
                                                                            .status
                                                                            .toString() ==
                                                                        'null')
                                                                ? ''
                                                                : maintenanceReportViewViewModel
                                                                    .maintenanceReportViewGetTabularData
                                                                    .data!
                                                                    .findAllJoinDatas![
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
                                                            (maintenanceReportViewViewModel
                                                                            .maintenanceReportViewGetTabularData
                                                                            .data!
                                                                            .findAllJoinDatas![
                                                                                index]
                                                                            .subStateName ==
                                                                        null ||
                                                                    maintenanceReportViewViewModel
                                                                            .maintenanceReportViewGetTabularData
                                                                            .data!
                                                                            .findAllJoinDatas![
                                                                                index]
                                                                            .subStateName
                                                                            .toString() ==
                                                                        'null')
                                                                ? ''
                                                                : maintenanceReportViewViewModel
                                                                    .maintenanceReportViewGetTabularData
                                                                    .data!
                                                                    .findAllJoinDatas![
                                                                        index]
                                                                    .subStateName
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
                                                            (maintenanceReportViewViewModel
                                                                            .maintenanceReportViewGetTabularData
                                                                            .data!
                                                                            .findAllJoinDatas![
                                                                                index]
                                                                            .feederName ==
                                                                        null ||
                                                                    maintenanceReportViewViewModel
                                                                            .maintenanceReportViewGetTabularData
                                                                            .data!
                                                                            .findAllJoinDatas![
                                                                                index]
                                                                            .feederName
                                                                            .toString() ==
                                                                        'null')
                                                                ? ''
                                                                : maintenanceReportViewViewModel
                                                                    .maintenanceReportViewGetTabularData
                                                                    .data!
                                                                    .findAllJoinDatas![
                                                                        index]
                                                                    .feederName
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
                                                            (maintenanceReportViewViewModel
                                                                            .maintenanceReportViewGetTabularData
                                                                            .data!
                                                                            .findAllJoinDatas![
                                                                                index]
                                                                            .maintType ==
                                                                        null ||
                                                                    maintenanceReportViewViewModel
                                                                            .maintenanceReportViewGetTabularData
                                                                            .data!
                                                                            .findAllJoinDatas![
                                                                                index]
                                                                            .maintType
                                                                            .toString() ==
                                                                        'null')
                                                                ? ''
                                                                : maintenanceReportViewViewModel
                                                                    .maintenanceReportViewGetTabularData
                                                                    .data!
                                                                    .findAllJoinDatas![
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
                                                            (maintenanceReportViewViewModel
                                                                            .maintenanceReportViewGetTabularData
                                                                            .data!
                                                                            .findAllJoinDatas![
                                                                                index]
                                                                            .type ==
                                                                        null ||
                                                                    maintenanceReportViewViewModel
                                                                            .maintenanceReportViewGetTabularData
                                                                            .data!
                                                                            .findAllJoinDatas![
                                                                                index]
                                                                            .type
                                                                            .toString() ==
                                                                        'null')
                                                                ? ''
                                                                : maintenanceReportViewViewModel
                                                                    .maintenanceReportViewGetTabularData
                                                                    .data!
                                                                    .findAllJoinDatas![
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
                                                            "ASSIGNED CONTRACTOR: ",
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
                                                            (maintenanceReportViewViewModel
                                                                            .maintenanceReportViewGetTabularData
                                                                            .data!
                                                                            .findAllJoinDatas![
                                                                                index]
                                                                            .name ==
                                                                        null ||
                                                                    maintenanceReportViewViewModel
                                                                            .maintenanceReportViewGetTabularData
                                                                            .data!
                                                                            .findAllJoinDatas![
                                                                                index]
                                                                            .name
                                                                            .toString() ==
                                                                        'null')
                                                                ? ''
                                                                : maintenanceReportViewViewModel
                                                                    .maintenanceReportViewGetTabularData
                                                                    .data!
                                                                    .findAllJoinDatas![
                                                                        index]
                                                                    .name
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
                                                  // Expanded(
                                                  //   // alignment: Alignment.topLeft,
                                                  //   child: Column(
                                                  //     children: [
                                                  //       const Align(
                                                  //         alignment:
                                                  //             Alignment.topLeft,
                                                  //         child: Text(
                                                  //           "COST PER MILE: ",
                                                  //           textAlign:
                                                  //               TextAlign.left,
                                                  //           style: TextStyle(
                                                  //             fontSize: 12,
                                                  //             fontWeight:
                                                  //                 FontWeight.bold,
                                                  //             color: Colors.white,
                                                  //           ),
                                                  //         ),
                                                  //       ),
                                                  //       Align(
                                                  //         alignment:
                                                  //             Alignment.topLeft,
                                                  //         child: Text(
                                                  //           (maintenanceReportViewViewModel
                                                  //                           .maintenanceReportViewGetTabularData
                                                  //                           .data!
                                                  //                           .findAllJoinDatas![
                                                  //                               index]
                                                  //                           .costPerMile ==
                                                  //                       null ||
                                                  //                   maintenanceReportViewViewModel
                                                  //                           .maintenanceReportViewGetTabularData
                                                  //                           .data!
                                                  //                           .findAllJoinDatas![
                                                  //                               index]
                                                  //                           .costPerMile
                                                  //                           .toString() ==
                                                  //                       'null')
                                                  //               ? ''
                                                  //               : maintenanceReportViewViewModel
                                                  //                   .maintenanceReportViewGetTabularData
                                                  //                   .data!
                                                  //                   .findAllJoinDatas![
                                                  //                       index]
                                                  //                   .costPerMile
                                                  //                   .toString(),
                                                  //           textAlign:
                                                  //               TextAlign.left,
                                                  //           style:
                                                  //               const TextStyle(
                                                  //             fontSize: 12,
                                                  //             //  fontWeight:
                                                  //             //      FontWeight.bold,
                                                  //             color: Colors.white,
                                                  //           ),
                                                  //         ),
                                                  //       ),
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
                                                            "ROW INSTALLATION YEAR: ",
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
                                                            (maintenanceReportViewViewModel
                                                                            .maintenanceReportViewGetTabularData
                                                                            .data!
                                                                            .findAllJoinDatas![
                                                                                index]
                                                                            .contractYear ==
                                                                        null ||
                                                                    maintenanceReportViewViewModel
                                                                            .maintenanceReportViewGetTabularData
                                                                            .data!
                                                                            .findAllJoinDatas![
                                                                                index]
                                                                            .contractYear
                                                                            .toString() ==
                                                                        'null')
                                                                ? ''
                                                                : maintenanceReportViewViewModel
                                                                    .maintenanceReportViewGetTabularData
                                                                    .data!
                                                                    .findAllJoinDatas![
                                                                        index]
                                                                    .contractYear
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
                                                            "CYCLE LENGTH: ",
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
                                                            (maintenanceReportViewViewModel
                                                                            .maintenanceReportViewGetTabularData
                                                                            .data!
                                                                            .findAllJoinDatas![
                                                                                index]
                                                                            .cycle ==
                                                                        null ||
                                                                    maintenanceReportViewViewModel
                                                                            .maintenanceReportViewGetTabularData
                                                                            .data!
                                                                            .findAllJoinDatas![
                                                                                index]
                                                                            .cycle
                                                                            .toString() ==
                                                                        'null')
                                                                ? ''
                                                                : maintenanceReportViewViewModel
                                                                    .maintenanceReportViewGetTabularData
                                                                    .data!
                                                                    .findAllJoinDatas![
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
                                                            (maintenanceReportViewViewModel
                                                                            .maintenanceReportViewGetTabularData
                                                                            .data!
                                                                            .findAllJoinDatas![
                                                                                index]
                                                                            .contractYear ==
                                                                        null ||
                                                                    maintenanceReportViewViewModel
                                                                            .maintenanceReportViewGetTabularData
                                                                            .data!
                                                                            .findAllJoinDatas![index]
                                                                            .contractYear
                                                                            .toString() ==
                                                                        'null')
                                                                ? ''
                                                                : formattedNextRowMaintenanceDue,
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
                                                            (maintenanceReportViewViewModel
                                                                            .maintenanceReportViewGetTabularData
                                                                            .data!
                                                                            .findAllJoinDatas![
                                                                                index]
                                                                            .totalMiles ==
                                                                        null ||
                                                                    maintenanceReportViewViewModel
                                                                            .maintenanceReportViewGetTabularData
                                                                            .data!
                                                                            .findAllJoinDatas![
                                                                                index]
                                                                            .totalMiles
                                                                            .toString() ==
                                                                        'null')
                                                                ? ''
                                                                : maintenanceReportViewViewModel
                                                                    .maintenanceReportViewGetTabularData
                                                                    .data!
                                                                    .findAllJoinDatas![
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
                                                            "MILES COMPLETED: ",
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
                                                            (maintenanceReportViewViewModel
                                                                            .maintenanceReportViewGetTabularData
                                                                            .data!
                                                                            .findAllJoinDatas![
                                                                                index]
                                                                            .milesCompleted ==
                                                                        null ||
                                                                    maintenanceReportViewViewModel
                                                                            .maintenanceReportViewGetTabularData
                                                                            .data!
                                                                            .findAllJoinDatas![
                                                                                index]
                                                                            .milesCompleted
                                                                            .toString() ==
                                                                        'null')
                                                                ? ''
                                                                : maintenanceReportViewViewModel
                                                                    .maintenanceReportViewGetTabularData
                                                                    .data!
                                                                    .findAllJoinDatas![
                                                                        index]
                                                                    .milesCompleted
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
                                                  // Expanded(
                                                  //   // alignment: Alignment.topLeft,
                                                  //   child: Column(
                                                  //     children: [
                                                  //       const Align(
                                                  //         alignment:
                                                  //             Alignment.topLeft,
                                                  //         child: Text(
                                                  //           " TOTAL COST: ",
                                                  //           textAlign:
                                                  //               TextAlign.left,
                                                  //           style: TextStyle(
                                                  //             fontSize: 12,
                                                  //             fontWeight:
                                                  //                 FontWeight.bold,
                                                  //             color: Colors.white,
                                                  //           ),
                                                  //         ),
                                                  //       ),
                                                  //       Align(
                                                  //         alignment:
                                                  //             Alignment.topLeft,
                                                  //         child: Text(
                                                  //           (maintenanceReportViewViewModel
                                                  //                           .maintenanceReportViewGetTabularData
                                                  //                           .data!
                                                  //                           .findAllJoinDatas![
                                                  //                               index]
                                                  //                           .totalCost ==
                                                  //                       null ||
                                                  //                   maintenanceReportViewViewModel
                                                  //                           .maintenanceReportViewGetTabularData
                                                  //                           .data!
                                                  //                           .findAllJoinDatas![
                                                  //                               index]
                                                  //                           .totalCost
                                                  //                           .toString() ==
                                                  //                       'null')
                                                  //               ? ''
                                                  //               : maintenanceReportViewViewModel
                                                  //                   .maintenanceReportViewGetTabularData
                                                  //                   .data!
                                                  //                   .findAllJoinDatas![
                                                  //                       index]
                                                  //                   .totalCost
                                                  //                   .toString(),
                                                  //           textAlign:
                                                  //               TextAlign.left,
                                                  //           style:
                                                  //               const TextStyle(
                                                  //             fontSize: 12,
                                                  //             color: Colors.white,
                                                  //           ),
                                                  //         ),
                                                  //       ),
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
                                                            "ORDER DATE: ",
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
                                                            (maintenanceReportViewViewModel
                                                                            .maintenanceReportViewGetTabularData
                                                                            .data!
                                                                            .findAllJoinDatas![
                                                                                index]
                                                                            .createDate ==
                                                                        null ||
                                                                    maintenanceReportViewViewModel
                                                                            .maintenanceReportViewGetTabularData
                                                                            .data!
                                                                            .findAllJoinDatas![index]
                                                                            .createDate
                                                                            .toString() ==
                                                                        'null')
                                                                ? ''
                                                                : newFormatedOrderDate,

                                                            //  maintenanceReportViewViewModel
                                                            //     .maintenanceReportViewGetTabularData
                                                            //     .data!
                                                            //     .findAllJoinDatas![
                                                            //         index]
                                                            //     .createDate
                                                            //     .toString(),
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
                                                    //  flex: 3,
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
                                                                            maintenanceReportViewViewModel.maintenanceReportViewGetTabularData.data!.findAllJoinDatas![index].tokenNo
                                                                                .toString(),
                                                                            id)),
                                                                        // "https://mapapi.ariespro.com/main/supervisor/CIVM_Map/${wOViewModel.woTabularData.data!.findAllTableData![index].tokenNo.toString()}/USRQWXH589Z"),
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
                                                            "NOTES: ",
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
                                                            (maintenanceReportViewViewModel
                                                                            .maintenanceReportViewGetTabularData
                                                                            .data!
                                                                            .findAllJoinDatas![
                                                                                index]
                                                                            .notes ==
                                                                        null ||
                                                                    maintenanceReportViewViewModel
                                                                            .maintenanceReportViewGetTabularData
                                                                            .data!
                                                                            .findAllJoinDatas![
                                                                                index]
                                                                            .notes
                                                                            .toString() ==
                                                                        'null')
                                                                ? ''
                                                                : maintenanceReportViewViewModel
                                                                    .maintenanceReportViewGetTabularData
                                                                    .data!
                                                                    .findAllJoinDatas![
                                                                        index]
                                                                    .notes
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

  fetchData(String type, substation, feeder) {
    // maintenanceReportViewViewModel.fetchMaintenanceReportViewTabularListApi(
    //     context, type, substation, feeder, id);
    maintenanceReportViewViewModel.fetchMaintenanceReportViewTabularListApi(
        context, type, substation, feeder, '','1,2');
  }

  Future<void> _filterData(String query) async {
    if (query.isEmpty) {
      selectedSubstation = null;
      selectedFeeder = null;
      selectedType = null;
      // maintenanceReportViewViewModel.fetchMaintenanceReportViewTabularListApi(
      //     context, '', '', '', id);
      maintenanceReportViewViewModel.fetchMaintenanceReportViewTabularListApi(
          context, '', '', '', '','1,2');
    } else {
      maintenanceReportViewViewModel
              .maintenanceReportViewGetTabularData.data?.findAllJoinDatas =
          maintenanceReportViewViewModel
              .maintenanceReportViewGetTabularData.data?.findAllJoinDatas
              ?.where((item) =>
                  item.tokenNo.toString().contains(query.toLowerCase()) ||
                  item.maintType
                      .toString()
                      .toLowerCase()
                      .contains(query.toLowerCase()) ||
                  item.status
                      .toString()
                      .toLowerCase()
                      .contains(query.toLowerCase()) ||
                  item.subStateName
                      .toString()
                      .toLowerCase()
                      .contains(query.toLowerCase()) ||
                  item.feederName
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
                  item.contractYear
                      .toString()
                      .toLowerCase()
                      .contains(query.toLowerCase()) ||
                  item.totalCost
                      .toString()
                      .toLowerCase()
                      .contains(query.toLowerCase()) ||
                  item.contractYear.toString().toLowerCase().contains(query.toLowerCase()) ||
                  item.cycle.toString().toLowerCase().contains(query.toLowerCase()) ||
                  item.totalCost.toString().toLowerCase().contains(query.toLowerCase()) ||
                  item.nextMaintDue.toString().toLowerCase().contains(query.toLowerCase()))
              .toList();
    }
    setState(() {});
  }

  Future openDailogAddCrewMember() => showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.all(2.0),
                              child: Text(
                                "Substation",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Color.fromARGB(255, 7, 59, 120)),
                              ),
                            )),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: DropdownButtonFormField<String>(
                              hint: const Text('-Select-'),
                              dropdownColor: Colors.white,
                              value: selectedSubstation,
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
                              items: maintenanceReportViewViewModel
                                  .maintenanceReportViewGetTabularData
                                  .data!
                                  .findSubstationAndSubIds!
                                  .map((e) {
                                return DropdownMenuItem(
                                  value: e.subId.toString(),
                                  // e.getIdAndSubstationByCountId![0].subStation.toString(),
                                  child: Text(e.subStation.toString()),
                                );
                              }).toList(),
                              onChanged: (val) {
                                if (selectedFeeder != null ||
                                    selectedType != null) {
                                  selectedFeeder = null;
                                }
                                fetchData('', val!, '');
                                subId = int.parse(val);
                                setState(() {
                                  selectedSubstation = val;
                                });
                                Navigator.pop(context);
                              },
                              validator: (value) =>
                                  value == null ? 'field required' : null,
                            ),
                          ),
                        ),
                      ],
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
                                "Feeder",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Color.fromARGB(255, 7, 59, 120)),
                              ),
                            )),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: DropdownButtonFormField<String>(
                              hint: const Text('-Select-'),
                              dropdownColor: Colors.white,
                              value: selectedFeeder,
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
                              items: maintenanceReportViewViewModel
                                  .maintenanceReportViewGetTabularData
                                  .data!
                                  .findAllFdrBySubstation!
                                  .map((e) {
                                return DropdownMenuItem(
                                  value: e.feedrId.toString(),
                                  // e.getIdAndSubstationByCountId![0].subStation.toString(),
                                  child: Text(e.feederName.toString()),
                                );
                              }).toList(),
                              onChanged: (val) {
                                if (selectedType != null) {
                                  selectedType = null;
                                }
                                fetchData('', selectedSubstation, val!);
                                feederId = int.parse(val);
                                setState(() {
                                  selectedFeeder = val;
                                });
                                Navigator.pop(context);
                              },
                              validator: (value) =>
                                  value == null ? 'field required' : null,
                            ),
                          ),
                        ),
                      ],
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
                                "Type",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Color.fromARGB(255, 7, 59, 120)),
                              ),
                            )),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: DropdownButtonFormField<String>(
                              hint: const Text('-Select-'),
                              dropdownColor: Colors.white,
                              value: selectedType,
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
                              items: maintenanceReportViewViewModel
                                  .maintenanceReportViewGetTabularData
                                  .data!
                                  .findAllTypeBySubstations!
                                  .map((e) {
                                return DropdownMenuItem(
                                  value: e.type.toString(),
                                  // e.getIdAndSubstationByCountId![0].subStation.toString(),
                                  child: Text(e.type.toString()),
                                );
                              }).toList(),
                              onChanged: (val) {
                                fetchData(
                                    val!, selectedSubstation, selectedFeeder);
                                // workOrderNoId = int.parse(val);
                                setState(() {
                                  selectedType = val;
                                });
                                Navigator.pop(context);
                              },
                              validator: (value) =>
                                  value == null ? 'field required' : null,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      });

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(item,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 20,
          )));

  Future openDailogApprove(String idLocal, int index) => showDialog(
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
                                        borderRadius: BorderRadius.circular(10),
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
                  // Container(
                  //   margin: const EdgeInsets.only(bottom: 10.0, top: 2),
                  //   padding: const EdgeInsets.all(8),
                  //   alignment: Alignment.center,
                  //   // width: size.width * 1,
                  //   decoration: const BoxDecoration(
                  //       boxShadow: [
                  //         BoxShadow(
                  //             color: Color.fromARGB(255, 3, 47, 97),
                  //             blurRadius: 5,
                  //             offset: Offset(2.0, 5.0))
                  //       ],
                  //       color: Color.fromARGB(255, 130, 193, 245),
                  //       gradient: LinearGradient(
                  //         colors: [
                  //           Colors.white,
                  //           Colors.white,
                  //         ],
                  //       )),
                  //   child: Row(
                  //     children: [
                  //       InkWell(
                  //           onTap: () {
                  //             // _checkPermission(context);
                  //             pickImageOptions();
                  //           },
                  //           child: const Text(
                  //             'Choose File',
                  //             style: TextStyle(
                  //               fontSize: 16,
                  //               color: AppColors.baseColor,
                  //               //fontWeight: FontWeight.bold
                  //             ),
                  //           )),
                  //       // Padding(
                  //       //   padding: const EdgeInsets.only(left: 8.0),
                  //       //   child: Container(
                  //       //     width: 1,
                  //       //     height: 50,
                  //       //     color: Colors.black,
                  //       //   ),
                  //       // ),
                  //       // Expanded(
                  //       //   child: Padding(
                  //       //     padding: const EdgeInsets.only(left: 8.0),
                  //       //     child: Text(
                  //       //       ((_imagePath.isEmpty) &&
                  //       //               (_imagePath2.isEmpty) &&
                  //       //               (_imagePath3.isEmpty))
                  //       //           ? 'No file selected'
                  //       //           : (_imagePath.isNotEmpty ||
                  //       //                   _imagePath2.isNotEmpty ||
                  //       //                   _imagePath3.isNotEmpty)
                  //       //               ? '3 files selected'
                  //       //               : (_imagePath.isNotEmpty ||
                  //       //                       _imagePath2.isEmpty ||
                  //       //                       _imagePath3.isEmpty)
                  //       //                   ? '1 file selected'
                  //       //                   : (_imagePath.isEmpty ||
                  //       //                           _imagePath2.isNotEmpty ||
                  //       //                           _imagePath3.isEmpty)
                  //       //                       ? '1 file selected'
                  //       //                       : (_imagePath.isNotEmpty &&
                  //       //                               _imagePath2.isEmpty &&
                  //       //                               _imagePath3.isEmpty)
                  //       //                           ? '1 file selected'
                  //       //                           : (_imagePath.isEmpty &&
                  //       //                                   _imagePath2
                  //       //                                       .isNotEmpty &&
                  //       //                                   _imagePath3.isEmpty)
                  //       //                               ? '1 file selected'
                  //       //                               : (_imagePath.isEmpty &&
                  //       //                                       _imagePath2
                  //       //                                           .isEmpty &&
                  //       //                                       _imagePath3
                  //       //                                           .isNotEmpty)
                  //       //                                   ? '1 file selected'
                  //       //                                   : (_imagePath
                  //       //                                               .isNotEmpty &&
                  //       //                                           _imagePath2
                  //       //                                               .isNotEmpty &&
                  //       //                                           _imagePath3
                  //       //                                               .isEmpty)
                  //       //                                       ? '2 files selected'
                  //       //                                       : (_imagePath
                  //       //                                                   .isNotEmpty &&
                  //       //                                               _imagePath2
                  //       //                                                   .isEmpty &&
                  //       //                                               _imagePath3
                  //       //                                                   .isNotEmpty)
                  //       //                                           ? '2 files selected'
                  //       //                                           : (_imagePath
                  //       //                                                       .isEmpty &&
                  //       //                                                   _imagePath2
                  //       //                                                       .isNotEmpty &&
                  //       //                                                   _imagePath3
                  //       //                                                       .isNotEmpty)
                  //       //                                               ? '2 files selected'
                  //       //                                               : 'No File selected',
                  //       //       style: const TextStyle(
                  //       //         fontSize: 16,
                  //       //         color: AppColors.baseColor,
                  //       //       ),
                  //       //     ),
                  //       //   ),
                  //       // ),
                  //     ],
                  //   ),
                  // ),

                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: Visibility(
                  //         visible: _isVisibleImage,
                  //         child: Stack(
                  //           children: [
                  //             if (imagePath.isNotEmpty)
                  //               Image.file(
                  //                 File(imagePath),
                  //                 height: 200,
                  //                 width: 200,
                  //                 fit: BoxFit.cover,
                  //               ),
                  //             InkWell(
                  //               onTap: () async {
                  //                 setState(() {
                  //                   _isVisibleImage = false;
                  //                 });

                  //                 // deleteOnlineImageApi(
                  //                 //     deleteImage1,
                  //                 //     maintenanceReportViewViewModel
                  //                 //         .maintenanceReportViewGetTabularData
                  //                 //         .data!
                  //                 //         .findAllJoinDatas![index]
                  //                 //         .tokenNo
                  //                 //         .toString());
                  //               },
                  //               child: const Icon(Icons.delete,
                  //                   color: Colors.red, size: 50),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //     Expanded(
                  //       child: Visibility(
                  //         visible: _isVisibleImage2,
                  //         child: Stack(
                  //           children: [
                  //             if (imagePath2.isNotEmpty)
                  //               Image.file(
                  //                 File(imagePath2),
                  //                 height: 200,
                  //                 width: 200,
                  //                 fit: BoxFit.cover,
                  //               ),
                  //             InkWell(
                  //               onTap: () {
                  //                 setState(() {
                  //                   _isVisibleImage2 = false;
                  //                 });

                  //                 // deleteOnlineImageApi(
                  //                 //     deleteImage2,
                  //                 //     maintenanceReportViewViewModel
                  //                 //         .maintenanceReportViewGetTabularData
                  //                 //         .data!
                  //                 //         .findAllJoinDatas![index]
                  //                 //         .tokenNo
                  //                 //         .toString());
                  //               },
                  //               child: const Icon(Icons.delete,
                  //                   color: Colors.red, size: 50),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //     Expanded(
                  //       child: Visibility(
                  //         visible: _isVisibleImage3,
                  //         child: Stack(
                  //           children: [
                  //             if (imagePath3.isNotEmpty)
                  //               Image.file(
                  //                 File(imagePath3),
                  //                 height: 200,
                  //                 width: 200,
                  //                 fit: BoxFit.cover,
                  //               ),
                  //             InkWell(
                  //               onTap: () {
                  //                 setState(() {
                  //                   _isVisibleImage3 = false;
                  //                 });

                  //                 // deleteOnlineImageApi(
                  //                 //     deleteImage3,
                  //                 //     maintenanceReportViewViewModel
                  //                 //         .maintenanceReportViewGetTabularData
                  //                 //         .data!
                  //                 //         .findAllJoinDatas![index]
                  //                 //         .tokenNo
                  //                 //         .toString());
                  //               },
                  //               child: const Icon(Icons.delete,
                  //                   color: Colors.red, size: 50),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(imagePaths.length, (index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal:
                                  5), // Optional: Add margin for spacing
                          width: 100, // Set a fixed width for each image/icon
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
                                    deleteOnlineImageApi(
                                        imagePaths[index],
                                        maintenanceReportViewViewModel
                                            .maintenanceReportViewGetTabularData
                                            .data!
                                            .findAllJoinDatas![index]
                                            .tokenNo
                                            .toString());
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
                              // submitImage(
                              //     imagePath,
                              //     maintenanceReportViewViewModel
                              //         .maintenanceReportViewGetTabularData
                              //         .data!
                              //         .findAllJoinDatas![index]
                              //         .tokenNo
                              //         .toString());
                              submitImages(
                                  imagePaths,
                                  maintenanceReportViewViewModel
                                      .maintenanceReportViewGetTabularData
                                      .data!
                                      .findAllJoinDatas![index]
                                      .tokenNo
                                      .toString(),
                                  maintenanceReportViewViewModel
                                      .maintenanceReportViewGetTabularData
                                      .data!
                                      .findAllJoinDatas![index]
                                      .budgetType
                                      .toString());
                            } else {
                              print('else case where no image111111111111111');
                              // maintenanceReportViewViewModel
                              //     .fetchMaintenanceReportViewTabularListApi(
                              //         context, '', '', '', id);
                              maintenanceReportViewViewModel
                                  .fetchMaintenanceReportViewTabularListApi(
                                      context, '', '', '', '','1,2');
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

  Future<void> submitImage(String fileName, String tokenNo) async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    print('object');
    try {
      var uri = Uri.parse(
          "https://atsdev2test.ariespro.com/civmapi/contractorPanel/updateImageVEGETATION_CREW_FORMs");
      var request = http.MultipartRequest("POST", uri);
      print('object111');
      final userPreferences = Provider.of<UserPref>(context, listen: false);
      UserModel data = await userPreferences.getUser();
      var headers = {
        "Content-Type": "multipart/form-data",
        "Accept": "*/*",
        "Authorization": 'Bearer ${data.token!}'
      };

      List<http.MultipartFile> newList = [];
      print('object22');
      if (imagePath != '') {
        print('object333');
        File img1 = new File(imagePath);
        File file = await img1.copy(
            '${tempPath}/img_${DateFormat('yyyyMMddHHmmss').format(DateTime.now())}${imagePath.contains('.pdf') ? '.pdf' : '.jpg'}');

        var stream1 = http.ByteStream(file.openRead());
        var length1 = await file.length();
        print('object666');
        print(length1);
        print(file.path);
        // Get the file length
        var multipartFile = http.MultipartFile("files", stream1, length1,
            filename: path.basename(file.path));
        deleteImage1 = path.basename(file.path);
        newList.add(multipartFile);
      }

      if (imagePath2 != '') {
        File img2 = new File(imagePath2);
        File file2 = await img2.copy(
            '${tempPath}/img_${DateFormat('yyyyMMddHHmmss').format(DateTime.now())}2${imagePath2.contains('.pdf') ? '.pdf' : '.jpg'}');

        var stream2 = http.ByteStream(file2.openRead());
        var length2 = await file2.length();
        print(length2);
        print(file2.path);
        // Get the file length
        var multipartFile2 = http.MultipartFile("files", stream2, length2,
            filename: path.basename(file2.path));

        deleteImage2 = path.basename(file2.path);

        newList.add(multipartFile2);
      }

      if (imagePath3 != '') {
        File img3 = new File(imagePath3);
        File file3 = await img3.copy(
            '${tempPath}/img_${DateFormat('yyyyMMddHHmmss').format(DateTime.now())}3${imagePath3.contains('.pdf') ? '.pdf' : '.jpg'}');

        var stream3 = http.ByteStream(file3.openRead());
        var length3 = await file3.length();
        print(length3);
        print(file3.path);
        // Get the file length
        var multipartFile3 = http.MultipartFile("files", stream3, length3,
            filename: path.basename(file3.path));
        deleteImage3 = path.basename(file3.path);
        newList.add(multipartFile3);
      }

      if (newList.isNotEmpty) {
        request.files.addAll(newList); // Add the multiple file to the request
      }
      print('222');
      request.headers.addAll(headers);
      request.fields['tokenNo'] = tokenNo;
      print('333');
      // Send the request
      var streamedResponse = await request.send();
      print(streamedResponse);
      print(streamedResponse.statusCode);
      var response = await http.Response.fromStream(streamedResponse);
      print("xyz");
      print(response.body);
      // listen for response
      // streamedResponse.stream.transform(utf8.decoder).listen((value) {
      //   print(value);
      // });
      if (response.statusCode == 200) {
        print('response');
        print(response);
        // maintenanceReportViewViewModel.fetchMaintenanceReportViewTabularListApi(
        //     context, '', '', '', id);
        maintenanceReportViewViewModel.fetchMaintenanceReportViewTabularListApi(
            context, '', '', '', '','1,2');
        Navigator.pop(context);
      }
    } catch (e, stacktrace) {
      print('catch statement');
      print('Exception: $e\n$stacktrace');
    }
    print('object');
    print(_isVisibleImage);
    _isVisibleImage = true;
    print(_isVisibleImage);
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

////////////////running code no image found//////////////////
  Future openDialogPicture(String tokenNo) => showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            int length =
                maintenanceReportViewViewModel.imageData.data?.images?.length ??
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
        maintenanceReportViewViewModel.imageData.data?.images![i].imageLocation;

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
        // maintenanceReportViewViewModel.fetchMaintenanceReportViewTabularListApi(
        //     context, '', '', '', id);
        maintenanceReportViewViewModel.fetchMaintenanceReportViewTabularListApi(
            context, '', '', '', '','1,2');
      } else {
        print('API request failed with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

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
          openDailogApprove(tokenNo, index);
        } else {
          // maintenanceReportViewViewModel
          //     .fetchMaintenanceReportViewTabularListApi(
          //         context, '', '', '', id);
          maintenanceReportViewViewModel
              .fetchMaintenanceReportViewTabularListApi(
                  context, '', '', '', '','1,2');
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

  Future<void> getInitData() async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    rights = data.user!.rights;

    id = data.user!.id.toString();
    // maintenanceReportViewViewModel.fetchMaintenanceReportViewTabularListApi(
    //     context, '', '', '', id);
    maintenanceReportViewViewModel.fetchMaintenanceReportViewTabularListApi(
        context, '', '', '', '','1,2');
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

  String formatDate(String isoDateString) {
    DateTime dateTime = DateTime.parse(isoDateString);
    // Custom format: MM-dd-yyyyTHH:mm:ss.SSS+00:00
    String formattedDate =
        DateFormat("MM-dd-yyyy'T'HH:mm:ss.SSS").format(dateTime);
    return "$formattedDate+00:00";
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
        // maintenanceReportViewViewModel.fetchMaintenanceReportViewTabularListApi(
        //     context, '', '', '', id);
        maintenanceReportViewViewModel.fetchMaintenanceReportViewTabularListApi(
            context, '', '', '', '','1,2');
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

  void dateFormat(
    int index,
  ) {
    String? rawNextRowMaintenanceDue = maintenanceReportViewViewModel
        .maintenanceReportViewGetTabularData
        .data!
        .findAllJoinDatas![index]
        .contractYear
        .toString();
    String? rawOrderDate = maintenanceReportViewViewModel
        .maintenanceReportViewGetTabularData
        .data!
        .findAllJoinDatas![index]
        .createDate
        .toString();

    print('rawOrderDate $rawOrderDate');

    formattedNextRowMaintenanceDue = extractYear(rawNextRowMaintenanceDue);

    print('rawCreateDate $rawNextRowMaintenanceDue');
    print('formattedContractYear: $formattedNextRowMaintenanceDue');

    if (rawOrderDate.isEmpty) {
      print("Invalid date");
      return;
    }

    try {
      DateTime parsedDate = DateTime.parse(rawOrderDate);
      String formattedDate =
          DateFormat("MM/dd/yyyy h:mm:ss a").format(parsedDate);
      newFormatedOrderDate = formattedDate;
      print('formattedOrderDate: $formattedDate');
    } catch (e) {
      print("Error parsing or formatting date: $rawOrderDate, Error: $e");
    }
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

// ignore: must_be_immutable
class DrawerManu extends StatefulWidget {
  List<String> menu;
  DrawerManu({Key? key, required this.menu}) : super(key: key);

  @override
  State<DrawerManu> createState() => _DrawerManuState();
}

class _DrawerManuState extends State<DrawerManu> {
  String userName = '';

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
                    title: const Text('Supervisor Dashboard'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const PeterContractorBottomNavigationPannel()));
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
                              const PeterGFDistributionIVMpEnding()));
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
                              const PeterGFDistributionIVMRejected()));
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
                              const PeterMaintenanceReportViewDistriIVMNew()));
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
