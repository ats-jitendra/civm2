import 'dart:convert';
import 'package:CIVM/piedmont/models/total_miles_model.dart';
import 'package:CIVM/piedmont/models/work_progress_by_miles.dart';
import 'package:CIVM/piedmont/models/work_progress_model.dart';
import 'package:CIVM/piedmont/resources/app_colors.dart';
import 'package:CIVM/piedmont/resources/app_url.dart';
import 'package:http/http.dart' as http;
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/////////////////////1111111111111111111111111111////////////////////////////////////////////////////////////////
class TotalMilesProgressCard extends StatefulWidget {
  final String jobNo;

  const TotalMilesProgressCard({
    super.key,
    required this.jobNo,
  });

  @override
  State<TotalMilesProgressCard> createState() =>
      _TotalMilesProgressCardState();
}

class _TotalMilesProgressCardState
    extends State<TotalMilesProgressCard> {
  TotalWorkProgressModel? workProgress;

  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      final data = await WorkProgressApi.getTotalWorkProgress(
        int.parse(widget.jobNo),
        context,
      );

      if (!mounted) return;

      setState(() {
        workProgress = data;
        loading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        loading = false;
      });

      debugPrint(
        "TotalWorkProgress Error: $e",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Padding(
        padding: const EdgeInsets.only(top:8.0),
        child: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.baseColor,
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: const Center(
            child: SizedBox(
              height: 22,
              width: 22,
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
          ),
        ),
      );
    }

    if (workProgress == null) {
      return const SizedBox.shrink();
    }

    final totalMiles = workProgress!.totalMiles;
    final completedMiles = workProgress!.completedMiles;
    final notRequiredMiles = workProgress!.notRequiredMiles;
    final sum = completedMiles + notRequiredMiles;

    return InkWell(
      onTap: () {
          _showTotalMilesProgressDialog(
      context,
      workProgress!,
    );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.baseColor,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total Miles",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.baseColor,
                  ),
                ),
      
                Text(
                  // "${completedMiles.toStringAsFixed(2)} / "
                  "${sum.toStringAsFixed(2)} / "
                  "${totalMiles.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.baseColor,
                  ),
                ),
              ],
            ),
      
            const SizedBox(height: 12),
      
            // Progress bar
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                height: 10,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (totalMiles <= 0) {
                      return Container(
                        color: Colors.grey.shade300,
                      );
                    }
            
                    final completedWidth =
                        constraints.maxWidth *
                            (completedMiles / totalMiles)
                                .clamp(0.0, 1.0);
            
                    final notRequiredWidth =
                        constraints.maxWidth *
                            (notRequiredMiles / totalMiles)
                                .clamp(0.0, 1.0);
            
                    return Stack(
                      children: [
                        // Pending / remaining
                        Container(
                          width: constraints.maxWidth,
                          height: 10,
                          color: Colors.grey.shade300,
                        ),
            
                        // Not Required
                        Positioned(
                          left: completedWidth,
                          child: Container(
                            width: notRequiredWidth,
                            height: 10,
                            color: Colors.blue,
                          ),
                        ),
            
                        // Completed
                        Container(
                          width: completedWidth,
                          height: 10,
                          color: AppColors.baseColor,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
      
           
          ],
        ),
      ),
    );
  }

 
  void _showTotalMilesProgressDialog(
  BuildContext context,
  TotalWorkProgressModel item,
) {
  final totalMiles = item.totalMiles;
  final completedMiles = item.completedMiles;
  final notRequiredMiles = item.notRequiredMiles;

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        contentPadding: const EdgeInsets.fromLTRB(
          20,
          10,
          20,
          5,
        ),
        actionsPadding: const EdgeInsets.fromLTRB(
          0,
          0,
          12,
          8,
        ),
        content: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _milesProgressRow(
                "Total Miles",
                totalMiles,
                AppColors.baseColor,
              ),

              const SizedBox(height: 12),

              _milesProgressRow(
                "Completed Miles",
                completedMiles,
                AppColors.baseColor,
              ),

              const SizedBox(height: 12),

              _milesProgressRow(
                "Not Required Miles",
                notRequiredMiles,
                Colors.blue,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "Close",
              style: TextStyle(
                color: AppColors.baseColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      );
    },
  );
}
Widget _milesProgressRow(
  String title,
  double value,
  Color color,
) {
  return Row(
    children: [
      Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(3),
        ),
      ),

      const SizedBox(width: 10),

      Expanded(
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      Text(
        value.toStringAsFixed(2),
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    ],
  );
}
 }

//////////////////////////////////////////////////////////////////////////////
class WorkProgressBySpan extends StatefulWidget {
  final String jobNo;

  const WorkProgressBySpan({super.key, required this.jobNo});

  @override
  State<WorkProgressBySpan> createState() => _WorkProgressBySpanState();
}

class _WorkProgressBySpanState extends State<WorkProgressBySpan> {
  List<WorkProgressModel> list = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 8.0, top: 8),
          child: Text(
            "Work Progress By Span",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.baseColor,
            ),
          ),
        ),

        const SizedBox(height: 10),

        if (loading)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: CircularProgressIndicator(),
            ),
          )
        else if (list.isEmpty)
          const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: Text("No work progress data available")),
          )
        else
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: list.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 2,
              crossAxisSpacing: 2,
              mainAxisExtent: 75,
            ),
            itemBuilder: (context, index) {
              final item = list[index];

              // final progress = item.totalSpans == 0
              //     ? 0.0
              //     : item.completedSpans / item.totalSpans;

              final totalSpans = item.totalSpans;
              final completedSpans = item.completedSpans;
              final notRequiredSpans = item.notRequiredSpans;
              final sum = completedSpans + notRequiredSpans;

              return InkWell(
                 onTap: () {
                              _showMilesProgressDialog(context, item);
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
                      Row(
                        children: [
                          const Icon(
                            Icons.engineering,
                            color: AppColors.baseColor,
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
                
                      Row(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: SizedBox(
                                height: 6,
                                child: Row(
                                  children: [
                                    // COMPLETED
                                    Expanded(
                                      flex: completedSpans,
                                      child: Container(
                                        color: AppColors.baseColor,
                                      ),
                                    ),
                            
                                    // NOT REQUIRED
                                    Expanded(
                                      flex: notRequiredSpans,
                                      child: Container(color: Colors.blue),
                                    ),
                            
                                    // REMAINING
                                    Expanded(
                                      flex:
                                          totalSpans -
                                          completedSpans -
                                          notRequiredSpans,
                                      child: Container(
                                        color: Colors.grey.shade200,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                
                          SizedBox(
                            width: 55,
                            child: Text(
                              "$sum/${item.totalSpans}",
                              // "${item.completedSpans}/${item.totalSpans}",
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
    );
  }

  Future<void> loadData() async {
  try {
    debugPrint(
      "WorkProgressBySpan widget.jobNo = ${widget.jobNo}",
    );

    final data = await WorkProgressApi.getWorkProgress(
      int.parse(widget.jobNo),
      context,
    );

    debugPrint(
      "WorkProgressBySpan received ${data.length} records",
    );

    if (!mounted) return;

    setState(() {
      list = data;
      loading = false;
    });
  } catch (e) {
    if (!mounted) return;

    setState(() {
      loading = false;
    });

    debugPrint(
      "WorkProgressApiCATCH: $e",
    );
  }
}
  void _showMilesProgressDialog(BuildContext context, WorkProgressModel item) {
    final totalSpans = item.totalSpans;
    final completedSpans = item.completedSpans;
    final notRequiredSpans = item.notRequiredSpans;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
          actionsPadding: const EdgeInsets.fromLTRB(0, 0, 12, 8),
          content: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _milesProgressRow(
                  "Total Spans",
                  totalSpans,
                  AppColors.baseColor,
                ),

                const SizedBox(height: 12),

                _milesProgressRow(
                  "Completed Spans",
                  completedSpans,
                  AppColors.baseColor,
                ),

                const SizedBox(height: 12),

                _milesProgressRow(
                  "Not Required Spans",
                  notRequiredSpans,
                  Colors.blue,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Close",
                style: TextStyle(
                  color: AppColors.baseColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _milesProgressRow(String title, int value, Color color) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ),

        Text(
          value.toStringAsFixed(2),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}

/////////////////////////////////////////////////////////////////////////////////
class WorkProgressByMiles extends StatefulWidget {
  final String jobNo;

  const WorkProgressByMiles({super.key, required this.jobNo});

  @override
  State<WorkProgressByMiles> createState() => _WorkProgressByMilesState();
}

class _WorkProgressByMilesState extends State<WorkProgressByMiles> {
  List<WorkProgressByMilesModel> listWorkProgressByMiles = [];

  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadDataMiles();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),

        const Padding(
          padding: EdgeInsets.only(left: 8.0, top: 8),
          child: Text(
            "Work Progress By Miles",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.baseColor,
            ),
          ),
        ),

        const SizedBox(height: 10),

        if (loading)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: CircularProgressIndicator(),
            ),
          )
        else if (listWorkProgressByMiles.isEmpty)
          const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: Text("No work progress data available")),
          )
        else
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: listWorkProgressByMiles.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 2,
              crossAxisSpacing: 2,
              mainAxisExtent: 75,
            ),
            itemBuilder: (context, index) {
              final item = listWorkProgressByMiles[index];

              final totalMiles = item.totalMiles ?? 0.0;
              final completedMiles = item.completedMiles ?? 0.0;
              final notRequiredMiles = item.notRequiredMiles ?? 0.0;
              final sum = completedMiles+ notRequiredMiles;

              return InkWell(
                                            onTap: () {
                              _showMilesProgressDialog(context, item);
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
                            color: AppColors.baseColor,
                            size: 18,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              item.maintType ?? "",
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
                      Row(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: SizedBox(
                                height: 6,
                                child: LayoutBuilder(
                                  builder: (context, constraints) {
                                    if (totalMiles <= 0) {
                                      return Container(
                                        color: Colors.grey.shade200,
                                      );
                                    }
                            
                                    final completedWidth =
                                        constraints.maxWidth *
                                        (completedMiles / totalMiles);
                            
                                    final notRequiredWidth =
                                        constraints.maxWidth *
                                        (notRequiredMiles / totalMiles);
                            
                                    return Stack(
                                      children: [
                                        /// REMAINING
                                        Container(
                                          width: constraints.maxWidth,
                                          color: Colors.grey.shade200,
                                        ),
                            
                                        /// NOT REQUIRED
                                        Positioned(
                                          left: completedWidth,
                                          child: Container(
                                            width: notRequiredWidth,
                                            height: 6,
                                            color: Colors.blue,
                                          ),
                                        ),
                            
                                        /// COMPLETED
                                        Container(
                                          width: completedWidth,
                                          height: 6,
                                          color: AppColors.baseColor,
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                
                          const SizedBox(width: 8),
                
                          /// TOTAL
                          SizedBox(
                            width: 55,
                            child: Text(
                              "${sum.toStringAsFixed(2)}/${totalMiles.toStringAsFixed(2)}",
                              // "${completedMiles.toStringAsFixed(2)}/${totalMiles.toStringAsFixed(2)}",
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
    );
  }

  Future<void> loadDataMiles() async {
    try {
      final data = await WorkProgressApi.getWorkProgressByMiles(
        int.parse(widget.jobNo),
        context,
      );

      if (!mounted) return;

      setState(() {
        listWorkProgressByMiles = data;
        loading = false;
      });

      debugPrint('WorkProgressByMilesApi111');
    } catch (e) {
      if (!mounted) return;

      setState(() {
        loading = false;
      });

      debugPrint('WorkProgressByMilesApiCATCH');
      debugPrint(e.toString());
    }
  }

  void _showMilesProgressDialog(
    BuildContext context,
    WorkProgressByMilesModel item,
  ) {
    final totalMiles = item.totalMiles ?? 0.0;
    final completedMiles = item.completedMiles ?? 0.0;
    final notRequiredMiles = item.notRequiredMiles ?? 0.0;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),

          contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 5),

          actionsPadding: const EdgeInsets.fromLTRB(0, 0, 12, 8),

          content: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _milesProgressRow(
                  "Total Miles",
                  totalMiles,
                  AppColors.baseColor,
                ),

                const SizedBox(height: 12),

                _milesProgressRow(
                  "Completed Miles",
                  completedMiles,
                  AppColors.baseColor,
                ),

                const SizedBox(height: 12),

                _milesProgressRow(
                  "Not Required Miles",
                  notRequiredMiles,
                  Colors.blue,
                ),
              ],
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Close",
                style: TextStyle(
                  color: AppColors.baseColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _milesProgressRow(String title, double value, Color color) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ),

        Text(
          value.toStringAsFixed(2),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}

//////////////////////////////////////////////////////////////////
class WorkProgressApi {

  static Future<List<WorkProgressModel>> getWorkProgress(
  int jobNo,
  BuildContext context,
) async {
  final userPreferences = Provider.of<UserPref>(
    context,
    listen: false,
  );

  UserModel data = await userPreferences.getUser();

  final url = Uri.parse(
    AppUrl.workProgressByMaintType,
  ).replace(
    queryParameters: {
      "jobNo": jobNo.toString(),
    },
  );

  debugPrint("======================================");
  debugPrint("Work Progress Job No: $jobNo");
  debugPrint("Work Progress URL: $url");
  debugPrint("======================================");

  final response = await http.get(
    url,
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${data.token!}",
    },
  );

  debugPrint(
    "Work Progress Status Code: ${response.statusCode}",
  );

  debugPrint(
    "Work Progress Response: ${response.body}",
  );

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);

    debugPrint(
      "Work Progress status: ${jsonData["status"]}",
    );

    debugPrint(
      "Work Progress message: ${jsonData["message"]}",
    );

    debugPrint(
      "Work Progress data: ${jsonData["data"]}",
    );

    final rawData = jsonData["data"];

    if (rawData == null) {
      return [];
    }

    if (rawData is! List) {
      throw Exception(
        "Invalid work progress data format",
      );
    }

    return rawData
        .map(
          (e) => WorkProgressModel.fromJson(
            e,
          ),
        )
        .toList();
  } else {
    throw Exception(
      "Unable to load data. Status: ${response.statusCode}",
    );
  }
}
  
  static Future<List<WorkProgressByMilesModel>> getWorkProgressByMiles(
    int jobNo,
    BuildContext context,
  ) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    final response = await http.get(
      Uri.parse(
        AppUrl.workProgressByMiles,
      ).replace(queryParameters: {"jobNo": jobNo.toString()}),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${data.token!}",
      },
    );

    if (response.statusCode == 200) {
      print('work progress by miles: ${response.body}');
      final jsonData = jsonDecode(response.body);

      List list = jsonData["data"];

      return list.map((e) => WorkProgressByMilesModel.fromJson(e)).toList();
    } else {
      throw Exception("Unable to load data");
    }
  }

  static Widget statusBox(String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }
  
   static Future<TotalWorkProgressModel> getTotalWorkProgress(
    int jobNo,
    BuildContext context,
  ) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);

    UserModel data = await userPreferences.getUser();

    final response = await http.get(
      Uri.parse(
        AppUrl.totalWorkProgress,
      ).replace(queryParameters: {"jobNo": jobNo.toString()}),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${data.token!}",
      },
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      return TotalWorkProgressModel.fromJson(jsonData["data"]);
    } else {
      throw Exception("Unable to load total work progress");
    }
  }
}




class ProgressDialog {
  static void show(
    BuildContext context, {
    required String jobNo,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.85,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.green2,
                        AppColors.pinkColor
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    children: [
                       Expanded(
                        child: Text(
                          "Work Progress of Job no. $jobNo",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(dialogContext).pop();
                        },
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                    ],
                  ),
                ),

                // Content
                Flexible(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TotalMilesProgressCard(
                          jobNo: jobNo,
                        ),

                        const SizedBox(height: 12),

                        WorkProgressBySpan(
                          jobNo: jobNo,
                        ),

                        const SizedBox(height: 12),

                        WorkProgressByMiles(
                          jobNo: jobNo,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}