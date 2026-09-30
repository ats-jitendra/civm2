import 'dart:io';
import 'package:CIVM/piedmont/resources/app_colors.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/BottomNavigationAccountPage.dart';
import 'package:CIVM/piedmont/screens/supervisor_pannel/row_maintenance_supervisor.dart';
import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';

class SupervisorBottomNavigationPannel extends StatefulWidget {
  const SupervisorBottomNavigationPannel({Key? key}) : super(key: key);

  @override
  State<SupervisorBottomNavigationPannel> createState() =>
      _SupervisorBottomNavigationPannelState();
}

class _SupervisorBottomNavigationPannelState
    extends State<SupervisorBottomNavigationPannel> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    const RowMaintenanceSupervisor(),
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
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
       backgroundColor:AppColors.backgroundColor,
      // appBar: AppBar(
      //   iconTheme: const IconThemeData(color: Colors.white),
      //   title: const Text(
      //     'IVM Maintenance Supervisor',
      //     style: TextStyle(color: Colors.white),
      //   ),
      //   backgroundColor: AppColors.baseColor,
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
      drawer: DrawerManu(menu: menu),
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
        backgroundColor: AppColors.baseColor,
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
        unselectedItemColor: AppColors.green2,
      ),
    );
  }
}
