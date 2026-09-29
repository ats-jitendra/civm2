// import 'dart:io';
// import 'package:CIVM/models/user_model.dart';
// import 'package:CIVM/screens/admin_pannel/row_maintenance_view/pdf_view.dart';
// import 'package:CIVM/screens/my_chrome_safari_map_recording.dart';
// import 'package:CIVM/screens/supervisor_pannel/supervisor_midCycle_all_status_job_details_screen.dart';
// import 'package:CIVM/screens/video_folder/fullVideo/full_screen_video_player.dart';
// import 'package:CIVM/utils/common_functions.dart';
// import 'package:CIVM/utils/user_pref.dart';
// import 'package:CIVM/view_model/ivm_all_status_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:photo_view/photo_view_gallery.dart';
// import 'package:provider/provider.dart';
// import '../../../data/response/status.dart';
// import '../../../utils/custom_toast_snackbar_progressdialog.dart';
// import 'package:http/http.dart' as http;
// import 'package:open_file/open_file.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;

// // ignore: must_be_immutable
// class SupervisorMidCycleAllStatus extends StatefulWidget {
//   String budgetType;
//   String maintenanceType;
//   String heading;

//   SupervisorMidCycleAllStatus(
//       {super.key,
//       required this.budgetType,
//       required this.maintenanceType,
//       required this.heading});

//   @override
//   State<SupervisorMidCycleAllStatus> createState() =>
//       _SupervisorMidCycleAllStatusState();
// }

// class _SupervisorMidCycleAllStatusState
//     extends State<SupervisorMidCycleAllStatus> {
//   List<String> menu = [];

//   int substationId = 0;
//   int feederId = 0;

//   // ignore: prefer_typing_uninitialized_variables
//   var selectedSubstation;
//   // ignore: prefer_typing_uninitialized_variables
//   var selectedFeeder;
//   final TextEditingController _input = TextEditingController();
//   String userName = '';

//   onTappedBar(int index) {
//     setState(() {
//       // _currentIndex = index;
//     });
//   }

//   final browser = MyChromeSafariBrowser();
//   IvmAllStatusViewModel ivmAllStatusViewModel = IvmAllStatusViewModel();

//   String formattedContractYear = '';
//   String formattedNextMaintDue = '';

//   @override
//   void initState() {
//     ivmAllStatusViewModel.fetchIvmAllStatusModelTabularListApi(
//         context, widget.budgetType);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//         appBar: AppBar(
//           iconTheme: const IconThemeData(color: Colors.white),
//           title: Text(
//             'Mid Cycle Herbicide',
//             style: const TextStyle(color: Colors.white),
//           ),
//           backgroundColor: const Color.fromARGB(255, 7, 59, 120),
//         ),
//         body: ChangeNotifierProvider<IvmAllStatusViewModel>(
//             create: (BuildContext context) => ivmAllStatusViewModel,
//             child:
//                 Consumer<IvmAllStatusViewModel>(builder: (context, value, _) {
//               switch (value.ivmAllStatusModelGetTabularData.status) {
//                 case Status.LOADING:
//                   return const Center(child: CircularProgressIndicator());
//                 case Status.ERROR:
//                   return Padding(
//                     padding: const EdgeInsets.only(
//                         top: 16.0, bottom: 16, left: 8, right: 8),
//                     child: Center(
//                       child: Align(
//                         alignment: Alignment.topCenter,
//                         child: Column(
//                           children: [
//                             Image.asset(
//                               'assets/empty_box.png',
//                               height: 200,
//                               width: 200,
//                               fit: BoxFit.cover,
//                             ),
//                             const Center(
//                               child: Text(
//                                 'Sorry, Data Not Found!',
//                                 textAlign: TextAlign.left,
//                                 style: TextStyle(
//                                   color: Color.fromARGB(255, 7, 59, 120),
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 20,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 case Status.COMPLETED:
//                   return RefreshIndicator(
//                     onRefresh: () async {
//                       _input.clear();
//                       selectedSubstation = null;
//                       selectedFeeder = null;
//                       ivmAllStatusViewModel
//                           .fetchIvmAllStatusModelTabularListApi(
//                               context, widget.budgetType);
//                     },
//                     child: Container(
//                       margin: const EdgeInsets.only(
//                           left: 8, right: 8, top: 10, bottom: 8),
//                       padding: const EdgeInsets.all(8),
//                       alignment: Alignment.center,
//                       height: size.height * 1,
//                       width: size.width * 0.99,
//                       decoration: BoxDecoration(
//                           // shape: BoxShape.circle,
//                           borderRadius: BorderRadius.circular(10),
//                           boxShadow: const [
//                             BoxShadow(
//                                 color: Color.fromARGB(255, 7, 59, 120),
//                                 blurRadius: 10,
//                                 offset: Offset(2.0, 5.0))
//                           ],
//                           gradient: const LinearGradient(
//                             colors: [
//                               Color.fromARGB(255, 255, 255, 255),
//                               Color.fromARGB(255, 255, 255, 255),
//                             ],
//                           )),
//                       child: Column(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(top: 8.0),
//                             child: Align(
//                               alignment: Alignment.bottomLeft,
//                               child: Text(
//                                 "TOTAL NO OF RECORDS : ${ivmAllStatusViewModel.ivmAllStatusModelGetTabularData.data!.findAllTableData!.length.toString()}",
//                                 style: const TextStyle(
//                                     fontSize: 16,
//                                     color: Color.fromARGB(255, 7, 59, 120),
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                           ),
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: Align(
//                                   alignment: Alignment.centerRight,
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(
//                                         left: 4.0,
//                                         right: 4.0,
//                                         top: 4,
//                                         bottom: 4),
//                                     child: TextFormField(
//                                       onChanged: (value) => _filterData(value),
//                                       //  key: formkey2,
//                                       controller: _input,
//                                       style: const TextStyle(
//                                           color:
//                                               Color.fromARGB(255, 7, 59, 120),
//                                           fontSize: 16),
//                                       obscureText: false,

//                                       // keyboardType: TextInputType.number,
//                                       decoration: const InputDecoration(
//                                         border: OutlineInputBorder(),
//                                         enabledBorder: OutlineInputBorder(
//                                           borderSide: BorderSide(
//                                             color:
//                                                 Color.fromARGB(255, 23, 1, 88),
//                                           ),
//                                           // borderRadius:
//                                           //     BorderRadius.circular(25),
//                                         ),
//                                         hintText: 'Search your input...',
//                                       ),
//                                       validator: (value) {
//                                         if (value!.toString == 'null') {
//                                           return "Please search your input";
//                                         } else {
//                                           return null;
//                                         }
//                                       },
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Expanded(
//                             child: ListView.builder(
//                               physics: const AlwaysScrollableScrollPhysics(),
//                               itemCount: ivmAllStatusViewModel
//                                   .ivmAllStatusModelGetTabularData
//                                   .data!
//                                   .findAllTableData!
//                                   .length,
//                               itemBuilder: (BuildContext ctxt, int index) {
//                                 var item = ivmAllStatusViewModel
//                                     .ivmAllStatusModelGetTabularData
//                                     .data!
//                                     .findAllTableData![index];
//                                 return Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 8, vertical: 6),
//                                   child: InkWell(
//                                     onTap: () {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (_) =>
//                                               SupervisorMidCycleAllStatusJobDetailsScreen(
//                                             tokenNo: item.tokenNo.toString(),
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                         color: getCardColor(item.status),
//                                         borderRadius: BorderRadius.circular(12),
//                                         boxShadow: [
//                                           BoxShadow(
//                                             color:
//                                                 Colors.black.withOpacity(0.2),
//                                             blurRadius: 6,
//                                             offset: const Offset(2, 4),
//                                           ),
//                                         ],
//                                       ),
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(12),
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             /// 🔹 TOP ROW (Job No + Status Badge)
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 Text(
//                                                   "JOB NO: ${item.tokenNo}",
//                                                   style: const TextStyle(
//                                                     fontSize: 14,
//                                                     fontWeight: FontWeight.bold,
//                                                     color: Colors.black,
//                                                   ),
//                                                 ),

//                                                 /// STATUS BADGE
//                                                 Container(
//                                                   padding: const EdgeInsets
//                                                       .symmetric(
//                                                       horizontal: 10,
//                                                       vertical: 4),
//                                                   decoration: BoxDecoration(
//                                                     color: getStatusColor(
//                                                         item.status),
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             20),
//                                                   ),
//                                                   child: Text(
//                                                     item.status ?? "",
//                                                     style: const TextStyle(
//                                                       fontSize: 11,
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                       color: Colors.black,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),

//                                             const SizedBox(height: 10),
//                                             Row(
//                                               children: [
//                                                 const Icon(
//                                                   Icons.numbers,
//                                                   size: 16,
//                                                   color: Colors.black,
//                                                 ),
//                                                 const SizedBox(width: 6),
//                                                 Expanded(
//                                                   child: Text(
//                                                     "MASTER JOB NO. : ${(item.masterJobNo == null || item.masterJobNo.toString().trim().isEmpty || item.masterJobNo.toString().trim().toLowerCase() == 'null' || item.masterJobNo.toString().trim().toUpperCase() == 'N/A') ? '' : item.masterJobNo.toString()}",
//                                                     style: const TextStyle(
//                                                       fontSize: 13,
//                                                       color: Colors.black,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                             const SizedBox(height: 4),

//                                             ///  SUBSTATION ROW
//                                             Row(
//                                               children: [
//                                                 const Icon(
//                                                   Icons.location_on,
//                                                   size: 16,
//                                                   color: Colors.black,
//                                                 ),
//                                                 const SizedBox(width: 6),
//                                                 Expanded(
//                                                   child: Text(
//                                                     "SUBSTATION : ${item.substation ?? ""}",
//                                                     style: const TextStyle(
//                                                       fontSize: 13,
//                                                       color: Colors.black,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                             const SizedBox(height: 4),

//                                             ///  FEEDER ROW
//                                             Row(
//                                               children: [
//                                                 const Icon(
//                                                   Icons.work,
//                                                   size: 16,
//                                                   color: Colors.black,
//                                                 ),
//                                                 const SizedBox(width: 6),
//                                                 Expanded(
//                                                   child: Text(
//                                                     "FEEDER : ${item.fdrName ?? ""}",
//                                                     style: const TextStyle(
//                                                       fontSize: 13,
//                                                       color: Colors.black,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                             const SizedBox(height: 4),

//                                             ///  TYPE ROW
//                                             Row(
//                                               children: [
//                                                 const Icon(
//                                                   Icons.build,
//                                                   size: 16,
//                                                   color: Colors.black,
//                                                 ),
//                                                 const SizedBox(width: 6),
//                                                 Expanded(
//                                                   child: Text(
//                                                     "TYPE : ${item.maintType ?? ""}",
//                                                     style: const TextStyle(
//                                                       fontSize: 13,
//                                                       color: Colors.black,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),

//                                             const SizedBox(height: 8),

//                                             ///  DIVIDER
//                                             Container(
//                                               height: 1,
//                                               color: Colors.black12,
//                                             ),

//                                             const SizedBox(height: 8),

//                                             ///  BOTTOM ROW
//                                             const Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 Text(
//                                                   "View Details",
//                                                   style: TextStyle(
//                                                     fontSize: 11,
//                                                     color: Colors.black,
//                                                   ),
//                                                 ),
//                                                 Icon(
//                                                   Icons.arrow_forward_ios,
//                                                   size: 14,
//                                                   color: Colors.black,
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );

//                 default:
//                   return const Text('data');
//               }
//             })));
//   }

//   Future<void> _filterData(String query) async {
//     if (query.isEmpty) {
//       selectedSubstation = null;
//       selectedFeeder = null;
//       ivmAllStatusViewModel.fetchIvmAllStatusModelTabularListApi(
//           context, widget.budgetType);
//     } else {
//       ivmAllStatusViewModel.ivmAllStatusModelGetTabularData.data!.findAllTableData = ivmAllStatusViewModel
//           .ivmAllStatusModelGetTabularData.data!.findAllTableData
//           ?.where((item) =>
//               item.tokenNo.toString().toLowerCase().contains(query.toLowerCase()) ||
//               item.maintType
//                   .toString()
//                   .toLowerCase()
//                   .contains(query.toLowerCase()) ||
//               item.status
//                   .toString()
//                   .toLowerCase()
//                   .contains(query.toLowerCase()) ||
//               item.substation
//                   .toString()
//                   .toLowerCase()
//                   .contains(query.toLowerCase()) ||
//               item.fdrName
//                   .toString()
//                   .toLowerCase()
//                   .contains(query.toLowerCase()) ||
//               item.createDate
//                   .toString()
//                   .toLowerCase()
//                   .contains(query.toLowerCase()) ||
//               item.type
//                   .toString()
//                   .toLowerCase()
//                   .contains(query.toLowerCase()) ||
//               item.contractorCompany
//                   .toString()
//                   .toLowerCase()
//                   .contains(query.toLowerCase()) ||
//               item.adminNotes1
//                   .toString()
//                   .toLowerCase()
//                   .contains(query.toLowerCase()) ||
//               item.totalMiles.toString().toLowerCase().contains(query.toLowerCase()) ||
//               item.contractYear.toString().toLowerCase().contains(query.toLowerCase()) ||
//               item.cycle.toString().toLowerCase().contains(query.toLowerCase()) ||
//               item.streetAddress.toString().toLowerCase().contains(query.toLowerCase()) ||
//               item.mapLocation.toString().toLowerCase().contains(query.toLowerCase()) ||
//               item.adminNotes1.toString().toLowerCase().contains(query.toLowerCase()) ||
//               item.dateOfInspection.toString().toLowerCase().contains(query.toLowerCase()) ||
//               item.followUpDate.toString().toLowerCase().contains(query.toLowerCase()) ||
//               item.costPerMile.toString().toLowerCase().contains(query.toLowerCase()) ||
//               item.totalCost.toString().toLowerCase().contains(query.toLowerCase()) ||
//               item.contractor.toString().toLowerCase().contains(query.toLowerCase()) ||
//               item.nextMaintDue.toString().toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     }
//     setState(() {});
//   }

//   DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
//       value: item,
//       child: Text(item,
//           style: const TextStyle(
//             fontWeight: FontWeight.normal,
//             fontSize: 20,
//           )));

//   void fetchData(String substation, String feeder, String contractorCompany) {
//     ivmAllStatusViewModel.fetchIvmAllStatusModelTabularListApi(
//         context, widget.budgetType);
//   }

//   Future openDialogPicture(String tokenNo) => showDialog(
//         context: context,
//         builder: (context) {
//           return StatefulBuilder(builder: (context, setState) {
//             // ivmAllStatusViewModel.fetchImageApi(
//             //     context,
//             //     //  '1');
//             //     tokenNo.toString());
//             int length =
//                 ivmAllStatusViewModel.imageData.data?.images?.length ?? 0;

//             return AlertDialog(
//               content: Container(
//                 width: MediaQuery.of(context).size.width * 0.99,
//                 padding: const EdgeInsets.only(top: 8.0),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       if (length == 0)
//                         const Center(
//                           child: Text(
//                             "No image found!",
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               color: Color.fromARGB(255, 7, 59, 120),
//                             ),
//                           ),
//                         )
//                       else
//                         for (int i = 0; i < length; i += 2)
//                           Row(
//                             children: [
//                               if (i < length) ...[
//                                 buildImageWidget(i, tokenNo.toString()),
//                               ],
//                               if (i + 1 < length) ...[
//                                 // const SizedBox(width: 8),
//                                 buildImageWidget(i + 1, tokenNo.toString()),
//                               ],
//                             ],
//                           ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           });
//         },
//       );

//   Widget buildImageWidget(int i, String tokenNo) {
//     String? fileLocation =
//         ivmAllStatusViewModel.imageData.data?.images![i].imageLocation;

//     bool isVideo(String file) {
//       return file.endsWith('.mp4') || file.endsWith('.mov');
//     }

//     return Expanded(
//       child: (fileLocation != null)
//           ? Container(
//               //  margin: const EdgeInsets.only(top:8, bottom:8),
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   color: Colors.black,
//                   width: 2,
//                 ),
//               ),
//               child: Stack(
//                 children: [
//                   if (isPDF(fileLocation))
//                     Center(
//                       child: InkWell(
//                         onTap: () {
//                           Navigator.of(context).push(MaterialPageRoute(
//                               builder: (BuildContext context) => PDFViewer(
//                                   pdfUrl:
//                                       'https://civm.ariespro.com/assets/clientuploads/$fileLocation')));
//                         },
//                         child: Image.asset(
//                           'assets/pdflogo.jpg',
//                           height: 150,
//                           width: 150,
//                         ),
//                       ),
//                     )
//                   else if (isVideo(fileLocation))
//                     InkWell(
//                         onTap: () {
//                           openFullSizeVideoDialog(fileLocation);
//                         },
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(
//                               5), // Optional rounded corners
//                           child: SizedBox(
//                             height: 150,
//                             width: double.infinity,
//                             child: VideoPlayerWidget(
//                               videoUrl:
//                                   'https://civm.ariespro.com/assets/clientuploads/$fileLocation',
//                             ),
//                           ),
//                         ))
//                   else
//                     InkWell(
//                       onTap: () {
//                         openFullSizeImageDialog(fileLocation);
//                       },
//                       child: Image.network(
//                         'https://civm.ariespro.com/assets/clientuploads/$fileLocation',
//                       ),
//                     ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         InkWell(
//                           onTap: () {
//                             if (!isPDF(fileLocation)) {
//                               downloadFile(
//                                   'https://civm.ariespro.com/assets/clientuploads/$fileLocation',
//                                   'File');
//                               Navigator.pop(context);
//                             } else {
//                               downloadFile(
//                                   'https://civm.ariespro.com/assets/clientuploads/$fileLocation',
//                                   'PDF');
//                               Navigator.pop(context);
//                             }
//                           },
//                           child: const Icon(
//                             Icons.download,
//                             color: Colors.blue,
//                             size: 20,
//                           ),
//                         ),
//                         InkWell(
//                           onTap: () {
//                             deleteOnlineImageApi(fileLocation, tokenNo);
//                             Navigator.pop(context);
//                           },
//                           child: const Icon(
//                             Icons.delete,
//                             color: Colors.red,
//                             size: 20,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           : const Center(
//               child: Text(
//                 "NO IMAGE",
//                 textAlign: TextAlign.left,
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: Color.fromARGB(255, 7, 59, 120),
//                 ),
//               ),
//             ),
//     );
//   }

//   void openFullSizeVideoDialog(String videoUrl) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return Dialog(
//           insetPadding: EdgeInsets.zero,
//           child: FullScreenVideoPlayer(videoUrl: videoUrl),
//         );
//       },
//     );
//   }

//   Future<void> downloadFile(String fileUrl, String fileType) async {
//     final response = await http.get(Uri.parse(fileUrl));
//     if (response.statusCode == 200) {
//       final appDir = await getApplicationDocumentsDirectory();
//       final fileName = fileUrl.split('/').last;
//       final file = File('${appDir.path}/$fileName');
//       await file.writeAsBytes(response.bodyBytes);
//       print('$fileType downloaded to: ${file.path}');
//       CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
//           '$fileType Downloaded', context);
//     } else {
//       print(
//           'Failed to download $fileType. Status code: ${response.statusCode}');
//     }
//   }

//   bool isPDF(String fileLocation) {
//     return fileLocation.toLowerCase().endsWith('.pdf');
//   }

//   void openFullSizeImageDialog(String imageUrl) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return Dialog(
//           insetPadding: EdgeInsets.zero,
//           child: Stack(
//             children: [
//               PhotoViewGallery(
//                 pageController: PageController(),
//                 backgroundDecoration: const BoxDecoration(
//                   color: Colors.black,
//                 ),
//                 onPageChanged: (index) {},
//                 scrollPhysics: const BouncingScrollPhysics(),
//                 pageOptions: [
//                   PhotoViewGalleryPageOptions(
//                     imageProvider: NetworkImage(
//                       'https://civm.ariespro.com/assets/clientuploads/$imageUrl',
//                     ),
//                     minScale: PhotoViewComputedScale.contained * 0.5,
//                     maxScale: PhotoViewComputedScale.covered * 0.5,
//                   ),
//                 ],
//               ),
//               Positioned(
//                 top: 30,
//                 right: 20,
//                 child: IconButton(
//                   icon: const Icon(Icons.close, color: Colors.white, size: 30),
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Future<void> deleteOnlineImageApi(String fileName, String tokenNo) async {
//     final apiUrl =
//         'http://civmapi.ariespro.com/civmapi/changeOrderLcpCreateOrder/deleteFile?fileName=$fileName&tokenNo=$tokenNo';
//     print(apiUrl);
//     final userPreferences = Provider.of<UserPref>(context, listen: false);
//     UserModel data = await userPreferences.getUser();

//     try {
//       final response = await http.delete(
//         Uri.parse(apiUrl),
//         headers: {"Authorization": 'Bearer ${data.token!}'},
//       );

//       if (response.statusCode == 200) {
//         print('API response: ${response.body}');
//         setState(() {});
//         print('Image deleted successfully');
//         CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
//             'Image deleted Successfully', context);
//         // Navigator.pop(context);
//         await Future.delayed(const Duration(seconds: 2));
//         ivmAllStatusViewModel.fetchIvmAllStatusModelTabularListApi(
//             context, widget.budgetType);
//       } else {
//         print('API request failed with status code: ${response.statusCode}');
//         print('Response body: ${response.body}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   Future<void> openPdf(
//       String? tokenNo,
//       String? followUpDate,
//       String? substation,
//       String? contactorCompany,
//       String? mapLocation,
//       String? maintType,
//       String? contractorNotes,
//       String? dateOfInspection,
//       String? county,
//       String? contractor,
//       String? streetAddress,
//       String? type,
//       String? adminNotes1,
//       String? adminNotes2) async {
//     writeOnPdf(
//         tokenNo,
//         followUpDate,
//         substation,
//         contactorCompany,
//         mapLocation,
//         maintType,
//         contractorNotes,
//         dateOfInspection,
//         county,
//         contractor,
//         streetAddress,
//         type,
//         adminNotes1,
//         adminNotes2);

//     // final output = await getExternalStorageDirectory();
//     // final file = File("${output!.path}/example.pdf");
//     // OpenFile.open(file.path);
//     final output = await getExternalStorageDirectory();
//     final file = File("${output!.path}/report.pdf");
//     await file.writeAsBytes(await pdf.save());
//     OpenFile.open(file.path);
//   }

//   final pdf = pw.Document();
//   List<Map<String, dynamic>> tableData = [];
//   String total = '';
//   String laborTotal = '';
//   String invoiceTotal = '';
//   String invoiceData = '';
//   String formattedDate = '';

//   writeOnPdf(
//       String? tokenNo,
//       String? followUpDate,
//       String? substation,
//       String? contactorCompany,
//       String? mapLocation,
//       String? maintType,
//       String? contractorNotes,
//       String? dateOfInspection,
//       String? county,
//       String? contractor,
//       String? streetAddress,
//       String? type,
//       String? adminNotes1,
//       String? adminNotes2) async {
//     // final ByteData data = await rootBundle.load('assets/civm_logo.png');
//     // final Uint8List bytes = data.buffer.asUint8List();
//     // final image = img.decodeImage(bytes)!;
//     List<Map<String, dynamic>> tableData = [
//       {
//         'CHANGE ORDER NO.': tokenNo,
//         'FOLLOW UP DATE': followUpDate,
//         'SUBSTATION': substation,
//         'CONTRACTOR COMPANY': contactorCompany,
//         'MAP LOCATION': mapLocation,
//         'MAINTENANCE TYPE': maintType,
//         'CONTRACTOR NOTES': contractorNotes,
//         'DATE OF INSPECTION': dateOfInspection,
//         'COUNTY': county,
//         'CONTRACTOR': contractor,
//         'STREET ADDRESS': streetAddress,
//         'TYPE': type,
//         'ADMIN NOTES 1': adminNotes1,
//         'ADMIN NOTES 2': adminNotes2
//       },
//     ];

//     pdf.addPage(
//       pw.Page(
//         build: (pw.Context context) => pw.Center(
//           child: pw.Table.fromTextArray(
//             context: context,
//             cellAlignment: pw.Alignment.centerLeft,
//             headerDecoration: const pw.BoxDecoration(
//               color: PdfColors.grey,
//             ),
//             cellHeight: 30,
//             headerHeight: 40,
//             cellAlignments: {
//               0: pw.Alignment.center,
//             },
//             headerStyle:
//                 pw.TextStyle(fontSize: 30, fontWeight: pw.FontWeight.bold),
//             cellStyle: const pw.TextStyle(fontSize: 20),
//             headers: ['Change Order'], // A single header for the vertical table
//             data: tableData
//                 .expand((row) =>
//                     row.entries.map((entry) => [entry.key, entry.value]))
//                 .toList(),
//           ),
//         ),
//       ),
//     );
//   }

//   Future<String> savePdf(pw.Document pdf, String tokenNo) async {
//     final Directory appDocDir = await getApplicationDocumentsDirectory();
//     final String appDocPath = appDocDir.path;
//     final String pdfPath = '$appDocPath/your_invoice.pdf';
//     final File pdfFile = File(pdfPath);
//     await pdfFile.writeAsBytes(pdf.save() as List<int>);
//     OpenFile.open(pdfPath);
//     return pdfPath;
//   }
// // Future domnload(
//   //     Dio dio, String url, String savePath, int idNotification) async {
//   //   Map<String, dynamic> result = {
//   //     'isSuccess': false,
//   //     'filePath': null,
//   //     'error': null,
//   //     'id': null
//   //   };

//   //   result['id'] = idNotification;
//   //   setState(() {
//   //     _loading = true;
//   //   });
//   //   try {
//   //     Response response = await dio.get(url,
//   //         onReceiveProgress: showDownloadProgress,
//   //         options: Options(
//   //             responseType: ResponseType.bytes,
//   //             followRedirects: false,
//   //             validateStatus: (status) {
//   //               return status! < 500;
//   //             }));
//   //     if (response.statusCode == 200) {
//   //       setState(() {
//   //         _loading = false;
//   //       });
//   //       result['isSuccess'] = response.statusCode == 200;
//   //       result['filePath'] = savePath;
//   //     } else {
//   //       setState(() {
//   //         _loading = false;
//   //       });
//   //     }

//   //     File file = File(savePath);
//   //     var raf = file.openSync(mode: FileMode.write);
//   //     raf.writeFromSync(response.data);

//   //     await raf.close();
//   //   } catch (e) {
//   //     result['error'] = e.toString();
//   //   } finally {
//   //     setState(() {
//   //       _loading = false;
//   //       percentDownload = "";
//   //     });

//   //     showNotifcation(result);
//   //   }
//   // }

//   void newDateFormat(
//     int index,
//   ) {
//     String? rawCreateDate = ivmAllStatusViewModel
//         .ivmAllStatusModelGetTabularData
//         .data!
//         .findAllTableData![index]
//         .contractYear
//         ?.toString();

//     String? rawNextMaintDue = ivmAllStatusViewModel
//         .ivmAllStatusModelGetTabularData
//         .data!
//         .findAllTableData![index]
//         .nextMaintDue
//         ?.toString();
//     formattedContractYear = extractYear(rawCreateDate);
//     formattedNextMaintDue = extractYear(rawNextMaintDue);
//     print('rawCreateDate $rawCreateDate');
//     print('formattedContractYear: $formattedContractYear');
//     print('formattedNextMaintDue: $formattedNextMaintDue');
//   }

//   String extractYear(String? date) {
//     if (date == null || date.isEmpty || date == "N/A") {
//       return ""; // Handle null or invalid dates
//     }
//     try {
//       if (date.contains('T')) {
//         // ISO 8601 format (e.g., 2024-12-07T11:37:16.750+00:00)
//         DateTime parsedDate = DateTime.parse(date);
//         return parsedDate.year.toString();
//       } else if (date.contains(' ')) {
//         // Formats like "Dec  7 2024 12:00AM"
//         String normalizedDate =
//             date.replaceAll(RegExp(r'\s+'), ' '); // Remove extra spaces
//         DateTime parsedDate =
//             DateFormat("MMM d yyyy h:mma").parse(normalizedDate);
//         return parsedDate.year.toString();
//       } else if (date.contains('/')) {
//         // Format MM/dd/yyyy
//         DateTime parsedDate = DateFormat("MM/dd/yyyy").parse(date);
//         return parsedDate.year.toString();
//       }
//     } catch (e) {
//       print("Error parsing date: $date, Error: $e");
//     }
//     return ""; // Default if parsing fails
//   }
// }
