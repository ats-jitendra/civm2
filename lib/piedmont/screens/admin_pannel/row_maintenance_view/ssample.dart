import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeeklyMilesScreen extends StatefulWidget {
  const WeeklyMilesScreen({super.key});

  @override
  State<WeeklyMilesScreen> createState() => _WeeklyMilesScreenState();
}

class _WeeklyMilesScreenState extends State<WeeklyMilesScreen> {

  List<MileageModel> data = [];

  /// ALL WEEK COLUMNS
  List<String> weekColumns = [];

  @override
  void initState() {
    super.initState();
    fetchWeeklyMilesData();
  }

  /// FETCH API
  Future<void> fetchWeeklyMilesData() async {

    final url = Uri.parse(
      'http://localhost:5125/civmapi/getDashboardWeeklyMilesData?year=2026',
    );

    try {

      final response = await http.get(url);

      if (response.statusCode == 200) {

        List jsonData = jsonDecode(response.body);

        data = jsonData
            .map((e) => MileageModel.fromJson(e))
            .toList();

        /// GET ALL UNIQUE WEEK DATES
        Set<String> allWeeks = {};

        for (var item in data) {
          allWeeks.addAll(item.weeks.keys);
        }

        weekColumns = allWeeks.toList();

        /// SORT DATE
        weekColumns.sort();

        setState(() {});
      }

    } catch (e) {
      debugPrint("ERROR : $e");
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Weekly Miles Table"),
      ),

      body: data.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(12),

        child: Card(

          elevation: 5,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),

          child: Padding(
            padding: const EdgeInsets.all(12),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                cardHeader("Table Data"),

                const SizedBox(height: 12),

                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,

                    child: SingleChildScrollView(
                      child: Table(

                        border: TableBorder.all(
                          color: Colors.grey,
                        ),

                        defaultVerticalAlignment:
                        TableCellVerticalAlignment.middle,

                        columnWidths: {

                          0: const FixedColumnWidth(150),
                          1: const FixedColumnWidth(180),
                          2: const FixedColumnWidth(100),
                          3: const FixedColumnWidth(120),

                          /// DYNAMIC WEEK COLUMNS
                          for (int i = 0; i < weekColumns.length; i++)
                            i + 4: const FixedColumnWidth(110),
                        },

                        children: [

                          /// HEADER
                          TableRow(

                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 241, 174, 85),
                            ),

                            children: [

                              headerCell("Substation"),
                              headerCell("Feeder"),
                              headerCell("Circuit"),
                              headerCell("Total Miles"),

                              ...weekColumns.map(
                                    (e) => headerCell(e),
                              ),

                            ],
                          ),

                          /// DATA ROWS
                          ...data.map((item) {

                            return TableRow(

                              children: [

                                tableCell(item.substation),

                                tableCell(item.feeder),

                                tableCell(item.circuitNo),

                                tableCell(
                                  item.totalMiles.toString(),
                                ),

                                ...weekColumns.map(

                                      (week) => tableCell(
                                    item.weeks[week]
                                        ?.toString() ??
                                        '0',
                                  ),

                                ),

                              ],
                            );
                          }).toList(),
                        ],
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

  /// HEADER CELL
  Widget headerCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  /// TABLE CELL
  Widget tableCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(text),
    );
  }

  /// CARD HEADER
  Widget cardHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

/// MAIN MODEL
class MileageModel {

  final String substation;
  final String feeder;
  final String circuitNo;
  final double totalMiles;

  /// KEY = DATE
  /// VALUE = MILES
  final Map<String, dynamic> weeks;

  MileageModel({
    required this.substation,
    required this.feeder,
    required this.circuitNo,
    required this.totalMiles,
    required this.weeks,
  });

  factory MileageModel.fromJson(Map<String, dynamic> json) {

    /// CONVERT WeeklyMiles LIST TO MAP
    Map<String, dynamic> weekMap = {};

    if (json['WeeklyMiles'] != null) {

      for (var item in json['WeeklyMiles']) {

        weekMap[item['WeekEnding']] = item['Miles'];

      }
    }

    return MileageModel(

      substation: json['Substation'] ?? '',

      feeder: json['Feeder'] ?? '',

      circuitNo: json['Circuit'] ?? '',

      totalMiles: (json['TotalMiles'] ?? 0).toDouble(),

      weeks: weekMap,
    );
  }
}