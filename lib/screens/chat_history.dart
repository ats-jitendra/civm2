import 'dart:async';
import 'dart:convert';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/resources/app_url.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

/// ================= SCREEN =================
// ignore: must_be_immutable
class ChatHistoryScreen extends StatefulWidget {
  String tokenNo;
  ChatHistoryScreen({super.key, required this.tokenNo});

  @override
  State<ChatHistoryScreen> createState() => _ChatHistoryScreenState();
}

class _ChatHistoryScreenState extends State<ChatHistoryScreen> {
  bool isTextEmpty = true;
  List<dynamic> yourList = [];
  Future? myFuture;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    myFuture = getChatNotes(widget.tokenNo);
    super.initState();
  }

  /// ================= UI =================
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
          child: Container(
        padding: const EdgeInsets.only(bottom: 8),
        width: width * .9,
        constraints: BoxConstraints(
          maxHeight: height * .6,
        ),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(),
            isLoading
    ? const Expanded(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      )
    : yourList.isEmpty
        ? const Expanded(
            child: Center(
              child: Text(
                'No Chat History Found',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
        :  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                     // physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 6),
                      itemCount: yourList.length,
                      itemBuilder: (context, index) {
                        var item = yourList[index];

                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 7, 59, 120),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: _fieldWidget(
                                          "ID", item["mapId"] ?? "")),
                                  Expanded(
                                      child: _fieldWidget(
                                          "NAME", item["userName"] ?? "")),
                                ],
                              ),
                              const SizedBox(height: 6),
                              const Divider(color: Colors.grey),
                              Row(
                                children: [
                                  Expanded(
                                      child: _fieldWidget(
                                          "CHAT HISTORY", item["desc"] ?? "")),
                                  Expanded(
                                      child: _fieldWidget(
                                    "TIME",
                                    item["crt_date"] != null
                                        ? formatDate(item["crt_date"])
                                        : "",
                                  )),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      )),
    );
  }

  String formatDate(String date) {
    DateTime parsedDate = DateTime.parse(date);
    return DateFormat('MM/dd/yyyy h:mm:ss a').format(parsedDate);
  }

  /// ================= HEADER =================
  Widget _buildHeader() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: const BoxDecoration(
        color: const Color.fromARGB(255, 7, 59, 120),
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      child: Row(
        children: [
          // Image.asset('assets/chatbot.png', height: 30, width: 30),
          // // const Icon(Icons.smart_toy, color: Colors.white),
          const SizedBox(width: 8),
          const Text(
            "Chat History Notes",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const Spacer(),
          IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              }),
        ],
      ),
    );
  }

  Widget _fieldWidget(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title:",
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
            softWrap: true,
          ),
        ],
      ),
    );
  }

  // Future<void> getChatNotes(String tokenNo) async {
  //   print('tokenNo $tokenNo');
  //   print('Api called');
  //   try {
  //     var url = Uri.parse(
  //         "${AppUrl.baseUrl}changeOrderLcpCreateOrder/GetAddChatNotes?token=$tokenNo");
  //         print('url chat history: $url');
  //     final userPreferences = Provider.of<UserPref>(context, listen: false);
  //     UserModel data = await userPreferences.getUser();

  //     var response = await http.get(
  //       url,
  //       headers: {
  //         'Authorization': 'Bearer ${data.token}',
  //         'Content-Type': 'application/json',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       var jsonData = jsonDecode(response.body);

  //       setState(() {
  //         yourList = jsonData['data'];
  //       });
  //     } else {
  //       print("API Error");
  //     }
  //   } catch (e) {
  //     print("Exception: $e");
  //   }
  // }
Future<void> getChatNotes(String tokenNo) async {
  try {
    setState(() {
      isLoading = true;
    });

    var url = Uri.parse(
      "${AppUrl.baseUrl}changeOrderLcpCreateOrder/GetAddChatNotes?token=$tokenNo",
    );

    final userPreferences = Provider.of<UserPref>(
      context,
      listen: false,
    );

    UserModel data = await userPreferences.getUser();

    var response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ${data.token}',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);

      setState(() {
        yourList = jsonData['data'] ?? [];
      });
    }
  } catch (e) {
    print("Exception: $e");
  } finally {
    setState(() {
      isLoading = false;
    });
  }
}
}

/// ================= TYPING INDICATOR =================
class TypingIndicator extends StatefulWidget {
  const TypingIndicator({super.key});

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _dot(int index) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        double value = (_controller.value - (index * 0.2));
        value = value.clamp(0.0, 1.0);

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Opacity(
            opacity: value,
            child: const CircleAvatar(
              radius: 4,
              backgroundColor: Colors.grey,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 14,
          backgroundColor: Colors.white,
          child: Icon(Icons.support_agent, size: 16, color: Colors.green),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.greenAccent.shade100,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _dot(0),
              _dot(1),
              _dot(2),
            ],
          ),
        ),
      ],
    );
  }
}
