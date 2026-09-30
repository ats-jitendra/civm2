import 'dart:convert';
import 'dart:io';
import 'package:CIVM/repository/map_url.dart';
import 'package:CIVM/resources/app_url.dart';
import 'package:CIVM/screens/login_page.dart';
import 'package:CIVM/screens/offline_map/map_screen_crew.dart';
// import 'package:CIVM/screens/map_view.dart';
import 'package:CIVM/screens/video_folder/bloc/camera_bloc.dart';
import 'package:CIVM/screens/video_folder/utils/camera_utils.dart';
import 'package:CIVM/screens/video_folder/utils/permission_utils.dart';
import 'package:CIVM/screens/video_folder/view/pages/camera_page.dart';
import 'package:CIVM/utils/common_functions.dart';
import 'package:camera/camera.dart';
import 'package:CIVM/data/response/status.dart';
import 'package:CIVM/models/contractor_row_maintenance_progress_model.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/screens/my_chrome_safari_map_recording.dart';
import 'package:CIVM/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/view_model/contractor_row_maintenance_progress_view_model.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

// ignore: must_be_immutable
class CrewTempRowMaintenanceProgressContractorNew extends StatefulWidget {
  String jobNo;
  String substation;
  String feeder;
  String substationId;
  String feederId;
  String maintenanceType;
  String nextMaintDue;
  CrewTempRowMaintenanceProgressContractorNew({
    Key? key,
    required this.jobNo,
    required this.substation,
    required this.feeder,
    required this.substationId,
    required this.feederId,
    required this.maintenanceType,
    required this.nextMaintDue,
  }) : super(key: key);
  @override
  State<CrewTempRowMaintenanceProgressContractorNew> createState() =>
      _CrewTempRowMaintenanceProgressContractorNewState();
}

class _CrewTempRowMaintenanceProgressContractorNewState
    extends State<CrewTempRowMaintenanceProgressContractorNew> {
  final TextEditingController _totalMiles = TextEditingController();
  final TextEditingController _milesCompleted = TextEditingController();
  final TextEditingController _milesInProgress = TextEditingController();
  final TextEditingController _milesPending = TextEditingController();
  final TextEditingController _milesCompleted2 = TextEditingController();
  final TextEditingController _milesInProgress2 = TextEditingController();
  final TextEditingController _spanCompleted2 = TextEditingController();
  final TextEditingController _milesPending2 = TextEditingController();
  final TextEditingController _affectedDays = TextEditingController();
  final TextEditingController _ivmNumber = TextEditingController();
  final TextEditingController _notes = TextEditingController();
  final TextEditingController _jobNo = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  String feederN = '';
  String substationN = '';
  String crewName = '';
  List dataList = [];
  List<String> menu = [];
  final browser = MyChromeSafariBrowser();
  late VideoPlayerController _videoController;
// ignore: non_constant_identifier_names
//   final select_rowMethod = [
//     'Jarraff',
//     'Bucket',
//     // 'Shear',
//     // 'Mulching Head',
//     'Mini Jaraff',
//     'BYL',
//     'Manual',
//     'Mowing',
//     'Herbicide',
//   ];
// // ignore: non_constant_identifier_names
//   String? rowMethod;

  // ignore: non_constant_identifier_names
  List<String> select_rowMethod = [
    // 'Jarraff',
    // 'Bucket',
    // // 'Shear',
    // // 'Mulching Head',
    // 'Mini Jaraff',
    // 'BYL',
    // 'Manual',
    // 'Mowing',
    // 'Herbicide',
    'JARRAFF',
    'MOWING',
    'MINI JARRAFF',
    'BYL',
    'BUCKET',
    'GROUND',
    'MANNUAL',
    'HERBICIDE'
  ];
  String? rowMethod;

  List<String> rowMethodNew = [
    'JARRAFF',
    'MOWING',
    'MINI JARRAFF',
    'BYL',
    'BUCKET',
    'GROUND',
    'MANNUAL',
    'HERBICIDE'
  ];

// ignore: non_constant_identifier_names
  final select_delayCause = ['Weather Delay', 'Other Issues'];
// ignore: non_constant_identifier_names
  String? delayCause;
// ignore: prefer_typing_uninitialized_variables, non_constant_identifier_names
  var select_reason = ['', ''];
// ignore: non_constant_identifier_names
  String? reason;
  String datetime = DateTime.now().toString();
  // File? image;

  bool _isVisibleImageDoc = false;
  bool _isVisibleImage2Doc = false;
  bool _isVisibleImage3Doc = false;

  bool _isVisibleImage = false;
  bool _isVisibleImage2 = false;
  bool _isVisibleImage3 = false;
  bool _isVisibleUpdateMap = false;
  bool _isVisibleMixingForm = false;
// ignore: prefer_typing_uninitialized_variables
  var deleteImage1;
// ignore: prefer_typing_uninitialized_variables
  var deleteImage2;
// ignore: prefer_typing_uninitialized_variables
  var deleteImage3;
  onTappedBar(int index) {
    setState(() {
// _currentIndex = index;
    });
  }

  ContractorRowMaintenanceProgressViewModelViewModel
      contractorRowMaintenanceProgressViewModelViewModel =
      ContractorRowMaintenanceProgressViewModelViewModel();
// ignore: prefer_typing_uninitialized_variables
  var selectedChangeOrderNo;
// ignore: prefer_typing_uninitialized_variables
  var selectedCrew;
  // File? image1;
  // File? image2;
  // File? image3;
  // String _imagePath = '';
  // String _imagePath2 = '';
  // String _imagePath3 = '';
// List<String> _imagePaths = [];
  final _formkey = GlobalKey<FormState>();
  searchFun() {}

  bool _isVisibleExceed = false;

  late List<CameraDescription> _cameras;
  late CameraController _camerasController;
  // String imagePath = '';
  // String imagePath1 = '';
  // String imagePath2 = '';
  List<String> imagePaths = [];
  List<XFile> images = [];
  // var image;
  // var image1;
  // var image2;

  String globalSubstation = '';
  String globalFeeder = '';
  String globalYear = '';
  String globalCycle = '';
  int flag = 0;
  bool _isPlayVideoFlag = true;

  VideoPlayerController? _controller;
  XFile? _videoFile;

  bool isVideoInitialized = false;
  String? videoControllerString;

  int videoFlag = 0;

  var _setState;
  String videoPath = '';

  String formattedDate = '';

  bool _isVisibleSubmittingButton = false;
  bool _isVisibleSubmitButton = true;

  bool _isVisibleSubmitForReviewButton = true;
  bool _isVisibleSubmitingForReviewButton = false;

  bool _isVisibleUpdatePreviousRecord = false;
  bool _isVisibleSubmitFormNewRecord = true;

  bool _isVisibleUpdateButton = false;
  bool _isVisibleUpdatingButton = false;

  double backendEditMilesCompleted = 0.0;

  String previousMilesCompleted = '';
  int? vegId;
  @override
  void initState() {
    fetchData(widget.jobNo);
    setDataForCalculation();
    _initializeScreen();
    // cameraInit();
    super.initState();
  }

  // @override
  // void dispose() {
  //   _controller?.dispose();
  //   super.dispose();
  // }

  // void initializeVideo() async {
  //   await _videoController.initialize();
  //   _videoController.setLooping(true);
  //   _videoController.play();
  // }

  void initializeVideo() async {
    await _videoController.initialize();
    _videoController.setLooping(true); // If you want the video to loop
    setState(() {});
  }

  // @override
  // void dispose() {
  //   if (isVideoInitialized) {
  //     _videoController.dispose();
  //   }
  //   super.dispose();
  // }

  int tblSubMilesCostId = 0;
  String subStateName = "";
  String feeder = "";
  String street = "";
  String crew = "";
  double totalMiles = 0.0;
//  double milesCompleted =  0.0;
//  double milesInProgress=23.0;
//  double milesPending=0.0;
  String performanceType = "";
  double wtdProgress = 0.0;
  double mtdProgress = 0.0;
  double ytdProgress = 0.0;
  String rowMethod2 = "";
  String delayCause2 = "";
  String delayReason = "";
  double effectedNoOfDays = 0.0;
  String fileUpload = "N/A";
  String createDate = "2025-02-02T12:19:29.427+00:00";
  String status = "";
  int idDuringUpdate = 0;
  int flagEdit = 0;

  @override
  void dispose() {
    _videoController.pause();
    _videoController.dispose();
    disposeCamera();
    super.dispose();
  }

  Future<void> disposeCamera() async {
    if (_camerasController.value.isInitialized) {
      await _camerasController.dispose();
      // _camerasController = null;
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    // _loadVideoController();
    Size size = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        bool shouldExit = await showExitPopup(context);
        if (shouldExit) {
          Navigator.of(context).pop(); // Exit the page if "Yes" is clicked
        }
      },
      child: Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            title: Row(
              children: [
                const Expanded(
                  child: Text(
                    "IVM Maintenance Job List Status",
                    //'IVM Work Progress Status',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                // InkWell(
                //   onTap: () async {
                //     if (_isVisibleSubmitFormNewRecord == true) {
                //       print('Form Submitting');
                //       if (_formkey.currentState!.validate()) {
                //         setState(() {
                //           _isVisibleSubmittingButton = true;
                //           _isVisibleSubmitButton = false;
                //         });
                //         print('after formkey validation');
                //         // if (videoPath != '' || imagePaths.isNotEmpty) {
                //         //   print('if condition videoPath != '
                //         //       ' ||imagePaths.isNotEmpty');
                //         //   submitMediaFiles(
                //         //       imagePaths, videoPath, selectedChangeOrderNo!);
                //         //   // submitVideo(videoPath,
                //         //   //     selectedChangeOrderNo!);
                //         // }

                //         // else {
                //         print('else condition1222');

                //         Map mapData = {
                //           "tblSubMilesCostId": (selectedChangeOrderNo == null)
                //               ? ''
                //               : selectedChangeOrderNo,
                //           "subStateName": widget.substationId,
                //           "feeder": widget.feederId,
                //           "street": "N/A",
                //           "crew": crewName,
                //           "totalMiles": (_totalMiles.text.toString() == 'null')
                //               ? ''
                //               : double.parse(_totalMiles.text)
                //                   .toStringAsFixed(2),
                //           "milesCompleted":
                //               double.parse(_milesCompleted2.text.toString())
                //                   .toStringAsFixed(2),
                //           "milesInProgress":
                //               (_milesInProgress2.text.toString() == 'null')
                //                   ? ''
                //                   : double.parse(_milesInProgress2.text)
                //                       .toStringAsFixed(2),
                //           "milesPending":
                //               (_milesPending2.text.toString() == 'null')
                //                   ? ''
                //                   : double.parse(_milesPending2.text)
                //                       .toStringAsFixed(2),
                //           "performanceType": 'N/A',
                //           "wtdProgress": 0.0,
                //           "mtdProgress": 0.0,
                //           "ytdProgress": 0.0,
                //           "rowMethod": rowMethod ?? '',
                //           "delayCause": delayCause ?? '',
                //           "delayReason": reason ?? '',
                //           "effectedNoOfDays":
                //               (_affectedDays.text.toString() == 'null')
                //                   ? 0
                //                   : _affectedDays.text.toString(),
                //           "fileUpload": "N/A",
                //           "createDate": "2023-12-13T12:19:29.427+00:00",
                //           //  "status": "PENDING",
                //           "status": "PENDING ZIELIES APPROVAL",
                //           "notes": (_notes.text.toString() == 'null')
                //               ? 'N/A'
                //               : _notes.text.toString(),
                //           "spanCompleted":
                //               (_spanCompleted2.text.toString() == 'null')
                //                   ? 'N/A'
                //                   : _spanCompleted2.text.toString(),
                //         };
                //         print('API called.........');
                //         // contractorRowMaintenanceProgressViewModelViewModel
                //         //     .fetchRowMaintenanceProgressContractorSubmitListApi(
                //         //         context, mapData);
                //         final response =
                //             await contractorRowMaintenanceProgressViewModelViewModel
                //                 .fetchRowMaintenanceProgressContractorSubmitListApi(
                //                     context, mapData);
                //         //  Store ID
                //         vegId = response.id;
                //         //  Optional
                //         print("Stored vegId: $vegId");
                //         //  Now you have ID here
                //         print("ID in Screen A: ${response.id}");
                //         print('mapData');

                //         print("${jsonEncode(mapData)}");
                //         if (videoPath != '' || imagePaths.isNotEmpty) {
                //           print('if condition videoPath != '
                //               ' ||imagePaths.isNotEmpty');
                //           submitMediaFiles(
                //               imagePaths, videoPath, selectedChangeOrderNo!);
                //           // submitVideo(videoPath,
                //           //     selectedChangeOrderNo!);
                //         }

                //         Future.delayed(const Duration(seconds: 5), () {
                //           Navigator.pop(context);
                //           Navigator.pop(context);
                //         });
                //         //  }
                //         print('name1');
                //       } else {
                //         print("Please fill all mendetory fields!!!");
                //         _showValidationErrorSnackBar(context);
                //       }
                //     } else if (_isVisibleSubmitFormNewRecord == false) {
                //       print('Updating form');
                //       if (_formkey.currentState!.validate()) {
                //         setState(() {
                //           _isVisibleUpdatingButton = true;
                //           _isVisibleUpdateButton = false;
                //         });
                //         print('after formkey validation');
                //         if (videoPath != '' || imagePaths.isNotEmpty) {
                //           print('if condition videoPath != '
                //               ' ||imagePaths.isNotEmpty');
                //           submitMediaFilesEditOldRecord(
                //               imagePaths, videoPath, selectedChangeOrderNo!);
                //           // submitVideo(videoPath,
                //           //     selectedChangeOrderNo!);
                //         }
                //         // if (imagePaths.isNotEmpty) {
                //         //   print('if condition 1222');
                //         //   // submitImage(imagePath!,
                //         //   //     selectedChangeOrderNo!);
                //         //   submitImage(imagePaths,
                //         //       selectedChangeOrderNo!);
                //         // }

                //         else {
                //           print('else condition1222');

                //           Map mapDataEditOldRecord = {
                //             "tblSubMilesCostId": tblSubMilesCostId,
                //             "subStateName": subStateName,
                //             "feeder": feeder,
                //             "street": street,
                //             "crew": crew,
                //             "totalMiles": totalMiles,
                //             "milesCompleted": _milesCompleted2.text.toString(),
                //             "milesInProgress":
                //                 _milesInProgress2.text.toString(),
                //             "milesPending": _milesPending2.text.toString(),
                //             "performanceType": "",
                //             "wtdProgress": 0.0,
                //             "mtdProgress": 0.0,
                //             "ytdProgress": 0.0,
                //             "rowMethod": rowMethod,
                //             "delayCause": delayCause ?? '',
                //             "delayReason": reason ?? '',
                //             "effectedNoOfDays":
                //                 (_affectedDays.text.toString() == 'null')
                //                     ? 0
                //                     : _affectedDays.text.toString(),
                //             "fileUpload": "N/A",
                //             "createDate": "2025-02-02T12:19:29.427+00:00",
                //             // "status": "PENDING",
                //             "status": "PENDING ZIELIES APPROVAL",
                //             "notes": _notes.text.toString(),
                //           };
                //           print('API called.........');
                //           updateVegetationCrewForm(
                //               mapDataEditOldRecord, idDuringUpdate);
                //           print('mapDataEditOldRecord');
                //           print(mapDataEditOldRecord);
                //           Future.delayed(const Duration(seconds: 5), () {
                //             Navigator.pop(context);
                //             Navigator.pop(context);
                //           });
                //         }
                //         print('name1');
                //       } else {
                //         print("Please fill all mendetory fields!!!");
                //         _showValidationErrorSnackBar(context);
                //       }
                //     }
                //   },
                //   child: const Icon(
                //     Icons.done_outline_rounded,
                //     size: 30.0,
                //     color: Colors.white,
                //   ),
                // ),
             
              ],
            ),
            backgroundColor: const Color.fromARGB(255, 7, 59, 120),
          ),
          body: ChangeNotifierProvider<
                  ContractorRowMaintenanceProgressViewModelViewModel>(
              create: (BuildContext context) =>
                  contractorRowMaintenanceProgressViewModelViewModel,
              child:
                  Consumer<ContractorRowMaintenanceProgressViewModelViewModel>(
                      builder: (context, value, _) {
                switch (value
                    .contractorRowMaintenanceProgressViewModelGetTabularData
                    .status) {
                  case Status.LOADING:
                    return const Center(child: CircularProgressIndicator());
                  case Status.ERROR:
                    return
                        // CustomToastSnackBarProgressDialog.flushBarErrorMessage(
                        //     value
                        //         .contractorRowMaintenanceProgressViewModelGetTabularData
                        //         .message
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
                                'assets/empty_box.png',
                                height: 200,
                                width: 200,
                                fit: BoxFit.cover,
                              ),
                              const Center(
                                child: Text(
                                  'Sorry, Data Not Found!',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 7, 59, 120),
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
                    _jobNo.text = widget.jobNo;
                    selectedChangeOrderNo = widget.jobNo;
                    print('selectedChangeOrderNo222 $selectedChangeOrderNo');

                    List<Map<String, dynamic>> convertToMapList(
                        List<GetAllList> list) {
                      return list.map((item) {
                        return {
                          'orderNo': item.orderNo,
                          'substation': item.substation,
                          'feeder': item.feeder,
                          'feederId': item.feederId,
                          'substationId': item.substationId
                        };
                      }).toList();
                    }
                    List<GetAllList> dataList =
                        contractorRowMaintenanceProgressViewModelViewModel
                            .contractorRowMaintenanceProgressViewModelGetTabularData
                            .data!
                            .getAllList!;
                    List<Map<String, dynamic>> mappedDataList =
                        convertToMapList(dataList);
                    print('mappedDataList $mappedDataList');
                    if (flag == 1) {
                      extractAndStoreSubstationFeeder(mappedDataList);
                    }

                    return SingleChildScrollView(
                        controller: _scrollController,
                        child: Form(
                          key: _formkey,
                          child: Column(children: [
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 8, right: 8, top: 10, bottom: 8),
                              padding: const EdgeInsets.all(8),
                              alignment: Alignment.center,
                              width: size.width * 0.99,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Color.fromARGB(255, 7, 59, 120),
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
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    alignment: Alignment.center,
                                    width: size.width * 0.99,
                                    decoration: const BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              color: Color.fromARGB(
                                                  255, 3, 47, 97),
                                              blurRadius: 5,
                                              offset: Offset(2.0, 5.0))
                                        ],
                                        gradient: LinearGradient(
                                          colors: [
                                            Color.fromARGB(255, 7, 59, 120),
                                            Color.fromARGB(255, 7, 59, 120)
                                          ],
                                        )),
                                    child: const Row(children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Search Option",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 20),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Job No",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 7, 59, 120),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Padding(
                                  //   padding:
                                  //       const EdgeInsets.only(top: 10, bottom: 10),
                                  //   child: TypeAheadField(
                                  //     controller: _ivmNumber,
                                  //     onSelected: (value) {
                                  //       print(value['orderNo']);
                                  //       _ivmNumber.text = value['orderNo'].toString();
                                  //       if (_ivmNumber.text.isEmpty) {
                                  //         fetchData('');
                                  //         flag = 0;
                                  //         globalFeeder = '';
                                  //         globalSubstation = '';
                                  //         globalYear = '';
                                  //         globalCycle = '';
                                  //         _isVisibleUpdateMap = false;
                                  //         _isVisibleMixingForm = false;
                                  //       } else {
                                  //         setState(() {
                                  //           selectedChangeOrderNo =
                                  //               _ivmNumber.text.toString();
                                  //           flag = 1;
                                  //         });
                                  //         fetchData(_ivmNumber.text);
                                  //       }
                                  //       feederN = value['feederId'].toString();
                                  //       substationN =
                                  //           value['substationId'].toString();
                                  //       print('===============$feederN');
                                  //       print('===========$substationN');
                                  //     },
                                  //     suggestionsCallback: (pattern) {
                                  //       return mappedDataList.where((element) {
                                  //         return (element['substation'] != null &&
                                  //                 element['substation']!
                                  //                     .toLowerCase()
                                  //                     .contains(
                                  //                         pattern.toLowerCase())) ||
                                  //             (element['feeder'] != null &&
                                  //                 element['feeder']!
                                  //                     .toLowerCase()
                                  //                     .contains(
                                  //                         pattern.toLowerCase())) ||
                                  //             (element['orderNo'].toString() != '' &&
                                  //                 element['orderNo']
                                  //                     .toString()
                                  //                     .contains(pattern));
                                  //       }).toList();
                                  //     },
                                  //     itemBuilder: (context, suggestion) {
                                  //       return ListTile(
                                  //         title:
                                  //             Text(suggestion['orderNo'].toString()),
                                  //       );
                                  //     },
                                  //     builder: (context, con, fn) {
                                  //       return TextField(
                                  //         controller: con,
                                  //         focusNode: fn,
                                  //         decoration: InputDecoration(
                                  //             enabledBorder: const OutlineInputBorder(
                                  //               borderSide: BorderSide(
                                  //                 color:
                                  //                     Color.fromARGB(255, 7, 59, 120),
                                  //               ),
                                  //             ),
                                  //             focusedBorder: const OutlineInputBorder(
                                  //               borderSide: BorderSide(
                                  //                 color:
                                  //                     Color.fromARGB(255, 7, 59, 120),
                                  //               ),
                                  //             ),
                                  //             prefixIcon: const Icon(Icons.search),
                                  //             suffixIcon: InkWell(
                                  //                 onTap: () {
                                  //                   setState(() {
                                  //                     _ivmNumber.text = '';
                                  //                     _totalMiles.clear();
                                  //                     _milesCompleted.clear();
                                  //                     _milesInProgress.clear();
                                  //                     _milesPending.clear();
                                  //                     _milesPending2.clear();
                                  //                     rowMethod = null;
                                  //                     delayCause = null;
                                  //                     reason = null;
                                  //                     _affectedDays.clear();
                                  //                     _notes.clear();
                                  //                     // imagePath = '';
                                  //                     // imagePath1 = '';
                                  //                     // imagePath2 = '';
                                  //                     imagePaths = [];
                                  //                     _isVisibleImage = false;
                                  //                     _isVisibleImage2 = false;
                                  //                     _isVisibleImage3 = false;
                                  //                     _milesCompleted2.text = '0';
                                  //                     _milesInProgress2.text = '0';
                                  //                     globalFeeder = '';
                                  //                     globalSubstation = '';
                                  //                     flag = 0;
                                  //                     globalYear = '';
                                  //                     globalCycle = '';
                                  //                     _isVisibleUpdateMap = false;
                                  //                     _isVisibleMixingForm = false;
                                  //                     fetchData('');
                                  //                   });
                                  //                 },
                                  //                 child: const Icon(Icons.close)),
                                  //             hintText: 'search'),
                                  //       );
                                  //     },
                                  //   ),
                                  // ),

                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: TextFormField(
                                        enabled: false,
                                        controller: _jobNo,
                                        style: const TextStyle(
                                            color:
                                                Color.fromARGB(255, 7, 59, 120),
                                            fontSize: 16),
                                        obscureText: false,
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 7, 59, 120),
                                            ),
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 7, 59, 120),
                                            ),
                                            // borderRadius:
                                            // BorderRadius.circular(25),
                                          ),
                                          hintText: 'Job No',
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Please enter Job No.";
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
                            Container(
                                margin: const EdgeInsets.only(
                                    left: 8, right: 8, top: 10, bottom: 8),
                                padding: const EdgeInsets.all(8),
                                alignment: Alignment.center,
                                // height: size.height * 0.5,
                                width: size.width * 0.99,
                                decoration: BoxDecoration(
                                    // shape: BoxShape.circle,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                                      BoxShadow(
                                          color:
                                              Color.fromARGB(255, 7, 59, 120),
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
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      alignment: Alignment.center,
                                      width: size.width * 0.99,
                                      // width: MediaQuery.of(context).size.width,
                                      // height: 40,
                                      decoration: const BoxDecoration(
                                          // shape: BoxShape.circle,
                                          //borderRadius: BorderRadius.circular(25),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Color.fromARGB(
                                                    255, 3, 47, 97),
                                                blurRadius: 5,
                                                offset: Offset(2.0, 5.0))
                                          ],
                                          gradient: LinearGradient(
                                            colors: [
                                              Color.fromARGB(255, 7, 59, 120),
                                              Color.fromARGB(255, 7, 59, 120)
                                            ],
                                          )),
                                      child: const Row(children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Prev Progress",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ]),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20.0, left: 4),
                                      child: Row(
                                        children: [
                                          const Text(
                                            "Last Updated At: ",
                                            //textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                          Text(
                                            (contractorRowMaintenanceProgressViewModelViewModel
                                                            .contractorRowMaintenanceProgressViewModelGetTabularData
                                                            .data!
                                                            .findLastMaintDone![
                                                                0]
                                                            .lastUpdated ==
                                                        null ||
                                                    contractorRowMaintenanceProgressViewModelViewModel
                                                        .contractorRowMaintenanceProgressViewModelGetTabularData
                                                        .data!
                                                        .findLastMaintDone![0]
                                                        .lastUpdated!
                                                        .isEmpty ||
                                                    contractorRowMaintenanceProgressViewModelViewModel
                                                            .contractorRowMaintenanceProgressViewModelGetTabularData
                                                            .data!
                                                            .findLastMaintDone![
                                                                0]
                                                            .lastUpdated
                                                            .toString() ==
                                                        'null')
                                                ? ''
                                                // : formattedDate,
                                                : contractorRowMaintenanceProgressViewModelViewModel
                                                    .contractorRowMaintenanceProgressViewModelGetTabularData
                                                    .data!
                                                    .findLastMaintDone![0]
                                                    .lastUpdated
                                                    .toString(),
                                            //textAlign: TextAlign.left,
                                            style: const TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20.0, left: 4),
                                      child: Row(
                                        children: [
                                          const Text(
                                            "Year: ",
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 7, 59, 120),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                          Text(
                                            globalYear,
                                            style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 7, 59, 120),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20.0, left: 4),
                                      child: Row(
                                        children: [
                                          const Text(
                                            "Cycle: ",
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 7, 59, 120),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                          Text(
                                            globalCycle,
                                            style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 7, 59, 120),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20.0, left: 4),
                                      child: Row(
                                        children: [
                                          const Text(
                                            "Substation: ",
                                            //textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 7, 59, 120),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                          Text(
                                            widget.substation,
                                            // globalSubstation,
                                            style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 7, 59, 120),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20.0, left: 4),
                                      child: Row(
                                        children: [
                                          const Text(
                                            "Feeder: ",
                                            //textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 7, 59, 120),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                          Text(
                                            widget.feeder,
                                            // globalFeeder,
                                            style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 7, 59, 120),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        const Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 2.0,
                                                  right: 2.0,
                                                  bottom: 2.0,
                                                  top: 20.0),
                                              child: Text(
                                                "TOTAL MILES",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color.fromARGB(
                                                        255, 7, 59, 120),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: TextFormField(
                                              enabled: false,
                                              //key: formkey4,
                                              controller: _totalMiles,
                                              style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 7, 59, 120),
                                                  fontSize: 16),
                                              obscureText: false,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(
                                                    // borderRadius:
                                                    // BorderRadius.circular(25),
                                                    ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 7, 59, 120),
                                                  ),
                                                  // borderRadius:
                                                  // BorderRadius.circular(25),
                                                ),
                                                disabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 7, 59, 120),
                                                  ),
                                                  // borderRadius:
                                                  // BorderRadius.circular(25),
                                                ),
                                                hintText: 'TOTAL MILES',
                                              ),
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Please enter Total Miles";
                                                } else {
                                                  return null;
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                        const Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 2.0,
                                                  right: 2.0,
                                                  bottom: 2.0,
                                                  top: 20.0),
                                              child: Text(
                                                "MILES COMPLETED",
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Color.fromARGB(
                                                      255, 7, 59, 120),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: TextFormField(
                                              enabled: false,
                                              //key: formkey4,
                                              controller: _milesCompleted,
                                              style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 7, 59, 120),
                                                  fontSize: 16),
                                              obscureText: false,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(
                                                    // borderRadius:
                                                    // BorderRadius.circular(25),
                                                    ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 7, 59, 120),
                                                  ),
                                                  // borderRadius:
                                                  // BorderRadius.circular(25),
                                                ),
                                                disabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 7, 59, 120),
                                                  ),
                                                  // borderRadius:
                                                  // BorderRadius.circular(25),
                                                ),
                                                hintText: 'Miles Completed',
                                              ),
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Please enter Miles Completed";
                                                } else {
                                                  return null;
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                        const Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 2.0,
                                                  right: 2.0,
                                                  bottom: 2.0,
                                                  top: 20.0),
                                              child: Text(
                                                "MILES IN PROGRESS",
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Color.fromARGB(
                                                      255, 7, 59, 120),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: TextFormField(
                                              enabled: false,
                                              //key: formkey4,
                                              controller: _milesInProgress,
                                              style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 7, 59, 120),
                                                  fontSize: 16),
                                              obscureText: false,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(
                                                    // borderRadius:
                                                    // BorderRadius.circular(25),
                                                    ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 7, 59, 120),
                                                  ),
                                                  // borderRadius:
                                                  // BorderRadius.circular(25),
                                                ),
                                                disabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 7, 59, 120),
                                                  ),
                                                  // borderRadius:
                                                  // BorderRadius.circular(25),
                                                ),
                                                hintText: 'Miles In Progress',
                                              ),
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Please enter Miles In Progress";
                                                } else {
                                                  return null;
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                        const Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 2.0,
                                                  right: 2.0,
                                                  bottom: 2.0,
                                                  top: 20.0),
                                              child: Text(
                                                "MILES PENDING",
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Color.fromARGB(
                                                      255, 7, 59, 120),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: TextFormField(
                                              enabled: false,
                                              // key: formkey5,
                                              controller: _milesPending,
                                              style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 7, 59, 120),
                                                  fontSize: 16),
                                              obscureText: false,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(
                                                    // borderRadius:
                                                    // BorderRadius.circular(25),
                                                    ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 7, 59, 120),
                                                  ),
                                                  // borderRadius:
                                                  // BorderRadius.circular(25),
                                                ),
                                                disabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 7, 59, 120),
                                                  ),
                                                  // borderRadius:
                                                  // BorderRadius.circular(25),
                                                ),
                                                hintText: 'Miles Pending',
                                              ),
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Please enter Miles Pending";
                                                } else {
                                                  return null;
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            // Container(
                            //     margin: const EdgeInsets.only(
                            //         left: 8, right: 8, top: 10, bottom: 8),
                            //     padding: const EdgeInsets.all(8),
                            //     alignment: Alignment.center,
                            //     // height: size.height * 0.5,
                            //     width: size.width * 0.99,
                            //     decoration: BoxDecoration(
                            //         // shape: BoxShape.circle,
                            //         borderRadius: BorderRadius.circular(10),
                            //         boxShadow: const [
                            //           BoxShadow(
                            //               color:
                            //                   Color.fromARGB(255, 7, 59, 120),
                            //               blurRadius: 10,
                            //               offset: Offset(2.0, 5.0))
                            //         ],
                            //         gradient: const LinearGradient(
                            //           colors: [
                            //             Color.fromARGB(255, 255, 255, 255),
                            //             Color.fromARGB(255, 255, 255, 255),
                            //           ],
                            //         )),
                            //     child: Column(
                            //       children: [
                            //         Container(
                            //           padding: const EdgeInsets.all(10),
                            //           alignment: Alignment.center,
                            //           width: size.width * 0.99,
                            //           // width: MediaQuery.of(context).size.width,
                            //           // height: 40,
                            //           decoration: const BoxDecoration(
                            //               // shape: BoxShape.circle,
                            //               //borderRadius: BorderRadius.circular(25),
                            //               boxShadow: [
                            //                 BoxShadow(
                            //                     color: Color.fromARGB(
                            //                         255, 3, 47, 97),
                            //                     blurRadius: 5,
                            //                     offset: Offset(2.0, 5.0))
                            //               ],
                            //               gradient: LinearGradient(
                            //                 colors: [
                            //                   Color.fromARGB(255, 7, 59, 120),
                            //                   Color.fromARGB(255, 7, 59, 120)
                            //                 ],
                            //               )),
                            //           child: const Row(children: [
                            //             Align(
                            //               alignment: Alignment.centerLeft,
                            //               child: Text(
                            //                 "(+) Add Current Progress",
                            //                 textAlign: TextAlign.left,
                            //                 style: TextStyle(
                            //                   color: Colors.white,
                            //                   fontWeight: FontWeight.bold,
                            //                   fontSize: 20,
                            //                 ),
                            //               ),
                            //             ),
                            //           ]),
                            //         ),
                            //         Column(
                            //           children: [
                            //             (contractorRowMaintenanceProgressViewModelViewModel
                            //                         .contractorRowMaintenanceProgressViewModelGetTabularData
                            //                         .data!
                            //                         .findAllByTokenNumbers!
                            //                         .isNotEmpty &&
                            //                     contractorRowMaintenanceProgressViewModelViewModel
                            //                             .contractorRowMaintenanceProgressViewModelGetTabularData
                            //                             .data!
                            //                             .findAllByTokenNumbers !=
                            //                         null &&
                            //                     contractorRowMaintenanceProgressViewModelViewModel
                            //                         .contractorRowMaintenanceProgressViewModelGetTabularData
                            //                         .data!
                            //                         .findAllByTokenNumbers![0]
                            //                         .totalMiles!
                            //                         .isNotEmpty &&
                            //                     contractorRowMaintenanceProgressViewModelViewModel
                            //                             .contractorRowMaintenanceProgressViewModelGetTabularData
                            //                             .data!
                            //                             .findAllByTokenNumbers![
                            //                                 0]
                            //                             .totalMiles !=
                            //                         null &&
                            //                     contractorRowMaintenanceProgressViewModelViewModel
                            //                             .contractorRowMaintenanceProgressViewModelGetTabularData
                            //                             .data!
                            //                             .findAllByTokenNumbers![
                            //                                 0]
                            //                             .milesCompleted !=
                            //                         null &&
                            //                     (double.parse(contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.findAllByTokenNumbers![0].totalMiles.toString()) ==
                            //                         double.parse(
                            //                             contractorRowMaintenanceProgressViewModelViewModel
                            //                                 .contractorRowMaintenanceProgressViewModelGetTabularData
                            //                                 .data!
                            //                                 .findAllByTokenNumbers![0]
                            //                                 .milesCompleted
                            //                                 .toString())) &&
                            //                     flagEdit == 0)
                            //                 ? const Align(
                            //                     alignment: Alignment.centerLeft,
                            //                     child: Padding(
                            //                       padding: EdgeInsets.only(
                            //                           left: 2.0,
                            //                           right: 2.0,
                            //                           bottom: 2.0,
                            //                           top: 20.0),
                            //                       child: Text(
                            //                         "Your MILES are already COMPLETED!",
                            //                         style: TextStyle(
                            //                           fontSize: 16.0,
                            //                           color: Colors.red,
                            //                           fontWeight:
                            //                               FontWeight.bold,
                            //                         ),
                            //                       ),
                            //                     ))
                            //                 : const Text(
                            //                     "",
                            //                     style: TextStyle(
                            //                       fontSize: 0.0,
                            //                       color: Colors.white,
                            //                       fontWeight: FontWeight.bold,
                            //                     ),
                            //                   ),
                            //             Visibility(
                            //               visible: _isVisibleExceed,
                            //               child: const Align(
                            //                   alignment: Alignment.centerLeft,
                            //                   child: Padding(
                            //                     padding: EdgeInsets.only(
                            //                         left: 2.0,
                            //                         right: 2.0,
                            //                         bottom: 2.0,
                            //                         top: 20.0),
                            //                     child: Text(
                            //                       "Entered MILES cannot exceed TOTAL MILES!",
                            //                       style: TextStyle(
                            //                         fontSize: 16.0,
                            //                         color: Colors.red,
                            //                         fontWeight: FontWeight.bold,
                            //                       ),
                            //                     ),
                            //                   )),
                            //             ),
                            //             const Align(
                            //                 alignment: Alignment.centerLeft,
                            //                 child: Padding(
                            //                   padding: EdgeInsets.only(
                            //                       left: 2.0,
                            //                       right: 2.0,
                            //                       bottom: 2.0,
                            //                       top: 20.0),
                            //                   child: Text(
                            //                     "ROW METHOD*",
                            //                     style: TextStyle(
                            //                       fontSize: 16.0,
                            //                       color: Color.fromARGB(
                            //                           255, 7, 59, 120),
                            //                       fontWeight: FontWeight.bold,
                            //                     ),
                            //                   ),
                            //                 )),
                            //             Align(
                            //               alignment: Alignment.centerLeft,
                            //               child: Padding(
                            //                 padding: const EdgeInsets.all(2.0),
                            //                 child: Container(
                            //                   padding:
                            //                       const EdgeInsets.symmetric(
                            //                           horizontal: 12,
                            //                           vertical: 4),
                            //                   decoration: BoxDecoration(
                            //                     // borderRadius:
                            //                     //     BorderRadius.circular(25),
                            //                     border: Border.all(
                            //                       color: const Color.fromARGB(
                            //                           255, 7, 59, 120),
                            //                     ),
                            //                   ),
                            //                   child: MultiSelectDialogField(
                            //                     initialValue: rowMethodNew,
                            //                     items: select_rowMethod
                            //                         .map((e) =>
                            //                             MultiSelectItem(e, e))
                            //                         .toList(),
                            //                     listType:
                            //                         MultiSelectListType.CHIP,
                            //                     onConfirm:
                            //                         (List<dynamic> value) {
                            //                       // Use List<dynamic> as the type
                            //                       setState(() {
                            //                         rowMethod =
                            //                             value.join(', ');
                            //                         // types.add(
                            //                         //     value.toString());
                            //                       });
                            //                       print(
                            //                           'rowMethod $rowMethod'); // This should print the selected values
                            //                     },
                            //                     validator: (value) {
                            //                       if (value == null ||
                            //                           value.isEmpty) {
                            //                         return 'Field required';
                            //                       }
                            //                       return null;
                            //                     },
                            //                   ),
                            //                 ),
                            //               ),
                            //             ),
                            //             const Align(
                            //                 alignment: Alignment.centerLeft,
                            //                 child: Padding(
                            //                   padding: EdgeInsets.only(
                            //                       left: 2.0,
                            //                       right: 2.0,
                            //                       bottom: 2.0,
                            //                       top: 20.0),
                            //                   child: Text(
                            //                     "MILES COMPLETED*",
                            //                     style: TextStyle(
                            //                       fontSize: 16.0,
                            //                       color: Color.fromARGB(
                            //                           255, 7, 59, 120),
                            //                       fontWeight: FontWeight.bold,
                            //                     ),
                            //                   ),
                            //                 )),
                            //             Align(
                            //               alignment: Alignment.centerRight,
                            //               child: Padding(
                            //                 padding: const EdgeInsets.all(2.0),
                            //                 child: TextFormField(
                            //                   //key: formkey4,
                            //                   controller: _milesCompleted2,
                            //                   style: const TextStyle(
                            //                       color: Color.fromARGB(
                            //                           255, 7, 59, 120),
                            //                       fontSize: 16),
                            //                   obscureText: false,
                            //                   // keyboardType: TextInputType.number,
                            //                   keyboardType: const TextInputType
                            //                       .numberWithOptions(
                            //                     decimal: true,
                            //                     signed: false,
                            //                   ),
                            //                   decoration: const InputDecoration(
                            //                     border: OutlineInputBorder(
                            //                         // borderRadius:
                            //                         // BorderRadius.circular(25),
                            //                         ),
                            //                     enabledBorder:
                            //                         OutlineInputBorder(
                            //                       borderSide: BorderSide(
                            //                         color: Color.fromARGB(
                            //                             255, 7, 59, 120),
                            //                       ),
                            //                       // borderRadius:
                            //                       // BorderRadius.circular(25),
                            //                     ),
                            //                     hintText: 'Miles Completed',
                            //                   ),
                            //                   onChanged: (value) {
                            //                     setState(() {
                            //                       if (_milesCompleted2.text == '' ||
                            //                           (flagEdit == 0 &&
                            //                               contractorRowMaintenanceProgressViewModelViewModel
                            //                                   .contractorRowMaintenanceProgressViewModelGetTabularData
                            //                                   .data!
                            //                                   .findAllByTokenNumbers!
                            //                                   .isNotEmpty &&
                            //                               contractorRowMaintenanceProgressViewModelViewModel
                            //                                       .contractorRowMaintenanceProgressViewModelGetTabularData
                            //                                       .data!
                            //                                       .findAllByTokenNumbers !=
                            //                                   null &&
                            //                               contractorRowMaintenanceProgressViewModelViewModel
                            //                                   .contractorRowMaintenanceProgressViewModelGetTabularData
                            //                                   .data!
                            //                                   .findAllByTokenNumbers![
                            //                                       0]
                            //                                   .totalMiles!
                            //                                   .isNotEmpty &&
                            //                               contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.findAllByTokenNumbers![0].totalMiles !=
                            //                                   null &&
                            //                               contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.findAllByTokenNumbers![0].milesCompleted !=
                            //                                   null &&
                            //                               (double.parse((double.parse(_milesCompleted2.text.toString()) + double.parse(contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.findAllByTokenNumbers![0].milesCompleted.toString()) + double.parse(contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.findAllByTokenNumbers![0].milesInProgress.toString())).toStringAsFixed(2)) <
                            //                                   double.parse(
                            //                                       contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.findAllByTokenNumbers![0].totalMiles
                            //                                           .toString()))) ||
                            //                           (flagEdit == 0 &&
                            //                               contractorRowMaintenanceProgressViewModelViewModel
                            //                                   .contractorRowMaintenanceProgressViewModelGetTabularData
                            //                                   .data!
                            //                                   .findAllByTokenNumbers!
                            //                                   .isNotEmpty &&
                            //                               contractorRowMaintenanceProgressViewModelViewModel
                            //                                       .contractorRowMaintenanceProgressViewModelGetTabularData
                            //                                       .data!
                            //                                       .findAllByTokenNumbers !=
                            //                                   null &&
                            //                               contractorRowMaintenanceProgressViewModelViewModel
                            //                                   .contractorRowMaintenanceProgressViewModelGetTabularData
                            //                                   .data!
                            //                                   .findAllByTokenNumbers![0]
                            //                                   .totalMiles!
                            //                                   .isNotEmpty &&
                            //                               contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.findAllByTokenNumbers![0].totalMiles != null &&
                            //                               contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.findAllByTokenNumbers![0].milesCompleted != null &&
                            //                               (double.parse((double.parse(_milesCompleted2.text.toString()) + double.parse(contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.findAllByTokenNumbers![0].milesCompleted.toString()) + double.parse(contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.findAllByTokenNumbers![0].milesInProgress.toString())).toStringAsFixed(2)) == double.parse(contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.findAllByTokenNumbers![0].totalMiles.toString())))) {
                            //                         print(
                            //                             'value.............. $value');
                            //                         setState(() {
                            //                           _isVisibleExceed = false;
                            //                         });
                            //                       } else if ((flagEdit == 0 && contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.findAllByTokenNumbers!.isNotEmpty && contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.findAllByTokenNumbers != null && contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.findAllByTokenNumbers![0].totalMiles!.isNotEmpty && contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.findAllByTokenNumbers![0].totalMiles != null && contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.findAllByTokenNumbers![0].milesCompleted != null && (double.parse((double.parse(_milesCompleted2.text.toString()) + double.parse(contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.findAllByTokenNumbers![0].milesCompleted.toString()) + double.parse(contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.findAllByTokenNumbers![0].milesInProgress.toString())).toStringAsFixed(2)) > double.parse(contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.findAllByTokenNumbers![0].totalMiles.toString())))) {
                            //                         _isVisibleExceed = true;
                            //                       } else if (_milesCompleted2.text == '' || (flagEdit == 1 && contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.findAllByTokenNumbers!.isNotEmpty && contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.findAllByTokenNumbers != null && contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.findAllByTokenNumbers![0].totalMiles!.isNotEmpty && contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.findAllByTokenNumbers![0].totalMiles != null && contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.findAllByTokenNumbers![0].milesCompleted != null && (double.parse((double.parse(_milesCompleted2.text.toString()) + double.parse(contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.findAllByTokenNumbers![0].milesCompleted.toString()) + double.parse(contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.findAllByTokenNumbers![0].milesInProgress.toString())).toStringAsFixed(2)) - double.parse(previousMilesCompleted) < double.parse(contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.findAllByTokenNumbers![0].totalMiles.toString()))) || (flagEdit == 1 && contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.findAllByTokenNumbers!.isNotEmpty && contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.findAllByTokenNumbers != null && contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.findAllByTokenNumbers![0].totalMiles!.isNotEmpty && contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.findAllByTokenNumbers![0].totalMiles != null && contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.findAllByTokenNumbers![0].milesCompleted != null && (double.parse((double.parse(_milesCompleted2.text.toString()) + double.parse(contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.findAllByTokenNumbers![0].milesCompleted.toString()) + double.parse(contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.findAllByTokenNumbers![0].milesInProgress.toString())).toStringAsFixed(2)) - double.parse(previousMilesCompleted) == double.parse(contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.findAllByTokenNumbers![0].totalMiles.toString())))) {
                            //                         print(
                            //                             'value.............. $value');
                            //                         setState(() {
                            //                           _isVisibleExceed = false;
                            //                         });
                            //                       } else if ((flagEdit == 1 && contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.findAllByTokenNumbers!.isNotEmpty && contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.findAllByTokenNumbers != null && contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.findAllByTokenNumbers![0].totalMiles!.isNotEmpty && contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.findAllByTokenNumbers![0].totalMiles != null && contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.findAllByTokenNumbers![0].milesCompleted != null && (double.parse((double.parse(_milesCompleted2.text.toString()) + double.parse(contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.findAllByTokenNumbers![0].milesCompleted.toString()) + double.parse(contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.findAllByTokenNumbers![0].milesInProgress.toString())).toStringAsFixed(2)) - double.parse(previousMilesCompleted) > double.parse(contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.findAllByTokenNumbers![0].totalMiles.toString())))) {
                            //                         _isVisibleExceed = true;
                            //                       }

                            //                       if (_isVisibleSubmitFormNewRecord ==
                            //                           true) {
                            //                         calculateMilesPending(
                            //                           double.parse(value),
                            //                           double.parse(
                            //                               _milesInProgress2
                            //                                   .text),
                            //                           _milesPending2,
                            //                         );
                            //                       } else {
                            //                         calculateMilesPendingDuringEdit(
                            //                           double.parse(value),
                            //                           double.parse(
                            //                               _milesInProgress2
                            //                                   .text),
                            //                           _milesPending2,
                            //                         );
                            //                       }
                            //                     });
                            //                   },
                            //                   validator: (value) {
                            //                     if (value!.isEmpty) {
                            //                       print('111111111111');
                            //                       return "Please enter Miles Completed";
                            //                     } else if (flagEdit == 0 &&
                            //                         double.parse((double.parse(value) + double.parse(contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.findAllByTokenNumbers![0].milesCompleted.toString()) + double.parse(contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.findAllByTokenNumbers![0].milesInProgress.toString())).toStringAsFixed(2)) >
                            //                             double.parse(
                            //                                 contractorRowMaintenanceProgressViewModelViewModel
                            //                                     .contractorRowMaintenanceProgressViewModelGetTabularData
                            //                                     .data!
                            //                                     .findAllByTokenNumbers![
                            //                                         0]
                            //                                     .totalMiles
                            //                                     .toString())) {
                            //                       print('12345678899');
                            //                       print(double.parse(value) +
                            //                           double.parse(
                            //                               contractorRowMaintenanceProgressViewModelViewModel
                            //                                   .contractorRowMaintenanceProgressViewModelGetTabularData
                            //                                   .data!
                            //                                   .findAllByTokenNumbers![
                            //                                       0]
                            //                                   .milesCompleted
                            //                                   .toString()) +
                            //                           double.parse(
                            //                               contractorRowMaintenanceProgressViewModelViewModel
                            //                                   .contractorRowMaintenanceProgressViewModelGetTabularData
                            //                                   .data!
                            //                                   .findAllByTokenNumbers![
                            //                                       0]
                            //                                   .milesInProgress
                            //                                   .toString()));
                            //                       print(double.parse(
                            //                           contractorRowMaintenanceProgressViewModelViewModel
                            //                               .contractorRowMaintenanceProgressViewModelGetTabularData
                            //                               .data!
                            //                               .findAllByTokenNumbers![
                            //                                   0]
                            //                               .totalMiles
                            //                               .toString()));
                            //                       return "Incorrect value in miles completed";
                            //                     } else if (flagEdit == 1 &&
                            //                         double.parse((double.parse(value) +
                            //                                     double.parse(contractorRowMaintenanceProgressViewModelViewModel
                            //                                         .contractorRowMaintenanceProgressViewModelGetTabularData
                            //                                         .data!
                            //                                         .findAllByTokenNumbers![0]
                            //                                         .milesCompleted
                            //                                         .toString()) +
                            //                                     double.parse(contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.findAllByTokenNumbers![0].milesInProgress.toString()) -
                            //                                     double.parse(previousMilesCompleted))
                            //                                 .toStringAsFixed(2)) >
                            //                             double.parse(contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.findAllByTokenNumbers![0].totalMiles.toString())) {
                            //                       print('12345678899');
                            //                       print(double.parse(value) +
                            //                           double.parse(
                            //                               contractorRowMaintenanceProgressViewModelViewModel
                            //                                   .contractorRowMaintenanceProgressViewModelGetTabularData
                            //                                   .data!
                            //                                   .findAllByTokenNumbers![
                            //                                       0]
                            //                                   .milesCompleted
                            //                                   .toString()) +
                            //                           double.parse(
                            //                               contractorRowMaintenanceProgressViewModelViewModel
                            //                                   .contractorRowMaintenanceProgressViewModelGetTabularData
                            //                                   .data!
                            //                                   .findAllByTokenNumbers![
                            //                                       0]
                            //                                   .milesInProgress
                            //                                   .toString()));
                            //                       print(double.parse(
                            //                           contractorRowMaintenanceProgressViewModelViewModel
                            //                               .contractorRowMaintenanceProgressViewModelGetTabularData
                            //                               .data!
                            //                               .findAllByTokenNumbers![
                            //                                   0]
                            //                               .totalMiles
                            //                               .toString()));
                            //                       return "Incorrect value in miles completed";
                            //                     }
                            //                     // try {
                            //                     // double parsedValue =
                            //                     // double.parse(value);
                            //                     // if (parsedValue % 1 != 0) {
                            //                     // return "Entered value should be an integer, not a float value";
                            //                     // }
                            //                     // } catch (e) {
                            //                     // return "Invalid input. Please enter a numeric value.";
                            //                     // }
                            //                     if (flagEdit == 0 &&
                            //                         double.parse(contractorRowMaintenanceProgressViewModelViewModel
                            //                                 .contractorRowMaintenanceProgressViewModelGetTabularData
                            //                                 .data!
                            //                                 .findAllByTokenNumbers![
                            //                                     0]
                            //                                 .totalMiles
                            //                                 .toString()) ==
                            //                             double.parse(
                            //                                 contractorRowMaintenanceProgressViewModelViewModel
                            //                                     .contractorRowMaintenanceProgressViewModelGetTabularData
                            //                                     .data!
                            //                                     .findAllByTokenNumbers![
                            //                                         0]
                            //                                     .milesCompleted
                            //                                     .toString())) {
                            //                       return "Your MILES are already COMPLETED!";
                            //                     } else {
                            //                       print(
                            //                           'success in validation');
                            //                       return null;
                            //                     }
                            //                   },
                            //                 ),
                            //               ),
                            //             ),
                            //             //new field added span completed
                            //             const Align(
                            //                 alignment: Alignment.centerLeft,
                            //                 child: Padding(
                            //                   padding: EdgeInsets.only(
                            //                       left: 2.0,
                            //                       right: 2.0,
                            //                       bottom: 2.0,
                            //                       top: 20.0),
                            //                   child: Text(
                            //                     "SPAN Completed*",
                            //                     style: TextStyle(
                            //                       fontSize: 16.0,
                            //                       color: Color.fromARGB(
                            //                           255, 7, 59, 120),
                            //                       fontWeight: FontWeight.bold,
                            //                     ),
                            //                   ),
                            //                 )),
                            //             Align(
                            //               alignment: Alignment.centerRight,
                            //               child: Padding(
                            //                 padding: const EdgeInsets.all(2.0),
                            //                 child: TextFormField(
                            //                   //key: formkey4,
                            //                   controller: _spanCompleted2,
                            //                   style: const TextStyle(
                            //                       color: Color.fromARGB(
                            //                           255, 7, 59, 120),
                            //                       fontSize: 16),
                            //                   obscureText: false,
                            //                   keyboardType:
                            //                       TextInputType.number,
                            //                   // keyboardType: const TextInputType
                            //                   //     .numberWithOptions(
                            //                   //   decimal: true,
                            //                   //   signed: false,
                            //                   // ),
                            //                   decoration: const InputDecoration(
                            //                     border: OutlineInputBorder(
                            //                         // borderRadius:
                            //                         // BorderRadius.circular(25),
                            //                         ),
                            //                     enabledBorder:
                            //                         OutlineInputBorder(
                            //                       borderSide: BorderSide(
                            //                         color: Color.fromARGB(
                            //                             255, 7, 59, 120),
                            //                       ),
                            //                       // borderRadius:
                            //                       // BorderRadius.circular(25),
                            //                     ),
                            //                     hintText: 'SPAN Completed',
                            //                   ),
                            //                   onChanged: (value) {},
                            //                   validator: (value) {
                            //                     if (value!.isEmpty) {
                            //                       return "Please enter SPAN Completed";
                            //                     }
                            //                   },
                            //                 ),
                            //               ),
                            //             ),

                            //             //------
                            //             const Align(
                            //                 alignment: Alignment.centerLeft,
                            //                 child: Padding(
                            //                   padding: EdgeInsets.only(
                            //                       left: 2.0,
                            //                       right: 2.0,
                            //                       bottom: 2.0,
                            //                       top: 20.0),
                            //                   child: Text(
                            //                     "MILES IN PROGRESS*",
                            //                     style: TextStyle(
                            //                       fontSize: 16.0,
                            //                       color: Color.fromARGB(
                            //                           255, 7, 59, 120),
                            //                       fontWeight: FontWeight.bold,
                            //                     ),
                            //                   ),
                            //                 )),
                            //             Align(
                            //               alignment: Alignment.centerRight,
                            //               child: Padding(
                            //                 padding: const EdgeInsets.all(2.0),
                            //                 child: TextFormField(
                            //                   //key: formkey4,
                            //                   controller: _milesInProgress2,
                            //                   style: const TextStyle(
                            //                       color: Color.fromARGB(
                            //                           255, 7, 59, 120),
                            //                       fontSize: 16),
                            //                   obscureText: false,
                            //                   // keyboardType: TextInputType.number,
                            //                   keyboardType: const TextInputType
                            //                       .numberWithOptions(
                            //                     decimal: true,
                            //                     signed: false,
                            //                   ),
                            //                   decoration: const InputDecoration(
                            //                     border: OutlineInputBorder(
                            //                         // borderRadius:
                            //                         // BorderRadius.circular(25),
                            //                         ),
                            //                     enabledBorder:
                            //                         OutlineInputBorder(
                            //                       borderSide: BorderSide(
                            //                         color: Color.fromARGB(
                            //                             255, 7, 59, 120),
                            //                       ),
                            //                       // borderRadius:
                            //                       // BorderRadius.circular(25),
                            //                     ),
                            //                     hintText: 'Miles In Progress',
                            //                   ),
                            //                   onChanged: (value) {
                            //                     setState(() {
                            //                       if (_isVisibleSubmitFormNewRecord ==
                            //                           true) {
                            //                         calculateMilesPending(
                            //                           double.parse(
                            //                               _milesCompleted2
                            //                                   .text),
                            //                           double.parse(value),
                            //                           _milesPending2,
                            //                         );
                            //                       } else {
                            //                         calculateMilesPendingDuringEdit(
                            //                           double.parse(
                            //                               _milesCompleted2
                            //                                   .text),
                            //                           double.parse(value),
                            //                           _milesPending2,
                            //                         );
                            //                       }
                            //                     });
                            //                   },
                            //                   validator: (value) {
                            //                     if (value!.isEmpty) {
                            //                       return "Please enter Miles In Progress";
                            //                     }
                            //                     // try {
                            //                     // double parsedValue =
                            //                     // double.parse(value);
                            //                     // if (parsedValue % 1 != 0) {
                            //                     // return "Entered value should be an integer, not a float value";
                            //                     // }
                            //                     // } catch (e) {
                            //                     // return "Invalid input. Please enter a numeric value.";
                            //                     // }
                            //                     // ;
                            //                     // return null;
                            //                   },
                            //                 ),
                            //               ),
                            //             ),
                            //             const Align(
                            //                 alignment: Alignment.centerLeft,
                            //                 child: Padding(
                            //                   padding: EdgeInsets.only(
                            //                       left: 2.0,
                            //                       right: 2.0,
                            //                       bottom: 2.0,
                            //                       top: 20.0),
                            //                   child: Text(
                            //                     "MILES PENDING*",
                            //                     style: TextStyle(
                            //                       fontSize: 16.0,
                            //                       color: Color.fromARGB(
                            //                           255, 7, 59, 120),
                            //                       fontWeight: FontWeight.bold,
                            //                     ),
                            //                   ),
                            //                 )),
                            //             Align(
                            //               alignment: Alignment.centerRight,
                            //               child: Padding(
                            //                 padding: const EdgeInsets.all(2.0),
                            //                 child: TextFormField(
                            //                   // key: formkey5,
                            //                   enabled: false,
                            //                   controller: _milesPending2,
                            //                   style: const TextStyle(
                            //                       color: Color.fromARGB(
                            //                           255, 7, 59, 120),
                            //                       fontSize: 16),
                            //                   obscureText: false,
                            //                   // keyboardType: TextInputType.number,
                            //                   keyboardType: const TextInputType
                            //                       .numberWithOptions(
                            //                     decimal: true,
                            //                     signed: false,
                            //                   ),
                            //                   decoration: const InputDecoration(
                            //                     border: OutlineInputBorder(
                            //                         // borderRadius:
                            //                         // BorderRadius.circular(25),
                            //                         ),
                            //                     disabledBorder:
                            //                         OutlineInputBorder(
                            //                       borderSide: BorderSide(
                            //                         color: Color.fromARGB(
                            //                             255, 7, 59, 120),
                            //                       ),
                            //                       // borderRadius:
                            //                       // BorderRadius.circular(25),
                            //                     ),
                            //                     hintText: 'Miles Pending',
                            //                   ),
                            //                   validator: (value) {
                            //                     if (value!.isEmpty) {
                            //                       return "Please enter Miles Pending";
                            //                     } else {
                            //                       return null;
                            //                     }
                            //                   },
                            //                 ),
                            //               ),
                            //             ),
                            //             Column(
                            //               children: [
                            //                 Visibility(
                            //                   visible: _isVisibleUpdateMap,
                            //                   child: Container(
                            //                       margin: const EdgeInsets.only(
                            //                         top: 10.0,
                            //                       ),
                            //                       child: InkWell(
                            //                         onTap: () async {
                            //                           String id = '';
                            //                           final userPreferences1 =
                            //                               Provider.of<UserPref>(
                            //                                   context,
                            //                                   listen: false);
                            //                           UserModel data =
                            //                               await userPreferences1
                            //                                   .getUser();
                            //                           id = data.user!.id
                            //                               .toString();
                            //                           //  Navigator.push(
                            //                           //                               context,
                            //                           //                               MaterialPageRoute(
                            //                           //                                 builder: (context) =>
                            //                           //                                     MapViewPage(
                            //                           //                                   url: MapUrl
                            //                           //                                               .getCrewWithWorkOrderNoEndPoint(
                            //                           //                                                   selectedChangeOrderNo,id),
                            //                           //                                 ),
                            //                           //                               ),
                            //                           //                             );
                            //                           await browser.open(
                            //                               url: WebUri(MapUrl
                            //                                   .getCrewWithWorkOrderNoEndPoint(
                            //                                       selectedChangeOrderNo,
                            //                                       id)),
                            //                               // "https://mapapi.ariespro.com/main/crew/CIVM_Map/$selectedChangeOrderNo/USRQWXH589Z"),
                            //                               settings: ChromeSafariBrowserSettings(
                            //                                   shareState:
                            //                                       CustomTabsShareState
                            //                                           .SHARE_STATE_OFF,
                            //                                   barCollapsingEnabled:
                            //                                       true));
                                                      
                            //           //                  Navigator.push(
                            //           //   context,
                            //           //   MaterialPageRoute(
                            //           //     builder: (context) => MapScreenCrew(
                            //           //       jobNo: widget.jobNo,
                            //           //       substation: widget.substation,
                            //           //       feeder: widget.feeder.split('(')
                            //           //           .first
                            //           //           .trim(),
                            //           //       year: getYearOrNA(
                            //           //         widget.nextMaintDue,
                            //           //       ),
                            //           //     ),
                            //           //   ),
                            //           // );
                            //                         },
                            //                         child: Container(
                            //                           margin:
                            //                               const EdgeInsets.only(
                            //                                   left: 40,
                            //                                   right: 40,
                            //                                   bottom: 10.0),
                            //                           // padding: const EdgeInsets.all(8),
                            //                           alignment:
                            //                               Alignment.center,
                            //                           width:
                            //                               MediaQuery.of(context)
                            //                                   .size
                            //                                   .width,
                            //                           height: 40,
                            //                           decoration: const BoxDecoration(
                            //                               // shape: BoxShape.circle,
                            //                               // borderRadius:
                            //                               // BorderRadius.circular(25),
                            //                               boxShadow: [
                            //                                 BoxShadow(
                            //                                     color: Color
                            //                                         .fromARGB(
                            //                                             255,
                            //                                             3,
                            //                                             47,
                            //                                             97),
                            //                                     blurRadius: 5,
                            //                                     offset: Offset(
                            //                                         2.0, 5.0))
                            //                               ],
                            //                               gradient: LinearGradient(
                            //                                 colors: [
                            //                                   Color.fromARGB(
                            //                                       255,
                            //                                       7,
                            //                                       59,
                            //                                       120),
                            //                                   Color.fromARGB(
                            //                                       255,
                            //                                       7,
                            //                                       59,
                            //                                       120)
                            //                                 ],
                            //                               )),
                            //                           child:
                            //                               const Row(children: [
                            //                             Expanded(
                            //                               child: Align(
                            //                                 alignment: Alignment
                            //                                     .center,
                            //                                 child: Text(
                            //                                   "UPDATE MAP",
                            //                                   textAlign:
                            //                                       TextAlign
                            //                                           .left,
                            //                                   style: TextStyle(
                            //                                     color: Colors
                            //                                         .white,
                            //                                     fontWeight:
                            //                                         FontWeight
                            //                                             .bold,
                            //                                     fontSize: 20,
                            //                                   ),
                            //                                 ),
                            //                               ),
                            //                             ),
                            //                           ]),
                            //                         ),
                            //                       )),
                            //                 ),
                            //                 Visibility(
                            //                   visible: _isVisibleMixingForm,
                            //                   child: Column(
                            //                     children: [
                            //                       Padding(
                            //                         padding:
                            //                             const EdgeInsets.only(
                            //                                 top: 2.0),
                            //                         child: Align(
                            //                           alignment:
                            //                               Alignment.topLeft,
                            //                           child: InkWell(
                            //                             onTap: () {
                            //                               Navigator.of(context).push(
                            //                                   MaterialPageRoute(
                            //                                       builder: (BuildContext
                            //                                               context) =>
                            //                                           CrewEditDailyHerbicideApplicationContractor(
                            //                                               id: selectedChangeOrderNo)));
                            //                             },
                            //                             child: Container(
                            //                               margin:
                            //                                   const EdgeInsets
                            //                                       .only(
                            //                                       left: 40,
                            //                                       right: 40,
                            //                                       bottom: 10.0),
                            //                               // padding: const EdgeInsets.all(8),
                            //                               alignment:
                            //                                   Alignment.center,
                            //                               width: MediaQuery.of(
                            //                                       context)
                            //                                   .size
                            //                                   .width,
                            //                               height: 40,
                            //                               decoration:
                            //                                   const BoxDecoration(
                            //                                       // shape: BoxShape.circle,
                            //                                       // borderRadius:
                            //                                       // BorderRadius.circular(25),
                            //                                       boxShadow: [
                            //                                     BoxShadow(
                            //                                         color: Color
                            //                                             .fromARGB(
                            //                                                 255,
                            //                                                 3,
                            //                                                 47,
                            //                                                 97),
                            //                                         blurRadius:
                            //                                             5,
                            //                                         offset:
                            //                                             Offset(
                            //                                                 2.0,
                            //                                                 5.0))
                            //                                   ],
                            //                                       gradient:
                            //                                           LinearGradient(
                            //                                         colors: [
                            //                                           Color.fromARGB(
                            //                                               255,
                            //                                               7,
                            //                                               59,
                            //                                               120),
                            //                                           Color.fromARGB(
                            //                                               255,
                            //                                               7,
                            //                                               59,
                            //                                               120)
                            //                                         ],
                            //                                       )),
                            //                               child: const Align(
                            //                                 alignment: Alignment
                            //                                     .center,
                            //                                 child: Text(
                            //                                   "DAILY HERBICIDE",
                            //                                   textAlign:
                            //                                       TextAlign
                            //                                           .left,
                            //                                   style: TextStyle(
                            //                                     color: Colors
                            //                                         .white,
                            //                                     fontWeight:
                            //                                         FontWeight
                            //                                             .bold,
                            //                                     fontSize: 20,
                            //                                   ),
                            //                                 ),
                            //                               ),
                            //                             ),
                            //                           ),
                            //                         ),
                            //                       ),
                            //                       Padding(
                            //                         padding:
                            //                             const EdgeInsets.only(
                            //                                 top: 2.0),
                            //                         child: Align(
                            //                           alignment:
                            //                               Alignment.topLeft,
                            //                           child: InkWell(
                            //                             onTap: () {
                            //                               Navigator.of(context).push(
                            //                                   MaterialPageRoute(
                            //                                       builder: (BuildContext
                            //                                               context) =>
                            //                                           CrewEditIVMTimeSheetContractor(
                            //                                               id: selectedChangeOrderNo)));
                            //                             },
                            //                             child: Container(
                            //                               margin:
                            //                                   const EdgeInsets
                            //                                       .only(
                            //                                       left: 40,
                            //                                       right: 40,
                            //                                       bottom: 10.0),
                            //                               // padding: const EdgeInsets.all(8),
                            //                               alignment:
                            //                                   Alignment.center,
                            //                               width: MediaQuery.of(
                            //                                       context)
                            //                                   .size
                            //                                   .width,
                            //                               height: 40,
                            //                               decoration:
                            //                                   const BoxDecoration(
                            //                                       // shape: BoxShape.circle,
                            //                                       // borderRadius:
                            //                                       // BorderRadius.circular(25),
                            //                                       boxShadow: [
                            //                                     BoxShadow(
                            //                                         color: Color
                            //                                             .fromARGB(
                            //                                                 255,
                            //                                                 3,
                            //                                                 47,
                            //                                                 97),
                            //                                         blurRadius:
                            //                                             5,
                            //                                         offset:
                            //                                             Offset(
                            //                                                 2.0,
                            //                                                 5.0))
                            //                                   ],
                            //                                       gradient:
                            //                                           LinearGradient(
                            //                                         colors: [
                            //                                           Color.fromARGB(
                            //                                               255,
                            //                                               7,
                            //                                               59,
                            //                                               120),
                            //                                           Color.fromARGB(
                            //                                               255,
                            //                                               7,
                            //                                               59,
                            //                                               120)
                            //                                         ],
                            //                                       )),
                            //                               child: const Align(
                            //                                 alignment: Alignment
                            //                                     .center,
                            //                                 child: Text(
                            //                                   "IVM TIMESHEET",
                            //                                   textAlign:
                            //                                       TextAlign
                            //                                           .left,
                            //                                   style: TextStyle(
                            //                                     color: Colors
                            //                                         .white,
                            //                                     fontWeight:
                            //                                         FontWeight
                            //                                             .bold,
                            //                                     fontSize: 20,
                            //                                   ),
                            //                                 ),
                            //                               ),
                            //                             ),
                            //                           ),
                            //                         ),
                            //                       ),
                            //                       Padding(
                            //                         padding:
                            //                             const EdgeInsets.only(
                            //                                 top: 2.0),
                            //                         child: Align(
                            //                           alignment:
                            //                               Alignment.topLeft,
                            //                           child: InkWell(
                            //                             onTap: () {
                            //                               Navigator.of(context).push(
                            //                                   MaterialPageRoute(
                            //                                       builder: (BuildContext
                            //                                               context) =>
                            //                                           CrewEditMixingInventoryContractor(
                            //                                               id: selectedChangeOrderNo)));
                            //                             },
                            //                             child: Container(
                            //                               margin:
                            //                                   const EdgeInsets
                            //                                       .only(
                            //                                       left: 40,
                            //                                       right: 40,
                            //                                       bottom: 10.0),
                            //                               // padding: const EdgeInsets.all(8),
                            //                               alignment:
                            //                                   Alignment.center,
                            //                               width: MediaQuery.of(
                            //                                       context)
                            //                                   .size
                            //                                   .width,
                            //                               height: 40,
                            //                               decoration:
                            //                                   const BoxDecoration(
                            //                                       // shape: BoxShape.circle,
                            //                                       // borderRadius:
                            //                                       // BorderRadius.circular(25),
                            //                                       boxShadow: [
                            //                                     BoxShadow(
                            //                                         color: Color
                            //                                             .fromARGB(
                            //                                                 255,
                            //                                                 3,
                            //                                                 47,
                            //                                                 97),
                            //                                         blurRadius:
                            //                                             5,
                            //                                         offset:
                            //                                             Offset(
                            //                                                 2.0,
                            //                                                 5.0))
                            //                                   ],
                            //                                       gradient:
                            //                                           LinearGradient(
                            //                                         colors: [
                            //                                           Color.fromARGB(
                            //                                               255,
                            //                                               7,
                            //                                               59,
                            //                                               120),
                            //                                           Color.fromARGB(
                            //                                               255,
                            //                                               7,
                            //                                               59,
                            //                                               120)
                            //                                         ],
                            //                                       )),
                            //                               child: const Align(
                            //                                 alignment: Alignment
                            //                                     .center,
                            //                                 child: Text(
                            //                                   "MIXING INVENTORY",
                            //                                   textAlign:
                            //                                       TextAlign
                            //                                           .left,
                            //                                   style: TextStyle(
                            //                                     color: Colors
                            //                                         .white,
                            //                                     fontWeight:
                            //                                         FontWeight
                            //                                             .bold,
                            //                                     fontSize: 20,
                            //                                   ),
                            //                                 ),
                            //                               ),
                            //                             ),
                            //                           ),
                            //                         ),
                            //                       ),
                            //                     ],
                            //                   ),
                            //                 ),
                            //               ],
                            //             ),
                            //             Padding(
                            //               padding:
                            //                   const EdgeInsets.only(top: 2.0),
                            //               child: Align(
                            //                 alignment: Alignment.bottomLeft,
                            //                 child: Container(
                            //                   margin: const EdgeInsets.only(
                            //                       left: 40,
                            //                       right: 40,
                            //                       bottom: 10.0),
                            //                   // padding: const EdgeInsets.all(8),
                            //                   alignment: Alignment.center,
                            //                   width: MediaQuery.of(context)
                            //                       .size
                            //                       .width,
                            //                   height: 40,
                            //                   decoration: const BoxDecoration(
                            //                       // shape: BoxShape.circle,
                            //                       // borderRadius:
                            //                       // BorderRadius.circular(25),
                            //                       boxShadow: [
                            //                         BoxShadow(
                            //                             color: Color.fromARGB(
                            //                                 255, 3, 47, 97),
                            //                             blurRadius: 5,
                            //                             offset:
                            //                                 Offset(2.0, 5.0))
                            //                       ],
                            //                       gradient: LinearGradient(
                            //                         colors: [
                            //                           Color.fromARGB(
                            //                               255, 7, 59, 120),
                            //                           Color.fromARGB(
                            //                               255, 7, 59, 120)
                            //                         ],
                            //                       )),
                            //                   child: InkWell(
                            //                       onTap: () async {
                            //                         // pickImageOptions();
                            //                         _takePictureDialog();
                            //                       },
                            //                       child: const Text(
                            //                         'CAMERA',
                            //                         style: TextStyle(
                            //                             fontSize: 18,
                            //                             color: Colors.white,
                            //                             fontWeight:
                            //                                 FontWeight.bold),
                            //                       )),
                            //                 ),
                            //               ),
                            //             ),
                            //             Column(
                            //               children: [
                            //                 Padding(
                            //                   padding: const EdgeInsets.only(
                            //                       top: 2.0),
                            //                   child: Align(
                            //                     alignment: Alignment.bottomLeft,
                            //                     child: Container(
                            //                       margin: const EdgeInsets.only(
                            //                           left: 40,
                            //                           right: 40,
                            //                           bottom: 10.0),
                            //                       alignment: Alignment.center,
                            //                       width: MediaQuery.of(context)
                            //                           .size
                            //                           .width,
                            //                       height: 40,
                            //                       decoration:
                            //                           const BoxDecoration(
                            //                               boxShadow: [
                            //                             BoxShadow(
                            //                                 color:
                            //                                     Color.fromARGB(
                            //                                         255,
                            //                                         3,
                            //                                         47,
                            //                                         97),
                            //                                 blurRadius: 5,
                            //                                 offset: Offset(
                            //                                     2.0, 5.0))
                            //                           ],
                            //                               gradient:
                            //                                   LinearGradient(
                            //                                 colors: [
                            //                                   Color.fromARGB(
                            //                                       255,
                            //                                       7,
                            //                                       59,
                            //                                       120),
                            //                                   Color.fromARGB(
                            //                                       255,
                            //                                       7,
                            //                                       59,
                            //                                       120)
                            //                                 ],
                            //                               )),
                            //                       child: InkWell(
                            //                         onTap: () async {
                            //                           // await getVideoFile();
                            //                           Navigator.of(context)
                            //                               .push(
                            //                             MaterialPageRoute(
                            //                               builder: (context) =>
                            //                                   BlocProvider(
                            //                                 create: (context) {
                            //                                   return CameraBloc(
                            //                                     cameraUtils:
                            //                                         CameraUtils(),
                            //                                     permissionUtils:
                            //                                         PermissionUtils(),
                            //                                   )..add(const CameraInitialize(
                            //                                       recordingLimit:
                            //                                           15));
                            //                                 },
                            //                                 child: CameraPage(
                            //                                     callback:
                            //                                         (file) {
                            //                                   _videoController =
                            //                                       VideoPlayerController
                            //                                           .file(
                            //                                               file);
                            //                                   setState(() {
                            //                                     videoFlag = 1;
                            //                                   });
                            //                                   initializeVideo();
                            //                                   videoPath =
                            //                                       file.path;

                            //                                   print(
                            //                                       'Video path11111111111111: $videoPath');
                            //                                   print(
                            //                                       '_videoController22222222222222222 $_videoController');
                            //                                   // submitVideo(
                            //                                   //     _videoController
                            //                                   //         .toString(),
                            //                                   //     selectedChangeOrderNo!);
                            //                                 }),
                            //                               ),
                            //                             ),
                            //                           );
                            //                         },
                            //                         child: const Text(
                            //                           'CAPTURE VIDEO',
                            //                           style: TextStyle(
                            //                               fontSize: 18,
                            //                               color: Colors.white,
                            //                               fontWeight:
                            //                                   FontWeight.bold),
                            //                         ),
                            //                       ),
                            //                     ),
                            //                   ),
                            //                 ),
                            //                 // _controller != null &&
                            //                 //         _controller!.value.isInitialized
                            //                 //     ? AspectRatio(
                            //                 //         aspectRatio: _controller!
                            //                 //             .value.aspectRatio,
                            //                 //         child: VideoPlayer(_controller!),
                            //                 //       )
                            //                 //     : _videoFile == null
                            //                 //         ? const Text('')
                            //                 //         : const CircularProgressIndicator(),
                            //                 /////////////////////////////video visibility////////////////////////
                            //                 // Padding(
                            //                 //   padding: const EdgeInsets.only(
                            //                 //       top: 8.0, bottom: 8),
                            //                 //   child: InkWell(
                            //                 //     onTap: () {
                            //                 //       setState(() {
                            //                 //         // if (_isPlayVideoFlag != true) {
                            //                 //         //   _videoController.play();
                            //                 //         // } else {
                            //                 //         //   _videoController.pause();
                            //                 //         // }
                            //                 //         if (!_videoController
                            //                 //             .value.isPlaying) {
                            //                 //           _videoController
                            //                 //               .play(); // Play video on tap
                            //                 //         } else {
                            //                 //           _videoController
                            //                 //               .pause(); // Pause video on tap
                            //                 //         }
                            //                 //         _isPlayVideoFlag =
                            //                 //             _videoController.value
                            //                 //                 .isPlaying; // Update flag
                            //                 //       });
                            //                 //     },
                            //                 //     child: (videoFlag == 1)
                            //                 //         ? SizedBox(
                            //                 //             height: 200,
                            //                 //             width: 180,
                            //                 //             child: Transform.scale(
                            //                 //               scale: 1.1,
                            //                 //               child: Container(
                            //                 //                 color: Colors.white,
                            //                 //                 child: (videoFlag == 1)
                            //                 //                     ? VideoPlayer(
                            //                 //                         _videoController)
                            //                 //                     : const Text(''),
                            //                 //               ),
                            //                 //             ),
                            //                 //           )
                            //                 //         : const Text(''),
                            //                 //   ),
                            //                 // ),

                            //                 Padding(
                            //                   padding: const EdgeInsets.only(
                            //                       top: 8.0, bottom: 8),
                            //                   child: InkWell(
                            //                     onTap: () {
                            //                       // You can still allow video tap functionality here if needed
                            //                     },
                            //                     child: (videoFlag == 1)
                            //                         ? SizedBox(
                            //                             height: 200,
                            //                             width: 180,
                            //                             child: Stack(
                            //                               alignment: Alignment
                            //                                   .center, // Center the play/pause button
                            //                               children: [
                            //                                 Transform.scale(
                            //                                   scale: 1.1,
                            //                                   child: Container(
                            //                                     color: Colors
                            //                                         .white,
                            //                                     child: VideoPlayer(
                            //                                         _videoController),
                            //                                   ),
                            //                                 ),
                            //                                 // Display play/pause button over the video
                            //                                 IconButton(
                            //                                   iconSize:
                            //                                       48, // Adjust size as per your design
                            //                                   icon: Icon(
                            //                                     _videoController
                            //                                             .value
                            //                                             .isPlaying
                            //                                         ? Icons
                            //                                             .pause
                            //                                         : Icons
                            //                                             .play_arrow,
                            //                                     color: Colors
                            //                                         .white,
                            //                                   ),
                            //                                   onPressed: () {
                            //                                     setState(() {
                            //                                       if (_videoController
                            //                                           .value
                            //                                           .isPlaying) {
                            //                                         _videoController
                            //                                             .pause();
                            //                                       } else {
                            //                                         _videoController
                            //                                             .play();
                            //                                       }
                            //                                       _isPlayVideoFlag =
                            //                                           _videoController
                            //                                               .value
                            //                                               .isPlaying;
                            //                                     });
                            //                                   },
                            //                                 ),
                            //                               ],
                            //                             ),
                            //                           )
                            //                         : const Text(''),
                            //                   ),
                            //                 ),
                            //               ],
                            //             ),
                            //             Padding(
                            //               padding:
                            //                   const EdgeInsets.only(top: 8.0),
                            //               child: SingleChildScrollView(
                            //                 scrollDirection: Axis.horizontal,
                            //                 child: Row(
                            //                   children: List.generate(
                            //                       imagePaths.length, (index) {
                            //                     return Container(
                            //                       margin: const EdgeInsets
                            //                           .symmetric(horizontal: 5),
                            //                       width: 100,
                            //                       child: Stack(
                            //                         children: [
                            //                           Center(
                            //                             child: Image.file(
                            //                               File(imagePaths[
                            //                                   index]),
                            //                               height: 100,
                            //                               width: 100,
                            //                               fit: BoxFit.cover,
                            //                             ),
                            //                           ),
                            //                           Positioned(
                            //                             top: 0,
                            //                             right: 0,
                            //                             child: InkWell(
                            //                               onTap: () {
                            //                                 setState(() {
                            //                                   // Remove the image path from the list
                            //                                   imagePaths
                            //                                       .removeAt(
                            //                                           index);
                            //                                   images.removeAt(
                            //                                       index); // Also remove from images list
                            //                                 });
                            //                                 // Call your API to delete the image
                            //                                 deleteOnlineImageApi(
                            //                                     imagePaths[
                            //                                         index],
                            //                                     selectedChangeOrderNo);
                            //                               },
                            //                               child: const Icon(
                            //                                   Icons.delete,
                            //                                   color: Colors.red,
                            //                                   size: 30),
                            //                             ),
                            //                           ),
                            //                         ],
                            //                       ),
                            //                     );
                            //                   }),
                            //                 ),
                            //               ),
                            //             ),
                            //           ],
                            //         ),
                            //       ],
                            //     )),
                           
                            Container(
                                margin: const EdgeInsets.only(
                                    left: 8, right: 8, top: 10, bottom: 8),
                                padding: const EdgeInsets.all(8),
                                alignment: Alignment.center,
                                width: size.width * 0.99,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                                      BoxShadow(
                                          color:
                                              Color.fromARGB(255, 7, 59, 120),
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
                                    Column(
                                      children: [
        //                                 const Align(
        //                                     alignment: Alignment.centerLeft,
        //                                     child: Padding(
        //                                       padding: EdgeInsets.only(
        //                                           left: 2.0,
        //                                           right: 2.0,
        //                                           bottom: 2.0,
        //                                           top: 20.0),
        //                                       child: Text(
        //                                         "DELAY CAUSE",
        //                                         style: TextStyle(
        //                                           fontSize: 16.0,
        //                                           color: Color.fromARGB(
        //                                               255, 7, 59, 120),
        //                                           fontWeight: FontWeight.bold,
        //                                         ),
        //                                       ),
        //                                     )),
        //                                 Align(
        //                                   alignment: Alignment.centerLeft,
        //                                   child: Padding(
        //                                     padding: const EdgeInsets.all(2.0),
        //                                     child:
        //                                         DropdownButtonFormField<String>(
        //                                       hint: const Text('-Select-'),
        //                                       dropdownColor: Colors.white,
        //                                       value: delayCause,
        //                                       style: const TextStyle(
        //                                           color: Color.fromARGB(
        //                                               255, 7, 59, 120),
        //                                           fontSize: 16),
        //                                       icon: const Icon(
        //                                         Icons.arrow_drop_down,
        //                                         color: Color.fromARGB(
        //                                             255, 7, 59, 120),
        //                                         size: 40,
        //                                       ),
        //                                       decoration: const InputDecoration(
        //                                         enabledBorder:
        //                                             OutlineInputBorder(
        //                                           borderSide: BorderSide(
        //                                             color: Color.fromARGB(
        //                                                 255, 7, 59, 120),
        //                                           ),
        //                                         ),
        //                                         focusedBorder:
        //                                             OutlineInputBorder(
        //                                           borderSide: BorderSide(
        //                                             color: Color.fromARGB(
        //                                                 255, 7, 59, 120),
        //                                           ),
        //                                         ),
        //                                       ),
        //                                       isExpanded: true,
        //                                       items: select_delayCause
        //                                           .map(buildMenuItem)
        //                                           .toList(),
        //                                       onChanged: (value) {
        //                                         reason = null;
        //                                         setState(
        //                                             () => delayCause = value);
        //                                         dropDownValues();
        //                                       },
        //                                     ),
        //                                   ),
        //                                 ),
        //                                 const Align(
        //                                     alignment: Alignment.centerLeft,
        //                                     child: Padding(
        //                                       padding: EdgeInsets.only(
        //                                           left: 2.0,
        //                                           right: 2.0,
        //                                           bottom: 2.0,
        //                                           top: 20.0),
        //                                       child: Text(
        //                                         "REASON",
        //                                         style: TextStyle(
        //                                           fontSize: 16.0,
        //                                           color: Color.fromARGB(
        //                                               255, 7, 59, 120),
        //                                           fontWeight: FontWeight.bold,
        //                                         ),
        //                                       ),
        //                                     )),
        //                                 Align(
        //                                   alignment: Alignment.centerLeft,
        //                                   child: Padding(
        //                                     padding: const EdgeInsets.all(2.0),
        //                                     child:
        //                                         DropdownButtonFormField<String>(
        //                                       hint: const Text('-Select-'),
        //                                       dropdownColor: Colors.white,
        //                                       value: reason,
        //                                       style: const TextStyle(
        //                                           color: Color.fromARGB(
        //                                               255, 7, 59, 120),
        //                                           fontSize: 16),
        //                                       icon: const Icon(
        //                                         Icons.arrow_drop_down,
        //                                         color: Color.fromARGB(
        //                                             255, 7, 59, 120),
        //                                         size: 40,
        //                                       ),
        //                                       decoration: const InputDecoration(
        //                                         enabledBorder:
        //                                             OutlineInputBorder(
        //                                           borderSide: BorderSide(
        //                                             color: Color.fromARGB(
        //                                                 255, 7, 59, 120),
        //                                           ),
        //                                         ),
        //                                         focusedBorder:
        //                                             OutlineInputBorder(
        //                                           borderSide: BorderSide(
        //                                             color: Color.fromARGB(
        //                                                 255, 7, 59, 120),
        //                                           ),
        //                                         ),
        //                                       ),
        //                                       isExpanded: true,
        //                                       items: select_reason
        //                                           .map(buildMenuItem)
        //                                           .toList(),
        //                                       onChanged: (value) => setState(
        //                                           () => reason = value),
        //                                       // validator: (value) => value == null
        //                                       // ? 'field required'
        //                                       // : null,
        //                                     ),
        //                                   ),
        //                                 ),
        //                                 const Align(
        //                                     alignment: Alignment.centerLeft,
        //                                     child: Padding(
        //                                       padding: EdgeInsets.only(
        //                                           left: 2.0,
        //                                           right: 2.0,
        //                                           bottom: 2.0,
        //                                           top: 20.0),
        //                                       child: Text(
        //                                         "NOTES",
        //                                         style: TextStyle(
        //                                           fontSize: 16.0,
        //                                           color: Color.fromARGB(
        //                                               255, 7, 59, 120),
        //                                           fontWeight: FontWeight.bold,
        //                                         ),
        //                                       ),
        //                                     )),
        //                                 Align(
        //                                   alignment: Alignment.centerRight,
        //                                   child: Padding(
        //                                     padding: const EdgeInsets.all(2.0),
        //                                     child: TextFormField(
        //                                       controller: _notes,
        //                                       style: const TextStyle(
        //                                           color: Color.fromARGB(
        //                                               255, 7, 59, 120),
        //                                           fontSize: 16),
        //                                       obscureText: false,
        //                                       // keyboardType: TextInputType.number,
        //                                       decoration: const InputDecoration(
        //                                         border: OutlineInputBorder(),
        //                                         enabledBorder:
        //                                             OutlineInputBorder(
        //                                           borderSide: BorderSide(
        //                                             color: Color.fromARGB(
        //                                                 255, 7, 59, 120),
        //                                           ),
        //                                         ),
        //                                         hintText: 'Notes',
        //                                       ),
        //                                       validator: (value) {},
        //                                     ),
        //                                   ),
        //                                 ),
        //                                 const Align(
        //                                     alignment: Alignment.centerLeft,
        //                                     child: Padding(
        //                                       padding: EdgeInsets.only(
        //                                           left: 2.0,
        //                                           right: 2.0,
        //                                           bottom: 2.0,
        //                                           top: 20.0),
        //                                       child: Text(
        //                                         "AFFECTED DAYS",
        //                                         style: TextStyle(
        //                                           fontSize: 16.0,
        //                                           color: Color.fromARGB(
        //                                               255, 7, 59, 120),
        //                                           fontWeight: FontWeight.bold,
        //                                         ),
        //                                       ),
        //                                     )),
        //                                 Align(
        //                                   alignment: Alignment.centerRight,
        //                                   child: Padding(
        //                                     padding: const EdgeInsets.all(2.0),
        //                                     child: TextFormField(
        //                                       controller: _affectedDays,
        //                                       style: const TextStyle(
        //                                           color: Color.fromARGB(
        //                                               255, 7, 59, 120),
        //                                           fontSize: 16),
        //                                       obscureText: false,
        //                                       keyboardType:
        //                                           TextInputType.number,
        //                                       decoration: const InputDecoration(
        //                                         border: OutlineInputBorder(),
        //                                         enabledBorder:
        //                                             OutlineInputBorder(
        //                                           borderSide: BorderSide(
        //                                             color: Color.fromARGB(
        //                                                 255, 7, 59, 120),
        //                                           ),
        //                                         ),
        //                                         hintText: 'Affected Days',
        //                                       ),
        //                                       validator: (value) {
        //                                         try {
        //                                           double parsedValue =
        //                                               double.parse(value!);
        //                                           if (parsedValue % 1 != 0) {
        //                                             return "Entered value should be an integer, not a float value";
        //                                           }
        //                                         } catch (e) {
        //                                           return "Invalid input. Please enter a numeric value.";
        //                                         }
        //                                         return null;
        //                                       },
        //                                     ),
        //                                   ),
        //                                 ),
        // //                                 Visibility(
        //                                   visible:
        //                                       _isVisibleSubmitFormNewRecord,
        //                                   child: Column(
        //                                     children: [
        //                                       Visibility(
        //                                         visible: _isVisibleSubmitButton,
        //                                         child: Container(
        //                                             margin:
        //                                                 const EdgeInsets.only(
        //                                                     left: 6,
        //                                                     right: 6,
        //                                                     top: 10.0,
        //                                                     bottom: 10),
        //                                             child: InkWell(
        //                                               onTap: () async {
        //                                                 ////////////////////////
        //                                                 print(
        //                                                     'before formkey validation');
        //                                                 if (_formkey
        //                                                     .currentState!
        //                                                     .validate()) {
        //                                                   setState(() {
        //                                                     _isVisibleSubmittingButton =
        //                                                         true;
        //                                                     _isVisibleSubmitButton =
        //                                                         false;
        //                                                   });
        //                                                   print(
        //                                                       'after formkey validation');
        //                                                   // if (videoPath != '' ||
        //                                                   //     imagePaths
        //                                                   //         .isNotEmpty) {
        //                                                   //   print(
        //                                                   //       'if condition videoPath != '
        //                                                   //       ' ||imagePaths.isNotEmpty');
        //                                                   //   submitMediaFiles(
        //                                                   //       imagePaths,
        //                                                   //       videoPath,
        //                                                   //       selectedChangeOrderNo!);
        //                                                   //   // submitVideo(videoPath,
        //                                                   //   //     selectedChangeOrderNo!);
        //                                                   // } else {

        //                                                   print(
        //                                                       'else condition1222');

        //                                                   Map mapData = {
        //                                                     "tblSubMilesCostId":
        //                                                         (selectedChangeOrderNo ==
        //                                                                 null)
        //                                                             ? ''
        //                                                             : selectedChangeOrderNo,
        //                                                     "subStateName": widget
        //                                                         .substationId,
        //                                                     "feeder":
        //                                                         widget.feederId,
        //                                                     "street": "N/A",
        //                                                     "crew": crewName,
        //                                                     "totalMiles": (_totalMiles
        //                                                                 .text
        //                                                                 .toString() ==
        //                                                             'null')
        //                                                         ? ''
        //                                                         : double.parse(
        //                                                                 _totalMiles
        //                                                                     .text)
        //                                                             .toStringAsFixed(
        //                                                                 2),
        //                                                     "milesCompleted": double.parse(
        //                                                             _milesCompleted2
        //                                                                 .text
        //                                                                 .toString())
        //                                                         .toStringAsFixed(
        //                                                             2),
        //                                                     "milesInProgress": (_milesInProgress2
        //                                                                 .text
        //                                                                 .toString() ==
        //                                                             'null')
        //                                                         ? ''
        //                                                         : double.parse(
        //                                                                 _milesInProgress2
        //                                                                     .text)
        //                                                             .toStringAsFixed(
        //                                                                 2),
        //                                                     "milesPending": (_milesPending2
        //                                                                 .text
        //                                                                 .toString() ==
        //                                                             'null')
        //                                                         ? ''
        //                                                         : double.parse(
        //                                                                 _milesPending2
        //                                                                     .text)
        //                                                             .toStringAsFixed(
        //                                                                 2),
        //                                                     "performanceType":
        //                                                         'N/A',
        //                                                     "wtdProgress": 0.0,
        //                                                     "mtdProgress": 0.0,
        //                                                     "ytdProgress": 0.0,
        //                                                     "rowMethod":
        //                                                         rowMethod ?? '',
        //                                                     "delayCause":
        //                                                         delayCause ??
        //                                                             '',
        //                                                     "delayReason":
        //                                                         reason ?? '',
        //                                                     "effectedNoOfDays":
        //                                                         (_affectedDays
        //                                                                     .text
        //                                                                     .toString() ==
        //                                                                 'null')
        //                                                             ? 0
        //                                                             : _affectedDays
        //                                                                 .text
        //                                                                 .toString(),
        //                                                     "fileUpload": "N/A",
        //                                                     "createDate":
        //                                                         "2023-12-13T12:19:29.427+00:00",
        //                                                     // "status":
        //                                                     //     "PENDING",
        //                                                     "status":
        //                                                         "PENDING ZIELIES APPROVAL",
        //                                                     "notes": (_notes
        //                                                                 .text
        //                                                                 .toString() ==
        //                                                             'null')
        //                                                         ? 'N/A'
        //                                                         : _notes.text
        //                                                             .toString(),
        //                                                     "spanCompleted": (_spanCompleted2
        //                                                                 .text
        //                                                                 .toString() ==
        //                                                             'null')
        //                                                         ? 'N/A'
        //                                                         : _spanCompleted2
        //                                                             .text
        //                                                             .toString(),
        //                                                   };
        //                                                   print(
        //                                                       'API called.........');
        //                                                   // contractorRowMaintenanceProgressViewModelViewModel
        //                                                   //     .fetchRowMaintenanceProgressContractorSubmitListApi(
        //                                                   //         context,
        //                                                   //         mapData);
        //                                                   final response =
        //                                                       await contractorRowMaintenanceProgressViewModelViewModel
        //                                                           .fetchRowMaintenanceProgressContractorSubmitListApi(
        //                                                               context,
        //                                                               mapData);
        //                                                   //  Store ID
        //                                                   vegId = response.id;
        //                                                   //  Optional
        //                                                   print(
        //                                                       "Stored vegId: $vegId");
        //                                                   //  Now you have ID here
        //                                                   print(
        //                                                       "ID in Screen A: ${response.id}");
        //                                                   print('mapData');

        //                                                   print(
        //                                                       "${jsonEncode(mapData)}");
        //                                                   if (videoPath != '' ||
        //                                                       imagePaths
        //                                                           .isNotEmpty) {
        //                                                     print(
        //                                                         'if condition videoPath != '
        //                                                         ' ||imagePaths.isNotEmpty');
        //                                                     submitMediaFiles(
        //                                                         imagePaths,
        //                                                         videoPath,
        //                                                         selectedChangeOrderNo!);
        //                                                     // submitVideo(videoPath,
        //                                                     //     selectedChangeOrderNo!);
        //                                                   }
        //                                                    String id = '';
        // final userPreferences1 = Provider.of<UserPref>(context, listen: false);
        // UserModel data = await userPreferences1.getUser();
        // id = data.user!.id.toString();
        //   await addLog(
        //   context,
        //   "Miles Completed",
        //   "$crewName completed ${_milesCompleted2
        //                                                                 .text
        //                                                                 .toString()} miles.",
        //   int.parse(id.toString()),
        //   int.parse(selectedChangeOrderNo.toString()),
        // );
        //                                                   Future.delayed(
        //                                                       const Duration(
        //                                                           seconds: 5),
        //                                                       () {
        //                                                     Navigator.pop(
        //                                                         context);
        //                                                     Navigator.pop(
        //                                                         context);
        //                                                          Navigator.pop(
        //                                                         context);
        //                                                     // Navigator.pop(
        //                                                     //     context);
        //                                                   });

        //                                                   //  }
        //                                                   print('name1');
        //                                                 } else {
        //                                                   print(
        //                                                       "Please fill all mendetory fields!!!");
        //                                                   _showValidationErrorSnackBar(
        //                                                       context);
        //                                                 }
        //                                               },
        //                                               child: Container(
        //                                                 margin: const EdgeInsets
        //                                                     .only(
        //                                                     left: 40,
        //                                                     right: 40,
        //                                                     bottom: 10.0),
        //                                                 // padding: const EdgeInsets.all(8),
        //                                                 alignment:
        //                                                     Alignment.center,
        //                                                 // width: MediaQuery.of(
        //                                                 //         context)
        //                                                 //     .size
        //                                                 //     .width,
        //                                                 // height: 40,
        //                                                 decoration:
        //                                                     const BoxDecoration(
        //                                                         // borderRadius:
        //                                                         //     BorderRadius.circular(10),
        //                                                         boxShadow: [
        //                                                       BoxShadow(
        //                                                           color: Color
        //                                                               .fromARGB(
        //                                                                   255,
        //                                                                   3,
        //                                                                   47,
        //                                                                   97),
        //                                                           blurRadius: 5,
        //                                                           offset:
        //                                                               Offset(
        //                                                                   2.0,
        //                                                                   5.0))
        //                                                     ],
        //                                                         gradient:
        //                                                             LinearGradient(
        //                                                           colors: [
        //                                                             Color.fromARGB(
        //                                                                 255,
        //                                                                 7,
        //                                                                 59,
        //                                                                 120),
        //                                                             Color
        //                                                                 .fromARGB(
        //                                                                     255,
        //                                                                     7,
        //                                                                     59,
        //                                                                     120)
        //                                                           ],
        //                                                         )),
        //                                                 child: Align(
        //                                                   alignment:
        //                                                       Alignment
        //                                                           .center,
        //                                                   child: Padding(
        //                                                     padding: EdgeInsets.all(8.0),
        //                                                     child: FittedBox(
        //                                                     fit: BoxFit.scaleDown,
        //                                                       child: Text(
        //                                                         // "SUBMIT",
        //                                                         "SUBMIT COMPLETED JOB",
        //                                                         textAlign:
        //                                                             TextAlign
        //                                                                 .center,
        //                                                         style:
        //                                                             TextStyle(
        //                                                           color: Colors
        //                                                               .white,
        //                                                           fontWeight:
        //                                                               FontWeight
        //                                                                   .bold,
        //                                                           fontSize:
        //                                                               20,
        //                                                         ),
        //                                                       ),
        //                                                     ),
        //                                                   ),
        //                                                 ),
        //                                               ),
        //                                             )),
        //                                       ),
        //                                       Visibility(
        //                                         visible:
        //                                             _isVisibleSubmittingButton,
        //                                         child: Container(
        //                                             margin:
        //                                                 const EdgeInsets.only(
        //                                                     left: 6,
        //                                                     right: 6,
        //                                                     top: 10.0,
        //                                                     bottom: 10),
        //                                             child: Container(
        //                                               margin:
        //                                                   const EdgeInsets.only(
        //                                                       left: 40,
        //                                                       right: 40,
        //                                                       bottom: 10.0),
        //                                               // padding: const EdgeInsets.all(8),
        //                                               alignment:
        //                                                   Alignment.center,
        //                                               width:
        //                                                   MediaQuery.of(context)
        //                                                       .size
        //                                                       .width,
        //                                               height: 40,
        //                                               decoration:
        //                                                   const BoxDecoration(
        //                                                       // borderRadius:
        //                                                       //     BorderRadius.circular(10),
        //                                                       boxShadow: [
        //                                                     BoxShadow(
        //                                                         color: Color
        //                                                             .fromARGB(
        //                                                                 255,
        //                                                                 3,
        //                                                                 47,
        //                                                                 97),
        //                                                         blurRadius: 5,
        //                                                         offset: Offset(
        //                                                             2.0, 5.0))
        //                                                   ],
        //                                                       gradient:
        //                                                           LinearGradient(
        //                                                         colors: [
        //                                                           Color
        //                                                               .fromARGB(
        //                                                                   255,
        //                                                                   7,
        //                                                                   59,
        //                                                                   120),
        //                                                           Color
        //                                                               .fromARGB(
        //                                                                   255,
        //                                                                   7,
        //                                                                   59,
        //                                                                   120)
        //                                                         ],
        //                                                       )),
        //                                               child:
        //                                                   const Row(children: [
        //                                                 Expanded(
        //                                                   child: Align(
        //                                                     alignment: Alignment
        //                                                         .center,
        //                                                     child: Text(
        //                                                       "SUBMITTING...",
        //                                                       // "SAVING...",
        //                                                       textAlign:
        //                                                           TextAlign
        //                                                               .left,
        //                                                       style: TextStyle(
        //                                                         color: Colors
        //                                                             .white,
        //                                                         fontWeight:
        //                                                             FontWeight
        //                                                                 .bold,
        //                                                         fontSize: 20,
        //                                                       ),
        //                                                     ),
        //                                                   ),
        //                                                 ),
        //                                               ]),
        //                                             )),
        //                                       ),
        //                                     ],
        //                                   ),
        //                                 ),
        //                                 Visibility(
        //                                   visible: _isVisibleUpdateButton,
        //                                   child: Container(
        //                                       margin: const EdgeInsets.only(
        //                                           left: 6,
        //                                           right: 6,
        //                                           top: 10.0,
        //                                           bottom: 10),
        //                                       child: InkWell(
        //                                         onTap: () {
        //                                           print(
        //                                               'before formkey validation');
        //                                           if (_formkey.currentState!
        //                                               .validate()) {
        //                                             setState(() {
        //                                               _isVisibleUpdatingButton =
        //                                                   true;
        //                                               _isVisibleUpdateButton =
        //                                                   false;
        //                                             });
        //                                             print(
        //                                                 'after formkey validation');
        //                                             // if (videoPath != '' ||
        //                                             //     imagePaths.isNotEmpty) {
        //                                             //   print(
        //                                             //       'if condition videoPath != '
        //                                             //       ' ||imagePaths.isNotEmpty');
        //                                             //   submitMediaFilesEditOldRecord(
        //                                             //       imagePaths,
        //                                             //       videoPath,
        //                                             //       selectedChangeOrderNo!);
        //                                             //   // submitVideo(videoPath,
        //                                             //   //     selectedChangeOrderNo!);
        //                                             // }

        //                                             // else {
        //                                             print('else condition1222');

        //                                             Map mapDataEditOldRecord = {
        //                                               "tblSubMilesCostId":
        //                                                   tblSubMilesCostId,
        //                                               "subStateName":
        //                                                   subStateName,
        //                                               "feeder": feeder,
        //                                               "street": street,
        //                                               "crew": crew,
        //                                               "totalMiles": totalMiles,
        //                                               "milesCompleted":
        //                                                   _milesCompleted2.text
        //                                                       .toString(),
        //                                               "milesInProgress":
        //                                                   _milesInProgress2.text
        //                                                       .toString(),
        //                                               "milesPending":
        //                                                   _milesPending2.text
        //                                                       .toString(),
        //                                               "performanceType": "",
        //                                               "wtdProgress": 0.0,
        //                                               "mtdProgress": 0.0,
        //                                               "ytdProgress": 0.0,
        //                                               "rowMethod": rowMethod,
        //                                               "delayCause":
        //                                                   delayCause ?? '',
        //                                               "delayReason":
        //                                                   reason ?? '',
        //                                               "effectedNoOfDays":
        //                                                   (_affectedDays
        //                                                               .text
        //                                                               .toString() ==
        //                                                           'null')
        //                                                       ? 0
        //                                                       : _affectedDays
        //                                                           .text
        //                                                           .toString(),
        //                                               "fileUpload": "N/A",
        //                                               "createDate":
        //                                                   "2025-02-02T12:19:29.427+00:00",
        //                                               // "status": "PENDING",
        //                                               "status":
        //                                                   "PENDING ZIELIES APPROVAL",
        //                                               "notes": _notes.text
        //                                                   .toString(),
        //                                             };
        //                                             print(
        //                                                 'API called.........');
        //                                             updateVegetationCrewForm(
        //                                                 mapDataEditOldRecord,
        //                                                 idDuringUpdate);
                                                      
        //                                                    //  Store ID
        //                                                   vegId = idDuringUpdate;
        //                                                   //  Optional
        //                                                   print(
        //                                                       "Stored vegId: $vegId");
        //                                             if (videoPath != '' ||
        //                                                 imagePaths.isNotEmpty) {
        //                                               print(
        //                                                   'if condition videoPath != '
        //                                                   ' ||imagePaths.isNotEmpty');
        //                                               submitMediaFilesEditOldRecord(
        //                                                   imagePaths,
        //                                                   videoPath,
        //                                                   selectedChangeOrderNo!);
        //                                               // submitVideo(videoPath,
        //                                               //     selectedChangeOrderNo!);
        //                                             }
        //                                             print(
        //                                                 'mapDataEditOldRecord');
        //                                             print(mapDataEditOldRecord);
        //                                             Future.delayed(
        //                                                 const Duration(
        //                                                     seconds: 5), () {
        //                                               Navigator.pop(context);
        //                                               Navigator.pop(context);
        //                                             });
        //                                             // }
        //                                             print('name1');
        //                                           } else {
        //                                             print(
        //                                                 "Please fill all mendetory fields!!!");
        //                                             _showValidationErrorSnackBar(
        //                                                 context);
        //                                           }
        //                                         },
        //                                         child: Container(
        //                                           margin: const EdgeInsets.only(
        //                                               left: 40,
        //                                               right: 40,
        //                                               bottom: 10.0),
        //                                           // padding: const EdgeInsets.all(8),
        //                                           alignment: Alignment.center,
        //                                           width: MediaQuery.of(context)
        //                                               .size
        //                                               .width,
        //                                           height: 40,
        //                                           decoration: const BoxDecoration(
        //                                               // borderRadius:
        //                                               //     BorderRadius.circular(10),
        //                                               boxShadow: [
        //                                                 BoxShadow(
        //                                                     color:
        //                                                         Color.fromARGB(
        //                                                             255,
        //                                                             3,
        //                                                             47,
        //                                                             97),
        //                                                     blurRadius: 5,
        //                                                     offset: Offset(
        //                                                         2.0, 5.0))
        //                                               ],
        //                                               gradient: LinearGradient(
        //                                                 colors: [
        //                                                   Color.fromARGB(
        //                                                       255, 7, 59, 120),
        //                                                   Color.fromARGB(
        //                                                       255, 7, 59, 120)
        //                                                 ],
        //                                               )),
        //                                           child: const Row(children: [
        //                                             Expanded(
        //                                               child: Align(
        //                                                 alignment:
        //                                                     Alignment.center,
        //                                                 child: Text(
        //                                                   "UPDATE",
        //                                                   textAlign:
        //                                                       TextAlign.left,
        //                                                   style: TextStyle(
        //                                                     color: Colors.white,
        //                                                     fontWeight:
        //                                                         FontWeight.bold,
        //                                                     fontSize: 20,
        //                                                   ),
        //                                                 ),
        //                                               ),
        //                                             ),
        //                                           ]),
        //                                         ),
        //                                       )),
        //                                 ),
        //                                 Visibility(
        //                                   visible: _isVisibleUpdatingButton,
        //                                   child: Container(
        //                                       margin: const EdgeInsets.only(
        //                                           left: 6,
        //                                           right: 6,
        //                                           top: 10.0,
        //                                           bottom: 10),
        //                                       child: Container(
        //                                         margin: const EdgeInsets.only(
        //                                             left: 40,
        //                                             right: 40,
        //                                             bottom: 10.0),
        //                                         // padding: const EdgeInsets.all(8),
        //                                         alignment: Alignment.center,
        //                                         width: MediaQuery.of(context)
        //                                             .size
        //                                             .width,
        //                                         height: 40,
        //                                         decoration: const BoxDecoration(
        //                                             // borderRadius:
        //                                             //     BorderRadius.circular(10),
        //                                             boxShadow: [
        //                                               BoxShadow(
        //                                                   color: Color.fromARGB(
        //                                                       255, 3, 47, 97),
        //                                                   blurRadius: 5,
        //                                                   offset:
        //                                                       Offset(2.0, 5.0))
        //                                             ],
        //                                             gradient: LinearGradient(
        //                                               colors: [
        //                                                 Color.fromARGB(
        //                                                     255, 7, 59, 120),
        //                                                 Color.fromARGB(
        //                                                     255, 7, 59, 120)
        //                                               ],
        //                                             )),
        //                                         child: const Row(children: [
        //                                           Expanded(
        //                                             child: Align(
        //                                               alignment:
        //                                                   Alignment.center,
        //                                               child: Text(
        //                                                 "UPDATING...",
        //                                                 textAlign:
        //                                                     TextAlign.left,
        //                                                 style: TextStyle(
        //                                                   color: Colors.white,
        //                                                   fontWeight:
        //                                                       FontWeight.bold,
        //                                                   fontSize: 20,
        //                                                 ),
        //                                               ),
        //                                             ),
        //                                           ),
        //                                         ]),
        //                                       )),
        //                                 ),
                                          Visibility(
                                              visible: _isVisibleUpdateMap,
                                              child: Container(
                                                  margin: const EdgeInsets.only(
                                                    top: 10.0,
                                                  ),
                                                  child: InkWell(
                                                    onTap: () async {
                                                      String id = '';
                                                      final userPreferences1 =
                                                          Provider.of<UserPref>(
                                                              context,
                                                              listen: false);
                                                      UserModel data =
                                                          await userPreferences1
                                                              .getUser();
                                                      id = data.user!.id
                                                          .toString();
                                                     
                                                      // await browser.open(
                                                      //     url: WebUri(MapUrl 
                                                      //         .getCrewWithWorkOrderNoEndPoint(
                                                      //             selectedChangeOrderNo,
                                                      //             id)),
                                                      //     // "https://mapapi.ariespro.com/main/crew/CIVM_Map/$selectedChangeOrderNo/USRQWXH589Z"),
                                                      //     settings: ChromeSafariBrowserSettings(
                                                      //         shareState:
                                                      //             CustomTabsShareState
                                                      //                 .SHARE_STATE_OFF,
                                                      //         barCollapsingEnabled:
                                                      //             true));
                                                      
                                                       Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MapScreenCrew(
                                            jobNo: widget.jobNo,
                                            substation: widget.substation,
                                            feeder: widget.feeder.split('(')
                                                .first
                                                .trim(),
                                            year: getYearOrNA(
                                              widget.nextMaintDue,
                                            ),
                                          ),
                                        ),
                                      );
                                                    },
                                                    child: Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 40,
                                                              right: 40,
                                                              bottom: 10.0),
                                                      // padding: const EdgeInsets.all(8),
                                                      alignment:
                                                          Alignment.center,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      height: 40,
                                                      decoration: const BoxDecoration(
                                                          // shape: BoxShape.circle,
                                                          // borderRadius:
                                                          // BorderRadius.circular(25),
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        3,
                                                                        47,
                                                                        97),
                                                                blurRadius: 5,
                                                                offset: Offset(
                                                                    2.0, 5.0))
                                                          ],
                                                          gradient: LinearGradient(
                                                            colors: [
                                                              Color.fromARGB(
                                                                  255,
                                                                  7,
                                                                  59,
                                                                  120),
                                                              Color.fromARGB(
                                                                  255,
                                                                  7,
                                                                  59,
                                                                  120)
                                                            ],
                                                          )),
                                                      child:
                                                          const Row(children: [
                                                        Expanded(
                                                          child: Align(
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                              "UPDATE MAP",
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 20,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ]),
                                                    ),
                                                  )),
                                            ),
                                           
                                        Container(
                                          margin: const EdgeInsets.only(
                                              left: 4,
                                              right: 4,
                                              top: 10,
                                              bottom: 8),
                                          padding: const EdgeInsets.all(8),
                                          alignment: Alignment.center,
                                          height: size.height * 0.6,
                                          width: size.width * 0.99,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: const [
                                                BoxShadow(
                                                    color: Color.fromARGB(
                                                        255, 7, 59, 120),
                                                    blurRadius: 10,
                                                    offset: Offset(2.0, 5.0))
                                              ],
                                              gradient: const LinearGradient(
                                                colors: [
                                                  Color.fromARGB(
                                                      255, 255, 255, 255),
                                                  Color.fromARGB(
                                                      255, 255, 255, 255),
                                                ],
                                              )),
                                          child: Column(
                                            children: [
                                              Expanded(
                                                child: ListView.builder(
                                                    itemCount: contractorRowMaintenanceProgressViewModelViewModel
                                                        .contractorRowMaintenanceProgressViewModelGetTabularData
                                                        .data!
                                                        .getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList!
                                                        .length,
                                                    itemBuilder:
                                                        (BuildContext ctxt,
                                                            int index) {
                                                      print(
                                                          'timestamp: ${contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].createDate.toString().split('.')[0]}');
                                                      String formattedDateTime =
                                                          formatDateTime(
                                                              contractorRowMaintenanceProgressViewModelViewModel
                                                                  .contractorRowMaintenanceProgressViewModelGetTabularData
                                                                  .data!
                                                                  .getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![
                                                                      index]
                                                                  .createDate
                                                                  .toString());
                                                      return Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 4.0,
                                                                    bottom: 4,
                                                                    left: 2,
                                                                    right: 2),
                                                            child: Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.85,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8),
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: const Color
                                                                          .fromARGB(
                                                                          255,
                                                                          7,
                                                                          59,
                                                                          120),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                      borderRadius:
                                                                          const BorderRadius
                                                                              .only(
                                                                        topRight:
                                                                            Radius.circular(10),
                                                                        bottomRight:
                                                                            Radius.circular(10),
                                                                        topLeft:
                                                                            Radius.circular(10),
                                                                        bottomLeft:
                                                                            Radius.circular(10),
                                                                      )),
                                                              child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              8.0),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                const Align(
                                                                                  alignment: Alignment.topLeft,
                                                                                  child: Text(
                                                                                    "EDIT: ",
                                                                                    textAlign: TextAlign.left,
                                                                                    style: TextStyle(
                                                                                      fontSize: 16,
                                                                                      fontWeight: FontWeight.bold,
                                                                                      color: Colors.white,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                (contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].status == 'PENDING' || contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].status == 'REJECTED')
                                                                                    ? InkWell(
                                                                                        onTap: () {
                                                                                          setState(() {
                                                                                            _isVisibleSubmitFormNewRecord = false;
                                                                                            _isVisibleUpdateButton = true;
                                                                                          });
                                                                                          _scrollToTop();
                                                                                          flagEdit = 1;
                                                                                          _milesCompleted2.text = contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].milesCompleted.toString();
                                                                                          previousMilesCompleted = contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].milesCompleted.toString();
                                                                                          backendEditMilesCompleted = double.parse(contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].milesCompleted.toString());
                                                                                          // delayCause= contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].delayCause.toString();
                                                                                          String? delayCauseTemp = contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].delayCause.toString();
                                                                                          print('delayCause $delayCauseTemp');
                                                                                          setState(() {
                                                                                            delayCause = (delayCauseTemp == "" || delayCauseTemp == "null") ? null : delayCauseTemp;
                                                                                          });
                                                                                          if (delayCause == 'Weather Delay') {
                                                                                            select_reason = [
                                                                                              // 'Hurricane',
                                                                                              'Ice',
                                                                                              'Major Storm',
                                                                                              'Rain',
                                                                                              'Snow',
                                                                                              'Wind'
                                                                                            ];
                                                                                          } else if (delayCause == 'Other Issues') {
                                                                                            select_reason = [
                                                                                              'Crew',
                                                                                              'Machinery',
                                                                                              'Safety Issue',
                                                                                              'Member'
                                                                                            ];
                                                                                          }
                                                                                          // reason = contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].delayReason.toString();
                                                                                          String? reasonTemp = contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].delayReason?.toString().trim();

                                                                                          reason = (reasonTemp == "" || reasonTemp == "null") ? null : reasonTemp;

                                                                                          print('contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].rowMethod.toString() ${contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].rowMethod.toString()}');
                                                                                          // if(contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].rowMethod.toString()!=''){
                                                                                          //  rowMethodNew = contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].rowMethod.toString().split(', ').map((e) => e.trim()).toList();

                                                                                          // String? newRowMehtod = rowMethodNew.isEmpty ? null : rowMethodNew.join(', ');
                                                                                          // print('newRowMehtod $newRowMehtod');
                                                                                          // // if (newMaintenanceType != rowMethod) {
                                                                                          // setState(() {
                                                                                          // rowMethod = newRowMehtod;
                                                                                          // });
                                                                                          // print('rowMethod $rowMethod');
                                                                                          // }else{
                                                                                          // }
                                                                                          String? rowMethodValue = contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].rowMethod?.toString().trim();

                                                                                          if (rowMethodValue != null && rowMethodValue.isNotEmpty) {
                                                                                            List<String> updatedRowMethodNew = rowMethodValue
                                                                                                .split(',')
                                                                                                .map((e) => e.trim().toUpperCase()) // Standardize case
                                                                                                .toList();

                                                                                            String? newRowMethod = updatedRowMethodNew.isEmpty ? null : updatedRowMethodNew.join(', ');

                                                                                            setState(() {
                                                                                              rowMethod = newRowMethod;
                                                                                              rowMethodNew = List<String>.from(updatedRowMethodNew); // Updating List<String> with case-standardized values
                                                                                            });

                                                                                            print('newRowMethod: $newRowMethod');
                                                                                            print('rowMethodNew: $rowMethodNew');
                                                                                          } else {
                                                                                            setState(() {
                                                                                              // rowMethod = null;
                                                                                              // rowMethodNew = [];
                                                                                            });

                                                                                            print('rowMethod is null');
                                                                                            print('rowMethodNew is empty');
                                                                                          }

                                                                                          _milesPending2.text = (contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.findAllByTokenNumbers![0].milesPending == null || contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.findAllByTokenNumbers![0].milesPending.toString() == 'null') ? '0' : double.parse(contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.findAllByTokenNumbers![0].milesPending.toString()).toStringAsFixed(2);
                                                                                          _notes.text = contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].notes.toString();
                                                                                          _affectedDays.text = contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].effectedNoOfDays.toString();
                                                                                          //////////assign backend value to local variables///////////////////////
                                                                                          tblSubMilesCostId = int.parse(contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].tblSubMilesCostId.toString());
                                                                                          idDuringUpdate = int.parse(contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].id.toString());
                                                                                          subStateName = contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].substation.toString();
                                                                                          feeder = contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].feeder.toString();
                                                                                          street = "";
                                                                                          crew = "";
                                                                                          totalMiles = double.parse(contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].totalMiles.toString());
                                                                                          //  double milesCompleted =  0.0;
                                                                                          //  double milesInProgress=23.0;
                                                                                          //  double milesPending=0.0;
                                                                                          performanceType = "";
                                                                                          wtdProgress = 0.0;
                                                                                          mtdProgress = 0.0;
                                                                                          ytdProgress = 0.0;
                                                                                          //  String rowMethod2= "";
                                                                                          //  String delayCause2 = "";
                                                                                          //  String delayReason= "";
                                                                                          //  double effectedNoOfDays=0.0;
                                                                                          fileUpload = "N/A";
                                                                                          createDate = "2025-02-02T12:19:29.427+00:00";
                                                                                          status = "";
                                                                                        },
                                                                                        child: const Align(
                                                                                          alignment: Alignment.topLeft,
                                                                                          child: Icon(
                                                                                            Icons.edit,
                                                                                            color: Color.fromARGB(255, 151, 249, 154),
                                                                                          ),
                                                                                        ),
                                                                                      )
                                                                                    : const Text('')
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                const Align(
                                                                                  alignment: Alignment.topLeft,
                                                                                  child: Text(
                                                                                    "SERIAL: ",
                                                                                    textAlign: TextAlign.left,
                                                                                    style: TextStyle(
                                                                                      fontSize: 16,
                                                                                      fontWeight: FontWeight.bold,
                                                                                      color: Colors.white,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Align(
                                                                                  alignment: Alignment.topLeft,
                                                                                  child: Text(
                                                                                    (index + 1).toString(),
                                                                                    textAlign: TextAlign.left,
                                                                                    style: const TextStyle(
                                                                                      fontSize: 16,
                                                                                      color: Colors.white,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                const Align(
                                                                                  alignment: Alignment.topLeft,
                                                                                  child: Text(
                                                                                    "SUBSTATION: ",
                                                                                    textAlign: TextAlign.left,
                                                                                    style: TextStyle(
                                                                                      fontSize: 16,
                                                                                      fontWeight: FontWeight.bold,
                                                                                      color: Colors.white,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Align(
                                                                                  alignment: Alignment.topLeft,
                                                                                  child: Text(
                                                                                    (contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].substation == null || contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].substation.toString() == 'null') ? '' : contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].substation.toString(),
                                                                                    textAlign: TextAlign.left,
                                                                                    style: const TextStyle(
                                                                                      fontSize: 16,
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
                                                                      color: Colors
                                                                          .grey,
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              8.0),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                const Align(
                                                                                  alignment: Alignment.topLeft,
                                                                                  child: Text(
                                                                                    "FEEDER: ",
                                                                                    textAlign: TextAlign.left,
                                                                                    style: TextStyle(
                                                                                      fontSize: 16,
                                                                                      fontWeight: FontWeight.bold,
                                                                                      color: Colors.white,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Align(
                                                                                  alignment: Alignment.topLeft,
                                                                                  child: Text(
                                                                                    (contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].fdrName == null || contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].fdrName.toString() == 'null') ? '' : contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].fdrName.toString(),
                                                                                    textAlign: TextAlign.left,
                                                                                    style: const TextStyle(
                                                                                      fontSize: 16,
                                                                                      color: Colors.white,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                const Align(
                                                                                  alignment: Alignment.topLeft,
                                                                                  child: Text(
                                                                                    "TOTAL MILES: ",
                                                                                    textAlign: TextAlign.left,
                                                                                    style: TextStyle(
                                                                                      fontSize: 16,
                                                                                      fontWeight: FontWeight.bold,
                                                                                      color: Colors.white,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Align(
                                                                                  alignment: Alignment.topLeft,
                                                                                  child: Text(
                                                                                    (contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].totalMiles == null || contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].totalMiles.toString() == 'null') ? '' : double.parse(contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].totalMiles.toString()).toStringAsFixed(2),
                                                                                    textAlign: TextAlign.left,
                                                                                    style: const TextStyle(
                                                                                      fontSize: 16,
                                                                                      color: Colors.white,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                const Align(
                                                                                  alignment: Alignment.topLeft,
                                                                                  child: Text(
                                                                                    "MILES COMPLETED: ",
                                                                                    textAlign: TextAlign.left,
                                                                                    style: TextStyle(
                                                                                      fontSize: 16,
                                                                                      fontWeight: FontWeight.bold,
                                                                                      color: Colors.white,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Align(
                                                                                  alignment: Alignment.topLeft,
                                                                                  child: Text(
                                                                                    (contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].milesCompleted == null || contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].milesCompleted.toString() == 'null') ? '' : double.parse(contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].milesCompleted.toString()).toStringAsFixed(2),
                                                                                    textAlign: TextAlign.left,
                                                                                    style: const TextStyle(
                                                                                      fontSize: 16,
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
                                                                      color: Colors
                                                                          .grey,
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              8.0),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                const Align(
                                                                                  alignment: Alignment.topLeft,
                                                                                  child: Text(
                                                                                    "ROW METHOD: ",
                                                                                    textAlign: TextAlign.left,
                                                                                    style: TextStyle(
                                                                                      fontSize: 16,
                                                                                      fontWeight: FontWeight.bold,
                                                                                      color: Colors.white,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Align(
                                                                                  alignment: Alignment.topLeft,
                                                                                  child: Text(
                                                                                    (contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].rowMethod == null || contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].rowMethod.toString() == 'null') ? '' : contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].rowMethod.toString(),
                                                                                    textAlign: TextAlign.left,
                                                                                    style: const TextStyle(
                                                                                      fontSize: 16,
                                                                                      color: Colors.white,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                const Align(
                                                                                  alignment: Alignment.topLeft,
                                                                                  child: Text(
                                                                                    "DELAY CAUSE: ",
                                                                                    textAlign: TextAlign.left,
                                                                                    style: TextStyle(
                                                                                      fontSize: 16,
                                                                                      fontWeight: FontWeight.bold,
                                                                                      color: Colors.white,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Align(
                                                                                  alignment: Alignment.topLeft,
                                                                                  child: Text(
                                                                                    (contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].delayCause == null || contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].delayCause.toString() == 'null') ? '' : contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].delayCause.toString(),
                                                                                    textAlign: TextAlign.left,
                                                                                    style: const TextStyle(
                                                                                      fontSize: 16,
                                                                                      color: Colors.white,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                const Align(
                                                                                  alignment: Alignment.topLeft,
                                                                                  child: Text(
                                                                                    "DELAY REASON: ",
                                                                                    textAlign: TextAlign.left,
                                                                                    style: TextStyle(
                                                                                      fontSize: 16,
                                                                                      fontWeight: FontWeight.bold,
                                                                                      color: Colors.white,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Align(
                                                                                  alignment: Alignment.topLeft,
                                                                                  child: Text(
                                                                                    (contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].delayReason == null || contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].delayReason.toString() == 'null') ? '' : contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].delayReason.toString(),
                                                                                    textAlign: TextAlign.left,
                                                                                    style: const TextStyle(
                                                                                      fontSize: 16,
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
                                                                      color: Colors
                                                                          .grey,
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              8.0),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                const Align(
                                                                                  alignment: Alignment.topLeft,
                                                                                  child: Text(
                                                                                    "EFFECTED NO. of DAYS: ",
                                                                                    textAlign: TextAlign.left,
                                                                                    style: TextStyle(
                                                                                      fontSize: 16,
                                                                                      fontWeight: FontWeight.bold,
                                                                                      color: Colors.white,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Align(
                                                                                  alignment: Alignment.topLeft,
                                                                                  child: Text(
                                                                                    (contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].effectedNoOfDays == null || contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].effectedNoOfDays.toString() == 'null') ? '' : contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].effectedNoOfDays.toString(),
                                                                                    textAlign: TextAlign.left,
                                                                                    style: const TextStyle(
                                                                                      fontSize: 16,
                                                                                      color: Colors.white,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                const Align(
                                                                                  alignment: Alignment.topLeft,
                                                                                  child: Text(
                                                                                    "STATUS: ",
                                                                                    textAlign: TextAlign.left,
                                                                                    style: TextStyle(
                                                                                      fontSize: 16,
                                                                                      fontWeight: FontWeight.bold,
                                                                                      color: Colors.white,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Align(
                                                                                  alignment: Alignment.topLeft,
                                                                                  child: Text(
                                                                                    (contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].status == null || contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].status.toString() == 'null') ? '' : contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].status.toString(),
                                                                                    textAlign: TextAlign.left,
                                                                                    style: const TextStyle(
                                                                                      fontSize: 16,
                                                                                      color: Colors.white,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                const Align(
                                                                                  alignment: Alignment.topLeft,
                                                                                  child: Text(
                                                                                    "TIMESTAMP: ",
                                                                                    textAlign: TextAlign.left,
                                                                                    style: TextStyle(
                                                                                      fontSize: 16,
                                                                                      fontWeight: FontWeight.bold,
                                                                                      color: Colors.white,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Align(
                                                                                  alignment: Alignment.topLeft,
                                                                                  child: Text(
                                                                                    (contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].createDate == null || contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].createDate.toString() == 'null') ? '' : formattedDateTime,
                                                                                    textAlign: TextAlign.left,
                                                                                    style: const TextStyle(
                                                                                      fontSize: 16,
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
                                                                      color: Colors
                                                                          .grey,
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              8.0),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                const Align(
                                                                                  alignment: Alignment.topLeft,
                                                                                  child: Text(
                                                                                    "ACTION: ",
                                                                                    textAlign: TextAlign.left,
                                                                                    style: TextStyle(
                                                                                      fontSize: 16,
                                                                                      fontWeight: FontWeight.bold,
                                                                                      color: Colors.white,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                (contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].status == 'REJECTED')
                                                                                    ? Container(
                                                                                        margin: const EdgeInsets.only(bottom: 10),
                                                                                        child: InkWell(
                                                                                          onTap: () {
                                                                                            updateStatus(contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].id.toString());
                                                                                          },
                                                                                          child: Container(
                                                                                            margin: const EdgeInsets.only(top: 2, bottom: 10.0),
                                                                                            // padding: const EdgeInsets.all(8),
                                                                                            alignment: Alignment.center,
                                                                                            // width: MediaQuery.of(context).size.width,
                                                                                            // height: 40,
                                                                                            decoration: BoxDecoration(
                                                                                                // shape: BoxShape.circle,
                                                                                                borderRadius: BorderRadius.circular(10),
                                                                                                boxShadow: const [
                                                                                                  BoxShadow(color: Color.fromARGB(255, 3, 47, 97), blurRadius: 5, offset: Offset(2.0, 5.0))
                                                                                                ],
                                                                                                gradient: const LinearGradient(
                                                                                                  colors: [
                                                                                                    Colors.white,
                                                                                                    Colors.white,
                                                                                                  ],
                                                                                                )),
                                                                                            child: const Padding(
                                                                                              padding: EdgeInsets.all(2.0),
                                                                                              child: Align(
                                                                                                alignment: Alignment.center,
                                                                                                child: Text(
                                                                                                  "Submit for Review",
                                                                                                  textAlign: TextAlign.left,
                                                                                                  style: TextStyle(
                                                                                                    color: Color.fromARGB(255, 3, 47, 97),
                                                                                                    fontWeight: FontWeight.bold,
                                                                                                    fontSize: 16,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ))
                                                                                    : const Text(''),
                                                                                // (contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].status == 'REJECTED')
                                                                                //     ? Visibility(
                                                                                //   visible:
                                                                                //       _isVisibleSubmitingForReviewButton,
                                                                                //   child: Container(
                                                                                //       margin: const EdgeInsets.only(bottom: 10),
                                                                                //       child: Container(
                                                                                //         margin: const EdgeInsets.only(top: 2, bottom: 10.0),
                                                                                //         // padding: const EdgeInsets.all(8),
                                                                                //         alignment: Alignment.center,
                                                                                //         // width: MediaQuery.of(context).size.width,                                                                  // height: 40,
                                                                                //         decoration: BoxDecoration(
                                                                                //             // shape: BoxShape.circle,
                                                                                //             borderRadius: BorderRadius.circular(10),
                                                                                //             boxShadow: const [
                                                                                //               BoxShadow(color: Color.fromARGB(255, 3, 47, 97), blurRadius: 5, offset: Offset(2.0, 5.0))
                                                                                //             ],
                                                                                //             gradient: const LinearGradient(
                                                                                //               colors: [
                                                                                //                 Colors.white,
                                                                                //                 Colors.white,
                                                                                //               ],
                                                                                //             )),
                                                                                //         child: const Padding(
                                                                                //           padding: EdgeInsets.all(2.0),
                                                                                //           child: Align(
                                                                                //             alignment: Alignment.center,
                                                                                //             child: Text(
                                                                                //               "Submitting for Review",
                                                                                //               textAlign: TextAlign.left,
                                                                                //               style: TextStyle(
                                                                                //                 color: Color.fromARGB(255, 3, 47, 97),
                                                                                //                 fontWeight: FontWeight.bold,
                                                                                //                 fontSize: 16,
                                                                                //               ),
                                                                                //             ),
                                                                                //           ),
                                                                                //         ),
                                                                                //       )),
                                                                                // )  : const Text(''),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            flex:
                                                                                2,
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                const Align(
                                                                                  alignment: Alignment.topLeft,
                                                                                  child: Text(
                                                                                    "NOTES: ",
                                                                                    textAlign: TextAlign.left,
                                                                                    style: TextStyle(
                                                                                      fontSize: 16,
                                                                                      fontWeight: FontWeight.bold,
                                                                                      color: Colors.white,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Align(
                                                                                  alignment: Alignment.topLeft,
                                                                                  child: Text(
                                                                                    (contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].notes == null || contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].notes.toString() == 'null') ? '' : contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].notes.toString(),
                                                                                    textAlign: TextAlign.left,
                                                                                    style: const TextStyle(
                                                                                      fontSize: 16,
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
                                      ],
                                    ),
                                  ],
                                )),
                          ]),
                        ));
                  default:
                    return const Text('data');
                }
              }))),
    );
  }

  fetchData(String tokenNo) async {
    print('111111111111');
    rowMethodNew = [];
    _affectedDays.text = '0';
// if (tokenNo.isEmpty) {
    print('222222');
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    await contractorRowMaintenanceProgressViewModelViewModel
        .fetchContractorRowMaintenanceProgressViewModelTabularListApi(
            context, data.user!.id.toString(), tokenNo);
    await Future.delayed(const Duration(seconds: 4));
    print('333333');
    if (tokenNo != '') {
      setState(() {
        _isVisibleUpdateMap = true;
      });
      setData();
    }
    print('444444');
    print('widget.maintenanceType:: ${widget.maintenanceType}');
    if (widget.maintenanceType == 'CROSS-COUNTRY SPRAY' ||
        widget.maintenanceType == 'ROADSIDE SPRAY' ||
        widget.maintenanceType == 'NO SPRAY' ||
        widget.maintenanceType == 'CROSS-COUNTRY SPRAY, ROADSIDE SPRAY' ||
        widget.maintenanceType == 'CROSS-COUNTRY SPRAY, NO SPRAY' ||
        widget.maintenanceType == 'ROADSIDE SPRAY, NO SPRAY') {
      print('if condition of maintenance type ${widget.maintenanceType}');
      setState(() {
        rowMethodNew = ['HERBICIDE'];
      });
    } else {
      print('else condition of maintenance type ${widget.maintenanceType}');
      setState(() {
        rowMethodNew =
            widget.maintenanceType.split(',').map((e) => e.trim()).toList();
      });
    }
    String budgetType = '';
    budgetType = (contractorRowMaintenanceProgressViewModelViewModel
                    .contractorRowMaintenanceProgressViewModelGetTabularData
                    .data!
                    .findAllByTokenNumbers![0]
                    .budgetType ==
                null ||
            contractorRowMaintenanceProgressViewModelViewModel
                    .contractorRowMaintenanceProgressViewModelGetTabularData
                    .data!
                    .findAllByTokenNumbers![0]
                    .budgetType
                    .toString() ==
                'null')
        ? ''
        : contractorRowMaintenanceProgressViewModelViewModel
            .contractorRowMaintenanceProgressViewModelGetTabularData
            .data!
            .findAllByTokenNumbers![0]
            .budgetType
            .toString();

    if (budgetType == 'Mid Cycle maintenance') {
      _isVisibleMixingForm = true;
    }

    if (contractorRowMaintenanceProgressViewModelViewModel
                .contractorRowMaintenanceProgressViewModelGetTabularData
                .data!
                .findLastMaintDone !=
            null &&
        contractorRowMaintenanceProgressViewModelViewModel
            .contractorRowMaintenanceProgressViewModelGetTabularData
            .data!
            .findLastMaintDone!
            .isNotEmpty) {
      String lastUpdated = contractorRowMaintenanceProgressViewModelViewModel
          .contractorRowMaintenanceProgressViewModelGetTabularData
          .data!
          .findLastMaintDone![0]
          .lastUpdated
          .toString();

      // Parse the date from the current format (DD-MM-YYYY HH:MM AM/PM)
      DateFormat inputFormat = DateFormat('dd-MM-yyyy h:mm a');
      DateTime dateTime = inputFormat.parse(lastUpdated);

      // Format the date to the desired format (MM-DD-YYYY HH:MM AM/PM)
      DateFormat outputFormat = DateFormat('MM-dd-yyyy h:mm a');
      formattedDate = outputFormat.format(dateTime);
    }
    print('widget.maintenanceType ${widget.maintenanceType}');
  }

  // setData() {
  //   print(
  //       'totalmiles----- ${contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.findAllByTokenNumbers!.first.totalMiles}');
  //   print(
  //       'MilesCompleted-----${contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.findAllByTokenNumbers!.first.milesCompleted}');
  //   print(
  //       'MilesInProgress-----${contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.findAllByTokenNumbers!.first.milesInProgress}');
  //   setState(() async {
  //     _totalMiles.text = (contractorRowMaintenanceProgressViewModelViewModel
  //                     .contractorRowMaintenanceProgressViewModelGetTabularData
  //                     .data!
  //                     .findAllByTokenNumbers!
  //                     .first
  //                     .totalMiles ==
  //                 null ||
  //             contractorRowMaintenanceProgressViewModelViewModel
  //                     .contractorRowMaintenanceProgressViewModelGetTabularData
  //                     .data!
  //                     .findAllByTokenNumbers!
  //                     .first
  //                     .totalMiles
  //                     .toString() ==
  //                 'null')
  //         ? '0'
  //         : double.parse(contractorRowMaintenanceProgressViewModelViewModel
  //                 .contractorRowMaintenanceProgressViewModelGetTabularData
  //                 .data!
  //                 .findAllByTokenNumbers!
  //                 .first
  //                 .totalMiles
  //                 .toString())
  //             .toStringAsFixed(2);
  //     print('aaaaaaaaaaaaaaaaaaa');
  //     _milesCompleted.text = (contractorRowMaintenanceProgressViewModelViewModel
  //                     .contractorRowMaintenanceProgressViewModelGetTabularData
  //                     .data!
  //                     .findAllByTokenNumbers!
  //                     .first
  //                     .milesCompleted ==
  //                 null ||
  //             contractorRowMaintenanceProgressViewModelViewModel
  //                     .contractorRowMaintenanceProgressViewModelGetTabularData
  //                     .data!
  //                     .findAllByTokenNumbers!
  //                     .first
  //                     .milesCompleted
  //                     .toString() ==
  //                 'null')
  //         ? '0'
  //         : double.parse(contractorRowMaintenanceProgressViewModelViewModel
  //                 .contractorRowMaintenanceProgressViewModelGetTabularData
  //                 .data!
  //                 .findAllByTokenNumbers!
  //                 .first
  //                 .milesCompleted
  //                 .toString())
  //             .toStringAsFixed(2);

  //     globalCycle = (contractorRowMaintenanceProgressViewModelViewModel
  //                     .contractorRowMaintenanceProgressViewModelGetTabularData
  //                     .data!
  //                     .findAllByTokenNumbers!
  //                     .first
  //                     .cycle ==
  //                 null ||
  //             contractorRowMaintenanceProgressViewModelViewModel
  //                     .contractorRowMaintenanceProgressViewModelGetTabularData
  //                     .data!
  //                     .findAllByTokenNumbers!
  //                     .first
  //                     .cycle
  //                     .toString() ==
  //                 'null')
  //         ? '0'
  //         : contractorRowMaintenanceProgressViewModelViewModel
  //             .contractorRowMaintenanceProgressViewModelGetTabularData
  //             .data!
  //             .findAllByTokenNumbers!
  //             .first
  //             .cycle
  //             .toString();

  //     var nextMaintDue = contractorRowMaintenanceProgressViewModelViewModel
  //         .contractorRowMaintenanceProgressViewModelGetTabularData
  //         .data!
  //         .findAllByTokenNumbers!
  //         .first
  //         .nextMaintDue;

  //     globalYear = (nextMaintDue == null || nextMaintDue.toString() == 'null')
  //         ? '0'
  //         : DateFormat('yyyy').format(DateTime.parse(nextMaintDue.toString()));

  //     print('globalYear111111111111 $globalYear');

  //     print('bbbbbbbbbbbbbbbbbbbbbbbbbbbb');
  //     _milesInProgress
  //         .text = (contractorRowMaintenanceProgressViewModelViewModel
  //                     .contractorRowMaintenanceProgressViewModelGetTabularData
  //                     .data!
  //                     .findAllByTokenNumbers!
  //                     .first
  //                     .milesInProgress ==
  //                 null ||
  //             contractorRowMaintenanceProgressViewModelViewModel
  //                     .contractorRowMaintenanceProgressViewModelGetTabularData
  //                     .data!
  //                     .findAllByTokenNumbers!
  //                     .first
  //                     .milesInProgress
  //                     .toString() ==
  //                 'null')
  //         ? '0'
  //         : double.parse(contractorRowMaintenanceProgressViewModelViewModel
  //                 .contractorRowMaintenanceProgressViewModelGetTabularData
  //                 .data!
  //                 .findAllByTokenNumbers!
  //                 .first
  //                 .milesInProgress
  //                 .toString())
  //             .toStringAsFixed(2);
  //     print('cccccccccccccccccccccccc');
  //     _milesPending.text = (contractorRowMaintenanceProgressViewModelViewModel
  //                     .contractorRowMaintenanceProgressViewModelGetTabularData
  //                     .data!
  //                     .findAllByTokenNumbers!
  //                     .first
  //                     .milesPending ==
  //                 null ||
  //             contractorRowMaintenanceProgressViewModelViewModel
  //                     .contractorRowMaintenanceProgressViewModelGetTabularData
  //                     .data!
  //                     .findAllByTokenNumbers!
  //                     .first
  //                     .milesPending
  //                     .toString() ==
  //                 'null')
  //         ? '0'
  //         : double.parse(contractorRowMaintenanceProgressViewModelViewModel
  //                 .contractorRowMaintenanceProgressViewModelGetTabularData
  //                 .data!
  //                 .findAllByTokenNumbers!
  //                 .first
  //                 .milesPending
  //                 .toString())
  //             .toStringAsFixed(2);
  //     print('dddddddddddddddddddddddd');
  //     // crewName = (contractorRowMaintenanceProgressViewModelViewModel
  //     //                 .contractorRowMaintenanceProgressViewModelGetTabularData
  //     //                 .data!
  //     //                 .findCrewOrderNo![0]
  //     //                 .crew ==
  //     //             null ||
  //     //         contractorRowMaintenanceProgressViewModelViewModel
  //     //                 .contractorRowMaintenanceProgressViewModelGetTabularData
  //     //                 .data!
  //     //                 .findCrewOrderNo![0]
  //     //                 .crew
  //     //                 .toString() ==
  //     //             'null')
  //     //     ? '0'
  //     //     : contractorRowMaintenanceProgressViewModelViewModel
  //     //         .contractorRowMaintenanceProgressViewModelGetTabularData
  //     //         .data!
  //     //         .findCrewOrderNo![0]
  //     //         .crew
  //     //         .toString();
  //     final userPreferences = Provider.of<UserPref>(context, listen: false);
  //     UserModel data = await userPreferences.getUser();
  //     crewName = data.user!.userName.toString();
  //     //  final findCrewOrderNo = contractorRowMaintenanceProgressViewModelViewModel
  //     // .contractorRowMaintenanceProgressViewModelGetTabularData
  //     // .data
  //     // ?.findCrewOrderNo;
  //     //   crewName = (findCrewOrderNo == null ||
  //     //     findCrewOrderNo.isEmpty ||
  //     //     findCrewOrderNo.first.crew == null ||
  //     //     findCrewOrderNo.first.crew.toString() == 'null')
  //     // ? '0'
  //     // : findCrewOrderNo.first.crew.toString();
  //     print('crewName $crewName');
  //   });
  // }
  Future<void> setData() async {
  print('totalmiles----- ${contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.findAllByTokenNumbers!.first.totalMiles}');

  final userPreferences = Provider.of<UserPref>(context, listen: false);
  UserModel data = await userPreferences.getUser();
  final model = contractorRowMaintenanceProgressViewModelViewModel
      .contractorRowMaintenanceProgressViewModelGetTabularData
      .data!
      .findAllByTokenNumbers!
      .first;

  final totalMiles = (model.totalMiles == null || model.totalMiles.toString() == 'null')
      ? '0'
      : double.parse(model.totalMiles.toString()).toStringAsFixed(2);

  final milesCompleted = (model.milesCompleted == null || model.milesCompleted.toString() == 'null')
      ? '0'
      : double.parse(model.milesCompleted.toString()).toStringAsFixed(2);

  final milesInProgress = (model.milesInProgress == null || model.milesInProgress.toString() == 'null')
      ? '0'
      : double.parse(model.milesInProgress.toString()).toStringAsFixed(2);

  final milesPending = (model.milesPending == null || model.milesPending.toString() == 'null')
      ? '0'
      : double.parse(model.milesPending.toString()).toStringAsFixed(2);

  final cycle = (model.cycle == null || model.cycle.toString() == 'null')
      ? '0'
      : model.cycle.toString();

  final nextMaintDue = model.nextMaintDue;

  final year = (nextMaintDue == null || nextMaintDue.toString() == 'null')
      ? '0'
      : DateFormat('yyyy').format(DateTime.parse(nextMaintDue.toString()));

  final crew = data.user!.userName.toString();

  setState(() {
    _totalMiles.text = totalMiles;
    _milesCompleted.text = milesCompleted;
    _milesInProgress.text = milesInProgress;
    _milesPending.text = milesPending;

    globalCycle = cycle;
    globalYear = year;
    crewName = crew;
  });
}
  setDataForCalculation() {
    _milesCompleted2.text = '0';
    _milesInProgress2.text = '0';
  }

  Future<void> _checkPermission(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    Map<Permission, PermissionStatus> statues = await [
      Permission.camera,
      Permission.storage,
      Permission.photos
    ].request();
    PermissionStatus? statusCamera = statues[Permission.camera];
    PermissionStatus? statusStorage;
    PermissionStatus? statusPhotos;
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt <= 32) {
        statusStorage = statues[Permission.storage];

        /// use [Permissions.storage.status]
      } else {
        statusPhotos = statues[Permission.photos];

        /// use [Permissions.photos.status]
      }
    } else if (Platform.isIOS) {
      statusPhotos = statues[Permission.photos];
    }
    bool isGranted = statusCamera == PermissionStatus.granted &&
            statusStorage == PermissionStatus.granted ||
        statusCamera == PermissionStatus.granted &&
            statusPhotos == PermissionStatus.granted;
    if (isGranted) {
      // _pickImagesCamera();
// _pickImages();
    }
    bool isPermanentlyDenied =
        statusCamera == PermissionStatus.permanentlyDenied ||
            statusStorage == PermissionStatus.permanentlyDenied ||
            statusPhotos == PermissionStatus.permanentlyDenied;
    if (isPermanentlyDenied) {
// _showSettingsDialog(context);
    }
  }

  Future<void> submitImage(List<String> imagePaths, String tokenNo) async {
    print('imagePaths: $imagePaths');
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;

    try {
      var uri = Uri.parse(
          "https://civm2.ariespro.com/civm2/contractorPanel/updateImageVEGETATION_CREW_FORMs");
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
      List<http.MultipartFile> multipartFiles = [];

      for (int i = 0; i < imagePaths.length; i++) {
        String imagePath = imagePaths[i];

        if (imagePath.isNotEmpty) {
          File img = File(imagePath);

          File file = await img.copy(
              '$tempPath/img_${DateFormat('yyyyMMddHHmmss').format(DateTime.now())}_$i${imagePath.contains('.pdf') ? '.pdf' : '.jpg'}');

          var stream = http.ByteStream(file.openRead());
          var length = await file.length();

          var multipartFile = http.MultipartFile("files", stream, length,
              filename: path.basename(file.path));

          multipartFiles.add(multipartFile);
        }
      }

      if (multipartFiles.isNotEmpty) {
        request.files.addAll(multipartFiles); // Add all the selected files
      }

      request.fields['tokenNo'] = tokenNo;
      request.fields['vegId'] = vegId.toString();
      request.headers.addAll(headers);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        print("Images submitted successfully.");

        Map mapData = {
          "tblSubMilesCostId":
              (selectedChangeOrderNo == null) ? '' : selectedChangeOrderNo,
          "subStateName": widget.substationId,
          "feeder": widget.feederId,
          "street": "N/A",
          "crew": crewName,
          "totalMiles": (_totalMiles.text.toString() == 'null')
              ? ''
              : double.parse(_totalMiles.text).toStringAsFixed(2),
          "milesCompleted":
              double.parse(_milesCompleted2.text.toString()).toStringAsFixed(2),
          "milesInProgress": (_milesInProgress2.text.toString() == 'null')
              ? ''
              : double.parse(_milesInProgress2.text).toStringAsFixed(2),
          "milesPending": (_milesPending2.text.toString() == 'null')
              ? ''
              : double.parse(_milesPending2.text).toStringAsFixed(2),
          "performanceType": 'N/A',
          "wtdProgress": 0.0,
          "mtdProgress": 0.0,
          "ytdProgress": 0.0,
          "rowMethod": rowMethod ?? '',
          "delayCause": delayCause ?? '',
          "delayReason": reason ?? '',
          "effectedNoOfDays": (_affectedDays.text.toString() == 'null')
              ? 0
              : _affectedDays.text.toString(),
          "fileUpload": "N/A",
          "createDate": "2023-12-13T12:19:29.427+00:00",
          // "status": "PENDING",
          "status": "PENDING ZIELIES APPROVAL",
          "notes": (_notes.text.toString() == 'null')
              ? 'N/A'
              : _notes.text.toString(),
          "spanCompleted": (_spanCompleted2.text.toString() == 'null')
              ? 'N/A'
              : _spanCompleted2.text.toString(),
        };
        print('API called.........');
        contractorRowMaintenanceProgressViewModelViewModel
            .fetchRowMaintenanceProgressContractorSubmitListApi(
                context, mapData);
        setState(() {
          flag = 0;
          globalFeeder = '';
          globalSubstation = '';
          globalYear = '';
          globalCycle = '';
          _isVisibleUpdateMap = false;
          _isVisibleMixingForm = false;
          imagePaths = [];
          videoFlag = 0;
          _jobNo.clear();
        });
        Future.delayed(const Duration(seconds: 5), () {
          Navigator.pop(context);
          Navigator.pop(context);
        });

        // Handle the success response
      } else {
        print("Failed to submit images. Status code: ${response.statusCode}");
        print("Failed to submit images. response body: ${response.body}");
      }
    } catch (e, stacktrace) {
      print('Exception: $e\n$stacktrace');
    }
  }

  Future<void> deleteOnlineImageApi(String fileName, String token) async {
    final apiUrl =
        'http://civmapi.ariespro.com/civmapi/changeOrderLcpCreateOrder/deleteFile?fileName=$fileName&tokenNo=$token';
    print(apiUrl);
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
      } else {
        print('API request failed with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(item,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 20,
          )));
  void dropDownValues() {
    if (delayCause == 'Weather Delay') {
      select_reason = [
        // 'Hurricane',
        'Ice',
        'Major Storm',
        'Rain',
        'Snow',
        'Wind'
      ];
    } else if (delayCause == 'Other Issues') {
      select_reason = ['Crew', 'Machinery', 'Safety Issue', 'Member'];
    }
  }

  void calculateMilesPending(
    double milesCompleted,
    double milesInProgress,
    TextEditingController milesPending,
  ) {
    print('miles completed $milesCompleted');
    print('milesInProgress $milesInProgress');
    print('milesPending $milesPending');
    setState(() {
      double totalMilesFromBackend = double.parse(
          contractorRowMaintenanceProgressViewModelViewModel
              .contractorRowMaintenanceProgressViewModelGetTabularData
              .data!
              .findAllByTokenNumbers![0]
              .totalMiles
              .toString());
      print('totalMilesFromBackend $totalMilesFromBackend');
      double milesCompletedFromBackend = double.parse(
          contractorRowMaintenanceProgressViewModelViewModel
              .contractorRowMaintenanceProgressViewModelGetTabularData
              .data!
              .findAllByTokenNumbers![0]
              .milesCompleted
              .toString());
      print('milesCompletedFromBackend $milesCompletedFromBackend');
      double milesPendingValue = double.parse(
        (totalMilesFromBackend -
                milesCompletedFromBackend -
                milesCompleted -
                milesInProgress)
            .toStringAsFixed(2),
      );
      milesPendingValue = milesPendingValue.abs();
      print('milesPendingValue $milesPendingValue');
      milesPending.text = milesPendingValue.toStringAsFixed(2);
    });
  }

  void calculateMilesPendingDuringEdit(
    double milesCompleted,
    double milesInProgress,
    TextEditingController milesPending,
  ) {
    print('miles completed $milesCompleted');
    print('milesInProgress $milesInProgress');
    print('milesPending $milesPending');
    setState(() {
      double totalMilesFromBackend = double.parse(
          contractorRowMaintenanceProgressViewModelViewModel
              .contractorRowMaintenanceProgressViewModelGetTabularData
              .data!
              .findAllByTokenNumbers![0]
              .totalMiles
              .toString());
      print('totalMilesFromBackend $totalMilesFromBackend');
      double milesCompletedFromBackend = double.parse(
          contractorRowMaintenanceProgressViewModelViewModel
              .contractorRowMaintenanceProgressViewModelGetTabularData
              .data!
              .findAllByTokenNumbers![0]
              .milesCompleted
              .toString());
      print('milesCompletedFromBackend $milesCompletedFromBackend');
      double milesPendingValue = double.parse(
        ((totalMilesFromBackend + backendEditMilesCompleted) -
                milesCompletedFromBackend -
                milesCompleted -
                milesInProgress)
            .toStringAsFixed(2),
      );
      milesPendingValue = milesPendingValue.abs();
      print('milesPendingValue $milesPendingValue');
      milesPending.text = milesPendingValue.toStringAsFixed(2);
    });
  }

  printValue() {
    print('length of cards');
    print(contractorRowMaintenanceProgressViewModelViewModel
        .contractorRowMaintenanceProgressViewModelGetTabularData
        .data!
        .getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList!
        .length);
  }

  Future<void> updateStatus(String id) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      final userPreferences = Provider.of<UserPref>(context, listen: false);
      UserModel data = await userPreferences.getUser();
      final String apiUrl =
          "https://civm2.ariespro.com/civm2/contractorPanel/updateStatusByIds/$id";
      print(apiUrl);
      Map<String, dynamic> updatedData = {
        "status": "new_status",
      };
      final http.Response response = await http.put(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${data.token}',
        },
        body: jsonEncode(updatedData),
      );
      Navigator.of(context).pop();
      if (response.statusCode == 200) {
        print("Update successful");
        CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
            'Successfully Submitted for Review', context);
        // fetchData(selectedChangeOrderNo);
        fetchData(widget.jobNo);
        setState(() {
          //_isVisibleSubmitForReviewButton = truer;
          //_isVisibleSubmitingForReviewButton = false;
        });
        if (response.body.isNotEmpty) {
          print(jsonDecode(response.body));
        } else {
          print("Response body is empty");
        }
      } else {
        print("Failed to update. Status code: ${response.statusCode}");
// Print the response body only if it is not empty
        if (response.body.isNotEmpty) {
          print(response.body);
        }
      }
    } catch (e) {
      Navigator.of(context)
          .pop(); // Close the loading dialog in case of an error
      print("Error updating status: $e");
    }
  }

  IconData getFileTypeIcon(String filePath) {
    if (filePath.endsWith('.pdf')) {
      return Icons.picture_as_pdf;
    } else if (filePath.endsWith('.doc') || filePath.endsWith('.docx')) {
      return Icons.description;
    } else {
      return Icons.insert_drive_file;
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
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Take Picture',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 23, 1, 88),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.red),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                      ),
                    ),
                  ],
                ),
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
                          Navigator.of(context).pop();
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
    setState(() {
      imagePaths.add(path);
      images.add(imageARG);
    });
  }

  void extractAndStoreSubstationFeeder(
      List<Map<String, dynamic>> mappedDataList) {
    for (var data in mappedDataList) {
      String substation = data['substation'];
      String feeder = data['feeder'];

      print('Substation: $substation, Feeder: $feeder');
      globalSubstation = substation;
      globalFeeder = feeder;
    }
  }

  Future pickImageOptions() => showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          _setState = setState;
          return AlertDialog(
            actions: [
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                // _pickImagesCamera();
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
                                          color: Color.fromARGB(255, 1, 30, 78),
                                          blurRadius: 5,
                                          offset: Offset(2.0, 5.0))
                                    ],
                                    color: Colors.black,
                                    gradient: LinearGradient(
                                      colors: [
                                        Color.fromARGB(255, 7, 40, 97),
                                        Color.fromARGB(255, 7, 40, 97),
                                      ],
                                    )),
                                child: const Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "PICTURE",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                // _pickImagesCamera();
                                Navigator.pop(context);
                                // Navigator.pop(context);
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => BlocProvider(
                                      create: (context) {
                                        return CameraBloc(
                                          cameraUtils: CameraUtils(),
                                          permissionUtils: PermissionUtils(),
                                        )..add(const CameraInitialize(
                                            recordingLimit: 15));
                                      },
                                      child: CameraPage(callback: (file) async {
                                        _videoController =
                                            VideoPlayerController.file(file);

                                        setState(() {
                                          videoFlag = 1;
                                        });
                                        // kdmk
                                        initializeVideo();
                                        //  getVideoFileSize(context, videoPath);
                                      }),
                                    ),
                                  ),
                                );
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
                                          color: Color.fromARGB(255, 1, 30, 78),
                                          blurRadius: 5,
                                          offset: Offset(2.0, 5.0))
                                    ],
                                    color: Colors.black,
                                    gradient: LinearGradient(
                                      colors: [
                                        Color.fromARGB(255, 7, 40, 97),
                                        Color.fromARGB(255, 7, 40, 97),
                                      ],
                                    )),
                                child: const Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "VIDEO",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
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

  // Future<void> submitVideo(String videoPath, String tokenNo) async {
  //   print('Video path: $videoPath');
  //   Directory tempDir = await getTemporaryDirectory();
  //   String tempPath = tempDir.path;

  //   try {
  //     var uri = Uri.parse(
  //         "https://civm2.ariespro.com/civm2/contractorPanel/uploadFiles");
  //     var request = http.MultipartRequest("POST", uri);

  //     final userPreferences = Provider.of<UserPref>(context, listen: false);
  //     UserModel data = await userPreferences.getUser();

  //     var headers = {
  //       "Content-Type": "multipart/form-data",
  //       "Accept": "*/*",
  //       "Authorization": 'Bearer ${data.token!}',
  //     };
  //     File videoFile = File(videoPath);
  //     File tempVideoFile = await videoFile.copy(
  //       '$tempPath/video_${DateFormat('MMddyyyyHHmmss').format(DateTime.now())}.mp4',
  //     );

  //     var stream = http.ByteStream(tempVideoFile.openRead());
  //     var length = await tempVideoFile.length();
  //     var multipartFile = http.MultipartFile("files", stream, length,
  //         filename: path.basename(tempVideoFile.path));

  //     request.files.add(multipartFile);

  //     request.fields['tokenNo'] = tokenNo;

  //     request.headers.addAll(headers);

  //     var streamedResponse = await request.send();
  //     var response = await http.Response.fromStream(streamedResponse);

  //     if (response.statusCode == 200) {
  //       print("Video submitted successfully168.");
  //     } else {
  //       print("Failed to submit video. Status code: ${response.statusCode}");
  //       print("Response body video: ${response.body}");
  //     }
  //   } catch (e, stacktrace) {
  //     print('Exception111111: $e\n$stacktrace');
  //   }
  // }

  Future<void> submitMediaFiles(
      List<String> imagePaths, String videoPath, String tokenNo) async {
    print('Image Paths: $imagePaths');
    print('Video Path: $videoPath');

    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;

    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );
      var uri = Uri.parse(
          "https://civm2.ariespro.com/civm2/contractorPanel/uploadFiles");
      var request = http.MultipartRequest("POST", uri);

      final userPreferences = Provider.of<UserPref>(context, listen: false);
      UserModel data = await userPreferences.getUser();

      var headers = {
        "Content-Type": "multipart/form-data",
        "Accept": "*/*",
        "Authorization": 'Bearer ${data.token!}',
      };
      request.headers.addAll(headers);

      // Add images to the request
      List<http.MultipartFile> multipartFiles = [];
      for (int i = 0; i < imagePaths.length; i++) {
        String imagePath = imagePaths[i];

        if (imagePath.isNotEmpty) {
          File img = File(imagePath);

          File file = await img.copy(
              '$tempPath/img_${DateFormat('yyyyMMddHHmmss').format(DateTime.now())}_$i${imagePath.contains('.pdf') ? '.pdf' : '.jpg'}');

          var stream = http.ByteStream(file.openRead());
          var length = await file.length();

          var multipartFile = http.MultipartFile(
            "files",
            stream,
            length,
            filename: path.basename(file.path),
          );

          multipartFiles.add(multipartFile);
        }
      }

      // Add video to the request
      if (videoPath.isNotEmpty) {
        File videoFile = File(videoPath);
        File tempVideoFile = await videoFile.copy(
          '$tempPath/video_${DateFormat('MMddyyyyHHmmss').format(DateTime.now())}.mp4',
        );

        var videoStream = http.ByteStream(tempVideoFile.openRead());
        var videoLength = await tempVideoFile.length();

        var videoMultipartFile = http.MultipartFile(
          "files",
          videoStream,
          videoLength,
          filename: path.basename(tempVideoFile.path),
        );

        multipartFiles.add(videoMultipartFile);
      }

      // Add files to the request
      if (multipartFiles.isNotEmpty) {
        request.files.addAll(multipartFiles);
      }

      // Add additional fields
      request.fields['tokenNo'] = tokenNo;
      request.fields['vegId'] = vegId.toString();

      // Send the request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        print("Media files submitted successfully.");

        // Future.delayed(const Duration(seconds: 2), () {
        Map mapData = {
          "tblSubMilesCostId":
              (selectedChangeOrderNo == null) ? '' : selectedChangeOrderNo,
          "subStateName": widget.substationId,
          "feeder": widget.feederId,
          "street": "N/A",
          "crew": crewName,
          "totalMiles": (_totalMiles.text.toString() == 'null')
              ? ''
              : double.parse(_totalMiles.text).toStringAsFixed(2),
          "milesCompleted":
              double.parse(_milesCompleted2.text.toString()).toStringAsFixed(2),
          "milesInProgress": (_milesInProgress2.text.toString() == 'null')
              ? ''
              : double.parse(_milesInProgress2.text).toStringAsFixed(2),
          "milesPending": (_milesPending2.text.toString() == 'null')
              ? ''
              : double.parse(_milesPending2.text).toStringAsFixed(2),
          "performanceType": 'N/A',
          "wtdProgress": 0.0,
          "mtdProgress": 0.0,
          "ytdProgress": 0.0,
          "rowMethod": rowMethod ?? '',
          "delayCause": delayCause ?? '',
          "delayReason": reason ?? '',
          "effectedNoOfDays": (_affectedDays.text.toString() == 'null')
              ? 0
              : _affectedDays.text.toString(),
          "fileUpload": "N/A",
          "createDate": "2023-12-13T12:19:29.427+00:00",
          // "status": "PENDING",
          "status": "PENDING ZIELIES APPROVAL",
          "notes": (_notes.text.toString() == 'null')
              ? 'N/A'
              : _notes.text.toString(),
          "spanCompleted": (_spanCompleted2.text.toString() == 'null')
              ? 'N/A'
              : _spanCompleted2.text.toString(),
        };

        print('API called.........submitmedialfiles');
        // contractorRowMaintenanceProgressViewModelViewModel
        //     .fetchRowMaintenanceProgressContractorSubmitListApi(
        //         context, mapData);
        // });

        // setState(() {
        //   flag = 0;
        //   globalFeeder = '';
        //   globalSubstation = '';
        //   globalYear = '';
        //   globalCycle = '';
        //   _isVisibleUpdateMap = false;
        //   _isVisibleMixingForm = false;
        //   imagePaths = [];
        //   videoFlag = 0;
        //   _jobNo.clear();
        // });
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pop(context);
          // Navigator.pop(context);
          // Navigator.pop(context);
        });
      } else {
        print(
            "Failed to submit media files. Status code: ${response.statusCode}");
        print("Response body: ${response.body}");
      }
    } catch (e, stacktrace) {
      print('Exception: $e\n$stacktrace');
    }
  }

  Future<void> submitMediaFilesEditOldRecord(
      List<String> imagePaths, String videoPath, String tokenNo) async {
    print('Image Paths: $imagePaths');
    print('Video Path: $videoPath');

    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;

    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );
      var uri = Uri.parse(
          "https://civm2.ariespro.com/civm2/contractorPanel/uploadFiles");
      var request = http.MultipartRequest("POST", uri);

      final userPreferences = Provider.of<UserPref>(context, listen: false);
      UserModel data = await userPreferences.getUser();

      var headers = {
        "Content-Type": "multipart/form-data",
        "Accept": "*/*",
        "Authorization": 'Bearer ${data.token!}',
      };
      request.headers.addAll(headers);

      // Add images to the request
      List<http.MultipartFile> multipartFiles = [];
      for (int i = 0; i < imagePaths.length; i++) {
        String imagePath = imagePaths[i];

        if (imagePath.isNotEmpty) {
          File img = File(imagePath);

          File file = await img.copy(
              '$tempPath/img_${DateFormat('yyyyMMddHHmmss').format(DateTime.now())}_$i${imagePath.contains('.pdf') ? '.pdf' : '.jpg'}');

          var stream = http.ByteStream(file.openRead());
          var length = await file.length();

          var multipartFile = http.MultipartFile(
            "files",
            stream,
            length,
            filename: path.basename(file.path),
          );

          multipartFiles.add(multipartFile);
        }
      }

      // Add video to the request
      if (videoPath.isNotEmpty) {
        File videoFile = File(videoPath);
        File tempVideoFile = await videoFile.copy(
          '$tempPath/video_${DateFormat('MMddyyyyHHmmss').format(DateTime.now())}.mp4',
        );

        var videoStream = http.ByteStream(tempVideoFile.openRead());
        var videoLength = await tempVideoFile.length();

        var videoMultipartFile = http.MultipartFile(
          "files",
          videoStream,
          videoLength,
          filename: path.basename(tempVideoFile.path),
        );

        multipartFiles.add(videoMultipartFile);
      }

      // Add files to the request
      if (multipartFiles.isNotEmpty) {
        request.files.addAll(multipartFiles);
      }

      // Add additional fields
      request.fields['tokenNo'] = tokenNo;
      request.fields['vegId'] = vegId.toString();

      // Send the request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        print("Media files submitted successfully.");

        // Future.delayed(const Duration(seconds: 2), () {
        Map mapDataEditOldRecord = {
          "tblSubMilesCostId": tblSubMilesCostId,
          "subStateName": subStateName,
          "feeder": feeder,
          "street": street,
          "crew": crew,
          "totalMiles": totalMiles,
          "milesCompleted": _milesCompleted2.text.toString(),
          "milesInProgress": _milesInProgress2.text.toString(),
          "milesPending": _milesPending2.text.toString(),
          "performanceType": "",
          "wtdProgress": 0.0,
          "mtdProgress": 0.0,
          "ytdProgress": 0.0,
          "rowMethod": rowMethod,
          "delayCause": delayCause ?? '',
          "delayReason": reason ?? '',
          "effectedNoOfDays": (_affectedDays.text.toString() == 'null')
              ? 0
              : _affectedDays.text.toString(),
          "fileUpload": "N/A",
          "createDate": "2025-02-02T12:19:29.427+00:00",
          // "status": "PENDING",
          "status": "PENDING ZIELIES APPROVAL",
          "notes": _notes.text.toString(),
        };
        print('API called.........');
        //  updateVegetationCrewForm(mapDataEditOldRecord, idDuringUpdate);
        // });

        // setState(() {
        //   flag = 0;
        //   globalFeeder = '';
        //   globalSubstation = '';
        //   globalYear = '';
        //   globalCycle = '';
        //   _isVisibleUpdateMap = false;
        //   _isVisibleMixingForm = false;
        //   imagePaths = [];
        //   videoFlag = 0;
        //   _jobNo.clear();
        // });
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pop(context);
          // Navigator.pop(context);
          // Navigator.pop(context);
        });
      } else {
        print(
            "Failed to submit media files. Status code: ${response.statusCode}");
        print("Response body: ${response.body}");
      }
    } catch (e, stacktrace) {
      print('Exception: $e\n$stacktrace');
    }
  }

  Future<void> getVideoFileSize(BuildContext context, String videoPath) async {
    try {
      final videoFile = File(videoPath);
      final fileSizeInBytes = await videoFile.length();
      final fileSizeInKB = fileSizeInBytes / 1024;
      final fileSizeInMB = fileSizeInKB / 1024;

      // Format the sizes to display in the snackbar
      final fileSizeMessage = '''
    Video File Size:
    ${fileSizeInBytes.toStringAsFixed(2)} bytes
    ${fileSizeInKB.toStringAsFixed(2)} KB
    ${fileSizeInMB.toStringAsFixed(2)} MB
    ''';

      // Show snackbar with file size details
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(fileSizeMessage),
          duration: const Duration(seconds: 5),
        ),
      );
    } catch (e) {
      // Show snackbar with error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error getting video file size: $e'),
          duration: const Duration(seconds: 5),
        ),
      );
    }
  }

  void _showValidationErrorSnackBar(BuildContext context) {
    const snackBar = SnackBar(
      content: Text('Please fill all the mandatory fields!'),
      backgroundColor: Color.fromARGB(255, 219, 17, 2),
      duration: Duration(seconds: 3), // Optional: Adjust duration
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  String formatDateTime(String? dateString) {
    if (dateString == null || dateString.isEmpty) return '';

    try {
      // Parse the input string into a DateTime object
      DateTime date = DateTime.parse(dateString.split('.')[0]);

      // Format the date to MM-dd-yyyy
      String formattedDate = DateFormat('MM-dd-yyyy').format(date);

      // Format the time to HH:mm:ss
      String formattedTime = DateFormat('HH:mm:ss').format(date);

      // Combine the formatted date and time with a 'T'
      return '$formattedDate $formattedTime';
    } catch (e) {
      // Handle any errors
      return 'Invalid date';
    }
  }

  Future<void> updateVegetationCrewForm(
      Map mapDataEditOldRecord, int id) async {
    const String url =
        "https://civm2.ariespro.com/civm2/contractorPanel/updateVegetationCrewForm";
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    try {
      final response = await http.put(
        Uri.parse("$url?id=$id"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": 'Bearer ${data.token!}',
        },
        body: jsonEncode(mapDataEditOldRecord),
      );
      print("$url?id=$id");

      if (response.statusCode == 200) {
        print("Success: ${response.body}");
        CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
            'Successfully Updated.', context);
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Exception: $e");
    }
  }

  Future<bool> showExitPopup(context) async {
    return await showDialog(
      barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SizedBox(
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Do you want to exit the form?",
                      style: TextStyle(
                        color: Color.fromARGB(255, 7, 59, 120),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                          child: const Text("Yes",
                              style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red.shade800),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("No",
                            style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                      ))
                    ],
                  )
                ],
              ),
            ),
          );
        });
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
