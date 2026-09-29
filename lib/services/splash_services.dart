// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:CIVM/models/user_details.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/admin_pannel.dart';
import 'package:CIVM/piedmont/screens/crew_pannel/crew_bottom_navigation_pannel.dart';
import 'package:CIVM/piedmont/screens/generalForeman_New_pannel/contractor_bottom_navigation.dart';
import 'package:CIVM/piedmont/screens/gf_edko_panel/edko_bottom_navigation.dart';
import 'package:CIVM/piedmont/screens/login_page.dart';
import 'package:CIVM/piedmont/screens/peter_pannel/peter_contractor_bottom_navigation.dart';
import 'package:CIVM/piedmont/screens/supervisor_pannel/supervisor_bottom_navigation_pannel.dart';
import 'package:CIVM/resources/app_url.dart';
import 'package:CIVM/screens/preLogin_screen.dart';
import 'package:CIVM/utils/routes/route_name.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashServices {
  Future<UserModel> getUserData() => UserPref().getUser();

  void checkAuthentication(BuildContext context) async {
    getUserData().then((value) async {
      if (value.token == 'null' || value.token == '') {
        await Future.delayed(const Duration(seconds: 3));
        // Navigator.of(context).pop();
        //  Navigator.pushNamed(context, RoutesName.login);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => PreLoginScreen()));
      } else {
        await Future.delayed(const Duration(seconds: 3));

        final prefs = await SharedPreferences.getInstance();
        String applicationType = prefs.getString("applicationType")!;
        print("splash applicationtype $applicationType");
        if (applicationType == "Piedmont Electric Cooperative") {
          if (value.user!.userType == '1' && value.user!.status == 'ACTIVE') {
            print('1111111111');
            print(value.user!.userType);
            print(value.user!.status);
            //   Navigator.of(context).pop();
            // Navigator.pushNamed(context, RoutesNamePemc.adminHome);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext contex) =>
                        const EnergyAuditPannel()));
          } else if (value.user!.userType == '2' &&
              value.user!.status == 'ACTIVE') {
            print('22222222222');
            //   Navigator.of(context).pop();
            //  Navigator.pushNamed(context, RoutesNamePemc.supervisorHome);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext contex) =>
                        const SupervisorBottomNavigationPannel()));
          } else if (value.user!.userType == '3' &&
              value.user!.status == 'ACTIVE') {
            print('333333333');
            //  Navigator.of(context).pop();
            // Navigator.pushNamed(context, RoutesNamePemc.contractorHome);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext contex) =>
                        const ContractorBottomNavigationPannel()));
          } else if (value.user!.userType == '4' &&
              value.user!.status == 'ACTIVE') {
            print('44444444444');
            //  Navigator.of(context).pop();
            //  Navigator.pushNamed(context, RoutesNamePemc.crewHome);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext contex) =>
                        const CrewBottomNavigationPannel()));
          }else if (value.user!.userType == '5' &&
              value.user!.status == 'ACTIVE') {
            print('333333333');
            //  Navigator.of(context).pop();
            // Navigator.pushNamed(context, RoutesNamePemc.contractorHome);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext contex) =>
                        const EdkoBottomNavigationPannel()));
          }
           else if (value.user!.userType == '6' &&
              value.user!.status == 'ACTIVE') {
            //  Navigator.pushNamed(context, RoutesNamePemc.plannerHome);
                        Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext contex) =>
                        const PeterContractorBottomNavigationPannel()));
          }
           else {
            print('Logged Out');
            //  Navigator.of(context).pop();
            // Navigator.pushNamed(context, RoutesNamePemc.loginPemc);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext contex) => const LoginPagePemc()));
          }
        } else if (applicationType == "Lake Country Power") {
          if (value.user!.userType == '1' && value.user!.status == 'ACTIVE') {
            print('1111111111');
            print(value.user!.userType);
            print(value.user!.status);
            Navigator.of(context).pop();
            Navigator.pushNamed(context, RoutesName.adminHome);
          } else if (value.user!.userType == '2' &&
              value.user!.status == 'ACTIVE') {
            print('22222222222');
            Navigator.of(context).pop();
            Navigator.pushNamed(context, RoutesName.supervisorHome);
          } else if (value.user!.userType == '3' &&
              value.user!.status == 'ACTIVE') {
                getUserDetailsByUsername(value,context);
            // print('333333333');
            // Navigator.of(context).pop();
            // Navigator.pushNamed(context, RoutesName.contractorHome);
          } else if (value.user!.userType == '4' &&
              value.user!.status == 'ACTIVE') {
            print('44444444444');
            Navigator.of(context).pop();
            Navigator.pushNamed(context, RoutesName.crewHome);
          } else if (value.user!.userType == '6' &&
              value.user!.status == 'ACTIVE') {
                getUserDetailsByUsername(value,context);
            // Navigator.pushNamed(context, RoutesName.plannerHome);
          } else {
            print('Logged Out');
            Navigator.of(context).pop();
            Navigator.pushNamed(context, RoutesName.login);
          }
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => PreLoginScreen()));
        }
      }
    }).onError(((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
      Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => PreLoginScreen()));
    }));
  }


  Future<UserDetails?> getUserDetailsByUsername(UserModel value, BuildContext context) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    String email = data.user!.email.toString();
    var url = "${AppUrl.baseUrl}login_user/get_userDetails_by_username/$email";
    print('url: $url');
  try {
    final response = await http.get(
      Uri.parse(url
      ),
      headers: {
        "Authorization": "Bearer ${data.token}",
        "Content-Type": "application/json",
      },
    );
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      String? userType = responseData["userDetails"]["userType"]?.toString();
      String? additionalUserType = responseData["userDetails"]["additionalUserType"]?.toString();
      final SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('userType', userType.toString());
      pref.setString('additionalUserType', additionalUserType.toString());
      print('additionalUserType:: $additionalUserType');
       if (value.user!.userType == '3' &&
              value.user!.status == 'ACTIVE') {
            print('333333333');
            Navigator.of(context).pop();
            Navigator.pushNamed(context, RoutesName.contractorHome);
          } else if (value.user!.userType == '6' &&
              value.user!.status == 'ACTIVE') {
            Navigator.pushNamed(context, RoutesName.plannerHome);
          } else {
            print('Logged Out');
            Navigator.of(context).pop();
            Navigator.pushNamed(context, RoutesName.login);
          }
      return UserDetails.fromJson(responseData["userDetails"]);
    } else {
      print("Error : ${response.statusCode}");
      print(response.body);
    }
  } catch (e) {
    print(e);
  }
  return null;
}
}
