import 'dart:io';
import 'package:CIVM/piedmont/resources/app_colors.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/BottomNavigationAccountPage.dart';
import 'package:CIVM/piedmont/screens/generalForeman_New_pannel/contractor_dispatch_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';

class ContractorBottomNavigationPannel extends StatefulWidget {
  const ContractorBottomNavigationPannel({Key? key}) : super(key: key);

  @override
  State<ContractorBottomNavigationPannel> createState() =>
      _ContractorBottomNavigationPannelState();
}

class _ContractorBottomNavigationPannelState
    extends State<ContractorBottomNavigationPannel> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    const ContractorDispatchDashboard(),
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
    //final userPreferences = Provider.of<UserPref>(context);
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
       backgroundColor:AppColors.backgroundColor,
      // appBar: AppBar(
      //   iconTheme: const IconThemeData(color: Colors.white),
      //   title: const Text(
      //     'General Foreman / Dispatch Dashboard',
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
