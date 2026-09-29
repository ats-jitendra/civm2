import 'package:CIVM/screens/admin_pannel/BottomNavigationAccountPage.dart';
import 'package:CIVM/screens/planner_pannel.dart/planner_add_new_row_table.dart';
import 'package:flutter/material.dart';

class PlannerBottomNavigationPannel extends StatefulWidget {
  const PlannerBottomNavigationPannel({Key? key}) : super(key: key);

  @override
  State<PlannerBottomNavigationPannel> createState() =>
      _PlannerBottomNavigationPannelState();
}

class _PlannerBottomNavigationPannelState
    extends State<PlannerBottomNavigationPannel> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    // const PlannerRowMaintenanceView(),
    PlannerAddNewRowTable(),
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
   // listenToConnectivity();
    // getOwnPermissions();
    super.initState();
  }
  
  // void listenToConnectivity() {
  //   Connectivity().onConnectivityChanged.listen((result) async {
  //     if (!result.contains(ConnectivityResult.none)) {
  //       print("Internet Restored ");

  //       int syncedCount =
        
  //       await DatabaseHelper.instance.syncPendingMapData();
  //       await DatabaseHelper.instance.syncPendingMessages();
          
  // print("syncedCount $syncedCount");
  //       // Show notification
  //       if (syncedCount > 0) {
  //         // await NotificationService.showNotification(
  //         //   title: "Sync Complete*",
  //         //   body: "$syncedCount offline record(s) uploaded successfully.",
  //         // );
  //         // print("$syncedCount offline record(s) uploaded successfully");
  //       }
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      
      body: _children[_currentIndex],
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
