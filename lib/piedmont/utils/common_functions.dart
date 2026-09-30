import 'dart:io';

import 'package:CIVM/piedmont/resources/app_colors.dart';
import 'package:CIVM/piedmont/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

String formatDateIfNeeded(String inputDate) {
  final List<String> knownPatterns = [
    "yyyy-MM-dd'T'HH:mm:ss.SSS", // eg., 2026-03-18T02:55:28.823
    "yyyy-MM-dd'T'HH:mm", // e.g., 2025-11-01T10:58
    "yyyy-MM-dd'T'HH:mm:ss", // e.g., 2023-02-14T00:00:00
    //"yyyy-MM-dd'T'HH:mm:ssZ", // e.g., 2025-09-05T00:00:00+00:00
    'yyyy-MM-dd hh:mm:ss a', // e.g., 2022-01-28 07:17:02 AM
    'MM/dd/yyyy hh:mm:ss a', // e.g., 01/28/2026 07:17:02 AM
    'yyyy-MM-dd HH:mm:ss', // e.g., 2022-01-28 13:45:00
    'yyyy-MM-dd', // e.g., 2022-02-15
    'dd-MM-yyyy h:mm a', //  e.g., 11-06-2025 5:53 PM
    'MM-dd-yyyy',
    "yyyy-MM-dd'T'HH:mm:ssXXX", //  handles 2026-02-03T00:00:00+00:00
    'MMM dd yyyy hh:mma', //Apr 10 2026 12:00AM
    'MMM  d yyyy hh:mma', // Apr 2 2026 12:00AM
    'MMM  d yyyy  hh:mma', // Apr  2 2026  12:00AM
    'MM/dd/yyyy h:mm a', //06/01/2025 2:10 AM
    'MM/dd/yyyy hh:mm a', //06/01/2025 02:10 AM
  ];
  for (String pattern in knownPatterns) {
    try {
      DateTime parsedDate = DateFormat(pattern).parseStrict(inputDate);
      return DateFormat('MM/dd/yyyy').format(parsedDate);
    } catch (_) {}
  }
  return inputDate;
}

DateTime _parseDate(String date) {
  // return DateFormat("M/d/yyyy H:mm:ss").parse(date);
  return DateFormat("MM/dd/yyyy h:mm a").parse(date);
}

String getMonth(String date) {
  try {
    DateTime dateTime = _parseDate(date);
    return dateTime.month.toString();
  } catch (e) {
    return '';
  }
}

String getYear(String date) {
  try {
    DateTime dateTime = _parseDate(date);
    return dateTime.year.toString();
  } catch (e) {
    return '';
  }
}

String getMonthInvoice(String date) {
  try {
    DateTime dateTime = DateTime.parse(date);
    return dateTime.month.toString();
  } catch (e) {
    return '';
  }
}

String getYearInvoice(String date) {
  try {
    DateTime dateTime = DateTime.parse(date);
    return dateTime.year.toString();
  } catch (e) {
    return '';
  }
}

//to print whole map data using this method*********
void printWrapped(String text) {
  final pattern = RegExp('.{1,800}'); // split into 800-char chunks
  for (final match in pattern.allMatches(text)) {
    print(match.group(0));
  }
}

//status text color
Color getStatusColorPemc(String? status) {
  final value = status?.toLowerCase().trim() ?? '';

  switch (value) {
    case 'closed':
      return Colors.green;

    case 'pending approval':
      return const Color.fromARGB(255, 241, 133, 125);

    case 'open':
      return Colors.blue;

    case 'assigned':
      return Colors.yellow;

    default:
      return Colors.white;
  }
}

///card background color
Color getCardColorPemc(String? status) {
  switch (status?.toLowerCase().trim()) {
    case 'closed':
      return Colors.green.shade100;
    case 'pending approval':
      return Colors.red.shade100;
    case 'open':
      return Colors.blue.shade100;
    case 'assigned':
      return Colors.yellow.shade100;
    default:
      return Colors.grey.shade200;
  }
}

Widget headerWidget(String label) {
  return Container(
    height: 50,
    width: double.infinity,
    padding: const EdgeInsets.all(10),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          AppColors.baseColor,
          AppColors.buttonOrange,
          AppColors.baseColor,
        ],
      ),
    ),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    ),
  );
}

class CommonActionButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final List<Color> gradientColors;
  final bool isLoading;

  const CommonActionButton({
    super.key,
    required this.title,
    required this.onTap,
    required this.gradientColors,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(left: 6, right: 6, bottom: 10),
        child: InkWell(
          onTap: isLoading ? null : onTap, // disable when loading
          child: Container(
            margin: const EdgeInsets.only(bottom: 10.0),
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: 40,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: 5,
                  offset: Offset(2.0, 5.0),
                )
              ],
              gradient: LinearGradient(colors: gradientColors),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: isLoading
                        ? const SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            title,
                            style: const TextStyle(
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
    );
  }
}

/// COMMON FIELD BUILDER
Widget buildField(
  String label,
  TextEditingController controller, {
  bool enabled = true,
  TextInputType? type,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.baseColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextFormField(
          maxLines: null,
          controller: controller,
          enabled: enabled,
          keyboardType: type,
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ),
      ],
    ),
  );
}

String getYearOrNA(String? apiDate) {
  if (apiDate == null || apiDate.trim().isEmpty) {
    return "N/A";
  }

  try {
    // First try automatic parsing (works for many ISO formats)
    DateTime parsedDate = DateTime.parse(apiDate);
    return parsedDate.year.toString();
  } catch (_) {
    // Try common alternative formats
    final formats = [
      'MM/dd/yyyy',
      'dd/MM/yyyy',
      'yyyy-MM-dd',
      'MM-dd-yyyy',
      'dd-MM-yyyy',
      'yyyy/MM/dd',
      'MMM dd yyyy hh:mma', //Apr 10 2026 12:00AM
      'MMM  d yyyy  hh:mma', // Apr  2 2026  12:00AM
      'MMM  d yyyy hh:mma', // Apr  2 2026 12:00AM
      'MMM d yyyy  hh:mma', //"Apr 28 2026  9:52AM",
      'yyyy-MM-dd HH:mm:ss.SSS', // 2026-05-02 07:38:39.150
      'yyyy' //2006
    ];

    for (var format in formats) {
      try {
        DateTime parsedDate = DateFormat(format).parseStrict(apiDate);
        return parsedDate.year.toString();
      } catch (_) {}
    }

    return "";
  }
}

Widget menuLogo() {
  return Container(
    width: 130,
    height: 60,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(
        'assets/pemc/pemc_logo.png',
        fit: BoxFit.fill,
      ),
    ),
  );
}

Container progressBar() {
  return Container(
    height: 25,
    width: 25,
    margin: const EdgeInsets.only(top: 4, bottom: 4),
    child: const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
  );
}

// ignore: must_be_immutable
class DashboardCard extends StatefulWidget {
  String cardTitle;
  String cardCount;
  dynamic cardIcon;
  Color? iconColor;
  Color? cardColor;

  DashboardCard({
    Key? key,
    required this.cardTitle,
    required this.cardCount,
    this.cardIcon,
    this.iconColor,
    this.cardColor,
  }) : super(key: key);

  @override
  State<DashboardCard> createState() => _DashboardCardState();
}

class _DashboardCardState extends State<DashboardCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        margin: const EdgeInsets.only(top: 10),
        padding:
            const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
        alignment: Alignment.center,
        //  width: size.width * 0.418,
        height: 95,
        //MediaQuery.of(context).size.height * 0.12,
        decoration: BoxDecoration(
          color: widget.cardColor,
          // shape: BoxShape.circle,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
                color: Colors.black, blurRadius: 5, offset: Offset(0.0, 2.0))
          ],
          // gradient:  LinearGradient(
          //   colors: [
          //      cardColor,
          //      cardColor
          //     //  Color.fromARGB(255, 255, 255, 255),
          //     //  Color.fromARGB(255, 255, 255, 255),
          //   ],
          // )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.cardTitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 16,
                  //color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              widget.cardCount,
              style: const TextStyle(
                  fontSize: 18,
                  // color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ));
  }
}

class DashboardCardWithIconNew extends StatelessWidget {
  final IconData icon;
  final String title;
  final String count;
  final VoidCallback onTap;
  //   final List<Color> gradientColors;

  const DashboardCardWithIconNew({
    super.key,
    required this.icon,
    required this.title,
    required this.count,
    required this.onTap,
    // required this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: const LinearGradient(
              colors: [
                AppColors.baseColor,
                AppColors.buttonOrange,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: Offset(2, 4),
              )
            ],
          ),
          //        decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(16),
          //   gradient: LinearGradient(
          //     colors: gradientColors,
          //     begin: Alignment.topLeft,
          //     end: Alignment.bottomRight,
          //   ),
          //   boxShadow: [
          //     BoxShadow(
          //       color: gradientColors.last.withOpacity(0.4),
          //       blurRadius: 10,
          //       offset: const Offset(2, 5),
          //     )
          //   ],
          // ),
          child: Row(
            children: [
              // Icon
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.4),
                      Colors.white.withOpacity(0.1),
                    ],
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(2, 3),
                    )
                  ],
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 26,
                ),
              ),

              const SizedBox(width: 16),

              //  Title
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              //  Count
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  count,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildNoDataWidget() {
  return Padding(
    padding: const EdgeInsets.only(top: 16.0, bottom: 16, left: 8, right: 8),
    child: Center(
      child: Column(
        children: [
          Image.asset(
            'assets/empty_box_pemc.png',
            height: 200,
            width: 200,
            fit: BoxFit.cover,
          ),
          const Text(
            'Sorry, Data Not Found!',
            style: TextStyle(
              color: AppColors.baseColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget rejectButton() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    width: 80,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      gradient: const LinearGradient(
        colors: [
          Color(0xFFFF3B30), // strong red
          Color(0xFFFF6B6B), // soft red
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: const [
        BoxShadow(
          color: Color(0x33FF3B30),
          blurRadius: 6,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: const Center(
      child: Text(
        "Reject",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 13,
          letterSpacing: 0.5,
        ),
      ),
    ),
  );
}

Widget approveButton() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    width: 80,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      gradient: const LinearGradient(
        colors: [
          Color(0xFF005CFF),
          Color(0xFF3A8DFF),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: const [
        BoxShadow(
          color: Color(0x33005CFF),
          blurRadius: 6,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: const Center(
      child: Text(
        "Approve",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 13,
          letterSpacing: 0.5,
        ),
      ),
    ),
  );
}

//////file download for tab data images
Future<void> downloadFile(
  String fileUrl,
  String fileType,
  BuildContext context,
) async {
  try {
    // Request storage permission for Android
    if (Platform.isAndroid) {
      await Permission.storage.request();
      await Permission.manageExternalStorage.request();
    }

    final response = await http.get(Uri.parse(fileUrl));

    if (response.statusCode == 200) {
      Directory? directory;

      if (Platform.isAndroid) {
        directory = Directory('/storage/emulated/0/Download');
      } else if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      }

      final fileName = fileUrl.split('/').last;

      final file = File('${directory!.path}/$fileName');

      await file.writeAsBytes(response.bodyBytes);

      print('$fileType downloaded to: ${file.path}');

      print('$fileType downloaded to: ${file.path}');
      // CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
      //   '$fileType Downloaded',
      //   context,
      // );
      CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
          'File saved at: ${file.path}', context);
    } else {
      print(
        'Failed to download $fileType. Status code: ${response.statusCode}',
      );
    }
  } catch (e) {
    print("Download Error: $e");
  }
}

///old code
//   Future<void> downloadFile(String fileUrl, String fileType) async {
//   final response = await http.get(Uri.parse(fileUrl));
//   if (response.statusCode == 200) {
//     final appDir = await getApplicationDocumentsDirectory();
//     final fileName = fileUrl.split('/').last;
//     final file = File('${appDir.path}/$fileName');
//     await file.writeAsBytes(response.bodyBytes);
//     print('$fileType downloaded to: ${file.path}');
//     CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
//         '$fileType Downloaded', context);
//   } else {
//     print(
//         'Failed to download $fileType. Status code: ${response.statusCode}');
//   }
// }
class ProgressCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color startColor;
  final Color endColor;

  const ProgressCard({
    Key? key,
    required this.title,
    required this.value,
    required this.icon,
    required this.startColor,
    required this.endColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // Responsive values
    double cardHeight = screenWidth < 400
        ? 95
        : screenWidth < 600
            ? 110
            : 100;
    double valueFontSize = screenWidth < 400
        ? 18
        : screenWidth < 600
            ? 20
            : 24;
    return Container(
      // height: 114,
      height: cardHeight,
      padding: const EdgeInsets.only(top: 12, bottom: 12, left: 12, right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [startColor, endColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: startColor.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Icon(
                icon,
                color: Colors.white,
                size: 26,
              ),
            ],
          ),
          // Tooltip(
          //   message: value,
          //   child: Text(
          //     value,
          //     maxLines: 1,
          //     overflow: TextOverflow.ellipsis,
          //     style: TextStyle(
          //       color: Colors.white,
          //       fontSize: valueFontSize,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          // )
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              // fontSize: 22,
              fontSize: valueFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

// Widget progressHeader(String label, {GestureTapCallback? onTap}) {
//   return Container(
//     margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//     decoration: BoxDecoration(
//       color: const Color.fromARGB(255, 218, 125, 4),
//       borderRadius: BorderRadius.circular(10),
//       boxShadow: [
//         BoxShadow(
//           color: Colors.orange.withOpacity(0.25),
//           blurRadius: 10,
//           offset: const Offset(0, 4),
//         ),
//       ],
//     ),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 20,
//             fontWeight: FontWeight.w700,
//             letterSpacing: 0.5,
//           ),
//         ),
//         InkWell(
//           onTap: onTap,
//           child: Container(
//             height: 30,
//             width: 30,
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.18),
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(
//                 color: Colors.white24,
//               ),
//             ),
//             child: const Icon(Icons.filter_alt_outlined,
//                 color: Colors.white, size: 20),
//           ),
//         ),
//       ],
//     ),
//   );
// }
Widget progressHeader(String label, {GestureTapCallback? onTap}) {
  return Container(
    // margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    margin: const EdgeInsets.only(right: 8, left: 8, top: 4, bottom: 0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [
          Color(0xFF283618),
          Color(0xFF3E5A2D),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF283618).withOpacity(0.35),
          blurRadius: 12,
          spreadRadius: 1,
          offset: const Offset(0, 5),
        ),
      ],
      border: Border.all(
        color: const Color(0xFF606C38),
        width: 1.5,
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 8,
      ),
      child: Row(
        children: [
          // Highlight bar
          Container(
            width: 5,
            height: 30,
            decoration: BoxDecoration(
              color: const Color(0xFFDDA15E),
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
              ),
            ),
          ),

          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: onTap,
              child: Container(
                height: 34,
                width: 34,
                decoration: BoxDecoration(
                  color: const Color(0xFFDDA15E).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: const Color(0xFFDDA15E),
                    width: 1.2,
                  ),
                ),
                child: const Icon(
                  Icons.filter_alt_rounded,
                  color: Color(0xFFDDA15E),
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Text textWithStar(String? text) {
  return Text.rich(
    TextSpan(
      text: text,
      style: const TextStyle(
        fontSize: 16,
        color: AppColors.baseColor,
        fontWeight: FontWeight.bold,
      ),
      children: const [
        TextSpan(text: "*", style: TextStyle(color: Colors.red)),
      ],
    ),
  );
}

Widget textWithOutStar(String? text, {Color textColor = AppColors.baseColor}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 2.0),
    child: Text.rich(
      TextSpan(
        text: text,
        style: TextStyle(
          fontSize: 16,
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  String label;
  VoidCallback onTap;
  Color buttonColor1;
  double buttonWidth;
  bool buttonMargin;
  final bool isLoading;
  // Color buttonColor2;
  // bool showButtonColor;
  //Color shadowColor;
  bool showGradientColor;
  CustomButton(
      {Key? key,
      required this.label,
      required this.onTap,
      this.buttonColor1 = const Color.fromRGBO(76, 175, 80, 1),
      this.buttonWidth = 200,
      this.buttonMargin = false,
      this.isLoading = false, //  default false
      // this.buttonColor2 = thirdColor,
      // this.shadowColor = fourthColor,
      this.showGradientColor = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin:
            buttonMargin ? const EdgeInsets.all(0) : const EdgeInsets.all(4),
        alignment: Alignment.center,
        height: 45,
        width: buttonWidth,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            // boxShadow: [
            //   BoxShadow(
            //       color: showButtonColor == true ? shadowColor : fourthColor,
            //       blurRadius: 5,
            //       offset: Offset(2.0, 5.0))
            // ],
            color: buttonColor1,
            gradient: showGradientColor
                ? const LinearGradient(
                    colors: [
                      AppColors.baseColor,
                      AppColors.buttonOrange,
                      AppColors.baseColor,
                    ],
                  )
                : LinearGradient(
                    colors: [
                      buttonColor1,
                      buttonColor1,
                    ],
                  )
            // gradient: showButtonColor == true
            //     ? LinearGradient(
            //         colors: [buttonColor1, buttonColor2],
            //       )
            //     : LinearGradient(
            //         colors: [mainColor, thirdColor],
            //       )
            ),
        child: Align(
          alignment: Alignment.center,
          child: isLoading
              ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 4,
                    color: Colors.white,
                  ),
                )
              : Text(
                  label,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
        ),
      ),
    );
  }
}

///card header
Widget cardHeader(String title) {
  return Container(
    padding: const EdgeInsets.all(10),
    alignment: Alignment.center,

    // width: MediaQuery.of(context).size.width,
    // height: 40,
    decoration: const BoxDecoration(
        // shape: BoxShape.circle,
        //borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
              color: AppColors.buttonShadow,
              blurRadius: 2,
              offset: Offset(1.0, 2.0))
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
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            textAlign: TextAlign.left,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
    ]),
  );
}
