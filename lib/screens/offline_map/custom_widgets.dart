import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void showLoader(BuildContext context, {String message = "Loading..."}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            circularBarWithIcon(context),
            const SizedBox(height: 10),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    ),
  );
}

SizedBox circularBarWithIcon(BuildContext context) {
  return SizedBox(
    width: 60,
    height: 60,
    child: Stack(
      alignment: Alignment.center,
      children: [
        CircularProgressIndicator(
          strokeWidth: 4,
          valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
        ),
        Icon(
          Icons.water_drop_outlined,
          color: Theme.of(context).primaryColor,
          size: 28,
        ),
      ],
    ),
  );
}

String formatChatDate(dynamic inputDate) {
  if (inputDate == null || inputDate.toString().trim().isEmpty) {
    return "";
  }

  try {
    final parsedDate = DateTime.parse(inputDate.toString()).toLocal();
    return DateFormat("MM/dd/yyyy HH:mm:ss").format(parsedDate);
  } catch (e) {
    print("Date parse error: $e");
    return "";
  }
}

// String formatChatDate(String inputDate) {
//   try {
//     final parsedDate = DateTime.parse(inputDate).toLocal();
//     return DateFormat("MM/dd/yyyy HH:mm:ss").format(parsedDate);
//   } catch (e) {
//     print("Date parse error: $e");
//     return inputDate;
//   }
// }
String formatDate(String inputDate) {
  if (inputDate.trim().isEmpty) return inputDate;

  try {
    final date = DateTime.parse(inputDate);
    return DateFormat('MM/dd/yyyy').format(date);
  } catch (_) {
    return inputDate;
  }
}

String formatDateTime(DateTime dateTime) {
  return "${DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime)}."
      "${dateTime.microsecond.toString().padLeft(6, '0')}";
}

class MapActionButton extends StatelessWidget {
  final String imagePath;
  final VoidCallback onTap;
  final double size;
  final double imageSize;
  final Color backgroundColor;

  const MapActionButton({
    super.key,
    required this.imagePath,
    required this.onTap,
    this.size = 42,
    this.imageSize = 24,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.25),
              blurRadius: 8,
              spreadRadius: 1,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Image.asset(
            imagePath,
            width: imageSize,
            height: imageSize,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

void showModernSuccessDialog(BuildContext context, {required String message}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {
      /// AUTO CLOSE
      Future.delayed(const Duration(seconds: 3), () {
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

class JobNoPointerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width / 2, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
///////

class NetworkImageGallery extends StatelessWidget {
  final List<String> imageLocations;
  final double imageSize;
  final double height;

  const NetworkImageGallery({
    super.key,
    required this.imageLocations,
    this.imageSize = 150,
    this.height = 150,
  });

  static const String baseUrl =
      'https://civm.ariespro.com/assets/clientuploadstest/';

  @override
  Widget build(BuildContext context) {
    final images = imageLocations
        .where((image) => image.trim().isNotEmpty)
        .toList();

    if (images.isEmpty) {
      return const SizedBox(
        // height: 150,
        // child: Center(
        //   child: Text(
        //     "No images found",
        //     style: TextStyle(fontWeight: FontWeight.bold),
        //   ),
        // ),
      );
    }

    return SizedBox(
      height: height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (context, index) {
          final fileLocation = images[index];

          return Padding(
            padding: const EdgeInsets.only(right: 10, bottom: 10),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                _openFullScreenImage(context, fileLocation);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  '$baseUrl$fileLocation',
                  width: imageSize,
                  height: imageSize,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }

                    return SizedBox(
                      width: imageSize,
                      height: imageSize,
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: imageSize,
                      height: imageSize,
                      color: Colors.grey.shade200,
                      child: const Icon(
                        Icons.broken_image_outlined,
                        size: 40,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _openFullScreenImage(BuildContext context, String fileLocation) {
    final imageUrl = '$baseUrl$fileLocation';

    showDialog(
      context: context,
      barrierColor: Colors.black,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.black,
          insetPadding: EdgeInsets.zero,
          child: Stack(
            children: [
              InteractiveViewer(
                minScale: 0.5,
                maxScale: 4.0,
                child: Center(
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.contain,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),

              Positioned(
                top: 35,
                right: 10,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close, color: Colors.white, size: 30),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

////////
Future<void> showConfirmDialog({
  required BuildContext context,
  String status = "Submit It!",
  String title = "Are you sure?",
  String message = "",
  required Future<void> Function() onTapYes,
  Color yesButtonColor = Colors.orange,
  IconData icon = Icons.error_outline_rounded,
}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      bool isLoading = false;

      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Column(
              children: [
                Icon(icon, color: yesButtonColor, size: 40),
                // const SizedBox(height: 8),
                // Text(title),
              ],
            ),
            content: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),

                // onPressed: isLoading
                //     ? null
                //     : () async {
                //         setState(() => isLoading = true);

                //         await onTapYes();

                //         if (context.mounted) {
                //           Navigator.pop(context);

                //         }
                //       },
                onPressed: isLoading
                    ? null
                    : () async {
                        setState(() => isLoading = true);

                        try {
                          await onTapYes();

                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                        } catch (e) {
                          if (context.mounted) {
                            setState(() => isLoading = false);
                          }
                          print("Delete error: $e");
                        }
                      },

                child: isLoading
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          color: Colors.white,
                        ),
                      )
                    : Text("Yes"),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  if (isLoading) return; // block tap, keep style
                  Navigator.pop(context);
                },
                child: const Text("No"),
              ),
            ],
          );
        },
      );
    },
  );
}

Future<void> showConfirmDialogWithMain({
  required BuildContext context,
  String status = "Submit It!",
  String title = "Confirm Submission",
  Widget message = const Text(""),
  required Future<void> Function() onTapYes,
  Color yesButtonColor = Colors.orange,
  IconData icon = Icons.error_outline_rounded,
}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      bool isLoading = false;

      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Column(
              children: [
                Icon(icon, color: yesButtonColor, size: 40),
                // const SizedBox(height: 8),
                Text(title),
              ],
            ),
            content: message,
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),

                onPressed: isLoading
                    ? null
                    : () async {
                        setState(() => isLoading = true);

                        try {
                          await onTapYes();

                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                        } catch (e) {
                          if (context.mounted) {
                            setState(() => isLoading = false);
                          }
                          print("Delete error: $e");
                        }
                      },

                child: isLoading
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          color: Colors.white,
                        ),
                      )
                    : Text("Yes, $status"),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  if (isLoading) return; // block tap, keep style
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),
            ],
          );
        },
      );
    },
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

Widget buildResponsiveInfo(
  IconData icon,
  String title,
  String value,
  bool isTablet, {
  bool isMasterJobNo = false,
}) {
  final showInRow = isTablet || isMasterJobNo;

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    decoration: BoxDecoration(
      color: Colors.orange.shade100,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.orange.shade700),
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.deepOrange, size: 18),
        const SizedBox(width: 6),
        Expanded(
          child: showInRow
              ? Row(
                  children: [
                    Flexible(
                      child: Text(
                        "$title :",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        value,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Colors.deepOrange,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      value,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.deepOrange,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
        ),
      ],
    ),
  );
}

Widget infoTile(IconData icon, String title, String value) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.blueGrey.shade100),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.08),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: const Color(0xFF073B78).withOpacity(0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, size: 16, color: const Color(0xFF073B78)),
        ),
        const SizedBox(width: 8),

        Text(
          "$title : ",
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w600,
          ),
        ),

        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF073B78),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Future<bool> showExitPopup(
  BuildContext context,
  Future<void> Function() onSubmit,
) async {
  bool isYes = false;

  return await showDialog<bool>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext dialogContext) {
          return StatefulBuilder(
            builder: (context, setDialogState) {
              return AlertDialog(
                content: SizedBox(
                  height: 140,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          "You're about to leave a page with unsaved work, would you like to save?",
                          style: TextStyle(
                            color: Color.fromARGB(255, 7, 59, 120),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: isYes
                                ? null
                                : () async {
                                    setDialogState(() {
                                      isYes = true;
                                    });

                                    try {
                                      await onSubmit();

                                      if (dialogContext.mounted) {
                                        Navigator.of(dialogContext).pop(true);
                                      }
                                    } catch (e) {
                                      print("Submit error: $e");

                                      if (dialogContext.mounted) {
                                        setDialogState(() {
                                          isYes = false;
                                        });
                                      }
                                    }
                                  },
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              height: 42,
                              width: 100,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: isYes
                                    ? Colors.red.shade300
                                    : Colors.red.shade800,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: isYes
                                  ? const SizedBox(
                                      height: 18,
                                      width: 18,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Text(
                                      "Yes",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          InkWell(
                            onTap: () {
                              Navigator.of(dialogContext).pop(true);
                            },
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              height: 42,
                              width: 100,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                "No",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ) ??
      false;
}
