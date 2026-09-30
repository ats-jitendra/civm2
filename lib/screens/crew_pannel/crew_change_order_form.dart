import 'dart:convert';
import 'dart:io';
// import 'package:CIVM/screens/crew_pannel/camera.dart';
import 'package:CIVM/repository/map_url.dart';
import 'package:CIVM/screens/video_folder/bloc/camera_bloc.dart';
import 'package:CIVM/screens/video_folder/utils/camera_utils.dart';
import 'package:CIVM/screens/video_folder/utils/permission_utils.dart';
import 'package:CIVM/screens/video_folder/view/pages/camera_page.dart';
import 'package:camera/camera.dart';
import 'package:CIVM/data/response/status.dart';
import 'package:CIVM/models/contractor_row_maintenance_progress_model.dart';
import 'package:CIVM/models/user_model.dart';
// import 'package:CIVM/screens/crew_pannel/Crewedit_ivmTimeSheet.dart';
// import 'package:CIVM/screens/crew_pannel/crewEdit_dailyHerbicide_cntractor.dart';
// import 'package:CIVM/screens/crew_pannel/crewEdit_mixingInventory.dart';
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
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

// ignore: must_be_immutable
class CrewChangeOrderForm extends StatefulWidget {
  String jobNo;
  String substation;
  String feeder;
  String streetAddress;
  String mapLocation;
  String substationId;
  String feederId;
  String maintenanceType;
  String inspectionDate;
  String followUpDate;
  CrewChangeOrderForm({
    Key? key,
    required this.jobNo,
    required this.substation,
    required this.feeder,
    required this.streetAddress,
    required this.mapLocation,
    required this.substationId,
    required this.feederId,
    required this.maintenanceType,
    required this.followUpDate,
    required this.inspectionDate,
  }) : super(key: key);
  @override
  State<CrewChangeOrderForm> createState() => _CrewChangeOrderFormState();
}

class _CrewChangeOrderFormState extends State<CrewChangeOrderForm> {
  final TextEditingController _totalMiles = TextEditingController();
  final TextEditingController _milesCompleted = TextEditingController();
  final TextEditingController _milesInProgress = TextEditingController();
  final TextEditingController _milesPending = TextEditingController();
  final TextEditingController _milesCompleted2 = TextEditingController();
  final TextEditingController _milesInProgress2 = TextEditingController();
  final TextEditingController _affectedDays = TextEditingController();
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

  String datetime = DateTime.now().toString();
  // File? image;
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

  VideoPlayerController? _controller;
  XFile? _videoFile;

  bool isVideoInitialized = false;
  String? videoControllerString;

  int videoFlag = 0;

  var _setState;
  String videoPath = '';

  String formattedDate = '';

  double backendEditMilesCompleted = 0.0;

  String previousMilesCompleted = '';

  @override
  void initState() {
    fetchData(widget.jobNo);
    setDataForCalculation();
    cameraInit();
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
          title: const Row(
            children: [
              Expanded(
                child: Text(
                  "View Change Order Form",
                  //'Change Order Form',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          backgroundColor: const Color.fromARGB(255, 7, 59, 120),
        ),
        body: ChangeNotifierProvider<ContractorRowMaintenanceProgressViewModelViewModel>(
          create: (BuildContext context) =>
              contractorRowMaintenanceProgressViewModelViewModel,
          child: Consumer<ContractorRowMaintenanceProgressViewModelViewModel>(
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
                      top: 16.0,
                      bottom: 16,
                      left: 8,
                      right: 8,
                    ),
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
                    List<GetAllList> list,
                  ) {
                    return list.map((item) {
                      return {
                        'orderNo': item.orderNo,
                        'substation': item.substation,
                        'feeder': item.feeder,
                        'feederId': item.feederId,
                        'substationId': item.substationId,
                      };
                    }).toList();
                  }
                  List<GetAllList>
                  dataList = contractorRowMaintenanceProgressViewModelViewModel
                      .contractorRowMaintenanceProgressViewModelGetTabularData
                      .data!
                      .getAllList!;
                  List<Map<String, dynamic>> mappedDataList = convertToMapList(
                    dataList,
                  );
                  print('mappedDataList $mappedDataList');
                  if (flag == 1) {
                    extractAndStoreSubstationFeeder(mappedDataList);
                  }

                  return SingleChildScrollView(
                    controller: _scrollController,
                    child: Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                              left: 8,
                              right: 8,
                              top: 10,
                              bottom: 8,
                            ),
                            padding: const EdgeInsets.all(8),
                            alignment: Alignment.center,
                            // height: size.height * 0.5,
                            width: size.width * 0.99,
                            decoration: BoxDecoration(
                              // shape: BoxShape.circle,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromARGB(255, 7, 59, 120),
                                  blurRadius: 10,
                                  offset: Offset(2.0, 5.0),
                                ),
                              ],
                              gradient: const LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 255, 255, 255),
                                  Color.fromARGB(255, 255, 255, 255),
                                ],
                              ),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  alignment: Alignment.center,
                                  width: size.width * 0.99,
                                  decoration: const BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color.fromARGB(255, 3, 47, 97),
                                        blurRadius: 5,
                                        offset: Offset(2.0, 5.0),
                                      ),
                                    ],
                                    gradient: LinearGradient(
                                      colors: [
                                        Color.fromARGB(255, 7, 59, 120),
                                        Color.fromARGB(255, 7, 59, 120),
                                      ],
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            const Text(
                                              "JOB NO: ",
                                              //textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                            Text(
                                              widget.jobNo,
                                              // globalSubstation,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 20.0,
                                    left: 4,
                                  ),
                                  child: Row(
                                    children: [
                                      const Expanded(
                                        child: Text(
                                          "SUBSTATION: ",
                                          //textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                              255,
                                              7,
                                              59,
                                              120,
                                            ),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          widget.substation,
                                          // globalSubstation,
                                          style: const TextStyle(
                                            color: Color.fromARGB(
                                              255,
                                              7,
                                              59,
                                              120,
                                            ),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 20.0,
                                    left: 4,
                                  ),
                                  child: Row(
                                    children: [
                                      const Expanded(
                                        child: Text(
                                          "FEEDER: ",
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                              255,
                                              7,
                                              59,
                                              120,
                                            ),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          widget.feeder,
                                          // globalFeeder,
                                          style: const TextStyle(
                                            color: Color.fromARGB(
                                              255,
                                              7,
                                              59,
                                              120,
                                            ),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 20.0,
                                    left: 4,
                                  ),
                                  child: Row(
                                    children: [
                                      const Expanded(
                                        child: Text(
                                          "SERVICE STREET ADDRESS: ",
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                              255,
                                              7,
                                              59,
                                              120,
                                            ),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          widget.streetAddress,
                                          // globalFeeder,
                                          style: const TextStyle(
                                            color: Color.fromARGB(
                                              255,
                                              7,
                                              59,
                                              120,
                                            ),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 20.0,
                                    left: 4,
                                  ),
                                  child: Row(
                                    children: [
                                      const Expanded(
                                        child: Text(
                                          "SERVICE MAP LOCATION: ",
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                              255,
                                              7,
                                              59,
                                              120,
                                            ),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          widget.mapLocation,
                                          // globalFeeder,
                                          style: const TextStyle(
                                            color: Color.fromARGB(
                                              255,
                                              7,
                                              59,
                                              120,
                                            ),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 20.0,
                                    left: 4,
                                  ),
                                  child: Row(
                                    children: [
                                      const Expanded(
                                        child: Text(
                                          "FOLLOW UP DATE: ",
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                              255,
                                              7,
                                              59,
                                              120,
                                            ),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          formatToMMDDYYYY(widget.followUpDate),
                                          // globalSubstation,
                                          style: const TextStyle(
                                            color: Color.fromARGB(
                                              255,
                                              7,
                                              59,
                                              120,
                                            ),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 20.0,
                                    left: 4,
                                  ),
                                  child: Row(
                                    children: [
                                      const Expanded(
                                        child: Text(
                                          "INSPECTION DATE: ",
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                              255,
                                              7,
                                              59,
                                              120,
                                            ),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          formatToMMDDYYYY(
                                            widget.inspectionDate,
                                          ),
                                          // globalFeeder,
                                          style: const TextStyle(
                                            color: Color.fromARGB(
                                              255,
                                              7,
                                              59,
                                              120,
                                            ),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: 2.0,
                                      right: 2.0,
                                      bottom: 2.0,
                                      top: 20.0,
                                    ),
                                    child: Text(
                                      "COMMENTS",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Color.fromARGB(255, 7, 59, 120),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: TextFormField(
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
                                        hintText: 'Comments',
                                      ),
                                      validator: (value) {},
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 10.0),
                                  child: InkWell(
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
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) =>
                                      //         MapViewPage(
                                      //       url: MapUrl.getGfEndPoint(
                                      //           widget.jobNo, id),
                                      //     ),
                                      //   ),
                                      // );
                                      await browser.open(
                                        url: WebUri(
                                          MapUrl.getCrewEndPoint(
                                            widget.jobNo,
                                            id,
                                          ),
                                        ),
                                        // "https://mapapi.ariespro.com/main/crew/CIVM_Map/$selectedChangeOrderNo/USRQWXH589Z"),
                                        settings: ChromeSafariBrowserSettings(
                                          shareState: CustomTabsShareState
                                              .SHARE_STATE_OFF,
                                          barCollapsingEnabled: true,
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                        left: 40,
                                        right: 40,
                                        bottom: 10.0,
                                      ),
                                      // padding: const EdgeInsets.all(8),
                                      alignment: Alignment.center,
                                      width: MediaQuery.of(context).size.width,
                                      // height: 40,
                                      decoration: const BoxDecoration(
                                        // shape: BoxShape.circle,
                                        // borderRadius:
                                        // BorderRadius.circular(25),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color.fromARGB(
                                              255,
                                              3,
                                              47,
                                              97,
                                            ),
                                            blurRadius: 5,
                                            offset: Offset(2.0, 5.0),
                                          ),
                                        ],
                                        gradient: LinearGradient(
                                          colors: [
                                            Color.fromARGB(255, 7, 59, 120),
                                            Color.fromARGB(255, 7, 59, 120),
                                          ],
                                        ),
                                      ),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "MAP",
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
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 2.0),
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                        left: 40,
                                        right: 40,
                                        bottom: 10.0,
                                      ),
                                      // padding: const EdgeInsets.all(8),
                                      alignment: Alignment.center,
                                      width: MediaQuery.of(context).size.width,
                                      // height: 40,
                                      decoration: const BoxDecoration(
                                        // shape: BoxShape.circle,
                                        // borderRadius:
                                        // BorderRadius.circular(25),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color.fromARGB(
                                              255,
                                              3,
                                              47,
                                              97,
                                            ),
                                            blurRadius: 5,
                                            offset: Offset(2.0, 5.0),
                                          ),
                                        ],
                                        gradient: LinearGradient(
                                          colors: [
                                            Color.fromARGB(255, 7, 59, 120),
                                            Color.fromARGB(255, 7, 59, 120),
                                          ],
                                        ),
                                      ),
                                      child: InkWell(
                                        onTap: () async {
                                          // pickImageOptions();
                                          _takePictureDialog();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: const Text(
                                            'CAMERA',
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: List.generate(imagePaths.length, (
                                        index,
                                      ) {
                                        return Container(
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: 5,
                                          ),
                                          width: 100,
                                          child: Stack(
                                            children: [
                                              Center(
                                                child: Image.file(
                                                  File(imagePaths[index]),
                                                  height: 100,
                                                  width: 100,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Positioned(
                                                top: 0,
                                                right: 0,
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      // Remove the image path from the list
                                                      imagePaths.removeAt(
                                                        index,
                                                      );
                                                      images.removeAt(
                                                        index,
                                                      ); // Also remove from images list
                                                    });
                                                    // Call your API to delete the image
                                                    deleteOnlineImageApi(
                                                      imagePaths[index],
                                                      selectedChangeOrderNo,
                                                    );
                                                  },
                                                  child: const Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                    size: 30,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom:16.0),
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                      left: 6,
                                      right: 6,
                                      top: 10.0,
                                      bottom: 10,
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        print('before formkey validation');
                                        if (_formkey.currentState!.validate()) {
                                          openDialogToCompleteWork(widget.jobNo);
                                          print('name1');
                                        } else {
                                          print(
                                            "Please fill all mendetory fields!!!",
                                          );
                                          _showValidationErrorSnackBar(context);
                                        }
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                          left: 40,
                                          right: 40,
                                          bottom: 10.0,
                                        ),
                                        // padding: const EdgeInsets.all(8),
                                        alignment: Alignment.center,
                                        // width: MediaQuery.of(context).size.width,
                                        // height: 60,
                                        decoration: const BoxDecoration(
                                          // borderRadius:
                                          //     BorderRadius.circular(10),
                                          boxShadow: [
                                           BoxShadow(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          3,
                                                                          47,
                                                                          97),
                                                                  blurRadius: 5,
                                                                  offset:
                                                                      Offset(
                                                                          2.0,
                                                                          5.0))
                                                            ],
                                                                gradient:
                                                                    LinearGradient(
                                                                  colors: [
                                                                    Color.fromARGB(
                                                                        255,
                                                                        7,
                                                                        59,
                                                                        120),
                                                                    Color
                                                                        .fromARGB(
                                                                            255,
                                                                            7,
                                                                            59,
                                                                            120)
                                                                  ],
                                          ),
                                        ),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: FittedBox(
                                                            fit: BoxFit.scaleDown,
                                              child: Text(
                                                "SUBMIT COMPLETED JOB",
                                                // "SAVE",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                ),
                                              ),
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
                  );
                default:
                  return const Text('data');
              }
            },
          ),
        ),
      ),
    );
  }

  fetchData(String tokenNo) async {
    print('111111111111');
    _affectedDays.text = '0';
    // if (tokenNo.isEmpty) {
    print('222222');
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    await contractorRowMaintenanceProgressViewModelViewModel
        .fetchContractorRowMaintenanceProgressViewModelTabularListApi(
          context,
          data.user!.id.toString(),
          tokenNo,
        );
    await Future.delayed(const Duration(seconds: 4));
    print('333333');
    if (tokenNo != '') {
      setData();
      _isVisibleUpdateMap = true;
    }
    print('444444');
    if (widget.maintenanceType == 'CROSS-COUNTRY SPRAY' ||
        widget.maintenanceType == 'ROADSIDE SPRAY' ||
        widget.maintenanceType == 'NO SPRAY' ||
        widget.maintenanceType == 'CROSS-COUNTRY SPRAY, ROADSIDE SPRAY' ||
        widget.maintenanceType == 'CROSS-COUNTRY SPRAY, NO SPRAY' ||
        widget.maintenanceType == 'ROADSIDE SPRAY, NO SPRAY') {
      print('if condition of maintenance type ${widget.maintenanceType}');
      setState(() {});
    } else {
      print('else condition of maintenance type ${widget.maintenanceType}');
    }
    String budgetType = '';
    budgetType =
        (contractorRowMaintenanceProgressViewModelViewModel
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

  setData() {
    print(
      'totalmiles----- ${contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.findAllByTokenNumbers![0].totalMiles}',
    );
    print(
      'MilesCompleted-----${contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.findAllByTokenNumbers![0].milesCompleted}',
    );
    print(
      'MilesInProgress-----${contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.findAllByTokenNumbers![0].milesInProgress}',
    );
    setState(() {
      _totalMiles.text =
          (contractorRowMaintenanceProgressViewModelViewModel
                      .contractorRowMaintenanceProgressViewModelGetTabularData
                      .data!
                      .findAllByTokenNumbers![0]
                      .totalMiles ==
                  null ||
              contractorRowMaintenanceProgressViewModelViewModel
                      .contractorRowMaintenanceProgressViewModelGetTabularData
                      .data!
                      .findAllByTokenNumbers![0]
                      .totalMiles
                      .toString() ==
                  'null')
          ? '0'
          : double.parse(
              contractorRowMaintenanceProgressViewModelViewModel
                  .contractorRowMaintenanceProgressViewModelGetTabularData
                  .data!
                  .findAllByTokenNumbers![0]
                  .totalMiles
                  .toString(),
            ).toStringAsFixed(2);
      print('aaaaaaaaaaaaaaaaaaa');
      _milesCompleted.text =
          (contractorRowMaintenanceProgressViewModelViewModel
                      .contractorRowMaintenanceProgressViewModelGetTabularData
                      .data!
                      .findAllByTokenNumbers![0]
                      .milesCompleted ==
                  null ||
              contractorRowMaintenanceProgressViewModelViewModel
                      .contractorRowMaintenanceProgressViewModelGetTabularData
                      .data!
                      .findAllByTokenNumbers![0]
                      .milesCompleted
                      .toString() ==
                  'null')
          ? '0'
          : double.parse(
              contractorRowMaintenanceProgressViewModelViewModel
                  .contractorRowMaintenanceProgressViewModelGetTabularData
                  .data!
                  .findAllByTokenNumbers![0]
                  .milesCompleted
                  .toString(),
            ).toStringAsFixed(2);

      globalCycle =
          (contractorRowMaintenanceProgressViewModelViewModel
                      .contractorRowMaintenanceProgressViewModelGetTabularData
                      .data!
                      .findAllByTokenNumbers![0]
                      .cycle ==
                  null ||
              contractorRowMaintenanceProgressViewModelViewModel
                      .contractorRowMaintenanceProgressViewModelGetTabularData
                      .data!
                      .findAllByTokenNumbers![0]
                      .cycle
                      .toString() ==
                  'null')
          ? '0'
          : contractorRowMaintenanceProgressViewModelViewModel
                .contractorRowMaintenanceProgressViewModelGetTabularData
                .data!
                .findAllByTokenNumbers![0]
                .cycle
                .toString();

      var nextMaintDue = contractorRowMaintenanceProgressViewModelViewModel
          .contractorRowMaintenanceProgressViewModelGetTabularData
          .data!
          .findAllByTokenNumbers![0]
          .nextMaintDue;

      globalYear = (nextMaintDue == null || nextMaintDue.toString() == 'null')
          ? '0'
          : DateFormat('yyyy').format(DateTime.parse(nextMaintDue.toString()));

      print('globalYear111111111111 $globalYear');

      print('bbbbbbbbbbbbbbbbbbbbbbbbbbbb');
      _milesInProgress.text =
          (contractorRowMaintenanceProgressViewModelViewModel
                      .contractorRowMaintenanceProgressViewModelGetTabularData
                      .data!
                      .findAllByTokenNumbers![0]
                      .milesInProgress ==
                  null ||
              contractorRowMaintenanceProgressViewModelViewModel
                      .contractorRowMaintenanceProgressViewModelGetTabularData
                      .data!
                      .findAllByTokenNumbers![0]
                      .milesInProgress
                      .toString() ==
                  'null')
          ? '0'
          : double.parse(
              contractorRowMaintenanceProgressViewModelViewModel
                  .contractorRowMaintenanceProgressViewModelGetTabularData
                  .data!
                  .findAllByTokenNumbers![0]
                  .milesInProgress
                  .toString(),
            ).toStringAsFixed(2);
      print('cccccccccccccccccccccccc');
      _milesPending.text =
          (contractorRowMaintenanceProgressViewModelViewModel
                      .contractorRowMaintenanceProgressViewModelGetTabularData
                      .data!
                      .findAllByTokenNumbers![0]
                      .milesPending ==
                  null ||
              contractorRowMaintenanceProgressViewModelViewModel
                      .contractorRowMaintenanceProgressViewModelGetTabularData
                      .data!
                      .findAllByTokenNumbers![0]
                      .milesPending
                      .toString() ==
                  'null')
          ? '0'
          : double.parse(
              contractorRowMaintenanceProgressViewModelViewModel
                  .contractorRowMaintenanceProgressViewModelGetTabularData
                  .data!
                  .findAllByTokenNumbers![0]
                  .milesPending
                  .toString(),
            ).toStringAsFixed(2);
      print('dddddddddddddddddddddddd');
      crewName =
          (contractorRowMaintenanceProgressViewModelViewModel
                      .contractorRowMaintenanceProgressViewModelGetTabularData
                      .data!
                      .findCrewOrderNo![0]
                      .crew ==
                  null ||
              contractorRowMaintenanceProgressViewModelViewModel
                      .contractorRowMaintenanceProgressViewModelGetTabularData
                      .data!
                      .findCrewOrderNo![0]
                      .crew
                      .toString() ==
                  'null')
          ? '0'
          : contractorRowMaintenanceProgressViewModelViewModel
                .contractorRowMaintenanceProgressViewModelGetTabularData
                .data!
                .findCrewOrderNo![0]
                .crew
                .toString();

      print('crewName $crewName');
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
      Permission.photos,
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
    bool isGranted =
        statusCamera == PermissionStatus.granted &&
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
        "https://civm2.ariespro.com/civm2/contractorPanel/updateImageVEGETATION_CREW_FORMs",
      );
      var request = http.MultipartRequest("POST", uri);

      // Get the user token
      final userPreferences = Provider.of<UserPref>(context, listen: false);
      UserModel data = await userPreferences.getUser();

      // Set headers
      var headers = {
        "Content-Type": "multipart/form-data",
        "Accept": "*/*",
        "Authorization": 'Bearer ${data.token!}',
      };
      List<http.MultipartFile> multipartFiles = [];

      for (int i = 0; i < imagePaths.length; i++) {
        String imagePath = imagePaths[i];

        if (imagePath.isNotEmpty) {
          File img = File(imagePath);

          File file = await img.copy(
            '$tempPath/img_${DateFormat('yyyyMMddHHmmss').format(DateTime.now())}_$i${imagePath.contains('.pdf') ? '.pdf' : '.jpg'}',
          );

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

      if (multipartFiles.isNotEmpty) {
        request.files.addAll(multipartFiles); // Add all the selected files
      }

      request.fields['tokenNo'] = tokenNo;
      request.headers.addAll(headers);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        print("Images submitted successfully.");
        Map<String, String> mapData = {
          "tokenNo": widget.jobNo,
          // "status": "COMPLETED",
          "status": "PENDING APPROVAL",
          "crewNotes": (_notes.text.toString() == 'null')
              ? 'N/A'
              : _notes.text.toString(),
        };
        print('API called.........');
        updateStatusAndCrewNotes(context, mapData);
        setState(() {
          flag = 0;
          globalFeeder = '';
          globalSubstation = '';
          imagePaths = [];
          videoFlag = 0;
          _jobNo.clear();
        });
        // Future.delayed(const Duration(seconds: 5), () {
        //   Navigator.pop(context);
        //   Navigator.pop(context);
        //   Navigator.pop(context);
        //   Navigator.pop(context);
        // });

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
            .toString(),
      );
      print('totalMilesFromBackend $totalMilesFromBackend');
      double milesCompletedFromBackend = double.parse(
        contractorRowMaintenanceProgressViewModelViewModel
            .contractorRowMaintenanceProgressViewModelGetTabularData
            .data!
            .findAllByTokenNumbers![0]
            .milesCompleted
            .toString(),
      );
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
            .toString(),
      );
      print('totalMilesFromBackend $totalMilesFromBackend');
      double milesCompletedFromBackend = double.parse(
        contractorRowMaintenanceProgressViewModelViewModel
            .contractorRowMaintenanceProgressViewModelGetTabularData
            .data!
            .findAllByTokenNumbers![0]
            .milesCompleted
            .toString(),
      );
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
    print(
      contractorRowMaintenanceProgressViewModelViewModel
          .contractorRowMaintenanceProgressViewModelGetTabularData
          .data!
          .getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList!
          .length,
    );
  }

  Future<void> updateStatus(String id) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
    try {
      final userPreferences = Provider.of<UserPref>(context, listen: false);
      UserModel data = await userPreferences.getUser();
      final String apiUrl =
          "https://civm2.ariespro.com/civm2/contractorPanel/updateStatusByIds/$id";
      print(apiUrl);
      Map<String, dynamic> updatedData = {"status": "new_status"};
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
          'Successfully Submitted for Review',
          context,
        );
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
      Navigator.of(
        context,
      ).pop(); // Close the loading dialog in case of an error
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
    _camerasController
        .initialize()
        .then((_) {
          if (!mounted) {
            return;
          }
          setState(() {});
        })
        .catchError((Object e) {
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
        return StatefulBuilder(
          builder: (context, setState) {
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
                              offset: Offset(2.0, 5.0),
                            ),
                          ],
                          color: Colors.black,
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(255, 7, 40, 97),
                              Color.fromARGB(255, 7, 40, 97),
                              Color.fromARGB(255, 7, 40, 97),
                            ],
                          ),
                        ),
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
              ],
            );
          },
        );
      },
    );
  }

  void refreshPath(String path, XFile imageARG) {
    setState(() {
      imagePaths.add(path);
      images.add(imageARG);
    });
  }

  void extractAndStoreSubstationFeeder(
    List<Map<String, dynamic>> mappedDataList,
  ) {
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
      return StatefulBuilder(
        builder: (context, setState) {
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
                                  left: 4,
                                  right: 4,
                                  bottom: 10.0,
                                ),
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
                                      offset: Offset(2.0, 5.0),
                                    ),
                                  ],
                                  color: Colors.black,
                                  gradient: LinearGradient(
                                    colors: [
                                      Color.fromARGB(255, 7, 40, 97),
                                      Color.fromARGB(255, 7, 40, 97),
                                    ],
                                  ),
                                ),
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
                                        )..add(
                                          const CameraInitialize(
                                            recordingLimit: 15,
                                          ),
                                        );
                                      },
                                      child: CameraPage(
                                        callback: (file) async {
                                          _videoController =
                                              VideoPlayerController.file(file);

                                          setState(() {
                                            videoFlag = 1;
                                          });
                                          // kdmk
                                          initializeVideo();
                                          //  getVideoFileSize(context, videoPath);
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                  left: 4,
                                  right: 4,
                                  bottom: 10.0,
                                ),
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
                                      offset: Offset(2.0, 5.0),
                                    ),
                                  ],
                                  color: Colors.black,
                                  gradient: LinearGradient(
                                    colors: [
                                      Color.fromARGB(255, 7, 40, 97),
                                      Color.fromARGB(255, 7, 40, 97),
                                    ],
                                  ),
                                ),
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
        },
      );
    },
  );

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

  void _showValidationErrorSnackBar(BuildContext context) {
    const snackBar = SnackBar(
      content: Text('Please fill all the mandatory fields!'),
      backgroundColor: Color.fromARGB(255, 219, 17, 2),
      duration: Duration(seconds: 3), // Optional: Adjust duration
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                        child: const Text(
                          "Yes",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade800,
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "No",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void openDialogToCompleteWork(String tokenNo) => showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Are you sure you want to submit this work?",
                        // textAlign: TextAlign.left,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 7, 59, 120),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
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
                    Container(
                      margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.15,
                        top: 6.0,
                        bottom: 10,
                        right: 2,
                      ),
                      child: InkWell(
                        onTap: () {
                          if (imagePaths.isNotEmpty) {
                            print('if condition 1222');
                            submitImage(imagePaths, selectedChangeOrderNo!);
                          } else {
                            print('else condition1222');
                            Map<String, String> mapData = {
                              "tokenNo": widget.jobNo,
                              // "status": "COMPLETED",
                              "status": "PENDING APPROVAL",
                              "crewNotes": _notes.text.toString(),
                            };
                            print('API called.........');
                            updateStatusAndCrewNotes(context, mapData);
                            print('mapData');
                            print(mapData);
                            // Future.delayed(const Duration(seconds: 5), () {
                            //   Navigator.pop(context);
                            //   Navigator.pop(context);
                            //   Navigator.pop(context);
                            //   Navigator.pop(context);
                            // });
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10.0),
                          // padding: const EdgeInsets.all(8),
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.25,
                          height: 40,
                          decoration: BoxDecoration(
                            // shape: BoxShape.circle,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(255, 1, 91, 4),
                                blurRadius: 5,
                                offset: Offset(2.0, 5.0),
                              ),
                            ],
                            color: Colors.black,
                            gradient: const LinearGradient(
                              colors: [Colors.green, Colors.green],
                            ),
                          ),
                          child: const Align(
                            alignment: Alignment.center,
                            child: Text(
                              "YES",
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
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 6, top: 6.0, bottom: 10),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10.0),
                          // padding: const EdgeInsets.all(8),
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.25,
                          height: 40,
                          decoration: BoxDecoration(
                            // shape: BoxShape.circle,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(255, 84, 7, 2),
                                blurRadius: 5,
                                offset: Offset(2.0, 5.0),
                              ),
                            ],
                            color: Colors.black,
                            gradient: const LinearGradient(
                              colors: [Colors.red, Colors.red],
                            ),
                          ),
                          child: const Align(
                            alignment: Alignment.center,
                            child: Text(
                              "CANCEL",
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

  Future<void> updateStatusAndCrewNotes(
    BuildContext context,
    Map<String, String> mappedData,
  ) async {
    String apiUrl =
        'https://civm2.ariespro.com/civm2/changeOrderLcpCreateOrder/updateStatusAndCrewNotesByTokenNo';

    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();

    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(child: CircularProgressIndicator());
        },
      );

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${data.token}',
        },
        body: jsonEncode(mappedData),
      );
      if (context.mounted) {
        Navigator.pop(context);
      }

      if (response.statusCode == 200) {
        print('✅ Update Successful');
        if (context.mounted) {
          CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
            'Status and Crew Notes Updated Successfully',
            context,
          );
        }
        // Future.delayed(const Duration(seconds: 5), () {
        //                         Navigator.pop(context);
        //                         Navigator.pop(context);
        //                         Navigator.pop(context);
        //                         Navigator.pop(context);
        //                       });
        Future.delayed(const Duration(seconds: 5), () {
          if (!context.mounted) return;

          int count = 0;
          Navigator.of(context).popUntil((_) => count++ >= 5);
        });
      } else {
        print('❌ API Error: ${response.body}');
        if (context.mounted) {
          CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            'Failed to update. Try again!',
            context,
          );
        }
      }
    } catch (error) {
      print('❌ Exception: $error');
      if (context.mounted) {
        Navigator.pop(context);
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
          "Something went wrong",
          context,
        );
      }
    }
  }

  String formatToMMDDYYYY(dynamic dateValue) {
    if (dateValue == null) return '';

    DateTime? dateTime;

    // If it's already DateTime
    if (dateValue is DateTime) {
      dateTime = dateValue;
    }
    // If it's a String
    else if (dateValue is String && dateValue.isNotEmpty) {
      try {
        // Try ISO format first (most common)
        dateTime = DateTime.parse(dateValue);
      } catch (_) {
        // Try common fallback formats
        final formats = [
          'yyyy-MM-dd',
          'dd-MM-yyyy',
          'MM-dd-yyyy',
          'yyyy/MM/dd',
          'dd/MM/yyyy',
          'MM/dd/yyyy',
        ];

        for (final format in formats) {
          try {
            dateTime = DateFormat(format).parse(dateValue);
            break;
          } catch (_) {}
        }
      }
    }

    if (dateTime == null) return '';

    return DateFormat('MM-dd-yyyy').format(dateTime);
  }
}
