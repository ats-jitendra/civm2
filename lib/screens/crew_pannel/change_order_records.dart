import 'dart:convert';
import 'dart:io';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/repository/map_url.dart';
import 'package:CIVM/resources/app_url.dart';
import 'package:CIVM/screens/admin_pannel/row_maintenance_view/pdf_view.dart';
import 'package:CIVM/screens/crew_pannel/change_order_records_job_details_screen.dart';
import 'package:CIVM/utils/common_functions.dart';
import 'package:CIVM/screens/crew_pannel/crew_bottom_navigation_pannel.dart';
import 'package:CIVM/screens/leaflat_map/leaf_lat_map_wakeLock.dart';
import 'package:CIVM/screens/login_page.dart';
import 'package:CIVM/screens/map/provider/location_provider.dart';
import 'package:CIVM/screens/my_chrome_safari_map_recording.dart';
import 'package:CIVM/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/view_model/crew_change_order_records_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/response/status.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class ChangeOrderTable extends StatefulWidget {
  String year;
  ChangeOrderTable({super.key, required this.year});
  @override
  State<ChangeOrderTable> createState() => _ChangeOrderTableState();
}

class _ChangeOrderTableState extends State<ChangeOrderTable> {
  List<String> menu = [];

  int workOrderNoId = 0;
  // ignore: prefer_typing_uninitialized_variables
  var selectedWorkOrderNo;

  final browser = MyChromeSafariBrowser();
  String userName = '';
  final TextEditingController _input = TextEditingController();
  CrewChangeOrderRecordsViewModel crewChangeOrderRecordsViewModel =
      CrewChangeOrderRecordsViewModel();
  String id = '';

  List<String> years = ["2021", "2022", "2023", "2024", "2025", "2026", "2027"];
  String? selectedYear;
  var selectedYearCurrent;
  int currentYear = DateTime.now().year;

  @override
  void initState() {
    selectedYear = selectedYearCurrent = (widget.year != '')
        ? widget.year
        : currentYear.toString();
    getData(selectedYear.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //  getData(selectedYear.toString());
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Change Order',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 7, 59, 120),
      ),
      body: ChangeNotifierProvider<CrewChangeOrderRecordsViewModel>(
        create: (BuildContext context) => crewChangeOrderRecordsViewModel,
        child: Consumer<CrewChangeOrderRecordsViewModel>(
          builder: (context, value, _) {
            switch (value.crewChangeOrderRecordsGetTabularData.status) {
              case Status.LOADING:
                return const Center(child: CircularProgressIndicator());
              case Status.ERROR:
                return
                //  CustomToastSnackBarProgressDialog.flushBarErrorMessage(
                //     value.crewChangeOrderRecordsGetTabularData.message
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
                return RefreshIndicator(
                  onRefresh: () async {
                    _input.clear();
                    selectedWorkOrderNo = null;
                    await crewChangeOrderRecordsViewModel
                        .fetchCrewChangeOrderRecordsTabularListApi(
                          context,
                          id,
                          "0,1,2",
                          selectedYear.toString(),
                        );
                        _initializeScreen();
                  },
                  child: Container(
                    margin: const EdgeInsets.only(
                      left: 8,
                      right: 8,
                      top: 10,
                      bottom: 8,
                    ),
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    height: size.height * 0.9,
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
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "TOTAL CHANGE ORDER : ${crewChangeOrderRecordsViewModel.crewChangeOrderRecordsGetTabularData.data!.data!.where((record) => record.status == 'ASSIGNED' || record.status == 'REJECTED' || record.status == 'PENDING ZIELIES APPROVAL').length}",
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 7, 59, 120),
                                fontWeight: FontWeight.bold,
                              ),
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
                                    bottom: 4,
                                  ),
                                  child: TextFormField(
                                    onChanged: (value) => _filterData(value),
                                    //  key: formkey2,
                                    controller: _input,
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 7, 59, 120),
                                      fontSize: 16,
                                    ),
                                    obscureText: false,

                                    //  keyboardType: TextInputType.number,
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
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: crewChangeOrderRecordsViewModel
                                .crewChangeOrderRecordsGetTabularData
                                .data!
                                .data!
                                .where(
                                  (record) =>
                                      // record.status == 'PENDING' ||
                                      record.status == 'ASSIGNED' ||
                                      record.status == 'REJECTED' ||
                                      record.status ==
                                          'PENDING ZIELIES APPROVAL',
                                )
                                .length, // Count
                            itemBuilder: (BuildContext ctxt, int index) {
                              var filteredList = crewChangeOrderRecordsViewModel
                                  .crewChangeOrderRecordsGetTabularData
                                  .data!
                                  .data!
                                  .where(
                                    (record) =>
                                        // record.status == 'PENDING' ||
                                        record.status == 'ASSIGNED' ||
                                        record.status == 'REJECTED' ||
                                        record.status ==
                                            'PENDING ZIELIES APPROVAL',
                                  )
                                  .toList();
                              var item = filteredList[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 6,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            ChangeOrderRecordsJobDetailsScreen(
                                              tokenNo: item.tokenNo.toString(),
                                            ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: getCardColor(item.status),
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          blurRadius: 6,
                                          offset: const Offset(2, 4),
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          /// 🔹 TOP ROW (Job No + Status Badge)
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "JOB NO: ${item.tokenNo}",
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),

                                              /// STATUS BADGE
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 4,
                                                    ),
                                                decoration: BoxDecoration(
                                                  color: getStatusColor(
                                                    item.status,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Text(
                                                  item.status ?? "",
                                                  style: const TextStyle(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),

                                          const SizedBox(height: 10),

                                          ///  SUBSTATION ROW
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.location_on,
                                                size: 16,
                                                color: Colors.black,
                                              ),
                                              const SizedBox(width: 6),
                                              Expanded(
                                                child: Text(
                                                  "SUBSTATION : ${item.substation ?? ""}",
                                                  style: const TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 4),

                                          ///  TYPE ROW
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.build,
                                                size: 16,
                                                color: Colors.black,
                                              ),
                                              const SizedBox(width: 6),
                                              Expanded(
                                                child: Text(
                                                  "TYPE : ${item.maintType ?? ""}",
                                                  style: const TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),

                                          const SizedBox(height: 8),

                                          ///  DIVIDER
                                          Container(
                                            height: 1,
                                            color: Colors.black12,
                                          ),

                                          const SizedBox(height: 8),

                                          ///  BOTTOM ROW
                                          const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "View Details",
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Icon(
                                                Icons.arrow_forward_ios,
                                                size: 14,
                                                color: Colors.black,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
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

              default:
                return const Text('data');
            }
          },
        ),
      ),
    );
  }

  void _filterData(String query) {
    if (query.isEmpty) {
      selectedWorkOrderNo = null;
      crewChangeOrderRecordsViewModel.fetchCrewChangeOrderRecordsTabularListApi(
        context,
        id,
        "0,1,2",
        selectedYear.toString(),
      );
    } else {
      crewChangeOrderRecordsViewModel
          .crewChangeOrderRecordsGetTabularData
          .data!
          .data = crewChangeOrderRecordsViewModel
          .crewChangeOrderRecordsGetTabularData
          .data!
          .data!
          .where(
            (item) =>
                item.tokenNo.toString().toLowerCase().contains(
                  query.toLowerCase(),
                ) ||
                item.maintType.toString().toLowerCase().contains(
                  query.toLowerCase(),
                ) ||
                item.status.toString().toLowerCase().contains(
                  query.toLowerCase(),
                ) ||
                item.substation.toString().toLowerCase().contains(
                  query.toLowerCase(),
                ) ||
                item.feeder.toString().toLowerCase().contains(
                  query.toLowerCase(),
                ) ||
                // item.createDate.toString().toLowerCase().contains(
                //   query.toLowerCase(),
                // ) ||
                item.type.toString().toLowerCase().contains(
                  query.toLowerCase(),
                ) 
                //||
                // item.contractorCompany.toString().toLowerCase().contains(
                //   query.toLowerCase(),
                // ) ||
                // item.adminNotes1.toString().toLowerCase().contains(
                //   query.toLowerCase(),
                // ) ||
                // item.totalMiles.toString().toLowerCase().contains(
                //   query.toLowerCase(),
                // ) ||
                // item.contractYear.toString().toLowerCase().contains(
                //   query.toLowerCase(),
                // ) ||
                // item.cycle.toString().toLowerCase().contains(
                //   query.toLowerCase(),
                // ) ||
                // item.streetAddress.toString().toLowerCase().contains(
                //   query.toLowerCase(),
                // ) ||
                // item.mapLocation.toString().toLowerCase().contains(
                //   query.toLowerCase(),
                // ) ||
                // item.adminNotes1.toString().toLowerCase().contains(
                //   query.toLowerCase(),
                // ) ||
                // item.dateOfInspection.toString().toLowerCase().contains(
                //   query.toLowerCase(),
                // ) ||
                // item.followUpDate.toString().toLowerCase().contains(
                //   query.toLowerCase(),
                // ) ||
                // item.costPerMile.toString().toLowerCase().contains(
                //   query.toLowerCase(),
                // ) ||
                // item.totalCost.toString().toLowerCase().contains(
                //   query.toLowerCase(),
                // ) ||
                // item.nextMaintDue.toString().toLowerCase().contains(
                //   query.toLowerCase(),
                //),
          )
          .toList();
    }
    setState(() {});
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
    value: item,
    child: Text(
      item,
      style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
    ),
  );

  Future openDialogPicture(String tokenNo) => showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          // lCPWorkOrdersClosedViewModel.fetchImageApi(
          //     context,
          //     //  '1');
          //     tokenNo.toString());
          int length =
              crewChangeOrderRecordsViewModel.imageData.data?.images?.length ??
              0;

          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                children: [
                  for (int i = 0; i < length; i += 2)
                    Row(
                      children: [
                        if (i < length) ...[
                          buildImageWidget(i, tokenNo.toString()),
                        ],
                        if (i + 1 < length) ...[
                          const SizedBox(width: 16),
                          buildImageWidget(i + 1, tokenNo.toString()),
                        ],
                      ],
                    ),
                ],
              ),
            ),
          );
        },
      );
    },
  );

  Widget buildImageWidget(int i, String tokenNo) {
    String? imageLocation = crewChangeOrderRecordsViewModel
        .imageData
        .data
        ?.images![i]
        .imageLocation;

    return Expanded(
      child: (imageLocation != null)
          ? Stack(
              children: [
                // Check if the file type is PDF
                if (isPDF(imageLocation))
                  Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => PDFViewer(
                              pdfUrl:
                                  'https://civm.ariespro.com/assets/clientuploads/$imageLocation',
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
                else
                  InkWell(
                    onTap: () {
                      openFullSizeImageDialog(imageLocation);
                    },
                    child: Image.network(
                      'https://civm.ariespro.com/assets/clientuploads/$imageLocation',
                      // height: 400,
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          print('111111111111111111111');
                          if (!isPDF(imageLocation)) {
                            print('image');
                            downloadFile(
                              'https://civm.ariespro.com/assets/clientuploads/$imageLocation',
                              'Image',
                            );
                            Navigator.pop(context);
                          } else {
                            print('pdf');
                            downloadFile(
                              'https://civm.ariespro.com/assets/clientuploads/$imageLocation',
                              'PDF',
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
                          deleteOnlineImageApi(imageLocation, tokenNo);
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

  Future<void> downloadFile(String fileUrl, String fileType) async {
    final response = await http.get(Uri.parse(fileUrl));
    if (response.statusCode == 200) {
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = fileUrl.split('/').last;
      final file = File('${appDir.path}/$fileName');
      await file.writeAsBytes(response.bodyBytes);
      print('$fileType downloaded to: ${file.path}');
      CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
        '$fileType Downloaded',
        context,
      );
    } else {
      print(
        'Failed to download $fileType. Status code: ${response.statusCode}',
      );
    }
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
          'Image deleted Successfully',
          context,
        );
        // Navigator.pop(context);
        await Future.delayed(const Duration(seconds: 2));
        crewChangeOrderRecordsViewModel
            .fetchCrewChangeOrderRecordsTabularListApi(
              context,
              id,
              "0,1,2",
              selectedYear.toString(),
            );
      } else {
        print('API request failed with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> getData(String year) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();

    id = data.user!.id.toString();

    crewChangeOrderRecordsViewModel.fetchCrewChangeOrderRecordsTabularListApi(
      context,
      id,
      "0,1,2",
      year,
    );
     _initializeScreen();
  }

  void showYearFilterDialog() {
    final String currentYear = DateTime.now().year.toString();

    // if (selectedYear == null || !years.contains(selectedYear)) {
    //   selectedYear = years.contains(currentYear)
    //       ? currentYear
    //       : null;
    // }
    final String initialYear =
        (widget.year != '' && years.contains(widget.year))
        ? widget.year
        : (years.contains(currentYear) ? currentYear : '');

    if (selectedYear == null || !years.contains(selectedYear)) {
      selectedYear = initialYear;
    }

    String? tempSelectedYear = selectedYear;
    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (dialogContext, setDialogState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),

              title: const Text(
                "Filter",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              content: DropdownButtonFormField<String>(
                value: years.contains(tempSelectedYear)
                    ? tempSelectedYear
                    : null,

                isExpanded: true,

                decoration: InputDecoration(
                  labelText: "Select Year",
                  prefixIcon: const Icon(Icons.calendar_today_rounded),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 14,
                  ),
                ),

                items: years.map((year) {
                  return DropdownMenuItem<String>(
                    value: year,
                    child: Text(year),
                  );
                }).toList(),

                onChanged: (value) {
                  setDialogState(() {
                    tempSelectedYear = value;
                  });
                },
              ),

              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                  },
                  child: const Text("Cancel"),
                ),

                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedYear = tempSelectedYear;
                    });

                    Navigator.pop(dialogContext);

                    print("Selected Year: $selectedYear");

                    getData(selectedYear.toString());
                  },
                  child: const Text("Search"),
                ),
              ],
            );
          },
        );
      },
    );
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
  }//----
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
    var provider = Provider.of<LocationProvider>(context, listen: true);
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 7, 59, 120),
            ),
            child: Column(
              children: [
                menuLogoLCP(),
                Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Text(
                    userName,
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.computer),
            title: const Text('Crew Dashboard'),
            textColor: const Color.fromARGB(255, 7, 59, 120),
            iconColor: const Color.fromARGB(255, 7, 59, 120),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      const CrewBottomNavigationPannel(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.running_with_errors),
            title: const Text('IVM Maintenance Progress'),
            textColor: const Color.fromARGB(255, 7, 59, 120),
            iconColor: const Color.fromARGB(255, 7, 59, 120),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.map),
            title: const Text('Map View'),
            textColor: const Color.fromARGB(255, 7, 59, 120),
            iconColor: const Color.fromARGB(255, 7, 59, 120),
            onTap: () async {
              String id = '';
              final userPreferences1 = Provider.of<UserPref>(
                context,
                listen: false,
              );
              UserModel data = await userPreferences1.getUser();
              id = data.user!.id.toString();
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => MapViewPage(
              //       url: MapUrl.getCrewWithIdEndPoint(id),
              //     ),
              //   ),
              // );

              await browser.open(
                url: WebUri(MapUrl.getCrewWithIdEndPoint(id)),
                // "https://mapapi.ariespro.com/main/crew_main/CIVM_Map/USRQWXH589Z/${id}"),
                settings: ChromeSafariBrowserSettings(
                  shareState: CustomTabsShareState.SHARE_STATE_OFF,
                  barCollapsingEnabled: true,
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.location_on),
            title: const Text('Live IVM System Map'),
            textColor: const Color.fromARGB(255, 7, 59, 120),
            iconColor: const Color.fromARGB(255, 7, 59, 120),
            onTap: () {
              provider.getLocation();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const MapScreenLeafLat(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Log Out'),
            textColor: const Color.fromARGB(255, 7, 59, 120),
            iconColor: const Color.fromARGB(255, 7, 59, 120),
            onTap: () {
              // // Constants.prefs.setBool("LoggedIn", false);
              userPreferences.remove().then((value) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => const LoginPage(),
                  ),
                );
              });
            },
          ),
        ],
      ),
    );
  }

  Future<void> setUserName() async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    Image.network(
      'https://civm.ariespro.com/assets/clientuploads/${data.user!.profilePhoto}',
    );
    String imageUrl =
        'https://civm.ariespro.com/assets/clientuploads/${data.user!.profilePhoto}';
    _imagePath = imageUrl;
    setState(() {
      String fName = (data.user!.fName == 'null')
          ? ''
          : data.user!.fName.toString();
      String lName = (data.user!.lName == 'null')
          ? ''
          : data.user!.lName.toString();
      // userName = '${data.user!.fName} ${(data.user!.lName) != null? data.user!.lName :''}';
      userName = '$fName $lName';
    });
  }
}
