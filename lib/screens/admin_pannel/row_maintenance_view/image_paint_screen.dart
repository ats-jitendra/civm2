import 'dart:io';
// import 'dart:typed_data';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:flutter/material.dart';
import 'package:image_painter/image_painter.dart';
import 'package:intl/intl.dart';
// import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

// ignore: must_be_immutable
class ImagePaintScreen extends StatefulWidget {
  String imageUrl;
  String tokenNo;
  ImagePaintScreen({Key? key, required this.imageUrl, required this.tokenNo})
      : super(key: key);

  @override
  State<ImagePaintScreen> createState() => _ImagePaintScreenState();
}

class _ImagePaintScreenState extends State<ImagePaintScreen> {
  final ImagePainterController _controller = ImagePainterController(
    color: Colors.white,
    strokeWidth: 4,
    mode: PaintMode.none,
  );

  String fullPath = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Image "),
        actions: [
          IconButton(
            icon: const Icon(Icons.done),
            onPressed: () {
              saveImage();
              // submitImage(widget.imageUrl, widget.tokenNo);
            },
          ),
          // IconButton(
          //   icon: const Icon(Icons.push_pin),
          //   onPressed: () {
          //     // saveImage();
          //     submitImage(widget.imageUrl, widget.tokenNo);
          //   },
          // ),
          // IconButton(
          //   icon: const Icon(Icons.close),
          //   onPressed: () {
          //     _controller.clear();
          //   },
          // ),
        ],
      ),
      body: ImagePainter.network(
        'https://civm.ariespro.com/assets/clientuploads/${widget.imageUrl}',
        controller: _controller,
        scalable: true,
        textDelegate: TextDelegate(),
      ),
    );
  }

  void saveImage() async {
    final image = await _controller.exportImage();
    final imageName = '${DateTime.now().millisecondsSinceEpoch}.png';
    final directory = (await getApplicationDocumentsDirectory()).path;
    await Directory('$directory/sample').create(recursive: true);
    fullPath = '$directory/sample/$imageName';
    final imgFile = File(fullPath);
    print('fullpath---- $fullPath');
    print('imagename---- $imageName');
    if (image != null) {
      if (fullPath != '') {
        submitImage(widget.tokenNo);
      }
      imgFile.writeAsBytesSync(image);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.grey[700],
          padding: const EdgeInsets.only(left: 10),
          content: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Text("Image Exported successfully.",
              //     style: TextStyle(color: Colors.white)),
              // TextButton(
              //   onPressed: () {
              //     OpenFile.open(fullPath);
              //     print('fullpath-------$fullPath');
              //   },
              //   child: Text(
              //     "Open",
              //     style: TextStyle(
              //       color: Colors.blue[200],
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      );
    }
  }

  Future<void> submitImage(String tokenNo) async {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing the dialog
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(), // Show progress indicator
        );
      },
    );
    print('submit image api11111111111');
    // print('imagePath $fileName');
    Directory tempDir = await getTemporaryDirectory();

    if (!(await tempDir.exists())) {
      await tempDir.create(recursive: true);
    }

    String tempPath = tempDir.path;
    print('tempPath $tempPath');
    try {
      print('submit image 333333333333333333333');
      var uri = Uri.parse(
          "https://civmapi.ariespro.com/civmapi/contractorPanel/updateImageVEGETATION_CREW_FORMs");
      var request = http.MultipartRequest("POST", uri);
      final userPreferences = Provider.of<UserPref>(context, listen: false);
      UserModel data = await userPreferences.getUser();
      print('submit image 4444444444444444444');

      var headers = {
        "Content-Type": "multipart/form-data",
        "Accept": "*/*",
        "Authorization": 'Bearer ${data.token!}'
      };

      List<http.MultipartFile> newList = [];
      if (fullPath != '') {
        print('submit image 4555555555555555555555');
        File img1 = File(fullPath);
        String newFileName =
            'img_${DateFormat('yyyyMMddHHmmss').format(DateTime.now())}${fullPath.contains('.pdf') ? '.pdf' : '.jpg'}';
        String newFilePath = '$tempPath/$newFileName';

        File file = await img1.copy(newFilePath);
        print('submit image 666666666666666');

        var stream1 = http.ByteStream(file.openRead());
        var length1 = await file.length();
        var multipartFile = http.MultipartFile("files", stream1, length1,
            filename: path.basename(file.path));
        newList.add(multipartFile);
      }

      if (newList.isNotEmpty) {
        request.files.addAll(newList); // Add the multiple file to the request
      }
      request.headers.addAll(headers);
      request.fields['tokenNo'] = tokenNo;
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        print('image successfully uploaded...........');
        print(response.body);

        Navigator.pop(context);
        Navigator.pop(context);
        // Navigator.pop(context);
        CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
            'Image Uploaded Successfully', context);
        // Navigator.pop(context);
      }
    } catch (e) {
      print('inside catch of image upload api.................');
      print(e.toString());
    }
  }
}
