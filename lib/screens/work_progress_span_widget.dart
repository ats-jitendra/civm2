import 'package:CIVM/models/primary_secondary_mile_model.dart';
import 'package:CIVM/models/work_progress_model.dart';
import 'package:CIVM/utils/work_progress_api.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class WorkProgressSpanWidget extends StatefulWidget {
  final String tokenNo;

  const WorkProgressSpanWidget({super.key, required this.tokenNo});

  @override
  State<WorkProgressSpanWidget> createState() => _WorkProgressSpanWidgetState();
}

class _WorkProgressSpanWidgetState extends State<WorkProgressSpanWidget> {
  bool loading = true;

  List<WorkProgressModel> list = [];

  PrimarySecondaryMileModel? primarySecondaryMileModel;

  double primarySpanProgress = 0.0;
  double secondarySpanProgress = 0.0;

  int primaryFlex = 1;
  int secondaryFlex = 1;

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

  @override
  void initState() {
    super.initState();
    loadData();
    loadPrimarySecondaryMiles();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return loading
        ? const Center(child: CircularProgressIndicator())
        : Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      "Work Progress by Span",
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
                      methodName: "TOTAL SPAN",
                      primaryCompleted:
                          "${primarySecondaryMileModel?.primarySpanCompleted ?? "0"}",
                      primarySpans:
                          "${primarySecondaryMileModel?.primarySpanTotal ?? "0"}",
                      secondaryCompleted:
                          "${primarySecondaryMileModel?.secondarySpanCompleted ?? "0"}",
                      secondarySpans:
                          "${primarySecondaryMileModel?.secondarySpanTotal ?? "0"}",
                      completedSpans:
                          "${primarySecondaryMileModel?.totalSpanCompleted ?? "0"}",
                      totalSpans:
                          "${primarySecondaryMileModel?.totalSpanTotal ?? "0"}",
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 6, left: 2, right: 2),
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
                              "TOTAL SPAN",
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
                                    value: secondarySpanProgress,
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
                                              ?.primarySpanTotal ??
                                          "0") !=
                                      "0" &&
                                  (primarySecondaryMileModel
                                              ?.secondarySpanTotal ??
                                          "0") !=
                                      "0")
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
                                                ?.secondarySpanTotal ==
                                            "0.0")
                                        ? Radius.circular(10)
                                        : Radius.circular(0),
                                    bottomLeft:
                                        (primarySecondaryMileModel
                                                ?.secondarySpanTotal ==
                                            "0.0")
                                        ? Radius.circular(10)
                                        : Radius.circular(0),
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                  child: LinearProgressIndicator(
                                    value: primarySpanProgress,
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
                          "${primarySecondaryMileModel?.secondarySpanTotal ?? "0"}/"
                          "${primarySecondaryMileModel?.primarySpanTotal ?? "0"}/"
                          "${primarySecondaryMileModel?.totalSpanTotal ?? "0"}",
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: list.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 👈 2 in a row
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2,
                    // childAspectRatio:
                    //     2.2, // adjust height
                    mainAxisExtent: 75,
                  ),
                  itemBuilder: (context, index) {
                    final item = list[index];

                    // final progress =
                    //     item.totalSpans == 0
                    //     ? 0.0
                    //     : item.completedSpans /
                    //           item.totalSpans;
                    final double primarySpans = item.primarySpans.toDouble();
                    final double secondarySpans = item.secondarySpans
                        .toDouble();

                    final double primaryCompleted = item.primaryCompleted
                        .toDouble();
                    final double secondaryCompleted = item.secondaryCompleted
                        .toDouble();

                    final double totalSpans = primarySpans + secondarySpans;

                    final double primaryProgress = primarySpans == 0
                        ? 0
                        : primaryCompleted / primarySpans;

                    final double secondaryProgress = secondarySpans == 0
                        ? 0
                        : secondaryCompleted / secondarySpans;

                    final int primaryFlex = totalSpans > 0
                        ? math.max(
                            1,
                            (primarySpans / totalSpans * 1000).round(),
                          )
                        : 1;

                    final int secondaryFlex = totalSpans > 0
                        ? math.max(
                            1,
                            (secondarySpans / totalSpans * 1000).round(),
                          )
                        : 1;
                    final Color methodColor =
                        methodColors[item.maintType.toUpperCase()] ??
                        Colors.blue;
                    return GestureDetector(
                      onTap: (){
                         _showSpanDialog(
                                context,
                                methodName: item.maintType,
                                primaryCompleted: item.primaryCompleted,
                                primarySpans: item.primarySpans,
                                secondaryCompleted: item.secondaryCompleted,
                                secondarySpans: item.secondarySpans,
                                completedSpans: item.completedSpans,
                                totalSpans: item.totalSpans,
                              );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.grey.shade200),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// ICON + TITLE
                            Row(
                              children: [
                                const Icon(
                                  Icons.engineering,
                                  color: Color(0xff073B78),
                                  size: 18,
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    item.maintType,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                      
                            const SizedBox(height: 10),
                      
                            /// PROGRESS BAR
                            // Row(
                            //   children: [
                            //     Expanded(
                            //       child: ClipRRect(
                            //         borderRadius:
                            //             BorderRadius.circular(
                            //               10,
                            //             ),
                            //         child: LinearProgressIndicator(
                            //           value: progress,
                            //           minHeight: 5,
                            //           backgroundColor:
                            //               Colors
                            //                   .grey
                            //                   .shade200,
                            //           valueColor:
                            //               AlwaysStoppedAnimation(
                            //                 methodColor,
                            //               ),
                            //         ),
                            //       ),
                            //     ),
                      
                            //     const SizedBox(width: 8),
                      
                            //     /// COUNT
                            //     SizedBox(
                            //       width: 55,
                            //       child: Text(
                            //         "${item.completedSpans}/${item.totalSpans}",
                            //         textAlign:
                            //             TextAlign.end,
                            //         style: TextStyle(
                            //           fontSize: 11,
                            //           color: Colors
                            //               .grey
                            //               .shade700,
                            //           fontWeight:
                            //               FontWeight.w500,
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            Row(
                              children: [
                                /// Secondary Section
                                Expanded(
                                  flex: secondaryFlex,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                    ),
                                    child: LinearProgressIndicator(
                                      value: secondaryProgress,
                                      minHeight: 6,
                                      backgroundColor: Colors.grey.shade300,
                                      valueColor: AlwaysStoppedAnimation(
                                        methodColor.withOpacity(.65),
                                      ),
                                    ),
                                  ),
                                ),
                                                  
                                if (primarySpans > 0 && secondarySpans > 0)
                                  Container(
                                    width: 1,
                                    height: 6,
                                    color: Colors.black,
                                  ),
                                                  
                                /// Primary Section
                                Expanded(
                                  flex: primaryFlex,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: (item.secondarySpans == 0)
                                          ? Radius.circular(10)
                                          : Radius.circular(0),
                                      bottomLeft: (item.secondarySpans == 0)
                                          ? Radius.circular(10)
                                          : Radius.circular(0),
                                      topRight: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                    child: LinearProgressIndicator(
                                      value: primaryProgress,
                                      minHeight: 6,
                                      backgroundColor: Colors.grey.shade300,
                                      valueColor: AlwaysStoppedAnimation(
                                        methodColor,
                                      ),
                                    ),
                                  ),
                                ),
                                                  
                                /// COUNT
                                SizedBox(
                                  width:
                                      65, // Increased width to fit all three values
                                  child: Text(
                                    "${item.secondarySpans}/${item.primarySpans}/${item.totalSpans}",
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey.shade700,
                                      fontWeight: FontWeight.w500,
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
                ),
              ],
            ),
          );
  }

  Future<void> loadData() async {
    try {
      list = await WorkProgressApi.getWorkProgress(
        int.parse(widget.tokenNo.toString()),
        context,
      );

      setState(() {
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });

      debugPrint(e.toString());
    }
  }

  void _showSpanDialog(
    BuildContext context, {
    required String methodName,
    required int primaryCompleted,
    required int primarySpans,
    required int secondaryCompleted,
    required int secondarySpans,
    required int completedSpans,
    required int totalSpans,
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
                _spanRow(
                  title: "Secondary",
                  completed: secondaryCompleted,
                  total: secondarySpans,
                  color: Colors.orange,
                ),

                const SizedBox(height: 12),
                _spanRow(
                  title: "Primary",
                  completed: primaryCompleted,
                  total: primarySpans,
                  color: Colors.blue,
                ),

                const SizedBox(height: 12),

                _spanRow(
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

  Widget _spanRow({
    required String title,
    required int completed,
    required int total,
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

  Future<void> loadPrimarySecondaryMiles() async {
    try {
      primarySecondaryMileModel =
          await WorkProgressApi.getPrimarySecondaryMileDetails(
            int.parse(widget.tokenNo.toString()),
            context,
          );

      final primarySpanCompleted =
          double.tryParse(
            primarySecondaryMileModel?.primarySpanCompleted ?? "0",
          ) ??
          0.0;

      final primarySpanTotal =
          double.tryParse(primarySecondaryMileModel?.primarySpanTotal ?? "0") ??
          0.0;

      primarySpanProgress = primarySpanTotal > 0
          ? primarySpanCompleted / primarySpanTotal
          : 0.0;

      // Secondary Span
      final secondarySpanCompleted =
          double.tryParse(
            primarySecondaryMileModel?.secondarySpanCompleted ?? "0",
          ) ??
          0.0;

      final secondarySpanTotal =
          double.tryParse(
            primarySecondaryMileModel?.secondarySpanTotal ?? "0",
          ) ??
          0.0;

      secondarySpanProgress = secondarySpanTotal > 0
          ? secondarySpanCompleted / secondarySpanTotal
          : 0.0;

      final totalSpan = secondarySpanTotal + primarySpanTotal;
      secondaryFlex = totalSpan > 0
          ? math.max(1, (secondarySpanTotal / totalSpan * 1000).round())
          : 1;

      primaryFlex = totalSpan > 0
          ? math.max(1, (primarySpanTotal / totalSpan * 1000).round())
          : 1;

      setState(() {});
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
