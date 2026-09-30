import 'dart:io';
import 'package:CIVM/piedmont/resources/app_colors.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/BottomNavigationAccountPage.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/row_maintenance_plan.dart';
import 'package:flutter/material.dart';


class EnergyAuditPannel extends StatefulWidget {
  const EnergyAuditPannel({Key? key}) : super(key: key);

  @override
  State<EnergyAuditPannel> createState() => _EnergyAuditPannelState();
}

class _EnergyAuditPannelState extends State<EnergyAuditPannel> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    // const BottomNavigationHomePage(),
    const RowMaintenanceView(),
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
       backgroundColor:AppColors.backgroundColor,
      // appBar: AppBar(
      //   title: const Text(
      //     'CIVM',
      //     style: TextStyle(color: Colors.white),
      //   ),
      //   backgroundColor: AppColors.baseColor,
      //   actions: [
      //     IconButton(
      //       icon: const Icon(
      //         Icons.logout,
      //         color: Colors.white,
      //       ),
      //       onPressed: () {
      //         userPreferences.remove().then((value) {
      //           // ignore: use_build_context_synchronously
      //           // Navigator.pushReplacement(context, RoutesName.login);
      //           // Navigator.pushNamed(
      //           //     context, RoutesName.login);
      //           Navigator.of(context).push(MaterialPageRoute(
      //               builder: (BuildContext context) => const LoginPage()));
      //         });
      //         // Navigator.of(context).push(MaterialPageRoute(
      //         //     builder: (BuildContext context) => const LoginPage()));
      //       },
      //     ),
      //   ],
      // ),
      body: _children[_currentIndex],
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

  Future<bool> showExitPopup(context) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SizedBox(
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Do you want to exit?",
                      style: TextStyle(
                        color: AppColors.baseColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            exit(0);
                          },
                          child: const Text("Yes",
                              style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red.shade800),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("No",
                            style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                      ))
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
