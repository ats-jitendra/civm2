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
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
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
          valueColor: AlwaysStoppedAnimation(
            Theme.of(context).primaryColor,
          ),
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
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
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
      'https://civm.ariespro.com/assets/clientuploads/';

  @override
  Widget build(BuildContext context) {
    final images = imageLocations
        .where((image) => image.trim().isNotEmpty)
        .toList();

    if (images.isEmpty) {
      return const SizedBox(
        height: 150,
        child: Center(
          child: Text(
            "No images found",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
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
            padding: const EdgeInsets.only(right: 10,bottom: 10),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                _openFullScreenImage(
                  context,
                  fileLocation,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  '$baseUrl$fileLocation',
                  width: imageSize,
                  height: imageSize,
                  fit: BoxFit.cover,
                  loadingBuilder: (
                    context,
                    child,
                    loadingProgress,
                  ) {
                    if (loadingProgress == null) {
                      return child;
                    }

                    return SizedBox(
                      width: imageSize,
                      height: imageSize,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                  errorBuilder: (
                    context,
                    error,
                    stackTrace,
                  ) {
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

  void _openFullScreenImage(
    BuildContext context,
    String fileLocation,
  ) {
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
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
