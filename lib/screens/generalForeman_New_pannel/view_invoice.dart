import 'dart:io';
import 'package:CIVM/data/response/status.dart';
import 'package:CIVM/view_model/invoice_list_contractor_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:image/image.dart' as img;

// ignore: must_be_immutable
class InvoicePage extends StatefulWidget {
  String id;
  InvoicePage({Key? key, required this.id}) : super(key: key);

  @override
  _InvoicePageState createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
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
    invoiceListViewModel.fetchInvoiceApi(context, widget.id);
    Future.delayed(const Duration(seconds: 5), () {
      openPdf(widget.id);
      savePdf(pdf, widget.id);
      table1Data();
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
            'Invoice',
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

  List<Map<String, dynamic>> table1Data() {
    tableData.clear();
    for (var i = 0;
        i < invoiceListViewModel.invoiceData.data!.findInvoiceByTokenNo!.length;
        i++) {
      var invoice =
          invoiceListViewModel.invoiceData.data!.findInvoiceByTokenNo![i];

      tableData.add({
        'Serial': (i + 1).toString(),
        'Employee Name':
            (invoice.empName == null || invoice.empName.toString() == 'null')
                ? ''
                : invoice.empName,
        'Employee Type':
            (invoice.empType == null || invoice.empType.toString() == 'null')
                ? ''
                : invoice.empType,
        'Total Hours': (invoice.workingHrs == null ||
                invoice.workingHrs.toString() == 'null')
            ? ''
            : invoice.workingHrs,
        'Hourly Rate (\$)':
            (invoice.hrlyRate == null || invoice.hrlyRate.toString() == 'null')
                ? ''
                : invoice.hrlyRate,
        'Labor Cost (\$)': (invoice.laborCost == null ||
                invoice.laborCost.toString() == 'null')
            ? ''
            : invoice.laborCost,
      });
      total = (invoiceListViewModel
                      .invoiceData.data!.findInvoiceByTokenNo![i].laborTotal ==
                  null ||
              invoiceListViewModel
                      .invoiceData.data!.findInvoiceByTokenNo![i].laborTotal
                      .toString() ==
                  'null')
          ? ''
          : invoiceListViewModel
              .invoiceData.data!.findInvoiceByTokenNo![i].laborTotal
              .toString();
      laborTotal = (invoiceListViewModel
                      .invoiceData.data!.findInvoiceByTokenNo![i].laborTotal ==
                  null ||
              invoiceListViewModel
                      .invoiceData.data!.findInvoiceByTokenNo![i].laborTotal
                      .toString() ==
                  'null')
          ? ''
          : invoiceListViewModel
              .invoiceData.data!.findInvoiceByTokenNo![i].laborTotal
              .toString();
      invoiceTotal = (invoiceListViewModel.invoiceData.data!
                      .findInvoiceByTokenNo![i].invoiceTotal ==
                  null ||
              invoiceListViewModel
                      .invoiceData.data!.findInvoiceByTokenNo![i].invoiceTotal
                      .toString() ==
                  'null')
          ? ''
          : invoiceListViewModel
              .invoiceData.data!.findInvoiceByTokenNo![i].invoiceTotal
              .toString();
      invoiceData = (invoiceListViewModel
                      .invoiceData.data!.findInvoiceByTokenNo![i].invoiceDate ==
                  null ||
              invoiceListViewModel
                      .invoiceData.data!.findInvoiceByTokenNo![i].invoiceDate
                      .toString() ==
                  'null')
          ? ''
          : invoiceListViewModel
              .invoiceData.data!.findInvoiceByTokenNo![i].invoiceDate
              .toString();
      formattedDate =
          DateFormat('MMMM dd, yyyy').format(DateTime.parse(invoiceData));
    }
    return tableData;
  }

  writeOnPdf(String tokenNo) async {
    final ByteData data = await rootBundle.load('assets/civm_logo.png');
    final Uint8List bytes = data.buffer.asUint8List();
    final image = img.decodeImage(bytes)!;
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Container(
            padding: const pw.EdgeInsets.all(16),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Image(
                    pw.MemoryImage(Uint8List.fromList(img.encodePng(image))),
                    width: 200,
                    height: 200),
                pw.SizedBox(height: 20),

                pw.Row(
                  children: [
                    pw.Expanded(
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.only(left: 8.0),
                        child: pw.Column(
                          children: [
                            pw.Align(
                              alignment: pw.Alignment.centerLeft,
                              child: pw.Text(
                                "Sparksuite, Inc.",
                                textAlign: pw.TextAlign.left,
                                style: pw.TextStyle(
                                  fontSize: 12,
                                  fontWeight: pw.FontWeight.bold,
                                  // color: const PdfColor.fromInt(255, 7, 59, 120),
                                ),
                              ),
                            ),
                            pw.Align(
                              alignment: pw.Alignment.centerLeft,
                              child: pw.Text(
                                "12345 Sunny Road",
                                textAlign: pw.TextAlign.left,
                                style: pw.TextStyle(
                                  fontSize: 12,
                                  fontWeight: pw.FontWeight.bold,
                                  // color: const PdfColor.fromInt(255, 7, 59, 120),
                                ),
                              ),
                            ),
                            pw.Align(
                              alignment: pw.Alignment.centerLeft,
                              child: pw.Text(
                                "Sunnyville, CA 12345",
                                textAlign: pw.TextAlign.left,
                                style: pw.TextStyle(
                                  fontSize: 12,
                                  fontWeight: pw.FontWeight.bold,
                                  // color: const PdfColor.fromInt(255, 7, 59, 120),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.only(right: 8.0),
                        child: pw.Column(
                          children: [
                            pw.Align(
                              alignment: pw.Alignment.centerRight,
                              child: pw.Text(
                                "Invoice Number: $tokenNo",
                                textAlign: pw.TextAlign.left,
                                style: pw.TextStyle(
                                  fontSize: 12,
                                  fontWeight: pw.FontWeight.bold,
                                  // color: const PdfColor.fromInt(255, 7, 59, 120),
                                ),
                              ),
                            ),
                            pw.Align(
                              alignment: pw.Alignment.centerRight,
                              child: pw.Text(
                                "Invoice Date: $formattedDate",
                                textAlign: pw.TextAlign.left,
                                style: pw.TextStyle(
                                  fontSize: 12,
                                  fontWeight: pw.FontWeight.bold,
                                  // color: const PdfColor.fromInt(255, 7, 59, 120),
                                ),
                              ),
                            ),
                            pw.Align(
                              alignment: pw.Alignment.centerRight,
                              child: pw.Text(
                                "Change Order No: $tokenNo",
                                textAlign: pw.TextAlign.left,
                                style: pw.TextStyle(
                                  fontSize: 12,
                                  fontWeight: pw.FontWeight.bold,
                                  // color: const PdfColor.fromInt(255, 7, 59, 120),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // ignore: deprecated_member_use
                pw.SizedBox(height: 20),
                // ignore: deprecated_member_use
                pw.Table.fromTextArray(
                  context: context,
                  cellAlignment: pw.Alignment.centerLeft,
                  headerDecoration: const pw.BoxDecoration(
                    color: PdfColors.grey,
                  ),
                  cellHeight: 30,
                  headerHeight: 40,
                  cellAlignments: {
                    0: pw.Alignment.center,
                    1: pw.Alignment.center,
                    2: pw.Alignment.center,
                    3: pw.Alignment.center,
                    4: pw.Alignment.center,
                    5: pw.Alignment.center,
                  },
                  headerStyle: pw.TextStyle(
                      fontSize: 12, fontWeight: pw.FontWeight.bold),
                  cellStyle: const pw.TextStyle(fontSize: 10),
                  headers: [
                    'Serial',
                    'Employee Name',
                    'Employee Type',
                    'Total Hours',
                    'Hourly Rate (\$)',
                    'Labor Cost (\$)'
                  ],
                  data: tableData
                      .map((row) => [
                            row['Serial'],
                            row['Employee Name'],
                            row['Employee Type'],
                            row['Total Hours'].toString(),
                            '\$${row['Hourly Rate (\$)'].toStringAsFixed(2)}', // Format as currency
                            '\$${row['Labor Cost (\$)'].toStringAsFixed(2)}', // Format as currency
                          ])
                      .toList(),
                ),

                // ignore: deprecated_member_use
                pw.Table.fromTextArray(
                  context: context,
                  cellAlignment: pw.Alignment.centerLeft,
                  headerDecoration: const pw.BoxDecoration(
                    color: PdfColors.white,
                  ),
                  cellHeight: 30,
                  headerHeight: 40,
                  cellAlignments: {
                    0: pw.Alignment.center,
                    1: pw.Alignment.center,
                    2: pw.Alignment.center,
                    3: pw.Alignment.center,
                    4: pw.Alignment.center,
                    5: pw.Alignment.center,
                  },
                  headerStyle: pw.TextStyle(
                      fontSize: 12, fontWeight: pw.FontWeight.bold),
                  cellStyle: const pw.TextStyle(fontSize: 10),
                  headers: ['Total', '\$ $total'],
                  data: [],
                ),

                // ignore: deprecated_member_use
                pw.SizedBox(height: 20),
                // ignore: deprecated_member_use
                pw.Table.fromTextArray(
                    context: context,
                    cellAlignment: pw.Alignment.centerLeft,
                    headerDecoration: const pw.BoxDecoration(
                      color: PdfColors.grey,
                    ),
                    cellHeight: 30,
                    headerHeight: 40,
                    cellAlignments: {
                      0: pw.Alignment.center,
                      1: pw.Alignment.center,
                      2: pw.Alignment.center,
                      3: pw.Alignment.center,
                      4: pw.Alignment.center,
                      5: pw.Alignment.center,
                    },
                    headerStyle: pw.TextStyle(
                        fontSize: 12, fontWeight: pw.FontWeight.bold),
                    cellStyle: const pw.TextStyle(fontSize: 10),
                    headers: ['Invoice Summary'],
                    data: []),
// ignore: deprecated_member_use
                pw.Table.fromTextArray(
                    context: context,
                    cellAlignment: pw.Alignment.centerLeft,
                    headerDecoration: const pw.BoxDecoration(
                      color: PdfColors.white,
                    ),
                    cellHeight: 30,
                    headerHeight: 40,
                    cellAlignments: {
                      0: pw.Alignment.center,
                      1: pw.Alignment.center,
                      2: pw.Alignment.center,
                      3: pw.Alignment.center,
                      4: pw.Alignment.center,
                      5: pw.Alignment.center,
                    },
                    headerStyle: pw.TextStyle(
                        fontSize: 12, fontWeight: pw.FontWeight.bold),
                    cellStyle: const pw.TextStyle(fontSize: 10),
                    headers: ['Labor Total', '\$ $laborTotal'],
                    data: []),

                // ignore: deprecated_member_use
                pw.Table.fromTextArray(
                    context: context,
                    cellAlignment: pw.Alignment.centerLeft,
                    headerDecoration: const pw.BoxDecoration(
                      color: PdfColors.white,
                    ),
                    cellHeight: 30,
                    headerHeight: 40,
                    cellAlignments: {
                      0: pw.Alignment.center,
                      1: pw.Alignment.center,
                      2: pw.Alignment.center,
                      3: pw.Alignment.center,
                      4: pw.Alignment.center,
                      5: pw.Alignment.center,
                    },
                    headerStyle: pw.TextStyle(
                        fontSize: 12, fontWeight: pw.FontWeight.bold),
                    cellStyle: const pw.TextStyle(fontSize: 10),
                    headers: ['Invoice Total 	', '\$ $invoiceTotal'],
                    data: []),

                pw.SizedBox(height: 20),

                pw.Container(
                    padding: const pw.EdgeInsets.all(8),
                    decoration: const pw.BoxDecoration(
                        gradient: pw.LinearGradient(
                      colors: [
                        PdfColors.blue,
                        PdfColors.blue,
                      ],
                    )),
                    child: pw.Text(
                      'Download Invoice',
                      style: pw.TextStyle(
                        fontSize: 16,
                        color: PdfColors.white,
                        fontWeight: pw.FontWeight.bold,
                        decoration: pw.TextDecoration.underline,
                      ),
                    ))
              ],
            ),
          );
        },
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
