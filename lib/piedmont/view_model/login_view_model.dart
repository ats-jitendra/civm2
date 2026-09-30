import 'dart:math';
import 'package:CIVM/piedmont/screens/gf_edko_panel/edko_bottom_navigation.dart';
import 'package:CIVM/piedmont/screens/peter_pannel/peter_contractor_bottom_navigation.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/admin_pannel.dart';
import 'package:CIVM/piedmont/screens/crew_pannel/crew_bottom_navigation_pannel.dart';
import 'package:CIVM/piedmont/screens/enter_otp.dart';
import 'package:CIVM/piedmont/screens/generalForeman_New_pannel/contractor_bottom_navigation.dart';
import 'package:CIVM/piedmont/screens/login_page.dart';

import 'package:CIVM/piedmont/screens/supervisor_pannel/supervisor_bottom_navigation_pannel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:CIVM/piedmont/repository/auth_repository.dart';
import 'package:CIVM/piedmont/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/piedmont/utils/routes/route_name.dart';
import 'package:CIVM/piedmont/utils/user_pref.dart';

class LoginViewModelPemc with ChangeNotifier {
  final _myRepo = AuthRepositoryPemc();
  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, bool dynamicIsCheckedRememberMe,
      String userName, String password, BuildContext context) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    setLoading(true);

    try {
      final value = await _myRepo.loginApi(data).timeout(
            const Duration(seconds: 30),
            onTimeout: () => throw TimeoutException("Server not responding!"),
          );
      // final value = await _myRepo.loginApi(data);
      // _myRepo.loginApi(data).then((value) async {
      setLoading(false);

      print('data otp123 ${data}');
      print('main dynamicIsCheckedRememberMe ${dynamicIsCheckedRememberMe}');
      if (!RegExp(r'\S+@\S+\.\S+').hasMatch(userName)) {
        if (value.user != null && value.user!.status == 'ACTIVE') {
          userPreferences.saveUser(value, userName);
          switch (value.user!.userType) {
            case '1':
              //  Navigator.pushNamed(context, RoutesNamePemc.adminHome);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext contex) =>
                          const EnergyAuditPannel()));
              break;
            case '2':
              //  Navigator.pushNamed(context, RoutesNamePemc.supervisorHome);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext contex) =>
                          const SupervisorBottomNavigationPannel()));
              break;
            case '3':
              // Navigator.pushNamed(context, RoutesNamePemc.contractorHome);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext contex) =>
                          const ContractorBottomNavigationPannel()));
              print('Utility type 3');
              break;
            case '4':
              //  Navigator.pushNamed(context, RoutesNamePemc.crewHome);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext contex) =>
                          const CrewBottomNavigationPannel()));
              break;
            case '5':
              // Navigator.pushNamed(context, RoutesNamePemc.contractorHome);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext contex) =>
                          const EdkoBottomNavigationPannel()));
              print('Utility type 5');
                break;
              case '6':
                 Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext contex) =>
                          const PeterContractorBottomNavigationPannel()));
              print('Utility type 6 Peter');
              break;
            default:
              // Navigator.pushNamed(context, RoutesNamePemc.loginPemc);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext contex) => const LoginPagePemc()));
          }
        } else if (value.user!.status == 'DELETE') {
          print('delete condition: ${value.user!.status}');
          CustomToastSnackBarProgressDialog.flushBarErrorMessageLogin(
              "Username does not exist!", context);
          // Navigator.pushNamed(context, RoutesName.login);
        }

        userPreferences.saveUser(value, userName);
      } else {
        if (dynamicIsCheckedRememberMe == false) {
          _generateOtp(
              value.user!.userType.toString(),
              value.user!.status.toString(),
              userName,
              password,
              value,
              context);
        } else if (dynamicIsCheckedRememberMe == true) {
          if (value.user != null && value.user!.status == 'ACTIVE') {
            userPreferences.saveUser(value, userName);
            switch (value.user!.userType) {
              case '1':
                // Navigator.pushNamed(context, RoutesNamePemc.adminHome);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext contex) =>
                            const EnergyAuditPannel()));
                break;
              case '2':
                // Navigator.pushNamed(context, RoutesNamePemc.supervisorHome);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext contex) =>
                            const SupervisorBottomNavigationPannel()));
                break;
              case '3':
                // Navigator.pushNamed(context, RoutesNamePemc.contractorHome);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext contex) =>
                            const ContractorBottomNavigationPannel()));
                print('Utility type 3');
                break;
              case '4':
                //   Navigator.pushNamed(context, RoutesNamePemc.crewHome);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext contex) =>
                            const CrewBottomNavigationPannel()));
                break;
              case '5':
                // Navigator.pushNamed(context, RoutesNamePemc.contractorHome);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext contex) =>
                            const EdkoBottomNavigationPannel()));
                print('Utility type 5');
                //   break;
                // case '6':
                //  // Navigator.pushNamed(context, RoutesNamePemc.plannerHome);
                //     Navigator.pushReplacement(
                //     context,
                //     MaterialPageRoute(
                //         builder: (BuildContext contex) =>
                //             const PlannerBottomNavigationPannel()));

                break;
              default:
                //  Navigator.pushNamed(context, RoutesNamePemc.loginPemc);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext contex) =>
                            const LoginPagePemc()));
            }
          } else if (value.user!.status == 'DELETE') {
            print('delete condition: ${value.user!.status}');
            CustomToastSnackBarProgressDialog.flushBarErrorMessageLogin(
                "Username does not exist!", context);
            // Navigator.pushNamed(context, RoutesName.login);
          } else {
            print('else condition');
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext contex) => const LoginPagePemc()));
            // Navigator.pushNamed(context, RoutesNamePemc.loginPemc);
          }
        }
      }

      if (kDebugMode) {
        print("✅ Login success: ${value.toString()}");
      }
    } catch (error) {
//  }).onError((error, stackTrace) {
      setLoading(false); // ✅ always stop spinner

      String errorMessage = 'Server not responding!';

      // Since we now throw Exception("Invalid Credentials!..."), just use toString()
      // errorMessage = error.toString().replaceFirst('Exception: ', '');
      if (error.toString().contains("Invalid Credentials")) {
        errorMessage = error.toString().replaceFirst('Exception: ', '');
        CustomToastSnackBarProgressDialog.flushBarErrorMessageLogin(
            errorMessage, context);
        print('errorMessage::: $errorMessage');
      } else if (error.toString().contains("SocketException")) {
        errorMessage = "No Internet Connection!";
        CustomToastSnackBarProgressDialog.flushBarErrorMessageLogin(
            errorMessage, context);
      } else if (error is TimeoutException) {
        // } else if (error.toString().contains("TimeoutException")) {
        errorMessage = "Server not responding!";
        CustomToastSnackBarProgressDialog.flushBarErrorMessageLogin(
            errorMessage, context);
      } else if (error.toString().contains("Not Found")) {
        print('1111111111111111111111111111');
        errorMessage = "User Not Found!";
        CustomToastSnackBarProgressDialog.flushBarErrorMessageLogin(
            errorMessage, context);
      } else {
        print('else in view model');
        // errorMessage = "User not found!";
        // "User not found";
      }
      // Show toast/snackbar with actual error
      // CustomToastSnackBarProgressDialog.flushBarErrorMessageLogin(
      //     errorMessage, context);

      if (kDebugMode) {
        print("❌ Login failed: $errorMessage");
      }
    }
  }

  String _generateOtp(String userType, String status, String userName,
      String password, value, BuildContext context) {
    CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
        "Secure Access Code sent to your email.", context);
    var random = Random();
    int otp = random.nextInt(90000) + 10000;
    print('Secure Access Code $otp');
    DateTime now = DateTime.now();
    int timestamp = now.millisecondsSinceEpoch;
    Timer(const Duration(minutes: 3), () {
      print('Secure Access Code expired');
    });

    // Send OTP via email
    List<String> list = ['preetika.patel@ariespro.com'];
    var subject = 'Secure Access Code for PEMC CIVM login';
    var msg =
        'Use secure access code for login to PEMC CIVM: $otp. Access Code is valid for only 5 minutes.';
    _sendMail(list, subject, msg, otp, userType, userName, password, status,
        value, context);
    return '$otp,$timestamp';
  }

  Future<void> _sendMail(
      List<String> recipientsList,
      String subject,
      String content,
      int otpSendInTheEmail,
      String userType,
      String userName,
      String password,
      String status,
      value,
      BuildContext context) async {
    print('userName: $userName');
    String email = userName;
    String capitalizedName = email.split('@').first.split('.').first;
    capitalizedName =
        capitalizedName[0].toUpperCase() + capitalizedName.substring(1);
    List<String> recipientsList = [];
    for (int i = 0; i < recipientsList.length; i++) {
      recipientsList.add(recipientsList[i]);
    }
    // ========================================================================

    String username = 'ats.ariespro@gmail.com';
    String password = 'ahbfhcshjujvkgge';

    final smtpServer = gmail(username, password);
    // Use the SmtpServer class to configure an SMTP server:
    // final smtpServer = SmtpServer('smtp.domain.com');
    // See the named arguments of SmtpServer for further configuration
    // options.

    // Create our message.
    final message = Message()
      ..from = Address(username, 'PEMC CIVM')
      ..recipients.addAll([
        // 'preetika.patel@ariespro.com',
        // 'jyothi.andhavarapu@ariespro.com',
        //temp commented
        userName,
      ])
      ..bccRecipients
          .addAll(['jitendra.kushwaha@ariespro.com'])
      ..subject = subject
      // ..text = 'HMHP'
      ..html =
          "<h4>Hi $capitalizedName,</h4>\n<p>$content</p>\n<p>Note: DO NOT REPLY TO THIS EMAIL. If you did not request this code, or if you believe you have received this email in error, please email at  it.support@ariespro.com.</p>\n<p>Thank you, </p>\n<p>AriesPro Utilities</p>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
      // CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
      //     'Secure Access Code sent successfully to your email', context);
      print('_userNameController.text.toString(): $userName');
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => EnterOTP(
              otp: otpSendInTheEmail,
              email: userName,
              password: password,
              userType: userType,
              status: status,
              value: value)));
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }
//   Future<void> loginApi(dynamic data, BuildContext context) async {
//     final userPreferences = Provider.of<UserPref>(context, listen: false);
//     setLoading(true);
//     _myRepo.loginApi(data).then((value) async {
//       setLoading(false);
//       // ignore: avoid_print
//       print(value.token.toString());
//       if (value.user!.userType == '1' && value.user!.status == 'ACTIVE') {
//         userPreferences.saveUser(value);
//         Navigator.pushNamed(context, RoutesName.adminHome);
//       } else if (value.user!.userType == '2' &&
//           value.user!.status == 'ACTIVE') {
//         userPreferences.saveUser(value);
//         Navigator.pushNamed(context, RoutesName.supervisorHome);
//       } else if (value.user!.userType == '3' &&
//           value.user!.status == 'ACTIVE') {
//         userPreferences.saveUser(value);
//         Navigator.pushNamed(context, RoutesName.contractorHome);
//       } else if (value.user!.userType == '4' &&
//           value.user!.status == 'ACTIVE') {
//         userPreferences.saveUser(value);
//         Navigator.pushNamed(context, RoutesName.crewHome);
//       } else if (value.user!.userType == '6' &&
//           value.user!.status == 'ACTIVE') {
//         userPreferences.saveUser(value);
//         Navigator.pushNamed(context, RoutesName.plannerHome);
//       }

//       // ************************************************************************//

//       else {
//         Navigator.pushNamed(context, RoutesName.login);
//       }

//       if (kDebugMode) {
//         print(value.toString());
//       }
//       // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
//     }).onError((error, StackTrace) {

// ///////////////////////////////////////////
//       var errorMessage = 'Server not responding';
//       try {
//         var errorJson = json.decode(error.toString());
//         if (errorJson.containsKey('error')) {
//           errorMessage = errorJson['error'];
//         }
//       } catch (e) {}
//       CustomToastSnackBarProgressDialog.flushBarErrorMessage(
//           errorMessage, context);

//       /////////////////////////////////////

//       setLoading(false);
//       if (kDebugMode) {
//         // CustomToastSnackBarProgressDialog.flushBarErrorMessage(
//         //     error.toString(), context);
//         print(error.toString());
//       }
//     });
//   }
}
