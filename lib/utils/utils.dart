// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:intl/intl.dart';
// import 'package:open_file/open_file.dart';
// import 'package:pdf/pdf.dart';
// import 'package:printing/printing.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;

// Future<Uint8List> generatePdf(final PdfPageFormat format) async {
//   var result = await getOnPremisesData();
//   var auditData = result[0];
//   var interiorData = result[1];
//   var exteriorData = result[2];
//   // var recommendationData = result[3];
//   print('object');
//   print(result[1]);

//   final doc = pw.Document(title: 'Audit Report');
//   // final logoImage = pw.MemoryImage(
//   //   (await rootBundle.load('assets/design.png')).buffer.asUint8List(),
//   // );
//   // final footerImage = pw.MemoryImage(
//   //   (await rootBundle.load('assets/design.png')).buffer.asUint8List(),
//   // );
//   final checkBoxImage = pw.MemoryImage(
//     (await rootBundle.load('assets/check_box.png')).buffer.asUint8List(),
//   );
//   final blankCheckBoxImage = pw.MemoryImage(
//     (await rootBundle.load('assets/blank_check_box.png')).buffer.asUint8List(),
//   );
//   // final font = await rootBundle.load('fonts/Roboto-Regular.ttf');
//   // final ttf = pw.Font.ttf(font);
//   final pageTheme = await _myPageTheme(format);

//   doc.addPage(pw.MultiPage(
//     pageTheme: pageTheme,
//     header: (context) => pw.Padding(
//       padding: const pw.EdgeInsets.only(bottom: 20),
//       child: pw.Align(
//           alignment: pw.Alignment.center,
//           child: pw.Text(
//             'On-Premise Energy Audit Report',
//             style: pw.TextStyle(
//               fontWeight: pw.FontWeight.bold,
//               fontSize: 20,
//               decoration: pw.TextDecoration.underline,
//             ),
//           )),
//     ),
//     footer: (context) => pw.Text('1'),
//     build: (context) => [
//       pw.Container(
//         child: pw.Column(
//           crossAxisAlignment: pw.CrossAxisAlignment.center,
//           mainAxisAlignment: pw.MainAxisAlignment.start,
//           children: [
//             pw.Padding(padding: const pw.EdgeInsets.only(top: 20)),
//             pw.Row(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Column(
//                     crossAxisAlignment: pw.CrossAxisAlignment.start,
//                     children: [
//                       pw.Row(
//                           crossAxisAlignment: pw.CrossAxisAlignment.start,
//                           mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                           children: [
//                             pw.Text('Audit ID: '),
//                             pw.Text(
//                                 (auditData[0]['TOKEN_NO'].toString().isEmpty)
//                                     ? 'N/A'
//                                     : auditData[0]['TOKEN_NO'].toString())
//                           ]),
//                       pw.Row(
//                           crossAxisAlignment: pw.CrossAxisAlignment.start,
//                           mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                           children: [
//                             pw.Text('Account No: '),
//                             pw.Text((auditData[0]['MBRSEP'].toString().isEmpty)
//                                 ? 'N/A'
//                                 : auditData[0]['MBRSEP'].toString())
//                           ]),
//                       pw.Row(
//                           crossAxisAlignment: pw.CrossAxisAlignment.start,
//                           mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                           children: [
//                             pw.Text('Member Name: '),
//                             pw.Text((auditData[0]['NAME'].toString().isEmpty)
//                                 ? 'N/A'
//                                 : auditData[0]['NAME'].toString())
//                           ]),
//                     ]),
//                 pw.Column(
//                     crossAxisAlignment: pw.CrossAxisAlignment.end,
//                     children: [
//                       pw.Row(
//                           crossAxisAlignment: pw.CrossAxisAlignment.start,
//                           mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                           children: [
//                             pw.Text('Date: '),
//                             pw.Text((auditData[0]['SCHEDULE_DATE']
//                                     .toString()
//                                     .isEmpty)
//                                 ? 'N/A'
//                                 : DateFormat('yyyy/MM/dd').format(
//                                     DateTime.parse(auditData[0]['SCHEDULE_DATE']
//                                         .toString())))
//                           ]),
//                       pw.Row(
//                           crossAxisAlignment: pw.CrossAxisAlignment.start,
//                           mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                           children: [
//                             pw.Text('Performed By: '),
//                             pw.Text((auditData[0]['AUDITOR_NAME']
//                                     .toString()
//                                     .isEmpty)
//                                 ? 'N/A'
//                                 : auditData[0]['AUDITOR_NAME'].toString())
//                           ]),
//                     ])
//               ],
//             ),
//             pw.SizedBox(height: 6),
//             pw.Align(
//                 alignment: pw.Alignment.centerLeft,
//                 child: pw.Text(
//                   'Interior Of Home',
//                   style: pw.TextStyle(
//                     fontWeight: pw.FontWeight.bold,
//                     fontSize: 18,
//                     decoration: pw.TextDecoration.underline,
//                   ),
//                 )),
//             pw.Divider(height: 1),
//             pw.Align(
//                 alignment: pw.Alignment.centerLeft,
//                 child: pw.Text(
//                   'HVAC',
//                   style: pw.TextStyle(
//                     fontWeight: pw.FontWeight.bold,
//                     fontSize: 18,
//                     // decoration: pw.TextDecoration.underline,
//                   ),
//                 )),
//             pw.Divider(height: 1),
//             pw.SizedBox(height: 6),
//             pw.Row(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Expanded(
//                   flex: 1,
//                   child: pw.Align(
//                     alignment: pw.Alignment.topLeft,
//                     child: pw.Text(
//                       "1.Thermostat location ",
//                       textAlign: pw.TextAlign.left,
//                       style: pw.TextStyle(
//                         // color: pw.Colors.blue,
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//                 pw.Expanded(
//                     flex: 1,
//                     child: pw.Row(
//                       children: [
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (interiorData[0]['THERMOSTAT_LOCATION_G'] == null ||
//                                     interiorData[0]['THERMOSTAT_LOCATION_G']
//                                             .toString() ==
//                                         '' ||
//                                     interiorData[0]['THERMOSTAT_LOCATION_G']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "G",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         pw.SizedBox(width: 4),
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (interiorData[0]['THERMOSTAT_LOCATION_F'] == null ||
//                                     interiorData[0]['THERMOSTAT_LOCATION_F']
//                                             .toString() ==
//                                         '' ||
//                                     interiorData[0]['THERMOSTAT_LOCATION_F']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "F",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         pw.SizedBox(width: 4),
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (interiorData[0]['THERMOSTAT_LOCATION_P'] == null ||
//                                     interiorData[0]['THERMOSTAT_LOCATION_P']
//                                             .toString() ==
//                                         '' ||
//                                     interiorData[0]['THERMOSTAT_LOCATION_P']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "P",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     )),
//                 pw.Expanded(
//                   flex: 3,
//                   child: pw.Text(
//                     (interiorData[0]['THERMOSTAT_LOCATION_COMMENTS'] == null ||
//                             interiorData[0]['THERMOSTAT_LOCATION_COMMENTS']
//                                     .toString() ==
//                                 '')
//                         ? "N/A"
//                         : interiorData[0]['THERMOSTAT_LOCATION_COMMENTS']
//                             .toString(),
//                     textAlign: pw.TextAlign.left,
//                     style: pw.TextStyle(
//                       fontWeight: pw.FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             pw.SizedBox(height: 6),
//             pw.Row(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Expanded(
//                   flex: 1,
//                   child: pw.Align(
//                     alignment: pw.Alignment.topLeft,
//                     child: pw.Text(
//                       "2.Set Temp ",
//                       textAlign: pw.TextAlign.left,
//                       style: pw.TextStyle(
//                         // color: pw.Colors.blue,
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//                 pw.Expanded(
//                     child: pw.Row(children: [
//                   pw.Image(
//                       alignment: pw.Alignment.center,
//                       (interiorData[0]['SET_TEMP_S'] == null ||
//                               interiorData[0]['SET_TEMP_S'].toString() == '' ||
//                               interiorData[0]['SET_TEMP_S'].toString() ==
//                                   'False')
//                           ? blankCheckBoxImage
//                           : checkBoxImage,
//                       fit: pw.BoxFit.contain,
//                       width: 18,
//                       height: 18),
//                   pw.SizedBox(width: 4),
//                   pw.Text(
//                     "S",
//                     textAlign: pw.TextAlign.left,
//                     style: pw.TextStyle(
//                       // color: pw.Colors.blue,
//                       fontWeight: pw.FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                   pw.SizedBox(width: 4),
//                   pw.Text(
//                     (interiorData[0]['SET_TEMP_S_VALUE'] == null ||
//                             interiorData[0]['SET_TEMP_S_VALUE'].toString() ==
//                                 '')
//                         ? "N/A"
//                         : interiorData[0]['SET_TEMP_S_VALUE'].toString(),
//                     textAlign: pw.TextAlign.left,
//                     style: pw.TextStyle(
//                       // color: pw.Colors.blue,
//                       fontWeight: pw.FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                   pw.SizedBox(width: 4),
//                   pw.Image(
//                       alignment: pw.Alignment.center,
//                       (interiorData[0]['SET_TEMP_W'] == null ||
//                               interiorData[0]['SET_TEMP_W'].toString() == '' ||
//                               interiorData[0]['SET_TEMP_W'].toString() ==
//                                   'False')
//                           ? blankCheckBoxImage
//                           : checkBoxImage,
//                       fit: pw.BoxFit.contain,
//                       width: 18,
//                       height: 18),
//                   pw.SizedBox(width: 4),
//                   pw.Text(
//                     "W",
//                     textAlign: pw.TextAlign.left,
//                     style: pw.TextStyle(
//                       // color: pw.Colors.blue,
//                       fontWeight: pw.FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                   pw.SizedBox(width: 4),
//                   pw.Text(
//                     (interiorData[0]['SET_TEMP_W_VALUE'] == null ||
//                             interiorData[0]['SET_TEMP_W_VALUE'].toString() ==
//                                 '')
//                         ? "N/A"
//                         : interiorData[0]['SET_TEMP_W_VALUE'].toString(),
//                     textAlign: pw.TextAlign.left,
//                     style: pw.TextStyle(
//                       // color: pw.Colors.blue,
//                       fontWeight: pw.FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 ])),
//               ],
//             ),
//             pw.SizedBox(height: 6),
//             pw.Row(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Expanded(
//                   flex: 1,
//                   child: pw.Text(
//                     (interiorData[0]['SET_TEMP_COMMENTS'] == null ||
//                             interiorData[0]['SET_TEMP_COMMENTS'].toString() ==
//                                 '')
//                         ? "N/A"
//                         : interiorData[0]['SET_TEMP_COMMENTS'].toString(),
//                     textAlign: pw.TextAlign.left,
//                     style: pw.TextStyle(
//                       fontWeight: pw.FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             pw.SizedBox(height: 6),
//             pw.Row(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Expanded(
//                   flex: 1,
//                   child: pw.Align(
//                     alignment: pw.Alignment.topLeft,
//                     child: pw.Text(
//                       "3.Fan On ",
//                       textAlign: pw.TextAlign.left,
//                       style: pw.TextStyle(
//                         // color: pw.Colors.blue,
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//                 pw.Expanded(
//                     flex: 1,
//                     child: pw.Row(children: [
//                       pw.Image(
//                           alignment: pw.Alignment.center,
//                           (interiorData[0]['FAN_ON'] == null ||
//                                   interiorData[0]['FAN_ON'].toString() == '' ||
//                                   interiorData[0]['FAN_ON'].toString() ==
//                                       'False')
//                               ? blankCheckBoxImage
//                               : checkBoxImage,
//                           fit: pw.BoxFit.contain,
//                           width: 18,
//                           height: 18),
//                       pw.SizedBox(width: 4),
//                       pw.Text(
//                         "On",
//                         textAlign: pw.TextAlign.left,
//                         style: pw.TextStyle(
//                           // color: pw.Colors.blue,
//                           fontWeight: pw.FontWeight.bold,
//                           fontSize: 14,
//                         ),
//                       ),
//                       pw.SizedBox(width: 4),
//                       pw.Image(
//                           alignment: pw.Alignment.center,
//                           (interiorData[0]['FAN_OFF'] == null ||
//                                   interiorData[0]['FAN_OFF'].toString() == '' ||
//                                   interiorData[0]['FAN_OFF'].toString() ==
//                                       'False')
//                               ? blankCheckBoxImage
//                               : checkBoxImage,
//                           fit: pw.BoxFit.contain,
//                           width: 18,
//                           height: 18),
//                       pw.SizedBox(width: 4),
//                       pw.Text(
//                         "Off",
//                         textAlign: pw.TextAlign.left,
//                         style: pw.TextStyle(
//                           // color: pw.Colors.blue,
//                           fontWeight: pw.FontWeight.bold,
//                           fontSize: 14,
//                         ),
//                       ),
//                       pw.SizedBox(width: 4),
//                       pw.Image(
//                           alignment: pw.Alignment.center,
//                           (interiorData[0]['FAN_AUTO'] == null ||
//                                   interiorData[0]['FAN_AUTO'].toString() ==
//                                       '' ||
//                                   interiorData[0]['FAN_AUTO'].toString() ==
//                                       'False')
//                               ? blankCheckBoxImage
//                               : checkBoxImage,
//                           fit: pw.BoxFit.contain,
//                           width: 18,
//                           height: 18),
//                       pw.SizedBox(width: 4),
//                       pw.Text(
//                         "Auto",
//                         textAlign: pw.TextAlign.left,
//                         style: pw.TextStyle(
//                           // color: pw.Colors.blue,
//                           fontWeight: pw.FontWeight.bold,
//                           fontSize: 14,
//                         ),
//                       ),
//                     ])),
//               ],
//             ),
//             pw.SizedBox(height: 6),
//             pw.Row(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Expanded(
//                   flex: 1,
//                   child: pw.Text(
//                     (interiorData[0]['FAN_COMMENTS'] == null ||
//                             interiorData[0]['FAN_COMMENTS'].toString() == '')
//                         ? "N/A"
//                         : interiorData[0]['FAN_COMMENTS'].toString(),
//                     textAlign: pw.TextAlign.left,
//                     style: pw.TextStyle(
//                       fontWeight: pw.FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             pw.SizedBox(height: 6),
//             pw.Row(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Expanded(
//                   flex: 1,
//                   child: pw.Align(
//                     alignment: pw.Alignment.topLeft,
//                     child: pw.Text(
//                       "4.Room Doors Kept Open ",
//                       textAlign: pw.TextAlign.left,
//                       style: pw.TextStyle(
//                         // color: pw.Colors.blue,
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//                 pw.Expanded(
//                     flex: 1,
//                     child: pw.Row(children: [
//                       pw.Image(
//                           alignment: pw.Alignment.center,
//                           (interiorData[0]['ROOM_DOORS_KEPT_OPEN_Y'] == null ||
//                                   interiorData[0]['ROOM_DOORS_KEPT_OPEN_Y']
//                                           .toString() ==
//                                       '' ||
//                                   interiorData[0]['ROOM_DOORS_KEPT_OPEN_Y']
//                                           .toString() ==
//                                       'False')
//                               ? blankCheckBoxImage
//                               : checkBoxImage,
//                           fit: pw.BoxFit.contain,
//                           width: 18,
//                           height: 18),
//                       pw.SizedBox(width: 4),
//                       pw.Text(
//                         "Yes",
//                         textAlign: pw.TextAlign.left,
//                         style: pw.TextStyle(
//                           // color: pw.Colors.blue,
//                           fontWeight: pw.FontWeight.bold,
//                           fontSize: 14,
//                         ),
//                       ),
//                       pw.SizedBox(width: 4),
//                       pw.Image(
//                           alignment: pw.Alignment.center,
//                           (interiorData[0]['ROOM_DOORS_KEPT_OPEN_N'] == null ||
//                                   interiorData[0]['ROOM_DOORS_KEPT_OPEN_N']
//                                           .toString() ==
//                                       '' ||
//                                   interiorData[0]['ROOM_DOORS_KEPT_OPEN_N']
//                                           .toString() ==
//                                       'False')
//                               ? blankCheckBoxImage
//                               : checkBoxImage,
//                           fit: pw.BoxFit.contain,
//                           width: 18,
//                           height: 18),
//                       pw.SizedBox(width: 4),
//                       pw.Text(
//                         "No",
//                         textAlign: pw.TextAlign.left,
//                         style: pw.TextStyle(
//                           // color: pw.Colors.blue,
//                           fontWeight: pw.FontWeight.bold,
//                           fontSize: 14,
//                         ),
//                       ),
//                     ])),
//                 pw.Expanded(
//                   flex: 3,
//                   child: pw.Text(
//                     (interiorData[0]['ROOM_DOORS_KEPT_OPEN_COMMENTS'] == null ||
//                             interiorData[0]['ROOM_DOORS_KEPT_OPEN_COMMENTS']
//                                     .toString() ==
//                                 '')
//                         ? "N/A"
//                         : interiorData[0]['ROOM_DOORS_KEPT_OPEN_COMMENTS']
//                             .toString(),
//                     textAlign: pw.TextAlign.left,
//                     style: pw.TextStyle(
//                       fontWeight: pw.FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             pw.SizedBox(height: 6),
//             pw.Row(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Expanded(
//                   flex: 1,
//                   child: pw.Align(
//                     alignment: pw.Alignment.topLeft,
//                     child: pw.Text(
//                       "5.Supply Registers Open ",
//                       textAlign: pw.TextAlign.left,
//                       style: pw.TextStyle(
//                         // color: pw.Colors.blue,
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//                 pw.Expanded(
//                     flex: 1,
//                     child: pw.Row(children: [
//                       pw.Image(
//                           alignment: pw.Alignment.center,
//                           (interiorData[0]['SUPPLY_REGISTERS_OPEN_Y'] == null ||
//                                   interiorData[0]['SUPPLY_REGISTERS_OPEN_Y']
//                                           .toString() ==
//                                       '' ||
//                                   interiorData[0]['SUPPLY_REGISTERS_OPEN_Y']
//                                           .toString() ==
//                                       'False')
//                               ? blankCheckBoxImage
//                               : checkBoxImage,
//                           fit: pw.BoxFit.contain,
//                           width: 18,
//                           height: 18),
//                       pw.SizedBox(width: 4),
//                       pw.Text(
//                         "Yes",
//                         textAlign: pw.TextAlign.left,
//                         style: pw.TextStyle(
//                           // color: pw.Colors.blue,
//                           fontWeight: pw.FontWeight.bold,
//                           fontSize: 14,
//                         ),
//                       ),
//                       pw.SizedBox(width: 4),
//                       pw.Image(
//                           alignment: pw.Alignment.center,
//                           (interiorData[0]['SUPPLY_REGISTERS_OPEN_N'] == null ||
//                                   interiorData[0]['SUPPLY_REGISTERS_OPEN_N']
//                                           .toString() ==
//                                       '' ||
//                                   interiorData[0]['SUPPLY_REGISTERS_OPEN_N']
//                                           .toString() ==
//                                       'False')
//                               ? blankCheckBoxImage
//                               : checkBoxImage,
//                           fit: pw.BoxFit.contain,
//                           width: 18,
//                           height: 18),
//                       pw.SizedBox(width: 4),
//                       pw.Text(
//                         "No",
//                         textAlign: pw.TextAlign.left,
//                         style: pw.TextStyle(
//                           // color: pw.Colors.blue,
//                           fontWeight: pw.FontWeight.bold,
//                           fontSize: 14,
//                         ),
//                       ),
//                     ])),
//                 pw.Expanded(
//                   flex: 3,
//                   child: pw.Text(
//                     (interiorData[0]['SUPPLY_REGISTERS_OPEN_COMMENTS'] ==
//                                 null ||
//                             interiorData[0]['SUPPLY_REGISTERS_OPEN_COMMENTS']
//                                     .toString() ==
//                                 '')
//                         ? "N/A"
//                         : interiorData[0]['SUPPLY_REGISTERS_OPEN_COMMENTS']
//                             .toString(),
//                     textAlign: pw.TextAlign.left,
//                     style: pw.TextStyle(
//                       fontWeight: pw.FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             pw.SizedBox(height: 6),
//             pw.Row(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Expanded(
//                   flex: 1,
//                   child: pw.Align(
//                     alignment: pw.Alignment.topLeft,
//                     child: pw.Text(
//                       "6.Return Filters ",
//                       textAlign: pw.TextAlign.left,
//                       style: pw.TextStyle(
//                         // color: pw.Colors.blue,
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//                 pw.Expanded(
//                     flex: 1,
//                     child: pw.Row(children: [
//                       pw.Image(
//                           alignment: pw.Alignment.center,
//                           (interiorData[0]['RETURN_FILTER_G'] == null ||
//                                   interiorData[0]['RETURN_FILTER_G']
//                                           .toString() ==
//                                       '' ||
//                                   interiorData[0]['RETURN_FILTER_G']
//                                           .toString() ==
//                                       'False')
//                               ? blankCheckBoxImage
//                               : checkBoxImage,
//                           fit: pw.BoxFit.contain,
//                           width: 18,
//                           height: 18),
//                       pw.SizedBox(width: 4),
//                       pw.Text(
//                         "G",
//                         textAlign: pw.TextAlign.left,
//                         style: pw.TextStyle(
//                           // color: pw.Colors.blue,
//                           fontWeight: pw.FontWeight.bold,
//                           fontSize: 14,
//                         ),
//                       ),
//                       pw.SizedBox(width: 4),
//                       pw.Image(
//                           alignment: pw.Alignment.center,
//                           (interiorData[0]['RETURN_FILTER_F'] == null ||
//                                   interiorData[0]['RETURN_FILTER_F']
//                                           .toString() ==
//                                       '' ||
//                                   interiorData[0]['RETURN_FILTER_F']
//                                           .toString() ==
//                                       'False')
//                               ? blankCheckBoxImage
//                               : checkBoxImage,
//                           fit: pw.BoxFit.contain,
//                           width: 18,
//                           height: 18),
//                       pw.SizedBox(width: 4),
//                       pw.Text(
//                         "F",
//                         textAlign: pw.TextAlign.left,
//                         style: pw.TextStyle(
//                           // color: pw.Colors.blue,
//                           fontWeight: pw.FontWeight.bold,
//                           fontSize: 14,
//                         ),
//                       ),
//                       pw.SizedBox(width: 4),
//                       pw.Image(
//                           alignment: pw.Alignment.center,
//                           (interiorData[0]['RETURN_FILTER_P'] == null ||
//                                   interiorData[0]['RETURN_FILTER_P']
//                                           .toString() ==
//                                       '' ||
//                                   interiorData[0]['RETURN_FILTER_P']
//                                           .toString() ==
//                                       'False')
//                               ? blankCheckBoxImage
//                               : checkBoxImage,
//                           fit: pw.BoxFit.contain,
//                           width: 18,
//                           height: 18),
//                       pw.SizedBox(width: 4),
//                       pw.Text(
//                         "P",
//                         textAlign: pw.TextAlign.left,
//                         style: pw.TextStyle(
//                           // color: pw.Colors.blue,
//                           fontWeight: pw.FontWeight.bold,
//                           fontSize: 14,
//                         ),
//                       ),
//                     ])),
//                 pw.Expanded(
//                   flex: 3,
//                   child: pw.Text(
//                     (interiorData[0]['RETURN_FILTER_COMMENTS'] == null ||
//                             interiorData[0]['RETURN_FILTER_COMMENTS']
//                                     .toString() ==
//                                 '')
//                         ? "N/A"
//                         : interiorData[0]['RETURN_FILTER_COMMENTS'].toString(),
//                     textAlign: pw.TextAlign.left,
//                     style: pw.TextStyle(
//                       fontWeight: pw.FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             pw.SizedBox(height: 6),
//             pw.Divider(height: 1),
//             pw.Align(
//                 alignment: pw.Alignment.centerLeft,
//                 child: pw.Text(
//                   'Space Heating',
//                   style: pw.TextStyle(
//                     fontWeight: pw.FontWeight.bold,
//                     fontSize: 18,
//                     // decoration: pw.TextDecoration.underline,
//                   ),
//                 )),
//             pw.Divider(height: 1),
//             pw.SizedBox(height: 6),
//             pw.Row(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Expanded(
//                   flex: 1,
//                   child: pw.Align(
//                     alignment: pw.Alignment.topLeft,
//                     child: pw.Text(
//                       "1.Electric ",
//                       textAlign: pw.TextAlign.left,
//                       style: pw.TextStyle(
//                         // color: pw.Colors.blue,
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//                 pw.Expanded(
//                     flex: 1,
//                     child: pw.Row(
//                       children: [
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (interiorData[0]['ELECTRIC_Y'] == null ||
//                                     interiorData[0]['ELECTRIC_Y'].toString() ==
//                                         '' ||
//                                     interiorData[0]['ELECTRIC_Y'].toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "Yes",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         pw.SizedBox(width: 4),
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (interiorData[0]['ELECTRIC_N'] == null ||
//                                     interiorData[0]['ELECTRIC_N'].toString() ==
//                                         '' ||
//                                     interiorData[0]['ELECTRIC_N'].toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "No",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     )),
//                 pw.Expanded(
//                   flex: 3,
//                   child: pw.Text(
//                     (interiorData[0]['ELECTRIC_COMMENTS'] == null ||
//                             interiorData[0]['ELECTRIC_COMMENTS'].toString() ==
//                                 '')
//                         ? "N/A"
//                         : interiorData[0]['ELECTRIC_COMMENTS'].toString(),
//                     textAlign: pw.TextAlign.left,
//                     style: pw.TextStyle(
//                       fontWeight: pw.FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             pw.SizedBox(height: 6),
//             pw.Row(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Expanded(
//                   flex: 1,
//                   child: pw.Align(
//                     alignment: pw.Alignment.topLeft,
//                     child: pw.Text(
//                       "2.BTU Size	 ",
//                       textAlign: pw.TextAlign.left,
//                       style: pw.TextStyle(
//                         // color: pw.Colors.blue,
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//                 pw.Expanded(
//                   flex: 2,
//                   child: pw.Text(
//                     (interiorData[0]['BTU_SIZE_COMMENTS'] == null ||
//                             interiorData[0]['BTU_SIZE_COMMENTS'].toString() ==
//                                 '')
//                         ? "N/A"
//                         : interiorData[0]['BTU_SIZE_COMMENTS'].toString(),
//                     textAlign: pw.TextAlign.left,
//                     style: pw.TextStyle(
//                       fontWeight: pw.FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             pw.SizedBox(height: 6),
//             pw.Row(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Expanded(
//                   flex: 1,
//                   child: pw.Align(
//                     alignment: pw.Alignment.topLeft,
//                     child: pw.Text(
//                       "3.How Many ",
//                       textAlign: pw.TextAlign.left,
//                       style: pw.TextStyle(
//                         // color: pw.Colors.blue,
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//                 pw.Expanded(
//                   flex: 2,
//                   child: pw.Text(
//                     (interiorData[0]['HOW_MANY'] == null ||
//                             interiorData[0]['HOW_MANY'].toString() == '')
//                         ? "N/A"
//                         : interiorData[0]['HOW_MANY'].toString(),
//                     textAlign: pw.TextAlign.left,
//                     style: pw.TextStyle(
//                       fontWeight: pw.FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             pw.SizedBox(height: 6),
//             pw.Divider(height: 1),
//             pw.Align(
//                 alignment: pw.Alignment.centerLeft,
//                 child: pw.Text(
//                   'Windows A/C',
//                   style: pw.TextStyle(
//                     fontWeight: pw.FontWeight.bold,
//                     fontSize: 18,
//                     // decoration: pw.TextDecoration.underline,
//                   ),
//                 )),
//             pw.Divider(height: 1),
//             pw.SizedBox(height: 6),
//             pw.Row(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Expanded(
//                   flex: 1,
//                   child: pw.Align(
//                     alignment: pw.Alignment.topLeft,
//                     child: pw.Text(
//                       "1.Area Sealed Around Unit ",
//                       textAlign: pw.TextAlign.left,
//                       style: pw.TextStyle(
//                         // color: pw.Colors.blue,
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//                 pw.Expanded(
//                     flex: 1,
//                     child: pw.Row(
//                       children: [
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (interiorData[0]['AREA_SEALED_AROUND_UNIT_Y'] ==
//                                         null ||
//                                     interiorData[0]['AREA_SEALED_AROUND_UNIT_Y']
//                                             .toString() ==
//                                         '' ||
//                                     interiorData[0]['AREA_SEALED_AROUND_UNIT_Y']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "Yes",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         pw.SizedBox(width: 4),
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (interiorData[0]['AREA_SEALED_AROUND_UNIT_N'] ==
//                                         null ||
//                                     interiorData[0]['AREA_SEALED_AROUND_UNIT_N']
//                                             .toString() ==
//                                         '' ||
//                                     interiorData[0]['AREA_SEALED_AROUND_UNIT_N']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "No",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     )),
//                 pw.Expanded(
//                   flex: 3,
//                   child: pw.Text(
//                     (interiorData[0]['AREA_SEALED_AROUND_UNIT_COMMENTS'] ==
//                                 null ||
//                             interiorData[0]['AREA_SEALED_AROUND_UNIT_COMMENTS']
//                                     .toString() ==
//                                 '')
//                         ? "N/A"
//                         : interiorData[0]['AREA_SEALED_AROUND_UNIT_COMMENTS']
//                             .toString(),
//                     textAlign: pw.TextAlign.left,
//                     style: pw.TextStyle(
//                       fontWeight: pw.FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             pw.SizedBox(height: 6),
//             pw.Row(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Expanded(
//                   flex: 1,
//                   child: pw.Align(
//                     alignment: pw.Alignment.topLeft,
//                     child: pw.Text(
//                       "2.Filter	 ",
//                       textAlign: pw.TextAlign.left,
//                       style: pw.TextStyle(
//                         // color: pw.Colors.blue,
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//                 pw.Expanded(
//                     flex: 1,
//                     child: pw.Row(
//                       children: [
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (interiorData[0]['FILTER_G'] == null ||
//                                     interiorData[0]['FILTER_G'].toString() ==
//                                         '' ||
//                                     interiorData[0]['FILTER_G'].toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "G",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         pw.SizedBox(width: 4),
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (interiorData[0]['FILTER_F'] == null ||
//                                     interiorData[0]['FILTER_F'].toString() ==
//                                         '' ||
//                                     interiorData[0]['FILTER_F'].toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "F",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         pw.SizedBox(width: 4),
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (interiorData[0]['FILTER_P'] == null ||
//                                     interiorData[0]['FILTER_P'].toString() ==
//                                         '' ||
//                                     interiorData[0]['FILTER_P'].toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "P",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     )),
//                 pw.Expanded(
//                   flex: 3,
//                   child: pw.Text(
//                     (interiorData[0]['FILTER_COMMENTS'] == null ||
//                             interiorData[0]['FILTER_COMMENTS'].toString() == '')
//                         ? "N/A"
//                         : interiorData[0]['FILTER_COMMENTS'].toString(),
//                     textAlign: pw.TextAlign.left,
//                     style: pw.TextStyle(
//                       fontWeight: pw.FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             pw.SizedBox(height: 6),
//             pw.Divider(height: 1),
//             pw.Align(
//                 alignment: pw.Alignment.centerLeft,
//                 child: pw.Text(
//                   'Infilteration',
//                   style: pw.TextStyle(
//                     fontWeight: pw.FontWeight.bold,
//                     fontSize: 18,
//                     // decoration: pw.TextDecoration.underline,
//                   ),
//                 )),
//             pw.Divider(height: 1),
//             pw.SizedBox(height: 6),
//             pw.Row(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Expanded(
//                   flex: 1,
//                   child: pw.Align(
//                     alignment: pw.Alignment.topLeft,
//                     child: pw.Text(
//                       "1.Windows ",
//                       textAlign: pw.TextAlign.left,
//                       style: pw.TextStyle(
//                         // color: pw.Colors.blue,
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//                 pw.Expanded(
//                     flex: 1,
//                     child: pw.Row(
//                       children: [
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (interiorData[0]['WINDOWS_G'] == null ||
//                                     interiorData[0]['WINDOWS_G'].toString() ==
//                                         '' ||
//                                     interiorData[0]['WINDOWS_G'].toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "G",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         pw.SizedBox(width: 4),
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (interiorData[0]['WINDOWS_F'] == null ||
//                                     interiorData[0]['WINDOWS_F'].toString() ==
//                                         '' ||
//                                     interiorData[0]['WINDOWS_F'].toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "F",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         pw.SizedBox(width: 4),
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (interiorData[0]['WINDOWS_P'] == null ||
//                                     interiorData[0]['WINDOWS_P'].toString() ==
//                                         '' ||
//                                     interiorData[0]['WINDOWS_P'].toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "P",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     )),
//                 pw.Expanded(
//                   flex: 3,
//                   child: pw.Text(
//                     (interiorData[0]['WINDOWS_COMMENTS'] == null ||
//                             interiorData[0]['WINDOWS_COMMENTS'].toString() ==
//                                 '')
//                         ? "N/A"
//                         : interiorData[0]['WINDOWS_COMMENTS'].toString(),
//                     textAlign: pw.TextAlign.left,
//                     style: pw.TextStyle(
//                       fontWeight: pw.FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             pw.SizedBox(height: 6),
//             pw.Row(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Expanded(
//                   flex: 1,
//                   child: pw.Align(
//                     alignment: pw.Alignment.topLeft,
//                     child: pw.Text(
//                       "2.Doors	 ",
//                       textAlign: pw.TextAlign.left,
//                       style: pw.TextStyle(
//                         // color: pw.Colors.blue,
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//                 pw.Expanded(
//                     flex: 1,
//                     child: pw.Row(
//                       children: [
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (interiorData[0]['DOORS_G'] == null ||
//                                     interiorData[0]['DOORS_G'].toString() ==
//                                         '' ||
//                                     interiorData[0]['DOORS_G'].toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "G",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         pw.SizedBox(width: 4),
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (interiorData[0]['DOORS_F'] == null ||
//                                     interiorData[0]['DOORS_F'].toString() ==
//                                         '' ||
//                                     interiorData[0]['DOORS_F'].toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "F",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         pw.SizedBox(width: 4),
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (interiorData[0]['DOORS_P'] == null ||
//                                     interiorData[0]['DOORS_P'].toString() ==
//                                         '' ||
//                                     interiorData[0]['DOORS_P'].toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "P",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     )),
//                 pw.Expanded(
//                   flex: 3,
//                   child: pw.Text(
//                     (interiorData[0]['DOORS_COMMENTS'] == null ||
//                             interiorData[0]['DOORS_COMMENTS'].toString() == '')
//                         ? "N/A"
//                         : interiorData[0]['DOORS_COMMENTS'].toString(),
//                     textAlign: pw.TextAlign.left,
//                     style: pw.TextStyle(
//                       fontWeight: pw.FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             pw.SizedBox(height: 6),
//             pw.Row(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Expanded(
//                   flex: 1,
//                   child: pw.Align(
//                     alignment: pw.Alignment.topLeft,
//                     child: pw.Text(
//                       "3.Fireplace Damper ",
//                       textAlign: pw.TextAlign.left,
//                       style: pw.TextStyle(
//                         // color: pw.Colors.blue,
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//                 pw.Expanded(
//                     flex: 1,
//                     child: pw.Row(
//                       children: [
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (interiorData[0]['FIREPLACE_DAMPER_G'] == null ||
//                                     interiorData[0]['FIREPLACE_DAMPER_G']
//                                             .toString() ==
//                                         '' ||
//                                     interiorData[0]['FIREPLACE_DAMPER_G']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "G",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         pw.SizedBox(width: 4),
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (interiorData[0]['FIREPLACE_DAMPER_F'] == null ||
//                                     interiorData[0]['FIREPLACE_DAMPER_F']
//                                             .toString() ==
//                                         '' ||
//                                     interiorData[0]['FIREPLACE_DAMPER_F']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "F",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         pw.SizedBox(width: 4),
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (interiorData[0]['FIREPLACE_DAMPER_P'] == null ||
//                                     interiorData[0]['FIREPLACE_DAMPER_P']
//                                             .toString() ==
//                                         '' ||
//                                     interiorData[0]['FIREPLACE_DAMPER_P']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "P",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     )),
//                 pw.Expanded(
//                   flex: 3,
//                   child: pw.Text(
//                     (interiorData[0]['FIREPLACE_DAMPER_COMMENTS'] == null ||
//                             interiorData[0]['FIREPLACE_DAMPER_COMMENTS']
//                                     .toString() ==
//                                 '')
//                         ? "N/A"
//                         : interiorData[0]['FIREPLACE_DAMPER_COMMENTS']
//                             .toString(),
//                     textAlign: pw.TextAlign.left,
//                     style: pw.TextStyle(
//                       fontWeight: pw.FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             pw.SizedBox(height: 6),
//             pw.Row(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Expanded(
//                   flex: 1,
//                   child: pw.Align(
//                     alignment: pw.Alignment.topLeft,
//                     child: pw.Text(
//                       "4.Outlet & Plumbing ",
//                       textAlign: pw.TextAlign.left,
//                       style: pw.TextStyle(
//                         // color: pw.Colors.blue,
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//                 pw.Expanded(
//                     flex: 1,
//                     child: pw.Row(
//                       children: [
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (interiorData[0]['OUTLET_PLUMBING_G'] == null ||
//                                     interiorData[0]['OUTLET_PLUMBING_G']
//                                             .toString() ==
//                                         '' ||
//                                     interiorData[0]['OUTLET_PLUMBING_G']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "G",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         pw.SizedBox(width: 4),
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (interiorData[0]['OUTLET_PLUMBING_F'] == null ||
//                                     interiorData[0]['OUTLET_PLUMBING_F']
//                                             .toString() ==
//                                         '' ||
//                                     interiorData[0]['OUTLET_PLUMBING_F']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "F",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         pw.SizedBox(width: 4),
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (interiorData[0]['OUTLET_PLUMBING_P'] == null ||
//                                     interiorData[0]['OUTLET_PLUMBING_P']
//                                             .toString() ==
//                                         '' ||
//                                     interiorData[0]['OUTLET_PLUMBING_P']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "P",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     )),
//                 pw.Expanded(
//                   flex: 3,
//                   child: pw.Text(
//                     (interiorData[0]['OUTLET_PLUMBING_COMMENTS'] == null ||
//                             interiorData[0]['OUTLET_PLUMBING_COMMENTS']
//                                     .toString() ==
//                                 '')
//                         ? "N/A"
//                         : interiorData[0]['OUTLET_PLUMBING_COMMENTS']
//                             .toString(),
//                     textAlign: pw.TextAlign.left,
//                     style: pw.TextStyle(
//                       fontWeight: pw.FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             pw.SizedBox(height: 6),
//             pw.Divider(height: 1),
//             pw.Align(
//                 alignment: pw.Alignment.centerLeft,
//                 child: pw.Text(
//                   '.Attic',
//                   style: pw.TextStyle(
//                     fontWeight: pw.FontWeight.bold,
//                     fontSize: 18,
//                     // decoration: pw.TextDecoration.underline,
//                   ),
//                 )),
//             pw.Divider(height: 1),
//             pw.SizedBox(height: 6),
//             pw.Row(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Expanded(
//                   flex: 1,
//                   child: pw.Align(
//                     alignment: pw.Alignment.topLeft,
//                     child: pw.Text(
//                       "1.Insulation ",
//                       textAlign: pw.TextAlign.left,
//                       style: pw.TextStyle(
//                         // color: pw.Colors.blue,
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//                 pw.Expanded(
//                     flex: 1,
//                     child: pw.Row(
//                       children: [
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (interiorData[0]['INSULATION_R'] == null ||
//                                     interiorData[0]['INSULATION_R']
//                                             .toString() ==
//                                         '' ||
//                                     interiorData[0]['INSULATION_R']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "R",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "__",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     )),
//                 pw.Expanded(
//                   flex: 3,
//                   child: pw.Text(
//                     (interiorData[0]['INSULATION_COMMENTS'] == null ||
//                             interiorData[0]['INSULATION_COMMENTS'].toString() ==
//                                 '')
//                         ? "N/A"
//                         : interiorData[0]['INSULATION_COMMENTS'].toString(),
//                     textAlign: pw.TextAlign.left,
//                     style: pw.TextStyle(
//                       fontWeight: pw.FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             pw.SizedBox(height: 6),
//             pw.Row(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Expanded(
//                   flex: 1,
//                   child: pw.Align(
//                     alignment: pw.Alignment.topLeft,
//                     child: pw.Text(
//                       "2.Ventilation ",
//                       textAlign: pw.TextAlign.left,
//                       style: pw.TextStyle(
//                         // color: pw.Colors.blue,
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//                 pw.Expanded(
//                     flex: 1,
//                     child: pw.Row(
//                       children: [
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (interiorData[0]['VENTILATION_G'] == null ||
//                                     interiorData[0]['VENTILATION_G']
//                                             .toString() ==
//                                         '' ||
//                                     interiorData[0]['VENTILATION_G']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "G",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         pw.SizedBox(width: 4),
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (interiorData[0]['VENTILATION_F'] == null ||
//                                     interiorData[0]['VENTILATION_F']
//                                             .toString() ==
//                                         '' ||
//                                     interiorData[0]['VENTILATION_F']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "F",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         pw.SizedBox(width: 4),
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (interiorData[0]['VENTILATION_P'] == null ||
//                                     interiorData[0]['VENTILATION_P']
//                                             .toString() ==
//                                         '' ||
//                                     interiorData[0]['VENTILATION_P']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "P",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     )),
//                 pw.Expanded(
//                   flex: 3,
//                   child: pw.Text(
//                     (interiorData[0]['VENTILATION_COMMENTS'] == null ||
//                             interiorData[0]['VENTILATION_COMMENTS']
//                                     .toString() ==
//                                 '')
//                         ? "N/A"
//                         : interiorData[0]['VENTILATION_COMMENTS'].toString(),
//                     textAlign: pw.TextAlign.left,
//                     style: pw.TextStyle(
//                       fontWeight: pw.FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             pw.SizedBox(height: 6),
//             pw.Row(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Expanded(
//                   flex: 1,
//                   child: pw.Align(
//                     alignment: pw.Alignment.topLeft,
//                     child: pw.Text(
//                       "3.Soffits Clear ",
//                       textAlign: pw.TextAlign.left,
//                       style: pw.TextStyle(
//                         // color: pw.Colors.blue,
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//                 pw.Expanded(
//                     flex: 1,
//                     child: pw.Row(
//                       children: [
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (interiorData[0]['SOFFITS_CLEAR_G'] == null ||
//                                     interiorData[0]['SOFFITS_CLEAR_G']
//                                             .toString() ==
//                                         '' ||
//                                     interiorData[0]['SOFFITS_CLEAR_G']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "G",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         pw.SizedBox(width: 4),
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (interiorData[0]['SOFFITS_CLEAR_F'] == null ||
//                                     interiorData[0]['SOFFITS_CLEAR_F']
//                                             .toString() ==
//                                         '' ||
//                                     interiorData[0]['SOFFITS_CLEAR_F']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "F",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         pw.SizedBox(width: 4),
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (interiorData[0]['SOFFITS_CLEAR_P'] == null ||
//                                     interiorData[0]['SOFFITS_CLEAR_P']
//                                             .toString() ==
//                                         '' ||
//                                     interiorData[0]['SOFFITS_CLEAR_P']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "P",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     )),
//                 pw.Expanded(
//                   flex: 3,
//                   child: pw.Text(
//                     (interiorData[0]['SOFFITS_CLEAR_COMMENTS'] == null ||
//                             interiorData[0]['SOFFITS_CLEAR_COMMENTS']
//                                     .toString() ==
//                                 '')
//                         ? "N/A"
//                         : interiorData[0]['SOFFITS_CLEAR_COMMENTS'].toString(),
//                     textAlign: pw.TextAlign.left,
//                     style: pw.TextStyle(
//                       fontWeight: pw.FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             pw.SizedBox(height: 6),
//             pw.Row(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Expanded(
//                   flex: 1,
//                   child: pw.Align(
//                     alignment: pw.Alignment.topLeft,
//                     child: pw.Text(
//                       "4.Duct Insulation ",
//                       textAlign: pw.TextAlign.left,
//                       style: pw.TextStyle(
//                         // color: pw.Colors.blue,
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//                 pw.Expanded(
//                     flex: 1,
//                     child: pw.Row(
//                       children: [
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (interiorData[0]['DUCTS_INSULATION_G'] == null ||
//                                     interiorData[0]['DUCTS_INSULATION_G']
//                                             .toString() ==
//                                         '' ||
//                                     interiorData[0]['DUCTS_INSULATION_G']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "G",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         pw.SizedBox(width: 4),
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (interiorData[0]['DUCTS_INSULATION_F'] == null ||
//                                     interiorData[0]['DUCTS_INSULATION_F']
//                                             .toString() ==
//                                         '' ||
//                                     interiorData[0]['DUCTS_INSULATION_F']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "F",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         pw.SizedBox(width: 4),
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (interiorData[0]['DUCTS_INSULATION_P'] == null ||
//                                     interiorData[0]['DUCTS_INSULATION_P']
//                                             .toString() ==
//                                         '' ||
//                                     interiorData[0]['DUCTS_INSULATION_P']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "P",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     )),
//                 pw.Expanded(
//                   flex: 3,
//                   child: pw.Text(
//                     (interiorData[0]['DUCTS_INSULATION_COMMENTS'] == null ||
//                             interiorData[0]['DUCTS_INSULATION_COMMENTS']
//                                     .toString() ==
//                                 '')
//                         ? "N/A"
//                         : interiorData[0]['DUCTS_INSULATION_COMMENTS']
//                             .toString(),
//                     textAlign: pw.TextAlign.left,
//                     style: pw.TextStyle(
//                       fontWeight: pw.FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             pw.SizedBox(height: 6),
//             pw.Row(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Expanded(
//                   flex: 1,
//                   child: pw.Align(
//                     alignment: pw.Alignment.topLeft,
//                     child: pw.Text(
//                       "5.Duct Leakage ",
//                       textAlign: pw.TextAlign.left,
//                       style: pw.TextStyle(
//                         // color: pw.Colors.blue,
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//                 pw.Expanded(
//                     flex: 1,
//                     child: pw.Row(
//                       children: [
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (interiorData[0]['DUCTS_LEAKAGE_G'] == null ||
//                                     interiorData[0]['DUCTS_LEAKAGE_G']
//                                             .toString() ==
//                                         '' ||
//                                     interiorData[0]['DUCTS_LEAKAGE_G']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "G",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         pw.SizedBox(width: 4),
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (interiorData[0]['DUCTS_LEAKAGE_F'] == null ||
//                                     interiorData[0]['DUCTS_LEAKAGE_F']
//                                             .toString() ==
//                                         '' ||
//                                     interiorData[0]['DUCTS_LEAKAGE_F']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "F",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         pw.SizedBox(width: 4),
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (interiorData[0]['DUCTS_LEAKAGE_P'] == null ||
//                                     interiorData[0]['DUCTS_LEAKAGE_P']
//                                             .toString() ==
//                                         '' ||
//                                     interiorData[0]['DUCTS_LEAKAGE_P']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "P",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     )),
//                 pw.Expanded(
//                   flex: 3,
//                   child: pw.Text(
//                     (interiorData[0]['DUCTS_LEAKAGE_COMMENTS'] == null ||
//                             interiorData[0]['DUCTS_LEAKAGE_COMMENTS']
//                                     .toString() ==
//                                 '')
//                         ? "N/A"
//                         : interiorData[0]['DUCTS_LEAKAGE_COMMENTS'].toString(),
//                     textAlign: pw.TextAlign.left,
//                     style: pw.TextStyle(
//                       fontWeight: pw.FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             pw.SizedBox(height: 6),
//             pw.Row(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Expanded(
//                   flex: 1,
//                   child: pw.Align(
//                     alignment: pw.Alignment.topLeft,
//                     child: pw.Text(
//                       "6.Air Handler ",
//                       textAlign: pw.TextAlign.left,
//                       style: pw.TextStyle(
//                         // color: pw.Colors.blue,
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//                 pw.Expanded(
//                     flex: 1,
//                     child: pw.Row(
//                       children: [
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (interiorData[0]['AIR_HANDLER_G'] == null ||
//                                     interiorData[0]['AIR_HANDLER_G']
//                                             .toString() ==
//                                         '' ||
//                                     interiorData[0]['AIR_HANDLER_G']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "G",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         pw.SizedBox(width: 4),
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (interiorData[0]['AIR_HANDLER_F'] == null ||
//                                     interiorData[0]['AIR_HANDLER_F']
//                                             .toString() ==
//                                         '' ||
//                                     interiorData[0]['AIR_HANDLER_F']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "F",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         pw.SizedBox(width: 4),
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (interiorData[0]['AIR_HANDLER_P'] == null ||
//                                     interiorData[0]['AIR_HANDLER_P']
//                                             .toString() ==
//                                         '' ||
//                                     interiorData[0]['AIR_HANDLER_P']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "P",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     )),
//                 pw.Expanded(
//                   flex: 3,
//                   child: pw.Text(
//                     (interiorData[0]['AIR_HANDLER_COMMENTS'] == null ||
//                             interiorData[0]['AIR_HANDLER_COMMENTS']
//                                     .toString() ==
//                                 '')
//                         ? "N/A"
//                         : interiorData[0]['AIR_HANDLER_COMMENTS'].toString(),
//                     textAlign: pw.TextAlign.left,
//                     style: pw.TextStyle(
//                       fontWeight: pw.FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             pw.SizedBox(height: 6),
//             pw.Divider(height: 1),
//             pw.Align(
//                 alignment: pw.Alignment.centerLeft,
//                 child: pw.Text(
//                   'Refrigerators & Freezers',
//                   style: pw.TextStyle(
//                     fontWeight: pw.FontWeight.bold,
//                     fontSize: 18,
//                     // decoration: pw.TextDecoration.underline,
//                   ),
//                 )),
//             pw.Divider(height: 1),
//             pw.SizedBox(height: 6),
//             pw.Row(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Expanded(
//                   flex: 1,
//                   child: pw.Align(
//                     alignment: pw.Alignment.topLeft,
//                     child: pw.Text(
//                       "1.How Many ",
//                       textAlign: pw.TextAlign.left,
//                       style: pw.TextStyle(
//                         // color: pw.Colors.blue,
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//                 pw.Expanded(
//                   flex: 2,
//                   child: pw.Text(
//                     (interiorData[0]['HOW_MANY_FRIG'] == null ||
//                             interiorData[0]['HOW_MANY_FRIG'].toString() == '')
//                         ? "N/A"
//                         : interiorData[0]['HOW_MANY_FRIG'].toString(),
//                     textAlign: pw.TextAlign.left,
//                     style: pw.TextStyle(
//                       fontWeight: pw.FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             pw.SizedBox(height: 6),
//             pw.Row(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Expanded(
//                   flex: 1,
//                   child: pw.Align(
//                     alignment: pw.Alignment.topLeft,
//                     child: pw.Text(
//                       "2.Condition	 ",
//                       textAlign: pw.TextAlign.left,
//                       style: pw.TextStyle(
//                         // color: pw.Colors.blue,
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//                 pw.Expanded(
//                     flex: 1,
//                     child: pw.Row(
//                       children: [
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (interiorData[0]['CONDITION_G'] == null ||
//                                     interiorData[0]['CONDITION_G'].toString() ==
//                                         '' ||
//                                     interiorData[0]['CONDITION_G'].toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "G",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         pw.SizedBox(width: 4),
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (interiorData[0]['CONDITION_F'] == null ||
//                                     interiorData[0]['CONDITION_F'].toString() ==
//                                         '' ||
//                                     interiorData[0]['CONDITION_F'].toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "F",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         pw.SizedBox(width: 4),
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (interiorData[0]['CONDITION_P'] == null ||
//                                     interiorData[0]['CONDITION_P'].toString() ==
//                                         '' ||
//                                     interiorData[0]['CONDITION_P'].toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "P",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     )),
//                 pw.Expanded(
//                   flex: 3,
//                   child: pw.Text(
//                     (interiorData[0]['CONDITION_COMMENTS'] == null ||
//                             interiorData[0]['CONDITION_COMMENTS'].toString() ==
//                                 '')
//                         ? "N/A"
//                         : interiorData[0]['CONDITION_COMMENTS'].toString(),
//                     textAlign: pw.TextAlign.left,
//                     style: pw.TextStyle(
//                       fontWeight: pw.FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             pw.SizedBox(height: 6),
//             pw.Divider(height: 1),
//             pw.Align(
//                 alignment: pw.Alignment.centerLeft,
//                 child: pw.Text(
//                   'Washer & Dryer',
//                   style: pw.TextStyle(
//                     fontWeight: pw.FontWeight.bold,
//                     fontSize: 18,
//                     // decoration: pw.TextDecoration.underline,
//                   ),
//                 )),
//             pw.Divider(height: 1),
//             pw.SizedBox(height: 6),
//             pw.Row(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Expanded(
//                   flex: 1,
//                   child: pw.Align(
//                     alignment: pw.Alignment.topLeft,
//                     child: pw.Text(
//                       "1.Condition ",
//                       textAlign: pw.TextAlign.left,
//                       style: pw.TextStyle(
//                         // color: pw.Colors.blue,
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//                 pw.Expanded(
//                     flex: 1,
//                     child: pw.Row(
//                       children: [
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (interiorData[0]['CONDITION_WASHER_G'] == null ||
//                                     interiorData[0]['CONDITION_WASHER_G']
//                                             .toString() ==
//                                         '' ||
//                                     interiorData[0]['CONDITION_WASHER_G']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "G",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         pw.SizedBox(width: 4),
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (interiorData[0]['CONDITION_WASHER_F'] == null ||
//                                     interiorData[0]['CONDITION_WASHER_F']
//                                             .toString() ==
//                                         '' ||
//                                     interiorData[0]['CONDITION_WASHER_F']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "F",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         pw.SizedBox(width: 4),
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (interiorData[0]['CONDITION_WASHER_P'] == null ||
//                                     interiorData[0]['CONDITION_WASHER_P']
//                                             .toString() ==
//                                         '' ||
//                                     interiorData[0]['CONDITION_WASHER_P']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "P",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     )),
//                 pw.Expanded(
//                   flex: 3,
//                   child: pw.Text(
//                     (interiorData[0]['CONDITION_WASHER_COMMENTS'] == null ||
//                             interiorData[0]['CONDITION_WASHER_COMMENTS']
//                                     .toString() ==
//                                 '')
//                         ? "N/A"
//                         : interiorData[0]['CONDITION_WASHER_COMMENTS']
//                             .toString(),
//                     textAlign: pw.TextAlign.left,
//                     style: pw.TextStyle(
//                       fontWeight: pw.FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             pw.SizedBox(height: 6),
//             pw.Align(
//                 alignment: pw.Alignment.centerLeft,
//                 child: pw.Text(
//                   'Exterior Of Home',
//                   style: pw.TextStyle(
//                     fontWeight: pw.FontWeight.bold,
//                     fontSize: 18,
//                     decoration: pw.TextDecoration.underline,
//                   ),
//                 )),
//             pw.Divider(height: 1),
//             pw.Align(
//                 alignment: pw.Alignment.centerLeft,
//                 child: pw.Text(
//                   'Windows',
//                   style: pw.TextStyle(
//                     fontWeight: pw.FontWeight.bold,
//                     fontSize: 18,
//                     // decoration: pw.TextDecoration.underline,
//                   ),
//                 )),
//             pw.Divider(height: 1),
//             pw.SizedBox(height: 6),
//             pw.Row(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Expanded(
//                   flex: 1,
//                   child: pw.Align(
//                     alignment: pw.Alignment.topLeft,
//                     child: pw.Text(
//                       "1.S/P SIP/Storm D/P ",
//                       textAlign: pw.TextAlign.left,
//                       style: pw.TextStyle(
//                         // color: pw.Colors.blue,
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//                 pw.Expanded(
//                   flex: 2,
//                   child: pw.Text(
//                     (interiorData[0]['SP_STORM_D'] == null ||
//                             interiorData[0]['SP_STORM_D'].toString() == '')
//                         ? "N/A"
//                         : interiorData[0]['SP_STORM_D'].toString(),
//                     textAlign: pw.TextAlign.left,
//                     style: pw.TextStyle(
//                       fontWeight: pw.FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             pw.SizedBox(height: 6),
//             pw.Row(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Expanded(
//                   flex: 1,
//                   child: pw.Align(
//                     alignment: pw.Alignment.topLeft,
//                     child: pw.Text(
//                       "2.Caulking ",
//                       textAlign: pw.TextAlign.left,
//                       style: pw.TextStyle(
//                         // color: pw.Colors.blue,
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//                 pw.Expanded(
//                     flex: 1,
//                     child: pw.Row(
//                       children: [
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (exteriorData[0]['CAULKING_G'] == null ||
//                                     exteriorData[0]['CAULKING_G'].toString() ==
//                                         '' ||
//                                     exteriorData[0]['CAULKING_G'].toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "G",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         pw.SizedBox(width: 4),
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (exteriorData[0]['CAULKING_F'] == null ||
//                                     exteriorData[0]['CAULKING_F'].toString() ==
//                                         '' ||
//                                     exteriorData[0]['CAULKING_F'].toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "F",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         pw.SizedBox(width: 4),
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (exteriorData[0]['CAULKING_P'] == null ||
//                                     exteriorData[0]['CAULKING_P'].toString() ==
//                                         '' ||
//                                     exteriorData[0]['CAULKING_P'].toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "P",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     )),
//                 pw.Expanded(
//                   flex: 3,
//                   child: pw.Text(
//                     (interiorData[0]['CAULKING_COMMENTS'] == null ||
//                             interiorData[0]['CAULKING_COMMENTS'].toString() ==
//                                 '')
//                         ? "N/A"
//                         : interiorData[0]['CAULKING_COMMENTS'].toString(),
//                     textAlign: pw.TextAlign.left,
//                     style: pw.TextStyle(
//                       fontWeight: pw.FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             pw.SizedBox(height: 6),
//             pw.Row(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Expanded(
//                   flex: 1,
//                   child: pw.Align(
//                     alignment: pw.Alignment.topLeft,
//                     child: pw.Text(
//                       "3.Shading ",
//                       textAlign: pw.TextAlign.left,
//                       style: pw.TextStyle(
//                         // color: pw.Colors.blue,
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//                 pw.Expanded(
//                     flex: 1,
//                     child: pw.Row(
//                       children: [
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (exteriorData[0]['SHADING_G'] == null ||
//                                     exteriorData[0]['SHADING_G'].toString() ==
//                                         '' ||
//                                     exteriorData[0]['SHADING_G'].toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "G",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         pw.SizedBox(width: 4),
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (exteriorData[0]['SHADING_F'] == null ||
//                                     exteriorData[0]['SHADING_F'].toString() ==
//                                         '' ||
//                                     exteriorData[0]['SHADING_F'].toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "F",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         pw.SizedBox(width: 4),
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (exteriorData[0]['SHADING_P'] == null ||
//                                     exteriorData[0]['SHADING_P'].toString() ==
//                                         '' ||
//                                     exteriorData[0]['SHADING_P'].toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "P",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     )),
//                 pw.Expanded(
//                   flex: 3,
//                   child: pw.Text(
//                     (interiorData[0]['SHADING_COMMENTS'] == null ||
//                             interiorData[0]['SHADING_COMMENTS'].toString() ==
//                                 '')
//                         ? "N/A"
//                         : interiorData[0]['SHADING_COMMENTS'].toString(),
//                     textAlign: pw.TextAlign.left,
//                     style: pw.TextStyle(
//                       fontWeight: pw.FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             pw.SizedBox(height: 6),
//             pw.Divider(height: 1),
//             pw.Align(
//                 alignment: pw.Alignment.centerLeft,
//                 child: pw.Text(
//                   'Doors',
//                   style: pw.TextStyle(
//                     fontWeight: pw.FontWeight.bold,
//                     fontSize: 18,
//                     // decoration: pw.TextDecoration.underline,
//                   ),
//                 )),
//             pw.Divider(height: 1),
//             pw.SizedBox(height: 6),
//             pw.Row(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Expanded(
//                   flex: 1,
//                   child: pw.Align(
//                     alignment: pw.Alignment.topLeft,
//                     child: pw.Text(
//                       "1.Weather Stripping ",
//                       textAlign: pw.TextAlign.left,
//                       style: pw.TextStyle(
//                         // color: pw.Colors.blue,
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//                 pw.Expanded(
//                     flex: 1,
//                     child: pw.Row(
//                       children: [
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (exteriorData[0]['WEATHER_STRIPPING_G'] == null ||
//                                     exteriorData[0]['WEATHER_STRIPPING_G']
//                                             .toString() ==
//                                         '' ||
//                                     exteriorData[0]['WEATHER_STRIPPING_G']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "G",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         pw.SizedBox(width: 4),
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (exteriorData[0]['WEATHER_STRIPPING_F'] == null ||
//                                     exteriorData[0]['WEATHER_STRIPPING_F']
//                                             .toString() ==
//                                         '' ||
//                                     exteriorData[0]['WEATHER_STRIPPING_F']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "F",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         pw.SizedBox(width: 4),
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (exteriorData[0]['WEATHER_STRIPPING_P'] == null ||
//                                     exteriorData[0]['WEATHER_STRIPPING_P']
//                                             .toString() ==
//                                         '' ||
//                                     exteriorData[0]['WEATHER_STRIPPING_P']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "P",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     )),
//                 pw.Expanded(
//                   flex: 3,
//                   child: pw.Text(
//                     (interiorData[0]['WEATHER_STRIPPING_COMMENTS'] == null ||
//                             interiorData[0]['WEATHER_STRIPPING_COMMENTS']
//                                     .toString() ==
//                                 '')
//                         ? "N/A"
//                         : interiorData[0]['WEATHER_STRIPPING_COMMENTS']
//                             .toString(),
//                     textAlign: pw.TextAlign.left,
//                     style: pw.TextStyle(
//                       fontWeight: pw.FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             pw.SizedBox(height: 6),
//             pw.Row(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Expanded(
//                   flex: 1,
//                   child: pw.Align(
//                     alignment: pw.Alignment.topLeft,
//                     child: pw.Text(
//                       "2.Tight Closing ",
//                       textAlign: pw.TextAlign.left,
//                       style: pw.TextStyle(
//                         // color: pw.Colors.blue,
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//                 pw.Expanded(
//                     flex: 1,
//                     child: pw.Row(
//                       children: [
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (exteriorData[0]['TIGHT_CLOSING_Y'] == null ||
//                                     exteriorData[0]['TIGHT_CLOSING_Y']
//                                             .toString() ==
//                                         '' ||
//                                     exteriorData[0]['TIGHT_CLOSING_Y']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "Yes",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         pw.SizedBox(width: 4),
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (exteriorData[0]['TIGHT_CLOSING_N'] == null ||
//                                     exteriorData[0]['TIGHT_CLOSING_N']
//                                             .toString() ==
//                                         '' ||
//                                     exteriorData[0]['TIGHT_CLOSING_N']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "No",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     )),
//                 pw.Expanded(
//                   flex: 3,
//                   child: pw.Text(
//                     (interiorData[0]['TIGHT_CLOSING_COMMENTS'] == null ||
//                             interiorData[0]['TIGHT_CLOSING_COMMENTS']
//                                     .toString() ==
//                                 '')
//                         ? "N/A"
//                         : interiorData[0]['TIGHT_CLOSING_COMMENTS'].toString(),
//                     textAlign: pw.TextAlign.left,
//                     style: pw.TextStyle(
//                       fontWeight: pw.FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             pw.SizedBox(height: 6),
//             pw.Row(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Expanded(
//                   flex: 1,
//                   child: pw.Align(
//                     alignment: pw.Alignment.topLeft,
//                     child: pw.Text(
//                       "3.Storm Door ",
//                       textAlign: pw.TextAlign.left,
//                       style: pw.TextStyle(
//                         // color: pw.Colors.blue,
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//                 pw.Expanded(
//                     flex: 1,
//                     child: pw.Row(
//                       children: [
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (exteriorData[0]['STORM_DOOR_G'] == null ||
//                                     exteriorData[0]['STORM_DOOR_G']
//                                             .toString() ==
//                                         '' ||
//                                     exteriorData[0]['STORM_DOOR_G']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "G",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         pw.SizedBox(width: 4),
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (exteriorData[0]['STORM_DOOR_F'] == null ||
//                                     exteriorData[0]['STORM_DOOR_F']
//                                             .toString() ==
//                                         '' ||
//                                     exteriorData[0]['STORM_DOOR_F']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "F",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         pw.SizedBox(width: 4),
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (exteriorData[0]['STORM_DOOR_P'] == null ||
//                                     exteriorData[0]['STORM_DOOR_P']
//                                             .toString() ==
//                                         '' ||
//                                     exteriorData[0]['STORM_DOOR_P']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "P",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     )),
//                 pw.Expanded(
//                   flex: 3,
//                   child: pw.Text(
//                     (interiorData[0]['STORM_DOOR_COMMENTS'] == null ||
//                             interiorData[0]['STORM_DOOR_COMMENTS'].toString() ==
//                                 '')
//                         ? "N/A"
//                         : interiorData[0]['STORM_DOOR_COMMENTS'].toString(),
//                     textAlign: pw.TextAlign.left,
//                     style: pw.TextStyle(
//                       fontWeight: pw.FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             pw.SizedBox(height: 6),
//             pw.Divider(height: 1),
//             pw.Align(
//                 alignment: pw.Alignment.centerLeft,
//                 child: pw.Text(
//                   'Siding',
//                   style: pw.TextStyle(
//                     fontWeight: pw.FontWeight.bold,
//                     fontSize: 18,
//                     // decoration: pw.TextDecoration.underline,
//                   ),
//                 )),
//             pw.Divider(height: 1),
//             pw.SizedBox(height: 6),
//             pw.Row(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Expanded(
//                   flex: 1,
//                   child: pw.Align(
//                     alignment: pw.Alignment.topLeft,
//                     child: pw.Text(
//                       "1.Weather tight ",
//                       textAlign: pw.TextAlign.left,
//                       style: pw.TextStyle(
//                         // color: pw.Colors.blue,
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//                 pw.Expanded(
//                     flex: 1,
//                     child: pw.Row(
//                       children: [
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (exteriorData[0]['WEATHER_TIGHT_G'] == null ||
//                                     exteriorData[0]['WEATHER_TIGHT_G']
//                                             .toString() ==
//                                         '' ||
//                                     exteriorData[0]['WEATHER_TIGHT_G']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "G",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         pw.SizedBox(width: 4),
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (exteriorData[0]['WEATHER_TIGHT_F'] == null ||
//                                     exteriorData[0]['WEATHER_TIGHT_F']
//                                             .toString() ==
//                                         '' ||
//                                     exteriorData[0]['WEATHER_TIGHT_F']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "F",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         pw.SizedBox(width: 4),
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (exteriorData[0]['WEATHER_TIGHT_P'] == null ||
//                                     exteriorData[0]['WEATHER_TIGHT_P']
//                                             .toString() ==
//                                         '' ||
//                                     exteriorData[0]['WEATHER_TIGHT_P']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "P",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     )),
//                 pw.Expanded(
//                   flex: 3,
//                   child: pw.Text(
//                     (interiorData[0]['WEATHER_TIGHT_COMMENTS'] == null ||
//                             interiorData[0]['WEATHER_TIGHT_COMMENTS']
//                                     .toString() ==
//                                 '')
//                         ? "N/A"
//                         : interiorData[0]['WEATHER_TIGHT_COMMENTS'].toString(),
//                     textAlign: pw.TextAlign.left,
//                     style: pw.TextStyle(
//                       fontWeight: pw.FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             pw.SizedBox(height: 6),
//             pw.Row(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Expanded(
//                   flex: 1,
//                   child: pw.Align(
//                     alignment: pw.Alignment.topLeft,
//                     child: pw.Text(
//                       "2.Condition ",
//                       textAlign: pw.TextAlign.left,
//                       style: pw.TextStyle(
//                         // color: pw.Colors.blue,
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//                 pw.Expanded(
//                     flex: 1,
//                     child: pw.Row(
//                       children: [
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (exteriorData[0]['CONDITION_G'] == null ||
//                                     exteriorData[0]['CONDITION_G'].toString() ==
//                                         '' ||
//                                     exteriorData[0]['CONDITION_G'].toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "G",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         pw.SizedBox(width: 4),
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (exteriorData[0]['CONDITION_F'] == null ||
//                                     exteriorData[0]['CONDITION_F'].toString() ==
//                                         '' ||
//                                     exteriorData[0]['CONDITION_F'].toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "F",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         pw.SizedBox(width: 4),
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (exteriorData[0]['CONDITION_P'] == null ||
//                                     exteriorData[0]['CONDITION_P'].toString() ==
//                                         '' ||
//                                     exteriorData[0]['CONDITION_P'].toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "P",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     )),
//                 pw.Expanded(
//                   flex: 3,
//                   child: pw.Text(
//                     (interiorData[0]['CONDITION_CONDITION'] == null ||
//                             interiorData[0]['CONDITION_CONDITION'].toString() ==
//                                 '')
//                         ? "N/A"
//                         : interiorData[0]['CONDITION_CONDITION'].toString(),
//                     textAlign: pw.TextAlign.left,
//                     style: pw.TextStyle(
//                       fontWeight: pw.FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             pw.SizedBox(height: 6),
//             pw.Divider(height: 1),
//             pw.Align(
//                 alignment: pw.Alignment.centerLeft,
//                 child: pw.Text(
//                   'Roof Ventilation',
//                   style: pw.TextStyle(
//                     fontWeight: pw.FontWeight.bold,
//                     fontSize: 18,
//                     // decoration: pw.TextDecoration.underline,
//                   ),
//                 )),
//             pw.Divider(height: 1),
//             pw.SizedBox(height: 6),
//             pw.Row(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.SizedBox(width: 4),
//                 pw.Image(
//                     alignment: pw.Alignment.center,
//                     (exteriorData[0]['GABLE'] == null ||
//                             exteriorData[0]['GABLE'].toString() == '' ||
//                             exteriorData[0]['GABLE'].toString() == 'False')
//                         ? blankCheckBoxImage
//                         : checkBoxImage,
//                     fit: pw.BoxFit.contain,
//                     width: 18,
//                     height: 18),
//                 pw.SizedBox(width: 4),
//                 pw.Expanded(
//                   flex: 1,
//                   child: pw.Align(
//                     alignment: pw.Alignment.topLeft,
//                     child: pw.Text(
//                       "Gable ",
//                       textAlign: pw.TextAlign.left,
//                       style: pw.TextStyle(
//                         // color: pw.Colors.blue,
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//                 pw.Expanded(
//                   flex: 3,
//                   child: pw.Text(
//                     (interiorData[0]['GABLE_VALUE'] == null ||
//                             interiorData[0]['GABLE_VALUE'].toString() == '')
//                         ? "N/A"
//                         : interiorData[0]['GABLE_VALUE'].toString(),
//                     textAlign: pw.TextAlign.left,
//                     style: pw.TextStyle(
//                       fontWeight: pw.FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             pw.SizedBox(height: 6),
//             pw.Row(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.SizedBox(width: 4),
//                 pw.Image(
//                     alignment: pw.Alignment.center,
//                     (exteriorData[0]['TURBINE'] == null ||
//                             exteriorData[0]['TURBINE'].toString() == '' ||
//                             exteriorData[0]['TURBINE'].toString() == 'False')
//                         ? blankCheckBoxImage
//                         : checkBoxImage,
//                     fit: pw.BoxFit.contain,
//                     width: 18,
//                     height: 18),
//                 pw.SizedBox(width: 4),
//                 pw.Expanded(
//                   flex: 1,
//                   child: pw.Align(
//                     alignment: pw.Alignment.topLeft,
//                     child: pw.Text(
//                       "Turbine ",
//                       textAlign: pw.TextAlign.left,
//                       style: pw.TextStyle(
//                         // color: pw.Colors.blue,
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//                 pw.Expanded(
//                   flex: 3,
//                   child: pw.Text(
//                     (interiorData[0]['TURBINE_VALUE'] == null ||
//                             interiorData[0]['TURBINE_VALUE'].toString() == '')
//                         ? "N/A"
//                         : interiorData[0]['TURBINE_VALUE'].toString(),
//                     textAlign: pw.TextAlign.left,
//                     style: pw.TextStyle(
//                       fontWeight: pw.FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             pw.SizedBox(height: 6),
//             pw.Row(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.SizedBox(width: 4),
//                 pw.Image(
//                     alignment: pw.Alignment.center,
//                     (exteriorData[0]['RIDGE'] == null ||
//                             exteriorData[0]['RIDGE'].toString() == '' ||
//                             exteriorData[0]['RIDGE'].toString() == 'False')
//                         ? blankCheckBoxImage
//                         : checkBoxImage,
//                     fit: pw.BoxFit.contain,
//                     width: 18,
//                     height: 18),
//                 pw.SizedBox(width: 4),
//                 pw.Expanded(
//                   flex: 1,
//                   child: pw.Align(
//                     alignment: pw.Alignment.topLeft,
//                     child: pw.Text(
//                       "Ridge ",
//                       textAlign: pw.TextAlign.left,
//                       style: pw.TextStyle(
//                         // color: pw.Colors.blue,
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//                 pw.Expanded(
//                   flex: 3,
//                   child: pw.Text(
//                     (interiorData[0]['RIDGE_VALUE'] == null ||
//                             interiorData[0]['RIDGE_VALUE'].toString() == '')
//                         ? "N/A"
//                         : interiorData[0]['RIDGE_VALUE'].toString(),
//                     textAlign: pw.TextAlign.left,
//                     style: pw.TextStyle(
//                       fontWeight: pw.FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             pw.SizedBox(height: 6),
//             pw.Row(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.SizedBox(width: 4),
//                 pw.Image(
//                     alignment: pw.Alignment.center,
//                     (exteriorData[0]['PWR'] == null ||
//                             exteriorData[0]['PWR'].toString() == '' ||
//                             exteriorData[0]['PWR'].toString() == 'False')
//                         ? blankCheckBoxImage
//                         : checkBoxImage,
//                     fit: pw.BoxFit.contain,
//                     width: 18,
//                     height: 18),
//                 pw.SizedBox(width: 4),
//                 pw.Expanded(
//                   flex: 1,
//                   child: pw.Align(
//                     alignment: pw.Alignment.topLeft,
//                     child: pw.Text(
//                       "PWR ",
//                       textAlign: pw.TextAlign.left,
//                       style: pw.TextStyle(
//                         // color: pw.Colors.blue,
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//                 pw.Expanded(
//                   flex: 3,
//                   child: pw.Text(
//                     (interiorData[0]['PWR_VALUE'] == null ||
//                             interiorData[0]['PWR_VALUE'].toString() == '')
//                         ? "N/A"
//                         : interiorData[0]['PWR_VALUE'].toString(),
//                     textAlign: pw.TextAlign.left,
//                     style: pw.TextStyle(
//                       fontWeight: pw.FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             pw.SizedBox(height: 6),
//             pw.Row(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Expanded(
//                   flex: 1,
//                   child: pw.Align(
//                     alignment: pw.Alignment.topLeft,
//                     child: pw.Text(
//                       "Comment ",
//                       textAlign: pw.TextAlign.left,
//                       style: pw.TextStyle(
//                         // color: pw.Colors.blue,
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//                 pw.Expanded(
//                   flex: 3,
//                   child: pw.Text(
//                     (interiorData[0]['GABLE_TURBINE_RIDGE_PWR_COMMENTS'] ==
//                                 null ||
//                             interiorData[0]['GABLE_TURBINE_RIDGE_PWR_COMMENTS']
//                                     .toString() ==
//                                 '')
//                         ? "N/A"
//                         : interiorData[0]['GABLE_TURBINE_RIDGE_PWR_COMMENTS']
//                             .toString(),
//                     textAlign: pw.TextAlign.left,
//                     style: pw.TextStyle(
//                       fontWeight: pw.FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             pw.SizedBox(height: 6),
//             pw.Row(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Expanded(
//                   flex: 1,
//                   child: pw.Align(
//                     alignment: pw.Alignment.topLeft,
//                     child: pw.Text(
//                       "2.Soffit clear ",
//                       textAlign: pw.TextAlign.left,
//                       style: pw.TextStyle(
//                         // color: pw.Colors.blue,
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//                 pw.Expanded(
//                     flex: 1,
//                     child: pw.Row(
//                       children: [
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (exteriorData[0]['SOFFIT_CLEAR_G'] == null ||
//                                     exteriorData[0]['SOFFIT_CLEAR_G']
//                                             .toString() ==
//                                         '' ||
//                                     exteriorData[0]['SOFFIT_CLEAR_G']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "G",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         pw.SizedBox(width: 4),
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (exteriorData[0]['SOFFIT_CLEAR_F'] == null ||
//                                     exteriorData[0]['SOFFIT_CLEAR_F']
//                                             .toString() ==
//                                         '' ||
//                                     exteriorData[0]['SOFFIT_CLEAR_F']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "F",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         pw.SizedBox(width: 4),
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (exteriorData[0]['SOFFIT_CLEAR_P'] == null ||
//                                     exteriorData[0]['SOFFIT_CLEAR_P']
//                                             .toString() ==
//                                         '' ||
//                                     exteriorData[0]['SOFFIT_CLEAR_P']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "P",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     )),
//                 pw.Expanded(
//                   flex: 3,
//                   child: pw.Text(
//                     (interiorData[0]['SOFFIT_CLEAR_COMMENTS'] == null ||
//                             interiorData[0]['SOFFIT_CLEAR_COMMENTS']
//                                     .toString() ==
//                                 '')
//                         ? "N/A"
//                         : interiorData[0]['SOFFIT_CLEAR_COMMENTS'].toString(),
//                     textAlign: pw.TextAlign.left,
//                     style: pw.TextStyle(
//                       fontWeight: pw.FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             pw.SizedBox(height: 6),
//             pw.Divider(height: 1),
//             pw.Align(
//                 alignment: pw.Alignment.centerLeft,
//                 child: pw.Text(
//                   'Crawl Space',
//                   style: pw.TextStyle(
//                     fontWeight: pw.FontWeight.bold,
//                     fontSize: 18,
//                     // decoration: pw.TextDecoration.underline,
//                   ),
//                 )),
//             pw.Divider(height: 1),
//             pw.SizedBox(height: 6),
//             pw.Row(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Expanded(
//                   flex: 1,
//                   child: pw.Align(
//                     alignment: pw.Alignment.topLeft,
//                     child: pw.Text(
//                       "1.Soil Condition ",
//                       textAlign: pw.TextAlign.left,
//                       style: pw.TextStyle(
//                         // color: pw.Colors.blue,
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//                 pw.Expanded(
//                     flex: 1,
//                     child: pw.Row(
//                       children: [
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (exteriorData[0]['SOIL_CONDITION_G'] == null ||
//                                     exteriorData[0]['SOIL_CONDITION_G']
//                                             .toString() ==
//                                         '' ||
//                                     exteriorData[0]['SOIL_CONDITION_G']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "G",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         pw.SizedBox(width: 4),
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (exteriorData[0]['SOIL_CONDITION_F'] == null ||
//                                     exteriorData[0]['SOIL_CONDITION_F']
//                                             .toString() ==
//                                         '' ||
//                                     exteriorData[0]['SOIL_CONDITION_F']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "F",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         pw.SizedBox(width: 4),
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (exteriorData[0]['SOIL_CONDITION_P'] == null ||
//                                     exteriorData[0]['SOIL_CONDITION_P']
//                                             .toString() ==
//                                         '' ||
//                                     exteriorData[0]['SOIL_CONDITION_P']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "P",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     )),
//                 pw.Expanded(
//                   flex: 3,
//                   child: pw.Text(
//                     (interiorData[0]['SOIL_CONDITION_CONDITION'] == null ||
//                             interiorData[0]['SOIL_CONDITION_CONDITION']
//                                     .toString() ==
//                                 '')
//                         ? "N/A"
//                         : interiorData[0]['SOIL_CONDITION_CONDITION']
//                             .toString(),
//                     textAlign: pw.TextAlign.left,
//                     style: pw.TextStyle(
//                       fontWeight: pw.FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             pw.SizedBox(height: 6),
//             pw.Row(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Expanded(
//                   flex: 1,
//                   child: pw.Align(
//                     alignment: pw.Alignment.topLeft,
//                     child: pw.Text(
//                       "2.Ventilation ",
//                       textAlign: pw.TextAlign.left,
//                       style: pw.TextStyle(
//                         // color: pw.Colors.blue,
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//                 pw.Expanded(
//                     flex: 1,
//                     child: pw.Row(
//                       children: [
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (exteriorData[0]['VENTILATION_G'] == null ||
//                                     exteriorData[0]['VENTILATION_G']
//                                             .toString() ==
//                                         '' ||
//                                     exteriorData[0]['VENTILATION_G']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "G",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         pw.SizedBox(width: 4),
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (exteriorData[0]['VENTILATION_F'] == null ||
//                                     exteriorData[0]['VENTILATION_F']
//                                             .toString() ==
//                                         '' ||
//                                     exteriorData[0]['VENTILATION_F']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "F",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         pw.SizedBox(width: 4),
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (exteriorData[0]['VENTILATION_P'] == null ||
//                                     exteriorData[0]['VENTILATION_P']
//                                             .toString() ==
//                                         '' ||
//                                     exteriorData[0]['VENTILATION_P']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "P",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     )),
//                 pw.Expanded(
//                   flex: 3,
//                   child: pw.Text(
//                     (interiorData[0]['VENTILATION_COMMENTS'] == null ||
//                             interiorData[0]['VENTILATION_COMMENTS']
//                                     .toString() ==
//                                 '')
//                         ? "N/A"
//                         : interiorData[0]['VENTILATION_COMMENTS'].toString(),
//                     textAlign: pw.TextAlign.left,
//                     style: pw.TextStyle(
//                       fontWeight: pw.FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             pw.SizedBox(height: 6),
//             pw.Row(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Expanded(
//                   flex: 1,
//                   child: pw.Align(
//                     alignment: pw.Alignment.topLeft,
//                     child: pw.Text(
//                       "3.Insulation ",
//                       textAlign: pw.TextAlign.left,
//                       style: pw.TextStyle(
//                         // color: pw.Colors.blue,
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//                 pw.Expanded(
//                     flex: 1,
//                     child: pw.Row(
//                       children: [
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (exteriorData[0]['INSULATION_R'] == null ||
//                                     exteriorData[0]['INSULATION_R']
//                                             .toString() ==
//                                         '' ||
//                                     exteriorData[0]['INSULATION_R']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "R",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           (interiorData[0]['INSULATION_R_VALUE'] == null ||
//                                   interiorData[0]['INSULATION_R_VALUE']
//                                           .toString() ==
//                                       '')
//                               ? "N/A"
//                               : interiorData[0]['INSULATION_R_VALUE']
//                                   .toString(),
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     )),
//                 pw.Expanded(
//                   flex: 3,
//                   child: pw.Text(
//                     (interiorData[0]['INSULATION_COMMENTS'] == null ||
//                             interiorData[0]['INSULATION_COMMENTS'].toString() ==
//                                 '')
//                         ? "N/A"
//                         : interiorData[0]['INSULATION_COMMENTS'].toString(),
//                     textAlign: pw.TextAlign.left,
//                     style: pw.TextStyle(
//                       fontWeight: pw.FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             pw.SizedBox(height: 6),
//             pw.Row(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Expanded(
//                   flex: 1,
//                   child: pw.Align(
//                     alignment: pw.Alignment.topLeft,
//                     child: pw.Text(
//                       "4.Insulation Condition ",
//                       textAlign: pw.TextAlign.left,
//                       style: pw.TextStyle(
//                         // color: pw.Colors.blue,
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//                 pw.Expanded(
//                     flex: 1,
//                     child: pw.Row(
//                       children: [
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (exteriorData[0]['INSULATION_CONDITION_G'] ==
//                                         null ||
//                                     exteriorData[0]['INSULATION_CONDITION_G']
//                                             .toString() ==
//                                         '' ||
//                                     exteriorData[0]['INSULATION_CONDITION_G']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "G",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         pw.SizedBox(width: 4),
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (exteriorData[0]['INSULATION_CONDITION_F'] ==
//                                         null ||
//                                     exteriorData[0]['INSULATION_CONDITION_F']
//                                             .toString() ==
//                                         '' ||
//                                     exteriorData[0]['INSULATION_CONDITION_F']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "F",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         pw.SizedBox(width: 4),
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (exteriorData[0]['INSULATION_CONDITION_P'] ==
//                                         null ||
//                                     exteriorData[0]['INSULATION_CONDITION_P']
//                                             .toString() ==
//                                         '' ||
//                                     exteriorData[0]['INSULATION_CONDITION_P']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "P",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     )),
//                 pw.Expanded(
//                   flex: 3,
//                   child: pw.Text(
//                     (interiorData[0]['INSULATION_CONDITION_COMMENTS'] == null ||
//                             interiorData[0]['INSULATION_CONDITION_COMMENTS']
//                                     .toString() ==
//                                 '')
//                         ? "N/A"
//                         : interiorData[0]['INSULATION_CONDITION_COMMENTS']
//                             .toString(),
//                     textAlign: pw.TextAlign.left,
//                     style: pw.TextStyle(
//                       fontWeight: pw.FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             pw.SizedBox(height: 6),
//             pw.Row(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Expanded(
//                   flex: 1,
//                   child: pw.Align(
//                     alignment: pw.Alignment.topLeft,
//                     child: pw.Text(
//                       "5.Duct Insulation ",
//                       textAlign: pw.TextAlign.left,
//                       style: pw.TextStyle(
//                         // color: pw.Colors.blue,
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//                 pw.Expanded(
//                     flex: 1,
//                     child: pw.Row(
//                       children: [
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (exteriorData[0]['DUCT_INSULATION_G'] == null ||
//                                     exteriorData[0]['DUCT_INSULATION_G']
//                                             .toString() ==
//                                         '' ||
//                                     exteriorData[0]['DUCT_INSULATION_G']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "G",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         pw.SizedBox(width: 4),
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (exteriorData[0]['DUCT_INSULATION_F'] == null ||
//                                     exteriorData[0]['DUCT_INSULATION_F']
//                                             .toString() ==
//                                         '' ||
//                                     exteriorData[0]['DUCT_INSULATION_F']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "F",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         pw.SizedBox(width: 4),
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (exteriorData[0]['DUCT_INSULATION_P'] == null ||
//                                     exteriorData[0]['DUCT_INSULATION_P']
//                                             .toString() ==
//                                         '' ||
//                                     exteriorData[0]['DUCT_INSULATION_P']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "P",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     )),
//                 pw.Expanded(
//                   flex: 3,
//                   child: pw.Text(
//                     (interiorData[0]['DUCT_INSULATION_COMMENTS'] == null ||
//                             interiorData[0]['DUCT_INSULATION_COMMENTS']
//                                     .toString() ==
//                                 '')
//                         ? "N/A"
//                         : interiorData[0]['DUCT_INSULATION_COMMENTS']
//                             .toString(),
//                     textAlign: pw.TextAlign.left,
//                     style: pw.TextStyle(
//                       fontWeight: pw.FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             pw.SizedBox(height: 6),
//             pw.Row(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Expanded(
//                   flex: 1,
//                   child: pw.Align(
//                     alignment: pw.Alignment.topLeft,
//                     child: pw.Text(
//                       "6.Air Handler ",
//                       textAlign: pw.TextAlign.left,
//                       style: pw.TextStyle(
//                         // color: pw.Colors.blue,
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//                 pw.Expanded(
//                     flex: 1,
//                     child: pw.Row(
//                       children: [
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (exteriorData[0]['AIR_HANDLER_G'] == null ||
//                                     exteriorData[0]['AIR_HANDLER_G']
//                                             .toString() ==
//                                         '' ||
//                                     exteriorData[0]['AIR_HANDLER_G']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "G",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         pw.SizedBox(width: 4),
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (exteriorData[0]['AIR_HANDLER_F'] == null ||
//                                     exteriorData[0]['AIR_HANDLER_F']
//                                             .toString() ==
//                                         '' ||
//                                     exteriorData[0]['AIR_HANDLER_F']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "F",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         pw.SizedBox(width: 4),
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (exteriorData[0]['AIR_HANDLER_P'] == null ||
//                                     exteriorData[0]['AIR_HANDLER_P']
//                                             .toString() ==
//                                         '' ||
//                                     exteriorData[0]['AIR_HANDLER_P']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "P",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     )),
//                 pw.Expanded(
//                   flex: 3,
//                   child: pw.Text(
//                     (interiorData[0]['AIR_HANDLER_COMMENTS'] == null ||
//                             interiorData[0]['AIR_HANDLER_COMMENTS']
//                                     .toString() ==
//                                 '')
//                         ? "N/A"
//                         : interiorData[0]['AIR_HANDLER_COMMENTS'].toString(),
//                     textAlign: pw.TextAlign.left,
//                     style: pw.TextStyle(
//                       fontWeight: pw.FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             pw.SizedBox(height: 6),
//             pw.Divider(height: 1),
//             pw.Align(
//                 alignment: pw.Alignment.centerLeft,
//                 child: pw.Text(
//                   'HVAC',
//                   style: pw.TextStyle(
//                     fontWeight: pw.FontWeight.bold,
//                     fontSize: 18,
//                     // decoration: pw.TextDecoration.underline,
//                   ),
//                 )),
//             pw.Divider(height: 1),
//             pw.SizedBox(height: 6),
//             pw.Row(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Expanded(
//                   flex: 1,
//                   child: pw.Align(
//                     alignment: pw.Alignment.topLeft,
//                     child: pw.Text(
//                       "1.Outside unit clear ",
//                       textAlign: pw.TextAlign.left,
//                       style: pw.TextStyle(
//                         // color: pw.Colors.blue,
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//                 pw.Expanded(
//                     flex: 1,
//                     child: pw.Row(
//                       children: [
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (exteriorData[0]['OUTSIDE_UNIT_CLEAR_G'] == null ||
//                                     exteriorData[0]['OUTSIDE_UNIT_CLEAR_G']
//                                             .toString() ==
//                                         '' ||
//                                     exteriorData[0]['OUTSIDE_UNIT_CLEAR_G']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "G",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         pw.SizedBox(width: 4),
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (exteriorData[0]['OUTSIDE_UNIT_CLEAR_F'] == null ||
//                                     exteriorData[0]['OUTSIDE_UNIT_CLEAR_F']
//                                             .toString() ==
//                                         '' ||
//                                     exteriorData[0]['OUTSIDE_UNIT_CLEAR_F']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "F",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         pw.SizedBox(width: 4),
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (exteriorData[0]['OUTSIDE_UNIT_CLEAR_P'] == null ||
//                                     exteriorData[0]['OUTSIDE_UNIT_CLEAR_P']
//                                             .toString() ==
//                                         '' ||
//                                     exteriorData[0]['OUTSIDE_UNIT_CLEAR_P']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "P",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     )),
//                 pw.Expanded(
//                   flex: 3,
//                   child: pw.Text(
//                     (interiorData[0]['OUTSIDE_UNIT_CLEAR_COMMENTS'] == null ||
//                             interiorData[0]['OUTSIDE_UNIT_CLEAR_COMMENTS']
//                                     .toString() ==
//                                 '')
//                         ? "N/A"
//                         : interiorData[0]['OUTSIDE_UNIT_CLEAR_COMMENTS']
//                             .toString(),
//                     textAlign: pw.TextAlign.left,
//                     style: pw.TextStyle(
//                       fontWeight: pw.FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             pw.SizedBox(height: 6),
//             pw.Row(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Expanded(
//                   flex: 1,
//                   child: pw.Align(
//                     alignment: pw.Alignment.topLeft,
//                     child: pw.Text(
//                       "2.Age or Efficiency ",
//                       textAlign: pw.TextAlign.left,
//                       style: pw.TextStyle(
//                         // color: pw.Colors.blue,
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//                 pw.Expanded(
//                   flex: 2,
//                   child: pw.Text(
//                     (interiorData[0]['AGE_OR_EFFICIENCY'] == null ||
//                             interiorData[0]['AGE_OR_EFFICIENCY'].toString() ==
//                                 '')
//                         ? "N/A"
//                         : interiorData[0]['AGE_OR_EFFICIENCY'].toString(),
//                     textAlign: pw.TextAlign.left,
//                     style: pw.TextStyle(
//                       fontWeight: pw.FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             pw.SizedBox(height: 6),
//             pw.Row(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Expanded(
//                   flex: 1,
//                   child: pw.Align(
//                     alignment: pw.Alignment.topLeft,
//                     child: pw.Text(
//                       "3.Air Flow to Unit ",
//                       textAlign: pw.TextAlign.left,
//                       style: pw.TextStyle(
//                         // color: pw.Colors.blue,
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//                 pw.Expanded(
//                     flex: 1,
//                     child: pw.Row(
//                       children: [
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (exteriorData[0]['AIR_FLOW_TO_UNIT_G'] == null ||
//                                     exteriorData[0]['AIR_FLOW_TO_UNIT_G']
//                                             .toString() ==
//                                         '' ||
//                                     exteriorData[0]['AIR_FLOW_TO_UNIT_G']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "G",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         pw.SizedBox(width: 4),
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (exteriorData[0]['AIR_FLOW_TO_UNIT_F'] == null ||
//                                     exteriorData[0]['AIR_FLOW_TO_UNIT_F']
//                                             .toString() ==
//                                         '' ||
//                                     exteriorData[0]['AIR_FLOW_TO_UNIT_F']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "F",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         pw.SizedBox(width: 4),
//                         pw.Image(
//                             alignment: pw.Alignment.center,
//                             (exteriorData[0]['AIR_FLOW_TO_UNIT_P'] == null ||
//                                     exteriorData[0]['AIR_FLOW_TO_UNIT_P']
//                                             .toString() ==
//                                         '' ||
//                                     exteriorData[0]['AIR_FLOW_TO_UNIT_P']
//                                             .toString() ==
//                                         'False')
//                                 ? blankCheckBoxImage
//                                 : checkBoxImage,
//                             fit: pw.BoxFit.contain,
//                             width: 18,
//                             height: 18),
//                         pw.SizedBox(width: 4),
//                         pw.Text(
//                           "P",
//                           textAlign: pw.TextAlign.left,
//                           style: pw.TextStyle(
//                             // color: pw.Colors.blue,
//                             fontWeight: pw.FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     )),
//                 pw.Expanded(
//                   flex: 3,
//                   child: pw.Text(
//                     (interiorData[0]['AIR_FLOW_TO_UNIT_COMMENTS'] == null ||
//                             interiorData[0]['AIR_FLOW_TO_UNIT_COMMENTS']
//                                     .toString() ==
//                                 '')
//                         ? "N/A"
//                         : interiorData[0]['AIR_FLOW_TO_UNIT_COMMENTS']
//                             .toString(),
//                     textAlign: pw.TextAlign.left,
//                     style: pw.TextStyle(
//                       fontWeight: pw.FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             pw.SizedBox(height: 6),
//             pw.Divider(height: 1),
//             pw.Align(
//                 alignment: pw.Alignment.centerLeft,
//                 child: pw.Text(
//                   'Type Of Dwelling',
//                   style: pw.TextStyle(
//                     fontWeight: pw.FontWeight.bold,
//                     fontSize: 18,
//                     // decoration: pw.TextDecoration.underline,
//                   ),
//                 )),
//             pw.Divider(height: 1),
//             pw.SizedBox(height: 6),
//             pw.Row(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.SizedBox(width: 4),
//                 pw.Image(
//                     alignment: pw.Alignment.center,
//                     (exteriorData[0]['HOUSE'] == null ||
//                             exteriorData[0]['HOUSE'].toString() == '' ||
//                             exteriorData[0]['HOUSE'].toString() == 'False')
//                         ? blankCheckBoxImage
//                         : checkBoxImage,
//                     fit: pw.BoxFit.contain,
//                     width: 18,
//                     height: 18),
//                 pw.SizedBox(width: 4),
//                 pw.Expanded(
//                   flex: 1,
//                   child: pw.Align(
//                     alignment: pw.Alignment.topLeft,
//                     child: pw.Text(
//                       "House ",
//                       textAlign: pw.TextAlign.left,
//                       style: pw.TextStyle(
//                         // color: pw.Colors.blue,
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//                 pw.Expanded(
//                   flex: 2,
//                   child: pw.Text(
//                     (interiorData[0]['HOUSE_VALUE'] == null ||
//                             interiorData[0]['HOUSE_VALUE'].toString() == '')
//                         ? "N/A"
//                         : interiorData[0]['HOUSE_VALUE'].toString(),
//                     textAlign: pw.TextAlign.left,
//                     style: pw.TextStyle(
//                       fontWeight: pw.FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             pw.SizedBox(height: 6),
//             pw.Row(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.SizedBox(width: 4),
//                 pw.Image(
//                     alignment: pw.Alignment.center,
//                     (exteriorData[0]['M_H'] == null ||
//                             exteriorData[0]['M_H'].toString() == '' ||
//                             exteriorData[0]['M_H'].toString() == 'False')
//                         ? blankCheckBoxImage
//                         : checkBoxImage,
//                     fit: pw.BoxFit.contain,
//                     width: 18,
//                     height: 18),
//                 pw.SizedBox(width: 4),
//                 pw.Expanded(
//                   flex: 1,
//                   child: pw.Align(
//                     alignment: pw.Alignment.topLeft,
//                     child: pw.Text(
//                       "M/H ",
//                       textAlign: pw.TextAlign.left,
//                       style: pw.TextStyle(
//                         // color: pw.Colors.blue,
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//                 pw.Expanded(
//                   flex: 2,
//                   child: pw.Text(
//                     (interiorData[0]['M_H_VALUE'] == null ||
//                             interiorData[0]['M_H_VALUE'].toString() == '')
//                         ? "N/A"
//                         : interiorData[0]['M_H_VALUE'].toString(),
//                     textAlign: pw.TextAlign.left,
//                     style: pw.TextStyle(
//                       fontWeight: pw.FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             pw.SizedBox(height: 6),
//             pw.Row(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.SizedBox(width: 4),
//                 pw.Image(
//                     alignment: pw.Alignment.center,
//                     (exteriorData[0]['OTHER'] == null ||
//                             exteriorData[0]['OTHER'].toString() == '' ||
//                             exteriorData[0]['OTHER'].toString() == 'False')
//                         ? blankCheckBoxImage
//                         : checkBoxImage,
//                     fit: pw.BoxFit.contain,
//                     width: 18,
//                     height: 18),
//                 pw.SizedBox(width: 4),
//                 pw.Expanded(
//                   flex: 1,
//                   child: pw.Align(
//                     alignment: pw.Alignment.topLeft,
//                     child: pw.Text(
//                       "Other ",
//                       textAlign: pw.TextAlign.left,
//                       style: pw.TextStyle(
//                         // color: pw.Colors.blue,
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//                 pw.Expanded(
//                   flex: 2,
//                   child: pw.Text(
//                     (interiorData[0]['OTHER_VALUE'] == null ||
//                             interiorData[0]['OTHER_VALUE'].toString() == '')
//                         ? "N/A"
//                         : interiorData[0]['OTHER_VALUE'].toString(),
//                     textAlign: pw.TextAlign.left,
//                     style: pw.TextStyle(
//                       fontWeight: pw.FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             pw.SizedBox(height: 6),
//             pw.Row(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Expanded(
//                   flex: 1,
//                   child: pw.Align(
//                     alignment: pw.Alignment.topLeft,
//                     child: pw.Text(
//                       "Comment ",
//                       textAlign: pw.TextAlign.left,
//                       style: pw.TextStyle(
//                         // color: pw.Colors.blue,
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//                 pw.Expanded(
//                   flex: 2,
//                   child: pw.Text(
//                     (interiorData[0]['HOUSE_M_H_OTHER'] == null ||
//                             interiorData[0]['HOUSE_M_H_OTHER'].toString() == '')
//                         ? "N/A"
//                         : interiorData[0]['HOUSE_M_H_OTHER'].toString(),
//                     textAlign: pw.TextAlign.left,
//                     style: pw.TextStyle(
//                       fontWeight: pw.FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             pw.SizedBox(height: 6),
//             pw.Row(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Expanded(
//                   flex: 1,
//                   child: pw.Align(
//                     alignment: pw.Alignment.topLeft,
//                     child: pw.Text(
//                       "2. Square Fig ",
//                       textAlign: pw.TextAlign.left,
//                       style: pw.TextStyle(
//                         // color: pw.Colors.blue,
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//                 pw.Expanded(
//                   flex: 2,
//                   child: pw.Text(
//                     (interiorData[0]['SQUARE_FTG'] == null ||
//                             interiorData[0]['SQUARE_FTG'].toString() == '')
//                         ? "N/A"
//                         : interiorData[0]['SQUARE_FTG'].toString(),
//                     textAlign: pw.TextAlign.left,
//                     style: pw.TextStyle(
//                       fontWeight: pw.FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             pw.SizedBox(height: 6),
//             pw.Row(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Expanded(
//                   flex: 1,
//                   child: pw.Align(
//                     alignment: pw.Alignment.topLeft,
//                     child: pw.Text(
//                       "3.  Number of people ",
//                       textAlign: pw.TextAlign.left,
//                       style: pw.TextStyle(
//                         // color: pw.Colors.blue,
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//                 pw.Expanded(
//                   flex: 1,
//                   child: pw.Align(
//                     alignment: pw.Alignment.topLeft,
//                     child: pw.Text(
//                       (interiorData[0]['NO_OF_PEOPLE'] == null ||
//                               interiorData[0]['NO_OF_PEOPLE'].toString() == '')
//                           ? "N/A"
//                           : interiorData[0]['NO_OF_PEOPLE'].toString(),
//                       textAlign: pw.TextAlign.left,
//                       style: pw.TextStyle(
//                         // color: pw.Colors.blue,
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//                 pw.Expanded(
//                   flex: 3,
//                   child: pw.Text(
//                     (interiorData[0]['NO_OF_PEOPLE_COMMENTS'] == null ||
//                             interiorData[0]['NO_OF_PEOPLE_COMMENTS']
//                                     .toString() ==
//                                 '')
//                         ? "N/A"
//                         : interiorData[0]['NO_OF_PEOPLE_COMMENTS'].toString(),
//                     textAlign: pw.TextAlign.left,
//                     style: pw.TextStyle(
//                       fontWeight: pw.FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//     ],
//   )); //

//   return doc.save();
// }

// Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
//   final path = (await getExternalStorageDirectory())!.path;
//   final file = File('$path/$fileName');
//   await file.writeAsBytes(bytes, flush: true);
//   OpenFile.open('$path/$fileName');
// }

// Future<List<dynamic>> getOnPremisesData() async {
//   SharedPreferences preferences = await SharedPreferences.getInstance();

//   var APIURL = "http://oemapi.ariespro.com/api/onpremise/auditdata";
//   Map mappedData = {"id": preferences.getString('auditID')};
//   http.Response response = await http.post(Uri.parse(APIURL), body: mappedData);

//   var data = jsonDecode(response.body);
//   print(" data: ${data}");

//   var status = "${data['code']}";
//   if (status.contains("SUCCESS")) {
//     var allData = [];
//     var result = data["result"];

//     var auditData = result['Audit Data'] as List;
//     var interiorData = result['Interior Data'] as List;
//     var exteriorData = result['Exterior Data'] as List;
//     var recommendationData = result['Recommendation Data'] as List;

//     allData.add(auditData);
//     allData.add(interiorData);
//     allData.add(exteriorData);
//     allData.add(recommendationData);
//     return allData;
//   } else {
//     var list = [];
//     return list;
//   }
// }

// Future<pw.PageTheme> _myPageTheme(PdfPageFormat format) async {
//   final logoImage = pw.MemoryImage(
//     (await rootBundle.load('assets/design.png')).buffer.asUint8List(),
//   );
//   return pw.PageTheme(
//       margin: const pw.EdgeInsets.symmetric(
//           horizontal: 1 + PdfPageFormat.cm, vertical: 0.5 + PdfPageFormat.cm),
//       textDirection: pw.TextDirection.ltr,
//       orientation: pw.PageOrientation.portrait,
//       buildBackground: (context) => pw.FullPage(
//           ignoreMargins: true,
//           child: pw.Watermark(
//               angle: 20,
//               child: pw.Opacity(
//                   opacity: 0.5,
//                   child: pw.Image(
//                       alignment: pw.Alignment.center,
//                       logoImage,
//                       fit: pw.BoxFit.cover)))));
// }

// Future<void> downloadReport(
//   final BuildContext context,
//   final LayoutCallback build,
//   final PdfPageFormat pageFormate,
// ) async {
//   final bytes = await build(pageFormate);
//   final appDocDir = await getApplicationDocumentsDirectory();
//   final appDocPath = appDocDir.path;
//   final file = File('$appDocPath/onPremiseEnergyAuditReport.pdf');
//   print('download as file ${file.path}...');
//   await file.writeAsBytes(bytes);
//   await OpenFile.open(file.path);
// }

// void showPrintedToast(final BuildContext context) {
//   ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Successfully report downloaded!')));
// }
