import 'dart:io';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/piedmont/resources/app_colors.dart';
import 'package:CIVM/piedmont/resources/app_url.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;
import 'package:video_player/video_player.dart';

// ignore: must_be_immutable
class EdkoAnnualHerbicideEditpageNew extends StatefulWidget {
  String jobNo;
  EdkoAnnualHerbicideEditpageNew({super.key, required this.jobNo});

  @override
  State<EdkoAnnualHerbicideEditpageNew> createState() =>
      _EdkoAnnualHerbicideEditpageNewState();
}

class _EdkoAnnualHerbicideEditpageNewState
    extends State<EdkoAnnualHerbicideEditpageNew> {
  final TextEditingController _jobNo = TextEditingController();
  final TextEditingController _comments = TextEditingController();
  final TextEditingController _gallons = TextEditingController();
  bool _isVisibleSubmittingButton = false;
  bool isSaveLoading = false;
  late List<CameraDescription> _cameras;
  late CameraController _camerasController;
  // String imagePath = '';
  // String imagePath1 = '';
  // String imagePath2 = '';
  List<String> imagePaths = [];
  List<XFile> images = [];
  var selectedChangeOrderNo;

  bool _isVisibleSubmitButton = true;
  String videoPath = '';
  bool _isPlayVideoFlag = true;

  VideoPlayerController? _controller;
  XFile? _videoFile;
  late VideoPlayerController _videoController;
  int videoFlag = 0;
  @override
  void initState() {
    selectedChangeOrderNo = widget.jobNo;
    _jobNo.text = widget.jobNo;
    cameraInit();
    super.initState();
  }

  @override
  void dispose() {
    disposeCamera();
    super.dispose();
  }

  void initializeVideo() async {
    await _videoController.initialize();
    _videoController.setLooping(true); // If you want the video to loop
    setState(() {});
  }

  Future<void> disposeCamera() async {
    if (_camerasController.value.isInitialized) {
      await _camerasController.dispose();
      // _camerasController = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Annual Herbicide Status',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.baseColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
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
                    // Container(
                    //   padding: const EdgeInsets.all(10),
                    //   alignment: Alignment.center,
                    //   width: size.width * 0.99,
                    //   decoration: const BoxDecoration(
                    //       boxShadow: [
                    //         BoxShadow(
                    //             color: AppColors.buttonShadow,
                    //             blurRadius: 5,
                    //             offset: Offset(2.0, 5.0))
                    //       ],
                    //       color: Color.fromARGB(255, 130, 193, 245),
                    //       gradient: LinearGradient(
                    //         colors: [
                    //           AppColors.baseColor,
                    //           AppColors.buttonOrange,
                    //           AppColors.baseColor,
                    //         ],
                    //       )),
                    //   child: const Row(children: [
                    //     Align(
                    //       alignment: Alignment.centerLeft,
                    //       child: Text(
                    //         "Search Option",
                    //         textAlign: TextAlign.left,
                    //         style: TextStyle(
                    //           color: Colors.white,
                    //           fontWeight: FontWeight.bold,
                    //           fontSize: 20,
                    //         ),
                    //       ),
                    //     ),
                    //   ]),
                    // ),
                    
                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Job No",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: AppColors.baseColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: TextFormField(
                          enabled: false,
                          controller: _jobNo,
                          style: const TextStyle(
                              color: AppColors.baseColor, fontSize: 16),
                          obscureText: false,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.baseColor,
                              ),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.baseColor,
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
                    left: 8, right: 8, top: 10, bottom: 12),
                padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                width: size.width * 0.99,
                decoration: BoxDecoration(
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
                    const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Comments",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: AppColors.baseColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: TextFormField(
                          //  enabled: false,
                          controller: _comments,
                          style: const TextStyle(
                              color: AppColors.baseColor, fontSize: 16),

                          //  keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.baseColor,
                              ),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.baseColor,
                              ),
                              // borderRadius:
                              // BorderRadius.circular(25),
                            ),
                            hintText: 'Comments',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter Comments.";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Gallons",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: AppColors.baseColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: TextFormField(
                          // enabled: false,
                          controller: _gallons,
                          style: const TextStyle(
                              color: AppColors.baseColor, fontSize: 16),

                          // keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.baseColor,
                              ),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.baseColor,
                              ),
                              // borderRadius:
                              // BorderRadius.circular(25),
                            ),
                            hintText: 'Gallons',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter Gallons.";
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
              Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    margin: const EdgeInsets.only(
                        left: 40, right: 40, bottom: 10.0),
                    // padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    decoration: const BoxDecoration(
                        // shape: BoxShape.circle,
                        // borderRadius:
                        // BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.buttonShadow,
                              blurRadius: 5,
                              offset: Offset(2.0, 5.0))
                        ],
                        color: Color.fromARGB(255, 130, 193, 245),
                        gradient: LinearGradient(
                          colors: [
                            AppColors.baseColor,
                            AppColors.buttonOrange,
                            AppColors.baseColor,
                          ],
                        )),
                    child: InkWell(
                        onTap: () async {
                          // pickImageOptions();
                          _takePictureDialog();
                        },
                        child: const Text(
                          'CAMERA',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ),
              ),
              // Column(
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.only(top: 2.0),
              //       child: Align(
              //         alignment: Alignment.bottomLeft,
              //         child: Container(
              //           margin: const EdgeInsets.only(
              //               left: 40, right: 40, bottom: 10.0),
              //           alignment: Alignment.center,
              //           width: MediaQuery.of(context).size.width,
              //           height: 40,
              //           decoration: const BoxDecoration(
              //               boxShadow: [
              //                 BoxShadow(
              //                     color: AppColors.buttonShadow,
              //                     blurRadius: 5,
              //                     offset: Offset(2.0, 5.0))
              //               ],
              //               color: Color.fromARGB(255, 130, 193, 245),
              //               gradient: LinearGradient(
              //                 colors: [
              //                   AppColors.baseColor,
              //                   AppColors.buttonOrange,
              //                   AppColors.baseColor,
              //                 ],
              //               )),
              //           child: InkWell(
              //             onTap: () async {
              //               // await getVideoFile();
              //               Navigator.of(context).push(
              //                 MaterialPageRoute(
              //                   builder: (context) => BlocProvider(
              //                     create: (context) {
              //                       return CameraBloc(
              //                         cameraUtils: CameraUtils(),
              //                         permissionUtils: PermissionUtils(),
              //                       )..add(const CameraInitialize(
              //                           recordingLimit: 15));
              //                     },
              //                     child: CameraPage(callback: (file) {
              //                       _videoController =
              //                           VideoPlayerController.file(file);
              //                       setState(() {
              //                         videoFlag = 1;
              //                       });
              //                       initializeVideo();
              //                       videoPath = file.path;

              //                       print(
              //                           'Video path11111111111111: $videoPath');
              //                       print(
              //                           '_videoController22222222222222222 $_videoController');
              //                       // submitVideo(
              //                       //     _videoController
              //                       //         .toString(),
              //                       //     selectedChangeOrderNo!);
              //                     }),
              //                   ),
              //                 ),
              //               );
              //             },
              //             child: const Text(
              //               'CAPTURE VIDEO',
              //               style: TextStyle(
              //                   fontSize: 18,
              //                   color: Colors.white,
              //                   fontWeight: FontWeight.bold),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.only(top: 8.0, bottom: 8),
              //       child: InkWell(
              //         onTap: () {
              //           // You can still allow video tap functionality here if needed
              //         },
              //         child: (videoFlag == 1)
              //             ? SizedBox(
              //                 height: 200,
              //                 width: 180,
              //                 child: Stack(
              //                   alignment: Alignment
              //                       .center, // Center the play/pause button
              //                   children: [
              //                     Transform.scale(
              //                       scale: 1.1,
              //                       child: Container(
              //                         color: Colors.white,
              //                         child: VideoPlayer(_videoController),
              //                       ),
              //                     ),
              //                     // Display play/pause button over the video
              //                     IconButton(
              //                       iconSize:
              //                           48, // Adjust size as per your design
              //                       icon: Icon(
              //                         _videoController.value.isPlaying
              //                             ? Icons.pause
              //                             : Icons.play_arrow,
              //                         color: Colors.white,
              //                       ),
              //                       onPressed: () {
              //                         setState(() {
              //                           if (_videoController.value.isPlaying) {
              //                             _videoController.pause();
              //                           } else {
              //                             _videoController.play();
              //                           }
              //                           _isPlayVideoFlag =
              //                               _videoController.value.isPlaying;
              //                         });
              //                       },
              //                     ),
              //                   ],
              //                 ),
              //               )
              //             : const Text(''),
              //       ),
              //     ),
              //   ],
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(imagePaths.length, (index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
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
                                    imagePaths.removeAt(index);
                                    images.removeAt(
                                        index); // Also remove from images list
                                  });
                                  // Call your API to delete the image
                                  deleteOnlineImageApi(
                                      imagePaths[index], selectedChangeOrderNo);
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
              ),
              InkWell(
                onTap: () {
                  saveData();
                  setState(() {
                    _isVisibleSubmittingButton = true;
                    _isVisibleSubmitButton = false;
                    isSaveLoading = true;
                  });
                  print('after formkey validation');
                  // if (videoPath != '' || imagePaths.isNotEmpty) {
                  //   print('if condition videoPath != '
                  //       ' ||imagePaths.isNotEmpty');
                  //   submitMediaFiles(
                  //       imagePaths, videoPath, selectedChangeOrderNo!);
                  //   // submitVideo(videoPath,
                  //   //     selectedChangeOrderNo!);
                  // }
                },
                child: Visibility(
                  visible: _isVisibleSubmitButton,
                  child: Container(
                    margin: const EdgeInsets.only(
                        left: 40, right: 40, bottom: 10.0),
                    // padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    decoration: const BoxDecoration(
                        // borderRadius:
                        //     BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.buttonShadow,
                              blurRadius: 5,
                              offset: Offset(2.0, 5.0))
                        ],
                        color: Color.fromARGB(255, 130, 193, 245),
                        gradient: LinearGradient(
                          colors: [
                            AppColors.baseColor,
                            AppColors.buttonOrange,
                            AppColors.baseColor,
                          ],
                        )),
                    child: Row(children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child:
                              //  isSaveLoading
                              //     ? progressBar()
                              //     :
                              const Text(
                             "SUBMIT",
                           //",
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
              Visibility(
                visible: _isVisibleSubmittingButton,
                child: Container(
                    margin: const EdgeInsets.only(
                        left: 6, right: 6, top: 10.0, bottom: 10),
                    child: Container(
                      margin: const EdgeInsets.only(
                          left: 40, right: 40, bottom: 10.0),
                      // padding: const EdgeInsets.all(8),
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      decoration: const BoxDecoration(
                          // borderRadius:
                          //     BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.buttonShadow,
                                blurRadius: 5,
                                offset: Offset(2.0, 5.0))
                          ],
                          gradient: LinearGradient(
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
                            "SUBMITTING...",
                             // "SAVING...",
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
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveData() async {
    var url =
        "${AppUrl.updateCommentsAndGallonsForAnnualHerbicide}?comments=${_comments.text}&gallons=${_gallons.text}&jobno=${widget.jobNo}";
    print('url $url');
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    var headers = {
      "Content-Type": "application/json",
      // "Authorization": "Bearer $token", //  Add this line
      "Authorization": 'Bearer ${data.token!}'
    };

    try {
      var response = await http.put(
        Uri.parse(url),
        headers: headers,
      );

      if (response.statusCode == 200) {
        print(" API Success:");
        // print(response.body);

        // var data = jsonDecode(response.body);

        if (videoPath != '' || imagePaths.isNotEmpty) {
          print('if condition videoPath != '
              ' ||imagePaths.isNotEmpty');
          submitMediaFiles(imagePaths, videoPath, selectedChangeOrderNo!);
          // submitVideo(videoPath,
          //     selectedChangeOrderNo!);
        }
      } else {
        print("❌ API Error: ${response.statusCode}");
        // print(response.body);
        setState(() {
          isSaveLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isSaveLoading = false;
      });
      print("❌ Exception: $e");
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
                        color: AppColors.baseColor,
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
                                  AppColors.baseColor,
                                  AppColors.buttonOrange,
                                  AppColors.baseColor,
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

  Future<void> deleteOnlineImageApi(String fileName, String token) async {
    final apiUrl =
        'https://atsdev2test.ariespro.com/civmapi/changeOrderLcpCreateOrder/deleteFile?fileName=$fileName&tokenNo=$token';
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
          "https://atsdev2test.ariespro.com/civmapi/contractorPanel/uploadFiles");
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

      // Send the request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        print("Media files submitted successfully.");
        setState(() {
          isSaveLoading = false;
        });
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
        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => GFAnnualHerbicideTOPending()));
        Future.delayed(const Duration(seconds: 2), () {
          print('submit mediafiles');
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
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
}
