import 'dart:convert';
import 'dart:math' as math;
import 'package:CIVM/models/primary_secondary_mile_model.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/resources/app_url.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/utils/work_progress_api.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class RowMethodProgressWidget extends StatefulWidget {
  String tokenNo;
  RowMethodProgressWidget({super.key, required this.tokenNo});

  @override
  State<RowMethodProgressWidget> createState() =>
      _RowMethodProgressWidgetState();
}

class _RowMethodProgressWidgetState extends State<RowMethodProgressWidget> {
  List<dynamic> methods = [];
  Map<String, dynamic>? actualTotalMilesData;
  double actualCompletedMiles = 0.0;
  double actualPercentage = 0.0;
  double actualTotalMiles = 0.0;

  double primaryMileProgress = 0.0;
  double secondaryMileProgress = 0.0;
  PrimarySecondaryMileModel? primarySecondaryMileModel;
  var secondaryFlex;
  var primaryFlex;

  @override
  void initState() {
    fetchRowMethodData();
    loadPrimarySecondaryMiles();
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

    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      child: Column(
        children: [
          if (responseHasActualTotalMiles())
            Container(
              margin: const EdgeInsets.only(bottom: 4, top: 4),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                // border: Border.all(
                //   color: const Color(0xff2563EB),
                //   width: 1.5,
                // ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xff073B78).withOpacity(.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.analytics_outlined,
                          color: Color(0xff073B78),
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        "Work Progress by Miles",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff073B78),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () {
                      _showMainSpanDialog(
                        context,
                        methodName: "TOTAL MILES",
                        primaryCompleted:
                            "${primarySecondaryMileModel?.primaryMilesCompleted ?? "0"}",
                        primarySpans:
                            "${primarySecondaryMileModel?.primaryMilesTotal ?? "0"}",
                        secondaryCompleted:
                            "${primarySecondaryMileModel?.secondaryMilesCompleted ?? "0"}",
                        secondarySpans:
                            "${primarySecondaryMileModel?.secondaryMilesTotal ?? "0"}",
                        completedSpans:
                            "${primarySecondaryMileModel?.totalMilesCompleted ?? "0"}",
                        totalSpans:
                            "${primarySecondaryMileModel?.totalMilesTotal ?? "0"}",
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(
                        bottom: 6,
                        left: 2,
                        right: 2,
                      ),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.grey.shade200),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: const SizedBox(
                              width: 130,
                              child: Text(
                                "TOTAL MILES",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 7, 59, 120),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 2),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: secondaryFlex,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                    ),
                                    child: LinearProgressIndicator(
                                      value: secondaryMileProgress,
                                      minHeight: 10,
                                      backgroundColor: Colors.grey.shade300,
                                      valueColor:
                                          const AlwaysStoppedAnimation<Color>(
                                            Colors.blue,
                                          ),
                                    ),
                                  ),
                                ),
                                if ((primarySecondaryMileModel
                                                ?.primaryMilesTotal ??
                                            "0.0") !=
                                        "0.0" &&
                                    (primarySecondaryMileModel
                                                ?.secondaryMilesTotal ??
                                            "0.0") !=
                                        "0.0")
                                  Container(
                                    width: 1,
                                    height: 10,
                                    color: Colors.black,
                                  ),
                                Expanded(
                                  flex: primaryFlex,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft:
                                          (primarySecondaryMileModel
                                                  ?.secondaryMilesTotal ==
                                              "0.0")
                                          ? Radius.circular(10)
                                          : Radius.circular(0),
                                      bottomLeft:
                                          (primarySecondaryMileModel
                                                  ?.secondaryMilesTotal ==
                                              "0.0")
                                          ? Radius.circular(10)
                                          : Radius.circular(0),
                                      topRight: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                    child: LinearProgressIndicator(
                                      value: primaryMileProgress,
                                      minHeight: 10,
                                      backgroundColor: Colors.grey.shade300,
                                      valueColor:
                                          const AlwaysStoppedAnimation<Color>(
                                            Colors.blue,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "${primarySecondaryMileModel?.secondaryMilesTotal ?? "0"}/"
                            "${primarySecondaryMileModel?.primaryMilesTotal ?? "0"}/"
                            "${primarySecondaryMileModel?.totalMilesTotal ?? "0"}",
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Container(
                  //    margin: const EdgeInsets.only(bottom: 6, left:2, right:2),
                  // padding: const EdgeInsets.all(10),
                  // decoration: BoxDecoration(
                  //   color: Colors.white,
                  //   borderRadius: BorderRadius.circular(14),
                  //   border: Border.all(
                  //                                   color: Colors.grey.shade200,
                  //                                 ),
                  //   boxShadow: [
                  //     BoxShadow(
                  //       color: Colors.black.withOpacity(0.08),
                  //       blurRadius: 5,
                  //       offset: const Offset(0, 3),
                  //     ),
                  //   ],
                  // ),
                  //   child: Row(
                  //     children: [
                  //       const SizedBox(
                  //         width: 130,
                  //         child: Text(
                  //           "TOTAL MILES",
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
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: methods.length,
                    itemBuilder: (context, index) {
                      final item = methods[index];

                      final String methodName = item['rowMethod'] ?? '';

                      final double milesCompleted =
                          (item['milesCompleted'] ?? 0.0).toDouble();

                      final double totalMiles = (item['totalMiles'] ?? 0.0)
                          .toDouble();

                      // final double progress =
                      //     totalMiles == 0 ? 0 : milesCompleted / totalMiles;
                      // print('progress $progress');
                      final double milesProgressApi =
                          item['completionPercentage'] ?? 0.0;

                      final Color methodColor =
                          methodColors[methodName] ?? Colors.grey;
                      /////////////////////////////////////////////////////////
                      final double primaryMiles = (item['primaryMiles'] ?? 0.0)
                          .toDouble();

                      final double secondaryMiles =
                          (item['secondaryMiles'] ?? 0.0).toDouble();

                      final double primaryCompleted =
                          (item['primaryCompleted'] ?? 0.0).toDouble();

                      final double secondaryCompleted =
                          (item['secondaryCompleted'] ?? 0.0).toDouble();

                      // final double totalMiles = primaryMiles + secondaryMiles;

                      final double primaryProgress = primaryMiles == 0
                          ? 0
                          : primaryCompleted / primaryMiles;

                      final double secondaryProgress = secondaryMiles == 0
                          ? 0
                          : secondaryCompleted / secondaryMiles;

                      final int primaryFlex = totalMiles > 0
                          ? math.max(
                              1,
                              (primaryMiles / totalMiles * 1000).round(),
                            )
                          : 1;

                      final int secondaryFlex = totalMiles > 0
                          ? math.max(
                              1,
                              (secondaryMiles / totalMiles * 1000).round(),
                            )
                          : 1;
                      return GestureDetector(
                        onTap: () {
                          _showMilesDialog(
                            context,
                            methodName: methodName,
                            primaryCompleted: primaryCompleted,
                            primaryMiles: primaryMiles,
                            secondaryCompleted: secondaryCompleted,
                            secondaryMiles: secondaryMiles,
                            milesCompleted: milesCompleted,
                            totalMiles: totalMiles,
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                            bottom: 6,
                            left: 2,
                            right: 2,
                          ),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: Colors.grey.shade200),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              /// Title
                              Expanded(
                                child: SizedBox(
                                  width: 130,
                                  child: Text(
                                    methodName,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(width: 10),

                              /// Progress Bar
                              Expanded(
                                child: Row(
                                  children: [
                                    ///  Secondary Section
                                    Expanded(
                                      flex: secondaryFlex,
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                        ),
                                        child: LinearProgressIndicator(
                                          value: secondaryProgress,
                                          minHeight: 10,
                                          backgroundColor: Colors.grey.shade300,
                                          valueColor: AlwaysStoppedAnimation(
                                            methodColor,
                                          ),
                                        ),
                                      ),
                                    ),

                                    if (primaryMiles > 0 && secondaryMiles > 0)
                                      Container(
                                        width: 1,
                                        height: 10,
                                        color: Colors.black,
                                      ),

                                    ///Primary Section
                                    Expanded(
                                      flex: primaryFlex,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topLeft:
                                              (secondaryMiles == 0 ||
                                                  secondaryMiles == 0.0)
                                              ? Radius.circular(10)
                                              : Radius.circular(0),
                                          bottomLeft:
                                              (secondaryMiles == 0 ||
                                                  secondaryMiles == 0.0)
                                              ? Radius.circular(10)
                                              : Radius.circular(0),

                                          topRight: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                        ),
                                        child: LinearProgressIndicator(
                                          value: primaryProgress,
                                          minHeight: 10,
                                          backgroundColor: Colors.grey.shade300,
                                          valueColor: AlwaysStoppedAnimation(
                                            methodColor.withOpacity(.65),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),

                              /// Percentage
                              // Text(
                              //   "${milesCompleted.toStringAsFixed(2)} / ${totalMiles.toStringAsFixed(2)}",
                              //   // "${(progress * 100).toInt()}%",
                              //   style: const TextStyle(
                              //     fontSize: 15,
                              //     fontWeight: FontWeight.w600,
                              //   ),
                              // ),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          "${secondaryMiles.toStringAsFixed(2)} / ",
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          "${primaryMiles.toStringAsFixed(2)} / ",
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                    TextSpan(
                                      text: totalMiles.toStringAsFixed(2),
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

          // Container(
          //   margin: const EdgeInsets.only(bottom: 4, top: 4),
          //   padding: const EdgeInsets.all(12),
          //   decoration: BoxDecoration(
          //     color: const Color(0xffEEF4FF),
          //     borderRadius: BorderRadius.circular(14),
          //     gradient: const LinearGradient(
          //       colors: [
          //         Color(0xff0F4C81),
          //         Color(0xff3B82F6),
          //       ],
          //       begin: Alignment.topLeft,
          //       end: Alignment.bottomRight,
          //     ),
          //     // /// Highlight Border
          //     // border: Border.all(
          //     //   color: const Color(0xff2563EB),
          //     //   width: 1.5,
          //     // ),
          //     /// Shadow
          //     boxShadow: [
          //       BoxShadow(
          //         color: const Color(0xff2563EB).withOpacity(0.18),
          //         blurRadius: 8,
          //         offset: const Offset(0, 3),
          //       ),
          //     ],
          //   ),
          //   child: Row(
          //     children: [
          //       // /// Icon
          //       // Container(
          //       //   padding: const EdgeInsets.all(7),
          //       //   decoration: BoxDecoration(
          //       //     color: const Color(0xff2563EB).withOpacity(0.12),
          //       //     borderRadius: BorderRadius.circular(10),
          //       //   ),
          //       //   child: const Icon(
          //       //     Icons.insights,
          //       //     color: Color(0xff2563EB),
          //       //     size: 20,
          //       //   ),
          //       // ),
          //       // const SizedBox(width: 10),
          //       /// Title
          //       const SizedBox(
          //         width: 120,
          //         child: Text(
          //           "Actual Total Miles",
          //           style: TextStyle(
          //             fontSize: 16,
          //             fontWeight: FontWeight.bold,
          //             //  color: Color(0xff1E3A8A),
          //             color: Colors.white,
          //           ),
          //         ),
          //       ),
          //       const SizedBox(width: 10),
          //       /// Progress Bar
          //       Expanded(
          //         child: ClipRRect(
          //           borderRadius: BorderRadius.circular(20),
          //           child: LinearProgressIndicator(
          //             value: actualPercentage / 100,
          //             minHeight: 16,
          //             backgroundColor: Colors.white.withOpacity(0.25),
          //             valueColor: const AlwaysStoppedAnimation<Color>(
          //               Colors.white,
          //             ),
          //           ),
          //         ),
          //       ),
          //       const SizedBox(width: 12),
          //       /// Miles
          //       Column(
          //         crossAxisAlignment: CrossAxisAlignment.end,
          //         children: [
          //           Text.rich(
          //             TextSpan(
          //               children: [
          //                 TextSpan(
          //                   text:
          //                       "${actualCompletedMiles.toStringAsFixed(2)} / ",
          //                   style: const TextStyle(
          //                       fontSize: 15,
          //                       fontWeight: FontWeight.w600,
          //                       /// color: Colors.black,
          //                       color: Colors.white),
          //                 ),
          //                 TextSpan(
          //                   text: actualTotalMiles.toStringAsFixed(2),
          //                   style: const TextStyle(
          //                       fontSize: 15,
          //                       fontWeight: FontWeight.bold,
          //                       // color: Color(0xff1E3A8A),
          //                       color: Colors.white),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           // const SizedBox(height: 2),
          //           // Text(
          //           //   "${actualPercentage.toStringAsFixed(0)}%",
          //           //   style: const TextStyle(
          //           //     fontSize: 12,
          //           //     fontWeight: FontWeight.bold,
          //           //     color: Color(0xff2563EB),
          //           //   ),
          //           // ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  bool responseHasActualTotalMiles() {
    return actualTotalMilesData != null &&
        actualTotalMilesData!['actualTotalMiles'] != null;
  }

  Future<void> fetchRowMethodData() async {
    try {
      var url = Uri.parse(
        "${AppUrl.baseUrl}row_maintenance_progress/progress?tokenNo=${widget.tokenNo}",
      );
      print('rowMethodProgressUrl $url');
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
          methods = responseData['rowWiseData'] ?? [];
          actualTotalMilesData = responseData['actualTotalMilesData'];

          /// Actual Total Miles Data
          actualCompletedMiles =
              (responseData['actualTotalMilesData']['actualCompletedMiles'] ??
                      0.0)
                  .toDouble();

          actualPercentage =
              (responseData['actualTotalMilesData']['actualPercentage'] ?? 0.0)
                  .toDouble();

          actualTotalMiles =
              (responseData['actualTotalMilesData']['actualTotalMiles'] ?? 0.0)
                  .toDouble();
          //   isLoading = false;
        });
      } else {
        setState(() {
          //isLoading = false;
        });

        throw Exception("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("API Error: $e");

      setState(() {
        //  isLoading = false;
      });
    }
  }

  Future<void> loadPrimarySecondaryMiles() async {
    try {
      primarySecondaryMileModel =
          await WorkProgressApi.getPrimarySecondaryMileDetails(
            int.parse(widget.tokenNo.toString()),
            context,
          );

      // Primary Miles
      final primaryMilesCompleted =
          double.tryParse(
            primarySecondaryMileModel?.primaryMilesCompleted ?? "0",
          ) ??
          0.0;

      final primaryMilesTotal =
          double.tryParse(
            primarySecondaryMileModel?.primaryMilesTotal ?? "0",
          ) ??
          0.0;

      primaryMileProgress = primaryMilesTotal > 0
          ? primaryMilesCompleted / primaryMilesTotal
          : 0.0;

      // Secondary Miles
      final secondaryMilesCompleted =
          double.tryParse(
            primarySecondaryMileModel?.secondaryMilesCompleted ?? "0",
          ) ??
          0.0;

      final secondaryMilesTotal =
          double.tryParse(
            primarySecondaryMileModel?.secondaryMilesTotal ?? "0",
          ) ??
          0.0;

      secondaryMileProgress = secondaryMilesTotal > 0
          ? secondaryMilesCompleted / secondaryMilesTotal
          : 0.0;
      final totalMiles = secondaryMilesTotal + primaryMilesTotal;
      //     secondaryFlex =
      //     totalMiles > 0 ? (secondaryMilesTotal / totalMiles * 1000).round() : 1;

      //  primaryFlex =
      //     totalMiles > 0 ? (primaryMilesTotal / totalMiles * 1000).round() : 1;

      secondaryFlex = totalMiles > 0
          ? math.max(1, (secondaryMilesTotal / totalMiles * 1000).round())
          : 1;

      primaryFlex = totalMiles > 0
          ? math.max(1, (primaryMilesTotal / totalMiles * 1000).round())
          : 1;
      setState(() {});
      print('flex value Miles: $secondaryFlex : $primaryFlex');
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _showMilesDialog(
    BuildContext context, {
    required String methodName,
    required double primaryCompleted,
    required double primaryMiles,
    required double secondaryCompleted,
    required double secondaryMiles,
    required double milesCompleted,
    required double totalMiles,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// Header
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        methodName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff073B78),
                        ),
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () => Navigator.pop(context),
                      child: const Padding(
                        padding: EdgeInsets.all(4),
                        child: Icon(Icons.close, size: 22, color: Colors.red),
                      ),
                    ),
                  ],
                ),

                const Divider(height: 20),
                _mileRow(
                  title: "Secondary",
                  completed: secondaryCompleted,
                  total: secondaryMiles,
                  color: Colors.orange,
                ),

                const SizedBox(height: 12),

                _mileRow(
                  title: "Primary",
                  completed: primaryCompleted,
                  total: primaryMiles,
                  color: Colors.blue,
                ),

                const SizedBox(height: 12),

                _mileRow(
                  title: "Total",
                  completed: milesCompleted,
                  total: totalMiles,
                  color: Colors.green,
                  isBold: true,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _mileRow({
    required String title,
    required double completed,
    required double total,
    required Color color,
    bool isBold = false,
  }) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 10),

        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
            ),
          ),
        ),

        Text(
          "${completed.toStringAsFixed(2)} / ${total.toStringAsFixed(2)}",
          style: TextStyle(
            fontSize: 15,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ],
    );
  }

  void _showMainSpanDialog(
    BuildContext context, {
    required String methodName,
    required String primaryCompleted,
    required String primarySpans,
    required String secondaryCompleted,
    required String secondarySpans,
    required String completedSpans,
    required String totalSpans,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// Header
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        methodName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff073B78),
                        ),
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () => Navigator.pop(context),
                      child: const Padding(
                        padding: EdgeInsets.all(4),
                        child: Icon(Icons.close, color: Colors.red),
                      ),
                    ),
                  ],
                ),

                const Divider(height: 20),
                _spanMainRow(
                  title: "Secondary",
                  completed: secondaryCompleted,
                  total: secondarySpans,
                  color: Colors.orange,
                ),

                const SizedBox(height: 12),
                _spanMainRow(
                  title: "Primary",
                  completed: primaryCompleted,
                  total: primarySpans,
                  color: Colors.blue,
                ),

                const SizedBox(height: 12),

                _spanMainRow(
                  title: "Total",
                  completed: completedSpans,
                  total: totalSpans,
                  color: Colors.green,
                  isBold: true,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _spanMainRow({
    required String title,
    required String completed,
    required String total,
    required Color color,
    bool isBold = false,
  }) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 10),

        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
            ),
          ),
        ),

        Text(
          "$completed / $total",
          style: TextStyle(
            fontSize: 15,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
