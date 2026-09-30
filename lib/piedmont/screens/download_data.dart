import 'dart:io';
import 'package:CIVM/piedmont/data/response/status.dart';
import 'package:CIVM/piedmont/view_model/invoice_list_contractor_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:image/image.dart' as img;

// ignore: must_be_immutable
class DownloadPage extends StatefulWidget {
  String id;
  DownloadPage({Key? key, required this.id}) : super(key: key);

  @override
  _DownloadPageState createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  InvoiceListViewModel invoiceListViewModel = InvoiceListViewModel();

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   await invoiceListViewModel.fetchInvoiceApi(context, widget.id);
    //   await Future.delayed(const Duration(seconds: 5));
    //   final pdfPath = await savePdf(pdf, widget.id);
    //   openPdf(pdfPath);
    //   table1Data();
    // });
    // invoiceListViewModel.fetchInvoiceApi(context, widget.id);
    Future.delayed(const Duration(seconds: 5), () {
      openPdf(widget.id);
      savePdf(pdf, widget.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'Report',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 7, 59, 120),
        ),
        body: ChangeNotifierProvider<InvoiceListViewModel>(
            create: (BuildContext context) => invoiceListViewModel,
            child: Consumer<InvoiceListViewModel>(builder: (context, value, _) {
              switch (value.invoiceListGetTabularData.status) {
                case Status.LOADING:
                  return const Center(child: CircularProgressIndicator());
                case Status.ERROR:
                  return
                      // CustomToastSnackBarProgressDialog.flushBarErrorMessage(
                      //     value.invoiceListGetTabularData.message.toString(),
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
                  return Container(
                      margin:
                          const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 2.0, right: 2.0, bottom: 2.0, top: 2.0),
                        child: InkWell(
                          onTap: () {
                            print('click on add new before');
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: 40, right: 40, bottom: 10.0),
                            padding: const EdgeInsets.all(8),
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            decoration: const BoxDecoration(
                                // shape: BoxShape.circle,
                                // borderRadius:
                                //     BorderRadius.circular(25),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromARGB(255, 3, 47, 97),
                                      blurRadius: 5,
                                      offset: Offset(2.0, 5.0))
                                ],
                                color: Color.fromARGB(255, 130, 193, 245),
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 7, 59, 120),
                                    Color.fromARGB(255, 7, 59, 120)
                                  ],
                                )),
                            child: const Row(children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Create Order',
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
                      ));

                default:
                  return const Text('data');
              }
            })));
  }

  Future<void> openPdf(String tokenNo) async {
    writeOnPdf(tokenNo);

    // final output = await getExternalStorageDirectory();
    // final file = File("${output!.path}/example.pdf");
    // OpenFile.open(file.path);
    final output = await getExternalStorageDirectory();
    final file = File("${output!.path}/example.pdf");
    await file.writeAsBytes(await pdf.save());
    OpenFile.open(file.path);
  }

  final pdf = pw.Document();
  List<Map<String, dynamic>> tableData = [];
  String total = '';
  String laborTotal = '';
  String invoiceTotal = '';
  String invoiceData = '';
  String formattedDate = '';

  writeOnPdf(String tokenNo) async {
    final ByteData data = await rootBundle.load('assets/civm_logo.png');
    final Uint8List bytes = data.buffer.asUint8List();
    final image = img.decodeImage(bytes)!;
    List<Map<String, dynamic>> tableData = [
      {
        'CHANGE ORDER NO.': 'a',
        'FOLLOW UP DATE': 'b',
        'SUBSTATION': 'c',
        'CONTRACTOR COMPANY': 'd',
        'MAP LOCATION': 'e',
        'MAINTENANCE TYPE': 'f',
        'CONTRACTOR NOTES': 'g',
        'DATE OF INSPECTION': 'a',
        'COUNTY': 'b',
        'CONTRACTOR': 'c',
        'STREET ADDRESS': 'd',
        'TYPE': 'e',
        'ADMIN NOTES 1': 'f',
        'ADMIN NOTES 2': 'g'
      },
    ];

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Table.fromTextArray(
            context: context,
            cellAlignment: pw.Alignment.centerLeft,
            headerDecoration: const pw.BoxDecoration(
              color: PdfColors.grey,
            ),
            cellHeight: 30,
            headerHeight: 40,
            cellAlignments: {
              0: pw.Alignment.center,
            },
            headerStyle:
                pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
            cellStyle: const pw.TextStyle(fontSize: 20),
            headers: ['Change Order'], // A single header for the vertical table
            data: tableData
                .expand((row) =>
                    row.entries.map((entry) => [entry.key, entry.value]))
                .toList(),
          ),
        ),
      ),
    );
  }

  Future<String> savePdf(pw.Document pdf, String tokenNo) async {
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final String appDocPath = appDocDir.path;
    final String pdfPath = '$appDocPath/your_invoice.pdf';
    final File pdfFile = File(pdfPath);
    await pdfFile.writeAsBytes(pdf.save() as List<int>);
    OpenFile.open(pdfPath);
    return pdfPath;
  }
// Future domnload(
  //     Dio dio, String url, String savePath, int idNotification) async {
  //   Map<String, dynamic> result = {
  //     'isSuccess': false,
  //     'filePath': null,
  //     'error': null,
  //     'id': null
  //   };

  //   result['id'] = idNotification;
  //   setState(() {
  //     _loading = true;
  //   });
  //   try {
  //     Response response = await dio.get(url,
  //         onReceiveProgress: showDownloadProgress,
  //         options: Options(
  //             responseType: ResponseType.bytes,
  //             followRedirects: false,
  //             validateStatus: (status) {
  //               return status! < 500;
  //             }));
  //     if (response.statusCode == 200) {
  //       setState(() {
  //         _loading = false;
  //       });
  //       result['isSuccess'] = response.statusCode == 200;
  //       result['filePath'] = savePath;
  //     } else {
  //       setState(() {
  //         _loading = false;
  //       });
  //     }

  //     File file = File(savePath);
  //     var raf = file.openSync(mode: FileMode.write);
  //     raf.writeFromSync(response.data);

  //     await raf.close();
  //   } catch (e) {
  //     result['error'] = e.toString();
  //   } finally {
  //     setState(() {
  //       _loading = false;
  //       percentDownload = "";
  //     });

  //     showNotifcation(result);
  //   }
  // }
}
