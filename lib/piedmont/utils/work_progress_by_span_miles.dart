// import 'package:CIVM/piedmont/models/work_progress_by_miles.dart';
// import 'package:CIVM/piedmont/models/work_progress_model.dart';
// import 'package:CIVM/piedmont/resources/app_colors.dart';
// import 'package:flutter/material.dart';

// //////////////////////////////////////////////////////////////////////////////
// class WorkProgressBySpan extends StatefulWidget {
//   final String jobNo;

//   const WorkProgressBySpan({super.key, required this.jobNo});

//   @override
//   State<WorkProgressBySpan> createState() => _WorkProgressBySpanState();
// }

// class _WorkProgressBySpanState extends State<WorkProgressBySpan> {
//   List<WorkProgressModel> list = [];
//   bool loading = true;

//   @override
//   void initState() {
//     super.initState();
//     loadData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Padding(
//           padding: EdgeInsets.only(left: 8.0, top: 8),
//           child: Text(
//             "Work Progress By Span",
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: AppColors.baseColor,
//             ),
//           ),
//         ),

//         const SizedBox(height: 10),

//         if (loading)
//           const Center(
//             child: Padding(
//               padding: EdgeInsets.all(20),
//               child: CircularProgressIndicator(),
//             ),
//           )
//         else if (list.isEmpty)
//           const Padding(
//             padding: EdgeInsets.all(16),
//             child: Center(child: Text("No work progress data available")),
//           )
//         else
//           GridView.builder(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: list.length,
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               mainAxisSpacing: 2,
//               crossAxisSpacing: 2,
//               mainAxisExtent: 75,
//             ),
//             itemBuilder: (context, index) {
//               final item = list[index];

//               // final progress = item.totalSpans == 0
//               //     ? 0.0
//               //     : item.completedSpans / item.totalSpans;

//               final totalSpans = item.totalSpans;
//               final completedSpans = item.completedSpans;
//               final notRequiredSpans = item.notRequiredSpans;

//               return Container(
//                 padding: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(14),
//                   border: Border.all(color: Colors.grey.shade200),
//                   color: Colors.white,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.04),
//                       blurRadius: 8,
//                       offset: const Offset(0, 3),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         const Icon(
//                           Icons.engineering,
//                           color: AppColors.baseColor,
//                           size: 18,
//                         ),
//                         const SizedBox(width: 6),
//                         Expanded(
//                           child: Text(
//                             item.maintType,
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                             style: const TextStyle(
//                               fontWeight: FontWeight.w600,
//                               fontSize: 10,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),

//                     const SizedBox(height: 10),

//                     Row(
//                       children: [
//                         Expanded(
//                           child: InkWell(
//                             onTap: () {
//                               _showMilesProgressDialog(context, item);
//                             },
//                             borderRadius: BorderRadius.circular(10),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(10),
//                               child: SizedBox(
//                                 height: 6,
//                                 child: Row(
//                                   children: [
//                                     // COMPLETED
//                                     Expanded(
//                                       flex: completedSpans,
//                                       child: Container(
//                                         color: AppColors.baseColor,
//                                       ),
//                                     ),

//                                     // NOT REQUIRED
//                                     Expanded(
//                                       flex: notRequiredSpans,
//                                       child: Container(color: Colors.blue),
//                                     ),

//                                     // REMAINING
//                                     Expanded(
//                                       flex:
//                                           totalSpans -
//                                           completedSpans -
//                                           notRequiredSpans,
//                                       child: Container(
//                                         color: Colors.grey.shade200,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 8),

//                         SizedBox(
//                           width: 55,
//                           child: Text(
//                             "${item.completedSpans}/${item.totalSpans}",
//                             textAlign: TextAlign.end,
//                             style: TextStyle(
//                               fontSize: 11,
//                               color: Colors.grey.shade700,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//       ],
//     );
//   }

//   Future<void> loadData() async {
//     try {
//       final data = await WorkProgressApi.getWorkProgress(
//         int.parse(widget.jobNo),
//         context,
//       );

//       if (!mounted) return;

//       setState(() {
//         list = data;
//         loading = false;
//       });

//       debugPrint('WorkProgressApi111');
//     } catch (e) {
//       if (!mounted) return;

//       setState(() {
//         loading = false;
//       });

//       debugPrint('WorkProgressApiCATCH');
//       debugPrint(e.toString());
//     }
//   }

//   void _showMilesProgressDialog(BuildContext context, WorkProgressModel item) {
//     final totalSpans = item.totalSpans;
//     final completedSpans = item.completedSpans;
//     final notRequiredSpans = item.notRequiredSpans;

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(18),
//           ),
//           contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
//           actionsPadding: const EdgeInsets.fromLTRB(0, 0, 12, 8),
//           content: Padding(
//             padding: const EdgeInsets.only(top:16.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 _milesProgressRow("Total Spans", totalSpans, AppColors.baseColor),
            
//                 const SizedBox(height: 12),
            
//                 _milesProgressRow(
//                   "Completed Spans",
//                   completedSpans,
//                   AppColors.baseColor,
//                 ),
            
//                 const SizedBox(height: 12),
            
//                 _milesProgressRow(
//                   "Not Required Spans",
//                   notRequiredSpans,
//                   Colors.blue,
//                 ),
//               ],
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text(
//                 "Close",
//                 style: TextStyle(
//                   color: AppColors.baseColor,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget _milesProgressRow(String title, int value, Color color) {
//     return Row(
//       children: [
//         Container(
//           width: 10,
//           height: 10,
//           decoration: BoxDecoration(color: color, shape: BoxShape.circle),
//         ),

//         const SizedBox(width: 10),

//         Expanded(
//           child: Text(
//             title,
//             style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
//           ),
//         ),

//         Text(
//           value.toStringAsFixed(2),
//           style: TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.bold,
//             color: color,
//           ),
//         ),
//       ],
//     );
//   }
// }

// /////////////////////////////////////////////////////////////////////////////////
// class WorkProgressByMiles extends StatefulWidget {
//   final String jobNo;

//   const WorkProgressByMiles({super.key, required this.jobNo});

//   @override
//   State<WorkProgressByMiles> createState() => _WorkProgressByMilesState();
// }

// class _WorkProgressByMilesState extends State<WorkProgressByMiles> {
//   List<WorkProgressByMilesModel> listWorkProgressByMiles = [];

//   bool loading = true;

//   @override
//   void initState() {
//     super.initState();
//     loadDataMiles();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SizedBox(height: 8),

//         const Padding(
//           padding: EdgeInsets.only(left: 8.0, top: 8),
//           child: Text(
//             "Work Progress By Miles",
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: AppColors.baseColor,
//             ),
//           ),
//         ),

//         const SizedBox(height: 10),

//         if (loading)
//           const Center(
//             child: Padding(
//               padding: EdgeInsets.all(20),
//               child: CircularProgressIndicator(),
//             ),
//           )
//         else if (listWorkProgressByMiles.isEmpty)
//           const Padding(
//             padding: EdgeInsets.all(16),
//             child: Center(child: Text("No work progress data available")),
//           )
//         else
//           GridView.builder(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: listWorkProgressByMiles.length,
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               mainAxisSpacing: 2,
//               crossAxisSpacing: 2,
//               mainAxisExtent: 75,
//             ),
//             itemBuilder: (context, index) {
//               final item = listWorkProgressByMiles[index];

//               final totalMiles = item.totalMiles ?? 0.0;
//               final completedMiles = item.completedMiles ?? 0.0;
//               final notRequiredMiles = item.notRequiredMiles ?? 0.0;

//               return Container(
//                 padding: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(14),
//                   border: Border.all(color: Colors.grey.shade200),
//                   color: Colors.white,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.04),
//                       blurRadius: 8,
//                       offset: const Offset(0, 3),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     /// ICON + TITLE
//                     Row(
//                       children: [
//                         const Icon(
//                           Icons.engineering,
//                           color: AppColors.baseColor,
//                           size: 18,
//                         ),
//                         const SizedBox(width: 6),
//                         Expanded(
//                           child: Text(
//                             item.maintType ?? "",
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                             style: const TextStyle(
//                               fontWeight: FontWeight.w600,
//                               fontSize: 10,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),

//                     const SizedBox(height: 10),

//                     /// PROGRESS BAR
//                     Row(
//                       children: [
//                         Expanded(
//                           child: InkWell(
//                             onTap: () {
//                               _showMilesProgressDialog(context, item);
//                             },
//                             borderRadius: BorderRadius.circular(10),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(10),
//                               child: SizedBox(
//                                 height: 6,
//                                 child: LayoutBuilder(
//                                   builder: (context, constraints) {
//                                     if (totalMiles <= 0) {
//                                       return Container(
//                                         color: Colors.grey.shade200,
//                                       );
//                                     }

//                                     final completedWidth =
//                                         constraints.maxWidth *
//                                         (completedMiles / totalMiles);

//                                     final notRequiredWidth =
//                                         constraints.maxWidth *
//                                         (notRequiredMiles / totalMiles);

//                                     return Stack(
//                                       children: [
//                                         /// REMAINING
//                                         Container(
//                                           width: constraints.maxWidth,
//                                           color: Colors.grey.shade200,
//                                         ),

//                                         /// NOT REQUIRED
//                                         Positioned(
//                                           left: completedWidth,
//                                           child: Container(
//                                             width: notRequiredWidth,
//                                             height: 6,
//                                             color: Colors.blue,
//                                           ),
//                                         ),

//                                         /// COMPLETED
//                                         Container(
//                                           width: completedWidth,
//                                           height: 6,
//                                           color: AppColors.baseColor,
//                                         ),
//                                       ],
//                                     );
//                                   },
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),

//                         const SizedBox(width: 8),

//                         /// TOTAL
//                         SizedBox(
//                           width: 55,
//                           child: Text(
//                             "${completedMiles.toStringAsFixed(2)}/${totalMiles.toStringAsFixed(2)}",
//                             textAlign: TextAlign.end,
//                             style: TextStyle(
//                               fontSize: 11,
//                               color: Colors.grey.shade700,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//       ],
//     );
//   }

//   Future<void> loadDataMiles() async {
//     try {
//       final data = await WorkProgressApi.getWorkProgressByMiles(
//         int.parse(widget.jobNo),
//         context,
//       );

//       if (!mounted) return;

//       setState(() {
//         listWorkProgressByMiles = data;
//         loading = false;
//       });

//       debugPrint('WorkProgressByMilesApi111');
//     } catch (e) {
//       if (!mounted) return;

//       setState(() {
//         loading = false;
//       });

//       debugPrint('WorkProgressByMilesApiCATCH');
//       debugPrint(e.toString());
//     }
//   }

//   void _showMilesProgressDialog(
//     BuildContext context,
//     WorkProgressByMilesModel item,
//   ) {
//     final totalMiles = item.totalMiles ?? 0.0;
//     final completedMiles = item.completedMiles ?? 0.0;
//     final notRequiredMiles = item.notRequiredMiles ?? 0.0;

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(18),
//           ),

//           contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 5),

//           actionsPadding: const EdgeInsets.fromLTRB(0, 0, 12, 8),

//           content: Padding(
//             padding: const EdgeInsets.only(top: 16.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 _milesProgressRow(
//                   "Total Miles",
//                   totalMiles,
//                   AppColors.baseColor,
//                 ),

//                 const SizedBox(height: 12),

//                 _milesProgressRow(
//                   "Completed Miles",
//                   completedMiles,
//                   AppColors.baseColor,
//                 ),

//                 const SizedBox(height: 12),

//                 _milesProgressRow(
//                   "Not Required Miles",
//                   notRequiredMiles,
//                   Colors.blue,
//                 ),
//               ],
//             ),
//           ),

//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text(
//                 "Close",
//                 style: TextStyle(
//                   color: AppColors.baseColor,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget _milesProgressRow(String title, double value, Color color) {
//     return Row(
//       children: [
//         Container(
//           width: 10,
//           height: 10,
//           decoration: BoxDecoration(color: color, shape: BoxShape.circle),
//         ),

//         const SizedBox(width: 10),

//         Expanded(
//           child: Text(
//             title,
//             style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
//           ),
//         ),

//         Text(
//           value.toStringAsFixed(2),
//           style: TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.bold,
//             color: color,
//           ),
//         ),
//       ],
//     );
//   }
// }
