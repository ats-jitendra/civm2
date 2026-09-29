import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:CIVM/piedmont/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

Widget statusBadge(String? status) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
    decoration: BoxDecoration(
      color: getStatusColor(status),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      status ?? "",
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
  );
}

Widget menuLogoLCP() {
  return Container(
    width: 130,
    height: 60,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset('assets/civm_logo.png', fit: BoxFit.fill),
    ),
  );
}

//status text color
Color getStatusColor(String? status) {
  final value = status?.toLowerCase().trim() ?? '';

  switch (value) {
    case 'assigned':
      return Colors.green;

    case 'cancel':
    case 'cancelled':
    case 'cancelled by supervisor':
    case 'cancelled by planner':
    case 'cancelled by gf':
    case 'cancelled by admin':
    case 'rejected':
      return const Color.fromARGB(255, 241, 133, 125);

    case 'completed':
    case 'closed':
      return Colors.blue;

    case 'pending':
    case 'pending approval':
    case 'pending  approval':
    case 'pending lcp approval':
    case 'pending zielies approval':
    case 'pending zielies assignment':
    case 'pending lcp inspection':
    case 'approved':
      return Colors.yellow;

    default:
      return Colors.white;
  }
}

///card background color
Color getCardColor(String? status) {
  switch (status?.toLowerCase().trim()) {
    case 'assigned':
      return Colors.green.shade100;
    case 'cancel':
    case 'cancelled':
    case 'cancelled by supervisor':
    case 'cancelled by planner':
    case 'cancelled by gf':
    case 'cancelled by admin':
    case 'rejected':
      return Colors.red.shade100;
    case 'completed':
    case 'closed':
      return Colors.blue.shade100;
    case 'pending':
    case 'pending approval':
    case 'pending  approval':
    case 'pending lcp approval':
    case 'pending zielies approval':
    case 'pending zielies assignment':
    case 'pending lcp inspection':
    case 'approved':
      return Colors.yellow.shade100;
    default:
      return Colors.grey.shade200;
  }
}

Container progressBar() {
  return Container(
    height: 25,
    width: 25,
    margin: const EdgeInsets.only(top: 4, bottom: 4),
    child: const CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
    ),
  );
}

String formatDate(String inputDate) {
  try {
    return DateFormat('MM/dd/yyyy').format(DateTime.parse(inputDate));
  } catch (_) {
    return inputDate;
  }
}

String formatDateIfNeeded(String inputDate) {
  final List<String> knownPatterns = [
    "yyyy-MM-dd'T'HH:mm", // e.g., 2025-11-01T10:58
    "yyyy-MM-dd'T'HH:mm:ss", // e.g., 2023-02-14T00:00:00
    //"yyyy-MM-dd'T'HH:mm:ssZ", // e.g., 2025-09-05T00:00:00+00:00
    'yyyy-MM-dd hh:mm:ss a', // e.g., 2022-01-28 07:17:02 AM
    'yyyy-MM-dd HH:mm:ss', // e.g., 2022-01-28 13:45:00
    'yyyy-MM-dd', // e.g., 2022-02-15
    'dd-MM-yyyy h:mm a', //  e.g., 11-06-2025 5:53 PM
    'MM-dd-yyyy',
    "yyyy-MM-dd'T'HH:mm:ssXXX", //  handles 2026-02-03T00:00:00+00:00
  ];
  for (String pattern in knownPatterns) {
    try {
      DateTime parsedDate = DateFormat(pattern).parseStrict(inputDate);
      return DateFormat('MM/dd/yyyy').format(parsedDate);
    } catch (_) {}
  }
  return inputDate;
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
                ),
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
       'MMM dd yyyy hh:mma', // Jul 28 2026 12:00AM
    ];

    for (var format in formats) {
      try {
        DateTime parsedDate = DateFormat(format).parseStrict(apiDate);
        return parsedDate.year.toString();
      } catch (_) {}
    }

    return "N/A";
  }
}

Widget buildNoDataWidget() {
  return Padding(
    padding: const EdgeInsets.only(top: 16.0, bottom: 16, left: 8, right: 8),
    child: Center(
      child: Column(
        children: [
          Image.asset(
            'assets/empty_box.png',
            height: 200,
            width: 200,
            fit: BoxFit.cover,
          ),
          const Text(
            'Sorry, Data Not Found!',
            style: TextStyle(
              color: Color.fromARGB(255, 7, 59, 120),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    ),
  );
}

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
      CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
        'File saved at: ${file.path}',
        context,
      );
    } else {
      print(
        'Failed to download $fileType. Status code: ${response.statusCode}',
      );
    }
  } catch (e) {
    print("Download Error: $e");
  }
}

void showModernSuccessDialog(BuildContext context, {required String message}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {
      /// AUTO CLOSE
      Future.delayed(const Duration(seconds: 2), () {
        if (dialogContext.mounted) {
          Navigator.of(dialogContext, rootNavigator: true).pop();
        }
      });

      return Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,

        child: TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 400),
          tween: Tween(begin: 0.7, end: 1),

          curve: Curves.easeOutBack,

          builder: (context, value, child) {
            return Transform.scale(
              scale: value,
              child: Opacity(opacity: value.clamp(0.0, 1.0), child: child),
            );
          },

          child: Container(
            padding: const EdgeInsets.all(24),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),

              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// SUCCESS ICON
                Container(
                  height: 85,
                  width: 85,

                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,

                    gradient: LinearGradient(
                      colors: [Color(0xFF00C853), Color(0xFF43A047)],
                    ),
                  ),

                  child: const Icon(
                    Icons.check_rounded,
                    color: Colors.white,
                    size: 50,
                  ),
                ),

                const SizedBox(height: 24),

                /// TITLE
                const Text(
                  "Success",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 10),

                /// MESSAGE
                Text(
                  message,
                  textAlign: TextAlign.center,

                  style: TextStyle(
                    fontSize: 15,
                    height: 1.5,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Widget progressHeaderCivm(String label, {GestureTapCallback? onTap}) {
  const Color primaryColor = Color.fromARGB(255, 7, 59, 120);
  const Color accentColor = Color(0xFF4DD0E1); // Amber accent

  return Container(
    margin: const EdgeInsets.only(right: 8, left: 8, top: 4, bottom: 0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [
          primaryColor,
          Color.fromARGB(255, 15, 87, 170), // Slightly lighter blue
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: primaryColor.withOpacity(0.35),
          blurRadius: 12,
          spreadRadius: 1,
          offset: const Offset(0, 5),
        ),
      ],
      border: Border.all(color: Color.fromARGB(255, 28, 103, 190), width: 1.5),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          // Accent bar
          Container(
            width: 5,
            height: 30,
            decoration: BoxDecoration(
              color: accentColor,
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
                padding: EdgeInsets.all(6),
                height: 34,
                width: 34,
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: accentColor, width: 1.2),
                ),
                child: Image.asset(
                  "assets/plus_simple.png",
                  color: accentColor,
                  // height: 10,
                  // width: 10,
                ),
                // Icon(
                //   Icons.add,
                //   color: accentColor,
                //   size: 20,
                // ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

  // Future<void> downloadFile(String fileUrl, String fileType) async {
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
