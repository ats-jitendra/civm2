import 'dart:convert';
import 'package:CIVM/piedmont/models/service_order_model.dart';
import 'package:CIVM/piedmont/repository/map_url.dart';
import 'package:CIVM/piedmont/resources/app_colors.dart';
import 'package:CIVM/piedmont/resources/app_url.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/image_paint_screen.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/pdf_view.dart';
import 'package:CIVM/piedmont/screens/my_chrome_safari_map_recording.dart';
import 'package:CIVM/piedmont/screens/video_folder/fullVideo/full_screen_video_player.dart';
import 'package:CIVM/piedmont/utils/common_functions.dart';
import 'package:CIVM/piedmont/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/piedmont/view_model/image_code_view_model.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/models/user_model.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class SupervisorSOView extends StatefulWidget {
  String tokenNo;
  String status;
  String soNo;

  SupervisorSOView({
    Key? key,
    required this.tokenNo,
    required this.status,
    required this.soNo,
  }) : super(key: key);

  @override
  State<SupervisorSOView> createState() => _SupervisorSOViewState();
}

class _SupervisorSOViewState extends State<SupervisorSOView> {
  final TextEditingController _notes = TextEditingController();
  DateTime currentDate = DateTime.now();

  ImageViewViewModel imageViewModel = ImageViewViewModel();
  Future? myFuture;
  List<String> crewList = ["FrankMendez"];
  bool isLoading = false;
  bool isSubmitLoading = false;
  bool _isApproveLoading = false;
  final TextEditingController _shareComments = TextEditingController();

  @override
  void initState() {
    myFuture = Future.wait([
      fetchDetails(context),
      imageViewModel.fetchImageApi(context, widget.soNo),
    ]);
    print('widget.tokenNo ${widget.tokenNo}');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final browser = MyChromeSafariBrowser();
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Service Order Data",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.baseColor,
      ),
      //   backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: FutureBuilder(
          future: myFuture,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

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
                  myFuture = Future.wait([
                    fetchDetails(context),
                    imageViewModel.fetchImageApi(context, widget.soNo),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    "SERVICE ORDER NO : ${item!.bISONBR}",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),

                                /// STATUS BADGE
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: getStatusColorPemc(widget.status),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    widget.status,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            //second row
                            // if (widget.status.toString() == "OPEN")
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                      if (widget.status.toString() == "OPEN")
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
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: InkWell(
                                            onTap: () async {
                                              showCrewDialog(
                                                context,
                                                "",
                                                item?.bISONBR ?? '',
                                              );
                                            },
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
                                   // SizedBox()
                                   Spacer(),
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
                                            MapUrl.supervisorServiceMapEndPoint(
                                              id,item!.bISONBR.toString()
                                            ),
                                          ),
                                          settings: ChromeSafariBrowserSettings(
                                            shareState: CustomTabsShareState
                                                .SHARE_STATE_OFF,
                                            barCollapsingEnabled: true,
                                          ),
                                        );
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
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
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
                            ///  DETAILS CARD
                            _buildDetailCard(
                              icon: Icons.numbers,
                              title: "Account No.",
                              value: item?.aCCOUNTNO ?? "",
                            ),
                            _buildDetailCard(
                              icon: Icons.person,
                              title: "Name",
                              value: item?.bISOFULLNM ?? "",
                            ),
                            _buildDetailCard(
                              icon: Icons.location_city,
                              title: "Address",
                              value: item?.aDDRESS ?? "",
                            ),
                            _buildDetailCard(
                              icon: Icons.code,
                              title: "Zip",
                              value: item?.zIP ?? "",
                            ),
                            _buildDetailCard(
                              icon: Icons.phone,
                              title: "Phone Number",
                              value: item?.pHONE ?? "",
                            ),
                            _buildDetailCard(
                              icon: Icons.build,
                              title: "Type",
                              value: item?.bISOTYPECD ?? "",
                            ),
                            _buildDetailCard(
                              icon: Icons.date_range,
                              title: "Open Date",
                              value: formatDateIfNeeded(
                                item?.bIOPENDT ?? "".toString(),
                              ),
                            ),

                            _buildDetailCard(
                              icon: Icons.description,
                              title: "Description",
                              value: item?.bISODESC ?? "",
                            ),

                            _buildDetailCard(
                              icon: Icons.notes,
                              title: "Supervisor Notes",
                              value: item?.sUPERVISORNOTES ?? "",
                            ),

                            _buildDetailCard(
                              icon: Icons.notes,
                              title: "Foreman Notes",
                              value: item?.tANDMNOTES ?? "",
                            ),

                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                width: 105,
                                // double.infinity,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade50,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.blue),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.image, color: Colors.blue),
                                    SizedBox(width: 8),
                                    Text(
                                      "Images",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),

                            ///  IMAGE GRID VIEW
                            _buildImageGrid(),

                            const SizedBox(height: 8),

                            if (widget.status.toString() == "OPEN")
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 12,
                                      bottom: 12,
                                      left: 12,
                                      right: 12,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            _notes.clear();
                                            openDailogClose(
                                              item!.bISONBR.toString(),
                                            );
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 8,
                                              horizontal: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: const Color.fromARGB(
                                                    255,
                                                    26,
                                                    89,
                                                    28,
                                                  ),
                                                  blurRadius: 6,
                                                  offset: const Offset(0, 3),
                                                ),
                                              ],
                                            ),
                                            alignment: Alignment.center,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 8.0,
                                                right: 8,
                                              ),
                                              child: const Text(
                                                "CLOSE",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                    /////ACTION BUTTONS
                    if (widget.status.toString() == "PENDING APPROVAL")
                      InkWell(
                        onTap: () {
                          openDailogPendingApproval(item?.bISONBR ?? '');
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                            top: 12,
                            bottom: 12,
                            left: 12,
                            right: 12,
                          ),
                          width: 200,
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.green.withOpacity(0.3),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            "Submit for Approval",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                    // buildField("SERVICE ORDER NO.", _serviceOrderNo),
                    // buildField("TYPE", _type),
                    // buildField("STATUS", _status),
                    // buildField("OPEN DATE", _openDate),
                    // buildField("DESCRIPTION", _description),

                    // const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
    value: item,
    child: Text(
      item,
      style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
    ),
  );

  ///  REUSABLE TILE
  Widget _buildDetailCard({
    required IconData icon,
    required String title,
    required String value,
    VoidCallback? onTapValue,
    FontWeight? fontWeight,
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
          crossAxisAlignment: CrossAxisAlignment.start,
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
              flex: 2,
              child: Text(
                "$title ",
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
                  style: TextStyle(fontWeight: fontWeight, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ServiceOrderForReviewData? item;

  Future<void> fetchDetails(BuildContext context) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    // id = data.user!.id.toString();
    var url =
        "${AppUrl.getServiceOrderByStatus}?status=${widget.status}&tokenNo=${widget.tokenNo}";

    print('url $url');

    var headers = {
      "Content-Type": "application/json",
      // "Authorization": "Bearer $token", //  Add this line
      "Authorization": 'Bearer ${data.token!}',
    };

    try {
      var response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        var res = jsonDecode(response.body);

        List list = res["Service_Order_For_Review_Data"];

        setState(() {
          item = ServiceOrderForReviewData.fromJson(list[0]);
          // isLoading = false;
        });
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
          "No images found",
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
                                '${AppUrl.assetsClientuploads}$fileLocation',
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
                    videoUrl: '${AppUrl.assetsClientuploads}$fileLocation',
                  ),
                )
              /// IMAGE
              else
                InkWell(
                  onTap: () {
                    if (widget.status.toString() == "PENDING APPROVAL") {
                      print('widget.status11111 ${widget.status.toString()}');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ImagePaintScreen(
                            imageUrl: fileLocation,
                            tokenNo: widget.soNo,
                          ),
                        ),
                      );
                    } else {
                      print('widget.status2222 ${widget.status.toString()}');
                      openFullSizeImageDialog(fileLocation);
                    }
                  },
                  child: Image.network(
                    '${AppUrl.assetsClientuploads}$fileLocation',
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
                      '${AppUrl.assetsClientuploads}$fileLocation',
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

              Positioned(
                top: 5,
                right: 5,
                child: InkWell(
                  onTap: () {
                    deleteOnlineImageApi2(fileLocation, widget.soNo);
                  },
                  child: const Icon(Icons.delete, color: Colors.red, size: 18),
                ),
              ),
            ],
          ),
        );
      },
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
    print('open view dailog-----');
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
                      '${AppUrl.assetsClientuploads}$imageUrl',
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
        '${AppUrl.deleteFileEndPoint}?fileName=$fileName&tokenNo=$tokenNo';
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
          imageViewModel.fetchImageApi(context, widget.soNo),
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
  void showCrewDialog(BuildContext context, String tokenNo, String soNo) async {
    // await fetchCrewList(); // Fetch crew list before showing the dialog

    String? selectedCrew; // Local state for dropdown selection
    String? errorMessage; // To show validation error message

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: Text.rich(
                TextSpan(
                  text: "Want to share Service Order No: ",
                  style: const TextStyle(
                    fontSize: 16,
                    // fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: "$soNo",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              content: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: DropdownButtonFormField<String>(
                              value: selectedCrew,
                              hint: const Text('-Select-'),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 14,
                                ),

                                // Default Border
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                ),

                                // Enabled Border
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                    width: 1.2,
                                  ),
                                ),

                                // Focused Border
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: AppColors.baseColor,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                              items: crewList.map((item) {
                                return DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(item),
                                );
                              }).toList(),
                              onChanged: (val) {
                                setStateDialog(() {
                                  selectedCrew = val;
                                });
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 3.0,
                            right: 3.0,
                            top: 8,
                          ),
                          child: TextFormField(
                            //  key: formkey2,
                            controller: _shareComments,
                            style: const TextStyle(
                              color: AppColors.baseColor,
                              fontSize: 16,
                            ),
                            obscureText: false,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 163, 162, 163),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: 'Add Comments',
                            ),
                          ),
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
                          updateFlagValue(soNo);
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
                color: AppColors.buttonShadow,
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

  Future<void> updateFlagValue(String soNo) async {
    String url =
        "${AppUrl.shareserviceorderforreview}?soNbr=$soNo&notes=${_shareComments.text}";

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
        //  String responceMessage = responseBody['message'];
        print('API call successful');

        CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
          'Service order no: $soNo  Successfully Shared',
          context,
        );
        print('Service order no: $soNo  Successfully Shared');

        Future.delayed(Duration(seconds: 2), () {
          if (context.mounted) {
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
          }
        });
        // myFuture = Future.wait([
        //   fetchDetails(context),
        //   imageViewModel.fetchImageApi(context, widget.soNo),
        // ]);
      } else {
        print('Failed to update flag: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  final List<String> select_action = ["Approve", "Reject"];
  String? action;
  Future openDailogPendingApproval(String id) => showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          // final List<String> select_action = [
          //   "Approve",
          //   "Reject"
          // ];
          // String? action;
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    "SUBMIT FOR APPROVAL",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: AppColors.baseColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      "Work Order No. : ${id}",
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: AppColors.baseColor,
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
                              "Action",
                              style: TextStyle(
                                fontSize: 16.0,
                                color: AppColors.baseColor,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: DropdownButtonFormField<String>(
                              hint: const Text('-Select-'),
                              dropdownColor: Colors.white,
                              value: action,
                              style: const TextStyle(
                                color: AppColors.baseColor,
                                fontSize: 16,
                              ),
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
                              items: select_action.map(buildMenuItem).toList(),
                              onChanged: (val) {
                                setState(() {
                                  action = val;
                                });
                              },
                              validator: (value) =>
                                  value == null ? 'field required' : null,
                            ),
                          ),
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              "Notes",
                              style: TextStyle(
                                fontSize: 16.0,
                                color: AppColors.baseColor,
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
                                color: AppColors.baseColor,
                                fontSize: 16,
                              ),
                              obscureText: false,
                              // keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.baseColor,
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
                          setState(() {
                            isSubmitLoading = true;
                          });
                          // print('a');
                          if (action == "Approve") {
                            fetchStatusChangeNewMethod(
                              _notes.text.toString(),
                              id.toString(),
                              "CLOSED",
                            );
                          } else {
                            fetchStatusChangeNewMethod(
                              _notes.text.toString(),
                              id.toString(),
                              "REJECTED",
                            );
                          }

                          // contractorOrderPendingViewModel
                          //     .fetchStatusChangeApi(
                          //         context,
                          //         // 'PENDING APPROVAL',
                          //         'CLOSED',
                          //         _notes.text.toString(),
                          //         int.parse(id))
                          //     .then((value) {
                          //   print('Success2222');
                          //   Navigator.pop(context);
                          //   getContractorData();
                          // });

                          //  Navigator.pop(context);
                          //                  CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
                          // 'Successfully Completed', context);
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
                          child: Align(
                            alignment: Alignment.center,
                            child: isSubmitLoading
                                ? const SizedBox(
                                    height: 22,
                                    width: 22,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 3,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text(
                                    "Submit",
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
                                    "Close",
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

  Future<void> fetchStatusChangeNewMethod(
    String notes,
    String soNo,
    String status,
  ) async {
    String url =
        '${AppUrl.approveAndSrejectPendingApprovalServiceOrder}?soNbr=$soNo&notes=$notes&status=$status';
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    print('url ${url}');
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${data.token}',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );
      print('response.statuscode ${response.statusCode}');
      if (response.statusCode == 200) {
        // var responseBody = json.decode(response.body);
        // print('responseBody $responseBody');

        print('API call successful $url');

        Future.delayed(Duration(seconds: 2), () {
          if (context.mounted) {
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
          }
        });
        // myFuture = Future.wait([
        //   fetchDetails(context),
        //   imageViewModel.fetchImageApi(context, widget.soNo),
        // ]);
        if (status == "CLOSED") {
          CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
            'Approved Successfully',
            context,
          );
        } else {
          CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
            'Rejected Successfully',
            context,
          );
        }
      } else {
        setState(() {
          isSubmitLoading = false;
        });
        print('Failed to update status: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        isSubmitLoading = false;
      });
      print('Error occurred: $e');
    }
  }

  Future openDailogClose(String tokenNo) => showDialog(
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
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: const Text(
                              "CLOSE SERVICE ORDER",
                              style: TextStyle(
                                fontSize: 18.0,
                                color: AppColors.baseColor,
                                fontWeight: FontWeight.bold,
                              ),
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
                            "Job No. : $tokenNo",
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: AppColors.baseColor,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: TextFormField(
                                  //  key: formkey2,
                                  controller: _notes,
                                  style: const TextStyle(
                                    color: AppColors.baseColor,
                                    fontSize: 16,
                                  ),
                                  obscureText: false,
                                  // keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.baseColor,
                                      ),
                                    ),
                                    hintText: 'Completion notes',
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
                    gradientColors: const [Colors.green, Colors.green],
                    onTap: () {
                      setState(() {
                        _isApproveLoading = true;
                      });
                      approveOrCancelOrder(tokenNo, 'CLOSED');
                    },
                    isLoading: _isApproveLoading,
                  ),
                ],
              ),
            ],
          );
        },
      );
    },
  );
  Future<void> approveOrCancelOrder(String soNo, String status) async {
    String url =
        '${AppUrl.approveAndSrejectPendingApprovalServiceOrder}?soNbr=$soNo&notes=${_notes.text}&status=$status';
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    print('url ${url}');
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${data.token}',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );
      print('response.statuscode ${response.statusCode}');
      if (response.statusCode == 200) {
        print('API call successful $url');
        Future.delayed(Duration(seconds: 2), () {
          if (context.mounted) {
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
          }
        });
        CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
          'Service Order Closed Successfully',
          context,
        );
      } else {
        setState(() {
          isSubmitLoading = false;
        });
        print('Failed to update status: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        isSubmitLoading = false;
      });
      print('Error occurred: $e');
    }
  }
}
