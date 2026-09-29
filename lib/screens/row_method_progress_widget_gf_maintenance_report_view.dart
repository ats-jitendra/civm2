import 'dart:convert';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/resources/app_url.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class RowMethodProgressWidgetGfMaintenanceReportView extends StatefulWidget {
  String tokenNo;
  RowMethodProgressWidgetGfMaintenanceReportView({
    super.key,
    required this.tokenNo,
  });

  @override
  State<RowMethodProgressWidgetGfMaintenanceReportView> createState() =>
      _RowMethodProgressWidgetGfMaintenanceReportViewState();
}

class _RowMethodProgressWidgetGfMaintenanceReportViewState
    extends State<RowMethodProgressWidgetGfMaintenanceReportView> {
  List<dynamic> methods = [];
  // Map<String, dynamic>? actualTotalMilesData;
  // double actualCompletedMiles = 0.0;
  // double actualPercentage = 0.0;
  // double actualTotalMiles = 0.0;
  bool isLoading = true;

  @override
  void initState() {
    fetchRowMethodData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final List<Map<String, dynamic>> methods = [
    //   {
    //     "title": "Jaraff",
    //     "progress": 0.75,
    //   },
    //   {
    //     "title": "Mowing",
    //     "progress": 0.45,
    //   },
    //   {
    //     "title": "Roadside spray",
    //     "progress": 0.90,
    //   },
    // ];

    /// Method Colors
    final Map<String, Color> methodColors = {
      "JARRAFF": const Color.fromARGB(255, 96, 0, 113),
      "MOWING": const Color.fromARGB(255, 113, 68, 1),
      "MINI JARRAFF": const Color.fromARGB(255, 247, 19, 2),
      "BYL": const Color.fromARGB(255, 2, 212, 249),
      "BUCKET": Colors.orange,
      "GROUND": Colors.yellow,
      "CROSS-COUNTRY SPRAY": const Color.fromARGB(255, 38, 1, 247),
      "ROADSIDE SPRAY": const Color.fromARGB(255, 1, 127, 5),
      "NO SPRAY": const Color.fromARGB(255, 252, 199, 249),
    };
    if (isLoading) {
      return Center(
        child: const SizedBox(
          height: 250,
          child: Center(
            child: CircularProgressIndicator(color: Color(0xff073B78)),
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(14),

      //   // /// Highlight Border
      //   border: Border.all(
      //     color: const Color(0xff2563EB),
      //     width: 1.5,
      //   ),
      // ),
      child: Column(
        children: [
          // if (responseHasActualTotalMiles())
          // /// TOP TOTAL MILES CARD
          // Container(
          //   margin: const EdgeInsets.only(bottom: 4, top: 4),
          //   padding: const EdgeInsets.all(14),
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.circular(14),
          //     border: Border.all(
          //       color: const Color(0xff2563EB),
          //       width: 1.5,
          //     ),
          //     boxShadow: [
          //       BoxShadow(
          //         color: Colors.black.withOpacity(0.08),
          //         blurRadius: 5,
          //         offset: const Offset(0, 3),
          //       ),
          //     ],
          //   ),
          //   child: Row(
          //     children: [
          //       const SizedBox(
          //         width: 130,
          //         child: Text(
          //           "Total Miles",
          //           style: TextStyle(
          //             fontSize: 16,
          //             fontWeight: FontWeight.bold,
          //             color: Color.fromARGB(255, 7, 59, 120),
          //           ),
          //         ),
          //       ),
          //       const SizedBox(width: 10),

          //       /// Progress Bar
          //       Expanded(
          //           child: Container(
          //         padding: const EdgeInsets.all(3),
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(12),

          //           /// Outer Highlight
          //           border: Border.all(
          //             color: Colors.blue.shade400,
          //             width: 1.3,
          //           ),

          //           /// Glow Effect
          //           boxShadow: [
          //             BoxShadow(
          //               color: Colors.blue.withOpacity(0.25),
          //               blurRadius: 8,
          //               spreadRadius: 1,
          //             ),
          //           ],
          //           color: Colors.white,
          //         ),
          //         child: ClipRRect(
          //           borderRadius: BorderRadius.circular(10),
          //           child: Stack(
          //             alignment: Alignment.center,
          //             children: [
          //               /// Progress Bar
          //               LinearProgressIndicator(
          //                 value: actualPercentage / 100,
          //                 minHeight: 14,
          //                 backgroundColor: Colors.blue.shade50,
          //                 valueColor: const AlwaysStoppedAnimation<Color>(
          //                   Colors.blue,
          //                 ),
          //               ),

          //               /// Percentage Text
          //               Text(
          //                 "${actualPercentage.toStringAsFixed(0)}%",
          //                 style: const TextStyle(
          //                   fontSize: 11,
          //                   fontWeight: FontWeight.bold,
          //                   color: Colors.blue,
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       )),
          //       const SizedBox(width: 12),

          //       /// Miles Text
          //       Text.rich(
          //         TextSpan(
          //           children: [
          //             TextSpan(
          //               text: "${actualCompletedMiles.toStringAsFixed(2)} / ",
          //               style: const TextStyle(
          //                 fontSize: 15,
          //                 fontWeight: FontWeight.w500,
          //                 //color: Colors.black,
          //                 color: Color.fromARGB(255, 7, 59, 120),
          //               ),
          //             ),
          //             TextSpan(
          //               text: actualTotalMiles.toStringAsFixed(2),
          //               style: const TextStyle(
          //                 fontSize: 15,
          //                 fontWeight: FontWeight.bold,
          //                 // color: Colors.black,
          //                 color: Color.fromARGB(255, 7, 59, 120),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          if (methods.isNotEmpty)
           Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xff2563EB), width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.08),
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.numbers_outlined, color: Color(0xff073B78)),
                  const SizedBox(width: 10),
                  const Text(
                    "JOB NO",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff073B78),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    widget.tokenNo,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff073B78),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xff2563EB), width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.08),
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.route, color: Color(0xff073B78)),
                  const SizedBox(width: 10),
                  const Text(
                    "Total Miles",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff073B78),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "$totalApprovedMiles/$smMaintTotalMiles",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff073B78),
                    ),
                  ),
                ],
              ),
            ),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: methods.length,
            itemBuilder: (context, index) {
              final item = methods[index];

              final String crewName = item['crewMemberName']?.toString() ?? '';

              final String rowMethod = item['rowMethod']?.toString() ?? '';

              final double approvedMiles = (item['approvedMiles'] ?? 0)
                  .toDouble();

              final double pendingMiles = (item['pendingMiles'] ?? 0)
                  .toDouble();

              final double totalMiles = (item['coordinateTotalMiles'] ?? 0)
                  .toDouble();

              final double progress = totalMiles == 0
                  ? 0
                  : approvedMiles / totalMiles;

              final Color methodColor =
                  methodColors[rowMethod.toUpperCase()] ?? Colors.blue;

              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.08),
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Crew Name : $crewName",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff073B78),
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      "Work Type : $rowMethod",
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    /// Progress Bar
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: progress.clamp(0.0, 1.0),
                        minHeight: 12,
                        backgroundColor: Colors.grey.shade300,
                        valueColor: AlwaysStoppedAnimation<Color>(methodColor),
                      ),
                    ),

                    const SizedBox(height: 12),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Text(
                        //     "${pendingMiles.toStringAsFixed(2)}/${approvedMiles.toStringAsFixed(2)}",
                        //     style: const TextStyle(
                        //       color: Colors.green,
                        //       fontWeight: FontWeight.w600,
                        //     ),
                        //   ),
                        Text(
                          "Completed : ${approvedMiles.toStringAsFixed(2)}",
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "Pending : ${pendingMiles.toStringAsFixed(2)}",
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    Text(
                      "Total Miles : ${totalMiles.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xff073B78),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // bool responseHasActualTotalMiles() {
  //   return actualTotalMilesData != null &&
  //       actualTotalMilesData!['actualTotalMiles'] != null;
  // }

  Future<void> fetchRowMethodData() async {
    try {
      setState(() {
        isLoading = true;
      });

      var url = Uri.parse(
        "${AppUrl.baseUrl}contractor_panel/getProgressDetail?tokenNo=${widget.tokenNo}",
      );

      print('url maintenance report view progress details: $url');

      final userPreferences = Provider.of<UserPref>(context, listen: false);

      UserModel data = await userPreferences.getUser();

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer ${data.token}',
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        setState(() {
          methods = responseData['progressDetailList'] ?? [];
          // actualTotalMilesData = responseData['actualTotalMilesData'];

          // actualCompletedMiles =
          //     (responseData['actualTotalMilesData']['actualCompletedMiles'] ?? 0.0)
          //         .toDouble();

          // actualPercentage =
          //     (responseData['actualTotalMilesData']['actualPercentage'] ?? 0.0)
          //         .toDouble();

          // actualTotalMiles =
          //     (responseData['actualTotalMilesData']['actualTotalMiles'] ?? 0.0)
          //         .toDouble();

          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint("API Error: $e");

      setState(() {
        isLoading = false;
      });
    }
  }

  String get totalApprovedMiles {
    // return methods.fold(
    //   0.0,
    //   (sum, item) => sum + ((item['smMaintMilesCompleted'] ?? 0).toDouble()),
    // );
    if (methods.isEmpty) return "0.00";
    return methods.first['smMaintMilesCompleted']?.toString() ?? "0.00";
  }

  String get smMaintTotalMiles {
    if (methods.isEmpty) return "0.00";
    return methods.first['smMaintTotalMiles']?.toString() ?? "0.00";
  }
}
