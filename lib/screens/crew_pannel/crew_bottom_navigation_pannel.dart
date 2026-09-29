import 'dart:io';

import 'package:CIVM/screens/admin_pannel/BottomNavigationAccountPage.dart';
import 'package:CIVM/screens/crew_pannel/crew_bottom_navigation_home_page.dart';
import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';


class CrewBottomNavigationPannel extends StatefulWidget {
  const CrewBottomNavigationPannel({Key? key}) : super(key: key);

  @override
  State<CrewBottomNavigationPannel> createState() =>
      _CrewBottomNavigationPannelState();
}

class _CrewBottomNavigationPannelState
    extends State<CrewBottomNavigationPannel> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    // const MapViewCrew(),
    const CrewBottomNavigationHomePage(),
    const BottomNavigationAccountPage()
  ];
  List<String> menu = [];

  onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    // getOwnPermissions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final userPreferences = Provider.of<UserPref>(context);
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   iconTheme: const IconThemeData(color: Colors.white),
      //   title: const Text(
      //     'CIVM',
      //     style: TextStyle(color: Colors.white),
      //   ),
      //   backgroundColor: const Color.fromARGB(255, 7, 59, 120),
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.logout, color: Colors.white),
      //       onPressed: () {
      //         userPreferences.remove().then((value) {
      //           Navigator.of(context).push(MaterialPageRoute(
      //               builder: (BuildContext context) => const LoginPage()));
      //         });
      //         // Navigator.of(context).push(MaterialPageRoute(
      //         //     builder: (BuildContext context) => const LoginPage()));
      //       },
      //     ),
      //   ],
      // ),
      // drawer: DrawerManu(menu: menu),
      body: UpgradeAlert(
            barrierDismissible: false,
            showLater: true,
            showIgnore: true,
            showReleaseNotes: false,
            dialogStyle: Platform.isIOS
                        ? UpgradeDialogStyle.cupertino
                        : UpgradeDialogStyle.material,
                        upgrader: Upgrader(
                          debugDisplayAlways: false,
                          messages: UpgraderMessages(code: "Kindly update your app.")
                        ),child: _children[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTappedBar,
        currentIndex: _currentIndex,
        backgroundColor: const Color.fromARGB(255, 7, 59, 120),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color.fromARGB(255, 116, 190, 251),
      ),
    );
  }
}
