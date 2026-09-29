import 'dart:io';

import 'package:CIVM/screens/admin_pannel/BottomNavigationAccountPage.dart';
import 'package:CIVM/screens/generalForeman_New_pannel/contractor_dispatch_dashboard.dart';
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
    // checkCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final userPreferences = Provider.of<UserPref>(context);
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   iconTheme: const IconThemeData(color: Colors.white),
      //   title: const Text(
      //     'General Foreman / Dispatch Dashboard',
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


  //  Future<void> checkCurrentUser() async {
  //   print('planner authentication');

  //   try {
  //     final prefs = await SharedPreferences.getInstance();

  //     final fcmToken = prefs.getString('device_token_for_logOut');

  //     if (fcmToken == null || fcmToken.isEmpty) {
  //       print("FCM token not found in SharedPreferences");
  //       return;
  //     }
  //     final userPreferences1 = Provider.of<UserPref>(context, listen: false);

  //     UserModel data = await userPreferences1.getUser();

  //     final String id = data.user!.id.toString();

  //     final apiUrl =
  //         "${AppUrl.baseUrl}login_user/checkCurrentUser"
  //         "?fcmToken=${Uri.encodeQueryComponent(fcmToken)}"
  //         "&userId=${Uri.encodeQueryComponent(id)}";

  //     final url = Uri.parse(apiUrl);

  //     print("API URL for authentication: $url");
  //     print("Bearer Token: ${data.token}");

  //     final response = await http.get(
  //       url,
  //       headers: {
  //         'Authorization': 'Bearer ${data.token!}',
  //         'Content-Type': 'application/json',
  //         'Accept': 'application/json',
  //       },
  //     );

  //     print("Status Code: ${response.statusCode}");
  //     print("Response: ${response.body}");

  //     if (response.statusCode == 200) {
  //       final responseData = jsonDecode(response.body);

  //       print("Current User Response: $responseData");

  //       if (responseData == false) {
  //         final userPreferences = Provider.of<UserPref>(context, listen: false);

  //         await userPreferences.remove();

  //         if (!mounted) return;

  //         Navigator.of(context).pushAndRemoveUntil(
  //           MaterialPageRoute(
  //             builder: (BuildContext context) => const LoginPage(),
  //           ),
  //           (route) => false,
  //         );
  //       }
  //     } else if (response.statusCode == 401) {
  //       print("Unauthorized - Bearer token is invalid or expired");
  //     } else {
  //       print(
  //         "checkCurrentUser failed: "
  //         "${response.statusCode} - ${response.body}",
  //       );
  //     }
  //   } catch (e) {
  //     print("checkCurrentUser Error: $e");
  //   }
  // }

}
