import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MyLinkButton extends StatelessWidget {
  final String url; // The URL you want to open when the button is pressed.

  const MyLinkButton({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _launchURL, // Call the _launchURL method when the button is tapped
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 68, 145, 234),
          border: Border.all(color: const Color.fromARGB(255, 7, 59, 120)),
        ),
        child: const Text(
          "VIEW MAP",
          textAlign: TextAlign.left,
          style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  void _launchURL() async {
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
