import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:typed_data';
import 'package:CIVM/piedmont/resources/app_colors.dart';
import 'package:path_provider/path_provider.dart';

class PDFViewer extends StatefulWidget {
  final String pdfUrl;

  const PDFViewer({Key? key, required this.pdfUrl}) : super(key: key);

  @override
  _PDFViewerState createState() => _PDFViewerState();
}

class _PDFViewerState extends State<PDFViewer> {
  bool isReady = false;
  late String localFilePath;

  @override
  void initState() {
    super.initState();
    _downloadAndLoadPDF();
  }

  Future<void> _downloadAndLoadPDF() async {
    final response = await http.get(Uri.parse(widget.pdfUrl));
    final bytes = Uint8List.fromList(response.bodyBytes);
    final tempDir = await getTemporaryDirectory();
    final tempPath = tempDir.path;

    localFilePath = '$tempPath/example.pdf'; // Use the correct local path
    File pdfFile = File(localFilePath);
    await pdfFile.writeAsBytes(bytes);

    if (mounted) {
      setState(() {
        isReady = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor:AppColors.backgroundColor,
      appBar: AppBar( iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'PDF',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.baseColor,
      ),
      body: isReady
          ? PDFView(
              filePath: localFilePath, // Use the local file path
              autoSpacing: true,
              pageSnap: true,
              swipeHorizontal: true,
              pageFling: true,
              onRender: (pages) {
                // Called when the PDF is rendered successfully
                print("Pages: $pages");
              },
              onViewCreated: (PDFViewController pdfViewController) {
                // Store the controller for later use
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
