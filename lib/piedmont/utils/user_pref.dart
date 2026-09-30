// import 'package:flutter/cupertino.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import 'package:CIVM/piedmont/models/user_model.dart';

// class UserPrefPemc with ChangeNotifier {
//   Future<bool> saveUser(UserModel user,String userNameForOTP) async {
//     final SharedPreferences pref = await SharedPreferences.getInstance();
//     String currentTime = DateTime.now().toIso8601String();
//     pref.setString('id', user.user!.id.toString());
//     pref.setString('token', user.token.toString());
//     pref.setString('password', user.user!.password.toString());
//     pref.setString('Email', user.user!.email.toString());
//     pref.setString('firstName', user.user!.fName.toString());
//     pref.setString('lastName', user.user!.lName.toString());
//     pref.setString('userType', user.user!.userType.toString());
//     pref.setString('status', user.user!.status.toString());
//     pref.setString('img', user.user!.profilePhoto.toString());
//     pref.setString('rights', user.user!.rights.toString());
//     String secureAccessCodeEmail;
//     secureAccessCodeEmail = userNameForOTP;
//     pref.setBool('deviceToken', true);
//     pref.setString(secureAccessCodeEmail, currentTime);
//     print('secureAccessCodeEmail22222222222: $secureAccessCodeEmail,  $currentTime');
//     notifyListeners();
//     return true;
//   }

//   Future<UserModel> getUser() async {
//     final SharedPreferences pref = await SharedPreferences.getInstance();
//     final String? id = pref.getString('id');
//     final String? token = pref.getString('token');
//     final String? email = pref.getString('Email');
//     final String? password = pref.getString('password');
//     final String? firstName = pref.getString('firstName');
//     final String? lastName = pref.getString('lastName');
//     final String? userType = pref.getString('userType');
//     final String? status = pref.getString('status');
//     final String? img = pref.getString('img');
//      final String? rights = pref.getString('rights');
//     print(token);

//     return UserModel(
//         user: User(
//             id: (id == null) ? 0 : int.parse(id.toString()),
//             userName: email,
//              password: password,
//             fName: firstName,
//             lName: lastName,
//             userType: userType,
//             email: email,
//             status: status,
//             profilePhoto: img,
//             rights: rights),
//         token: token.toString());
//   }

//   Future<bool> remove() async {
//     final SharedPreferences pref = await SharedPreferences.getInstance();
//     pref.remove('token');
//     return true;
//   }

//   Future<void> saveAccountNo(String acc) async {
//     final SharedPreferences pref = await SharedPreferences.getInstance();
//     pref.setString('accountNo', acc);
//     notifyListeners();
//   }

//   Future<String> getAccountNo() async {
//     final SharedPreferences pref = await SharedPreferences.getInstance();
//     String acc = (pref.getString('accountNo').toString().isEmpty)
//         ? '0'
//         : pref.getString('accountNo').toString();
//     return acc;
//   }
// }
