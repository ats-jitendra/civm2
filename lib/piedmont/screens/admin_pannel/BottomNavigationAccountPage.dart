import 'dart:convert';
import 'dart:io';
import 'package:CIVM/piedmont/data/response/status.dart';
import 'package:CIVM/piedmont/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/piedmont/view_model/account_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:CIVM/piedmont/resources/app_colors.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/models/user_model.dart';
import '../login_page.dart';

class BottomNavigationAccountPage extends StatefulWidget {
  const BottomNavigationAccountPage({Key? key}) : super(key: key);

  @override
  State<BottomNavigationAccountPage> createState() =>
      _BottomNavigationAccountPageState();
}

class _BottomNavigationAccountPageState
    extends State<BottomNavigationAccountPage> {
  final TextEditingController _userType = TextEditingController();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _address = TextEditingController();
  // final TextEditingController _gender = TextEditingController();
  // final TextEditingController _dob = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final TextEditingController _currentPassword = TextEditingController();
  final TextEditingController _password = TextEditingController();

  // final TextEditingController _department = TextEditingController();
  // final TextEditingController _designation = TextEditingController();

  String _name = '';

  bool _isVisiblePickImage = false;
  bool _isVisibleNetwork = true;

  bool _userTypeEnabled = false;
  // bool _DOBEnabled = false;
  // bool _genderEnabled = false;
  bool _emailEnabled = false;
  // bool _contactEnabled = false;
  bool _firstNameEnabled = false;
  bool _lastNameEnabled = false;
  // bool _departmentEnabled = false;
  // bool _designationEnabled = false;
  bool _phoneNumberEnabled = false;
  bool _officeNumberEnabled = false;
  bool _userDetailsUpdate = false;
  bool _editProfile = true;
  bool _obscureText = true;
  bool _obscureText2 = true;
  bool _obscureText3 = true;
  // int _selectedIndex = 0;
  File? image;
  String? _imagePath;
  List<String> menu = [];
  final _formkeyMain = GlobalKey<FormState>();
  final _formkey = GlobalKey<FormState>();
  String imageNewName = '';
  onTappedBar(int index) {
    setState(() {});
  }

  AccountPageViewModel accountPageViewModel = AccountPageViewModel();
  // ignore: prefer_typing_uninitialized_variables
  var a;
  String id = '';

  @override
  void initState() {
    fetchData();
    // sharedPreferencesDataData();
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      // getData();
      fetchInitData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userPreferences = Provider.of<UserPref>(context);
    // Size size = MediaQuery.of(context).size;
    double coverHeight = MediaQuery.of(context).size.height * 0.3;
    double profileHeight = MediaQuery.of(context).size.height * 0.15;
    double plusHeight = MediaQuery.of(context).size.height * 0.02;
    final top = coverHeight - 40 / 2;
    final topPlus = profileHeight - plusHeight;
    return PopScope(
      canPop: false,
      onPopInvoked: ((didpop) {
        if (didpop) {
          return;
        }
        showExitPopup(context);
      }),
      child: Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            title: const Text(
              'Account Details',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: AppColors.baseColor,
          ),
          body: ChangeNotifierProvider<AccountPageViewModel>(
              create: (BuildContext context) => accountPageViewModel,
              child:
                  Consumer<AccountPageViewModel>(builder: (context, value, _) {
                switch (value.accountPageGetTabularData.status) {
                  case Status.LOADING:
                    return const Center(child: CircularProgressIndicator());
                  case Status.ERROR:
                    return CustomToastSnackBarProgressDialog
                        .flushBarErrorMessage(
                            value.accountPageGetTabularData.message.toString(),
                            context);

                  case Status.COMPLETED:
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                alignment: Alignment.center,
                                // width: size.width * 0.99,
                                height: coverHeight,
                                decoration: const BoxDecoration(
                                    // shape: BoxShape.circle,
                                    //borderRadius: BorderRadius.circular(25),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color.fromARGB(255, 3, 47, 97),
                                          blurRadius: 5,
                                          offset: Offset(2.0, 5.0))
                                    ],
                                    color: Color.fromARGB(255, 130, 193, 245),
                                    gradient: LinearGradient(
                                      colors: [
                                        AppColors.lightGreen,
                                        AppColors.lightGreen,
                                      ],
                                    )),
                              ),
                              Stack(children: [
                                Visibility(
                                  visible: _isVisiblePickImage,
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 20.0),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius:
                                            MediaQuery.of(context).size.height *
                                                0.095,
                                        child: CircleAvatar(
                                          backgroundColor: AppColors.lightGreen,
                                          radius: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.09,
                                          child: ClipOval(
                                              child: _imagePath != null
                                                  ? Image.file(
                                                      File(
                                                          _imagePath!), // Use Image.file for local files
                                                      height: 200,
                                                      width: 200,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : Image.asset(
                                                      'assets/person_icon.jpg',
                                                      height: 200,
                                                      width: 200,
                                                      fit: BoxFit.cover,
                                                    )),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: _isVisibleNetwork,
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 20.0),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius:
                                            MediaQuery.of(context).size.height *
                                                0.095,
                                        child: CircleAvatar(
                                          backgroundColor: AppColors.baseColor,
                                          radius: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.09,
                                          child: ClipOval(
                                              child: _imagePath != null
                                                  ? Image.network(
                                                      Uri.parse(_imagePath!)
                                                          .toString(), // Use Uri.parse for network URLs
                                                      height: 200,
                                                      width: 200,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : Image.asset(
                                                      'assets/person_icon.jpg',
                                                      height: 200,
                                                      width: 200,
                                                      fit: BoxFit.cover,
                                                    )),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: topPlus,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.6),
                                    child: FloatingActionButton(
                                      onPressed: pickImageOptions,
                                      tooltip: 'Pick Image from gallery',
                                      child: CircleAvatar(
                                        radius: plusHeight,
                                        backgroundColor: AppColors.baseColor,
                                        child: Icon(
                                          Icons.camera_enhance,
                                          size: plusHeight + 5,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.22,
                                    bottom: 10,
                                    // left: MediaQuery.of(context).size.width * 0.22,
                                  ),
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        _name,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ),
                              ]),
                              Positioned(
                                top: top,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 10.0),
                                    padding: const EdgeInsets.all(8),
                                    // alignment: Alignment.center,
                                    width: MediaQuery.of(context).size.width,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        // shape: BoxShape.circle,
                                        borderRadius: BorderRadius.circular(25),
                                        boxShadow: const [
                                          BoxShadow(
                                              color: AppColors.black,
                                              blurRadius: 5,
                                              offset: Offset(2.0, 5.0))
                                        ],
                                        color: const Color.fromARGB(
                                            255, 130, 193, 245),
                                        gradient: const LinearGradient(
                                          colors: [
                                            AppColors.baseColor,
                                            AppColors.pinkColor,
                                            // AppColors.buttonOrange,
                                            AppColors.baseColor,
                                          ],
                                        )),
                                    child: const Expanded(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Profile Details",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Form(
                            key: _formkeyMain,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20.0, left: 40, right: 40),
                                    child: Row(children: [
                                      const Expanded(
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "User Type: ",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: AppColors.baseColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: TextFormField(
                                              enabled: _userTypeEnabled,
                                              controller: _userType,
                                              style: const TextStyle(
                                                  color: AppColors.baseColor,
                                                  fontSize: 16),
                                              decoration: const InputDecoration(
                                                hintText: 'User Type',
                                              ),
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Please enter User Type";
                                                } else {
                                                  return null;
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 40, right: 40),
                                  child: Row(children: [
                                    const Expanded(
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "First Name: ",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: AppColors.baseColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: TextFormField(
                                            enabled: _firstNameEnabled,
                                            controller: _firstName,
                                            style: const TextStyle(
                                                color: AppColors.baseColor,
                                                fontSize: 16),
                                            obscureText: false,
                                            decoration: const InputDecoration(
                                              hintText: 'First Name',
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Please enter First Name";
                                              } else {
                                                return null;
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 40, right: 40),
                                  child: Row(children: [
                                    const Expanded(
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Last Name: ",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: AppColors.baseColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: TextFormField(
                                            enabled: _lastNameEnabled,
                                            controller: _lastName,
                                            style: const TextStyle(
                                                color: AppColors.baseColor,
                                                fontSize: 16),
                                            obscureText: false,
                                            decoration: const InputDecoration(
                                              hintText: 'Last Name',
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Please enter Last Name";
                                              } else {
                                                return null;
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 4.0, left: 40, right: 40),
                                  child: Row(children: [
                                    const Expanded(
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Email: ",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: AppColors.baseColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: TextFormField(
                                            enabled: _emailEnabled,
                                            controller: _email,
                                            style: const TextStyle(
                                                color: AppColors.baseColor,
                                                fontSize: 16),
                                            obscureText: false,
                                            decoration: const InputDecoration(
                                              hintText: 'Email',
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Please enter Email";
                                              } else {
                                                return null;
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 40, right: 40),
                                  child: Row(children: [
                                    const Expanded(
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Phone Number: ",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: AppColors.baseColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            enabled: _phoneNumberEnabled,
                                            controller: _phoneNumber,
                                            style: const TextStyle(
                                                color: AppColors.baseColor,
                                                fontSize: 16),
                                            obscureText: false,
                                            decoration: const InputDecoration(
                                              hintText: 'Phone Number',
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Please enter Phone Number";
                                              } else {
                                                return null;
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 40, right: 40),
                                  child: Row(children: [
                                    const Expanded(
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Address: ",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: AppColors.baseColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            enabled: _officeNumberEnabled,
                                            controller: _address,
                                            style: const TextStyle(
                                                color: AppColors.baseColor,
                                                fontSize: 16),
                                            obscureText: false,
                                            decoration: const InputDecoration(
                                              hintText: 'Address',
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Please enter Address";
                                              } else {
                                                return null;
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: _editProfile,
                            child: Container(
                                margin: const EdgeInsets.only(top: 20.0),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _emailEnabled = true;
                                      _firstNameEnabled = true;
                                      _lastNameEnabled = true;
                                      _phoneNumberEnabled = true;
                                      _officeNumberEnabled = true;
                                      _userDetailsUpdate = true;
                                      _editProfile = false;
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        left: 60, right: 60, bottom: 10.0),
                                    padding: const EdgeInsets.all(8),
                                    alignment: Alignment.center,
                                    // width: MediaQuery.of(context).size.width,
                                    height: 40,
                                    decoration: const BoxDecoration(
                                        // shape: BoxShape.circle,
                                        // borderRadius: BorderRadius.circular(25),
                                        boxShadow: [
                                          BoxShadow(
                                              color: AppColors.black,
                                              blurRadius: 5,
                                              offset: Offset(2.0, 5.0))
                                        ],
                                        color:
                                            Color.fromARGB(255, 130, 193, 245),
                                        gradient: LinearGradient(
                                          colors: [
                                            AppColors.baseColor,
                                            AppColors.lightGreen,
                                            AppColors.baseColor,
                                          ],
                                        )),
                                    child: const Row(children: [
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Edit profile",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ),
                                )),
                          ),
                          Visibility(
                            visible: _userDetailsUpdate,
                            child: Container(
                                margin: const EdgeInsets.only(top: 8.0),
                                child: InkWell(
                                  onTap: () {
                                    if (_formkeyMain.currentState!.validate()) {
                                      submitImage(_imagePath!);
                                      //  updateData();
                                    } else {
                                      print(
                                          "Please fill all mendetory fields!!!");
                                    }
                                    // submitImage(_imagePath!);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        left: 60, right: 60, bottom: 10.0),
                                    padding: const EdgeInsets.all(8),
                                    alignment: Alignment.center,
                                    width: MediaQuery.of(context).size.width,
                                    height: 40,
                                    decoration: const BoxDecoration(
                                        // shape: BoxShape.circle,
                                        // borderRadius: BorderRadius.circular(25),
                                        boxShadow: [
                                          BoxShadow(
                                              color: AppColors.black,
                                              blurRadius: 5,
                                              offset: Offset(2.0, 5.0))
                                        ],
                                        color:
                                            Color.fromARGB(255, 130, 193, 245),
                                        gradient: LinearGradient(
                                          colors: [
                                            AppColors.baseColor,
                                            AppColors.lightGreen,
                                            AppColors.baseColor,
                                          ],
                                        )),
                                    child: const Row(children: [
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Update",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ),
                                )),
                          ),
                          Container(
                              margin: const EdgeInsets.only(top: 8.0),
                              child: InkWell(
                                onTap: () {
                                  changePassword();
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 60, right: 60, bottom: 10.0),
                                  padding: const EdgeInsets.all(8),
                                  alignment: Alignment.center,
                                  width: MediaQuery.of(context).size.width,
                                  height: 40,
                                  decoration: const BoxDecoration(
                                      // shape: BoxShape.circle,
                                      // borderRadius: BorderRadius.circular(25),
                                      boxShadow: [
                                        BoxShadow(
                                            color: AppColors.black,
                                            blurRadius: 5,
                                            offset: Offset(2.0, 5.0))
                                      ],
                                      color: Color.fromARGB(255, 130, 193, 245),
                                      gradient: LinearGradient(
                                        colors: [
                                          AppColors.baseColor,
                                          AppColors.lightGreen,
                                          AppColors.baseColor,
                                        ],
                                      )),
                                  child: const Row(children: [
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Change Password",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                                ),
                              )),
                          Container(
                              margin: const EdgeInsets.only(top: 8.0),
                              child: InkWell(
                                onTap: () async {
                                  userPreferences.remove().then((value) {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                const LoginPagePemc()));
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 60, right: 60, bottom: 10.0),
                                  padding: const EdgeInsets.all(8),
                                  alignment: Alignment.center,
                                  width: MediaQuery.of(context).size.width,
                                  height: 40,
                                  decoration: const BoxDecoration(
                                      // shape: BoxShape.circle,
                                      // borderRadius: BorderRadius.circular(25),
                                      boxShadow: [
                                        BoxShadow(
                                            color: AppColors.black,
                                            blurRadius: 5,
                                            offset: Offset(2.0, 5.0))
                                      ],
                                      color: Color.fromARGB(255, 130, 193, 245),
                                      gradient: LinearGradient(
                                        colors: [
                                          AppColors.baseColor,
                                          AppColors.lightGreen,
                                          AppColors.baseColor,
                                        ],
                                      )),
                                  child: const Row(children: [
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Log Out",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                                ),
                              )),
                          Container(
                              margin: const EdgeInsets.only(top: 8.0),
                              child: InkWell(
                                onTap: () async {
                                  openDailogDeleteAccount();
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 60, right: 60, bottom: 10.0),
                                  padding: const EdgeInsets.all(8),
                                  alignment: Alignment.center,
                                  width: MediaQuery.of(context).size.width,
                                  height: 40,
                                  decoration: const BoxDecoration(
                                      // shape: BoxShape.circle,
                                      // borderRadius: BorderRadius.circular(25),
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                Color.fromARGB(255, 96, 8, 1),
                                            blurRadius: 5,
                                            offset: Offset(2.0, 5.0))
                                      ],
                                      color: Color.fromARGB(255, 130, 193, 245),
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.red,
                                          Colors.red,
                                        ],
                                      )),
                                  child: const Row(children: [
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Delete Account",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                                ),
                              )),
                        ],
                      ),
                    );

                  default:
                    return const Text('data');
                }
              }))),
    );
  }

  Future changePassword() => showDialog(
      context: context,
      builder: (context) => Form(
          key: _formkey,
          child: AlertDialog(
              title: const Text(
                'Change Password',
                style: TextStyle(
                    color: Color.fromARGB(255, 3, 47, 97),
                    fontWeight: FontWeight.bold),
              ),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 5.0, left: 5.0, bottom: 10.0),
                        child: TextFormField(
                          controller: _currentPassword,
                          style: const TextStyle(
                              color: AppColors.baseColor, fontSize: 20),
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            border: const OutlineInputBorder(),
                            //hintMaxLines: 5,
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                              color: AppColors.baseColor,
                            )),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              child: Icon(_obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                            labelText: 'Password ',
                            labelStyle: const TextStyle(
                              color: Color.fromARGB(255, 47, 62, 74),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Enter Correct Password";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: TextFormField(
                          controller: _password,
                          obscureText: _obscureText2,
                          //keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                  // borderRadius: BorderRadius.circular(25),
                                  ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 3, 47, 97),
                                ),
                                // borderRadius: BorderRadius.circular(25),
                              ),
                              //labelText: getCurrentDate(),
                              suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    _obscureText2 = !_obscureText2;
                                  });
                                },
                                child: Icon(_obscureText2
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                              ),
                              hintText: 'New Password'),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: TextFormField(
                          controller: _confirmPassword,
                          obscureText: _obscureText3,
                          //keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                  // borderRadius: BorderRadius.circular(25),
                                  ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 3, 47, 97),
                                ),
                                // borderRadius: BorderRadius.circular(25),
                              ),
                              //labelText: getCurrentDate(),
                              suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    _obscureText3 = !_obscureText3;
                                  });
                                },
                                child: Icon(_obscureText3
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                              ),
                              hintText: 'Confirm Password'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Enter Password again";
                            }
                            if (_password.text != _confirmPassword.text) {
                              return "Password does not match";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10, left: 40),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: (() {
                          if (_formkey.currentState!.validate()) {
                            // final snackBar = const SnackBar(
                            //     content: Text('Password updating'));
                            resetPassword();
                            Navigator.pop(context);
                          }
                        }),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: MediaQuery.of(context).size.height * 0.052,
                            decoration: const BoxDecoration(
                                // shape: BoxShape.circle,

                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromARGB(255, 1, 58, 3),
                                      blurRadius: 5,
                                      offset: Offset(2.0, 5.0))
                                ],
                                color: Colors.black,
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 1, 91, 4),
                                    Color.fromARGB(255, 1, 91, 4),
                                  ],
                                )),
                            child: const Row(children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Update",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (() {
                          Navigator.of(context).pop();
                        }),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: MediaQuery.of(context).size.height * 0.052,
                            decoration: const BoxDecoration(
                                // shape: BoxShape.circle,

                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromARGB(255, 101, 4, 4),
                                      blurRadius: 5,
                                      offset: Offset(2.0, 5.0))
                                ],
                                color: Colors.black,
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 206, 31, 31),
                                    Color.fromARGB(255, 228, 18, 147),
                                    Color.fromARGB(255, 215, 7, 0),
                                  ],
                                )),
                            child: const Row(children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Cancel",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ])));

  Future pickImageOptions() => showDialog(
      context: context,
      builder: (context) => Form(
          key: _formkey,
          child: AlertDialog(
              title: const Text(
                'Choose Image',
                style: TextStyle(
                    color: Color.fromARGB(255, 3, 47, 97),
                    fontWeight: FontWeight.bold),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: (() {
                            _pickImageCamera();
                            Navigator.pop(context);
                          }),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: MediaQuery.of(context).size.height * 0.052,
                            decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromARGB(255, 1, 58, 3),
                                      blurRadius: 5,
                                      offset: Offset(2.0, 5.0))
                                ],
                                color: Colors.black,
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 1, 91, 4),
                                    Color.fromARGB(255, 1, 91, 4),
                                  ],
                                )),
                            child: const Row(children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Camera",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: (() {
                            _pickImageGallery();
                            Navigator.pop(context);
                          }),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              height:
                                  MediaQuery.of(context).size.height * 0.052,
                              decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color.fromARGB(255, 1, 58, 3),
                                        blurRadius: 5,
                                        offset: Offset(2.0, 5.0))
                                  ],
                                  color: Colors.black,
                                  gradient: LinearGradient(
                                    colors: [
                                      Color.fromARGB(255, 1, 91, 4),
                                      Color.fromARGB(255, 1, 91, 4),
                                    ],
                                  )),
                              child: const Row(children: [
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Gallery",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ])));

  getData() async {
    print(accountPageViewModel
        .accountPageGetTabularData.data?.userDetails?.address);
    print('00000000000000000000');
    print(accountPageViewModel
        .accountPageGetTabularData.data!.userDetails!.userType
        .toString());
    print('00000000000000000000');
    setState(() {
      _name =
          '${accountPageViewModel.accountPageGetTabularData.data!.userDetails!.fName.toString()} ${accountPageViewModel.accountPageGetTabularData.data!.userDetails!.lName.toString()}';
      _firstName.text = (accountPageViewModel
                  .accountPageGetTabularData.data!.userDetails!.fName
                  .toString()
                  .isEmpty ||
              accountPageViewModel
                      .accountPageGetTabularData.data!.userDetails!.fName ==
                  null ||
              accountPageViewModel
                      .accountPageGetTabularData.data!.userDetails!.fName
                      .toString() ==
                  'null')
          ? ''
          : accountPageViewModel
              .accountPageGetTabularData.data!.userDetails!.fName
              .toString();
      _lastName.text = (accountPageViewModel
                  .accountPageGetTabularData.data!.userDetails!.lName
                  .toString()
                  .isEmpty ||
              accountPageViewModel
                      .accountPageGetTabularData.data!.userDetails!.lName ==
                  null ||
              accountPageViewModel
                      .accountPageGetTabularData.data!.userDetails!.lName
                      .toString() ==
                  'null')
          ? ''
          : accountPageViewModel
              .accountPageGetTabularData.data!.userDetails!.lName
              .toString();
      _email.text = (accountPageViewModel
                  .accountPageGetTabularData.data!.userDetails!.email
                  .toString()
                  .isEmpty ||
              accountPageViewModel
                      .accountPageGetTabularData.data!.userDetails!.email ==
                  null ||
              accountPageViewModel
                      .accountPageGetTabularData.data!.userDetails!.email
                      .toString() ==
                  'null')
          ? ''
          : accountPageViewModel
              .accountPageGetTabularData.data!.userDetails!.email
              .toString();

      if (accountPageViewModel
              .accountPageGetTabularData.data!.userDetails!.userType
              .toString() ==
          '1') {
        _userType.text = 'ADMIN';
      } else if (accountPageViewModel
              .accountPageGetTabularData.data!.userDetails!.userType
              .toString() ==
          '2') {
        _userType.text = 'SUPERVISOR';
      } else if (accountPageViewModel
              .accountPageGetTabularData.data!.userDetails!.userType
              .toString() ==
          '3') {
        _userType.text = 'CONTRACTOR';
      } else if (accountPageViewModel
              .accountPageGetTabularData.data!.userDetails!.userType
              .toString() ==
          '4') {
        _userType.text = 'CREW';
      } else if (accountPageViewModel
              .accountPageGetTabularData.data!.userDetails!.userType
              .toString() ==
          '6') {
        _userType.text = 'PLANNER';
      }
      _phoneNumber.text = (accountPageViewModel
                  .accountPageGetTabularData.data!.userDetails!.mobile
                  .toString()
                  .isEmpty ||
              accountPageViewModel
                      .accountPageGetTabularData.data!.userDetails!.mobile ==
                  null ||
              accountPageViewModel
                      .accountPageGetTabularData.data!.userDetails!.mobile
                      .toString() ==
                  'null')
          ? ''
          : accountPageViewModel
              .accountPageGetTabularData.data!.userDetails!.mobile
              .toString();
      _address.text = (accountPageViewModel
                  .accountPageGetTabularData.data!.userDetails!.address
                  .toString()
                  .isEmpty ||
              accountPageViewModel
                      .accountPageGetTabularData.data!.userDetails!.address ==
                  null ||
              accountPageViewModel
                      .accountPageGetTabularData.data!.userDetails!.address
                      .toString() ==
                  'null')
          ? ''
          : accountPageViewModel
              .accountPageGetTabularData.data!.userDetails!.address
              .toString();

      Image.network(
        'https://civm.ariespro.com/assets/clientuploads/${accountPageViewModel.accountPageGetTabularData.data!.userDetails!.profilePhoto.toString()}',
      );
      String imageUrl =
          'https://civm.ariespro.com/assets/clientuploads/${accountPageViewModel.accountPageGetTabularData.data!.userDetails!.profilePhoto.toString()}';
      _imagePath = imageUrl;
    });
  }

  showSnackBar(String msg) {
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: '',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _pickImageCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        _imagePath = imageTemporary.path;
        _isVisiblePickImage = true;
        _isVisibleNetwork = false;
        print("Camera Image Path: $_imagePath");
      });
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<void> _pickImageGallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        _imagePath = imageTemporary.path;
        _isVisiblePickImage = true;
        _isVisibleNetwork = false;
        print("Gallery Image Path: $_imagePath");
      });
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<void> submitImage(String fileName) async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    try {
      var uri = Uri.parse(
          "https://atsdev2test.ariespro.com/civmapi/login_user/update_user_image_profile");
      var request = http.MultipartRequest("PUT", uri);
      final userPreferences = Provider.of<UserPref>(context, listen: false);
      UserModel data = await userPreferences.getUser();

      print('_imagePath: $_imagePath');

      if (_imagePath != '') {
        File img = File(_imagePath!);
        File file = await img.copy(
            '$tempPath/img_${DateFormat('yyyyMMddHHmmss').format(DateTime.now())}${_imagePath!.contains('.pdf') ? '.pdf' : '.jpg'}');

        var stream = http.ByteStream(file.openRead());
        var length = await file.length();

        // Get the file length
        var multipartFile = http.MultipartFile("file", stream, length,
            filename: path.basename(file.path));
        request.files.add(multipartFile);
        print('file.path111111111111111111');
        print(path.basename(file.path)); // Add the single file to the request
      }
      print('222');
      request.headers['Authorization'] = 'Bearer ${data.token!}';
      request.headers['Content-Type'] = 'multipart/form-data';

      print('333');
      // Send the request
      var streamedResponse = await request.send();
      String responseBody = await streamedResponse.stream.bytesToString();
      if (streamedResponse.statusCode == 200) {
        print('Image Successfully Uploaded');
        fetchData();
        a = jsonDecode(responseBody);
        imageNewName = a['createChangeOrderImage'];
        print('imageNewName');
        print(imageNewName);
        print(a['createChangeOrderImage']);
        updateData();
      } else {
        print('Error: ${streamedResponse.statusCode}');
        print('Error Body: $responseBody');
      }
    } catch (e, stacktrace) {
      CustomToastSnackBarProgressDialog.flushBarErrorMessage(
          'Please Select Image', context);
      print('Exception: $e\n$stacktrace');
    }
    print('object');
  }

  Future<void> fetchData() async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();

    accountPageViewModel.fetchAccountPageTabularListApi(
        context, data.user!.email.toString());
    _isVisiblePickImage = false;
    _isVisibleNetwork = true;
  }

  Future<void> updateData() async {
    const apiUrl =
        'https://atsdev2test.ariespro.com/civmapi/login_user/update_user';
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();

    Map mapData = {
      "id": data.user!.id.toString(),
      "fName": _firstName.text.toString(),
      "lName": _lastName.text.toString(),
      "mobile": _phoneNumber.text.toString(),
      "email": _email.text.toString(),
      "address": _address.text.toString(),
      "profilePhoto": (imageNewName == '')
          ? accountPageViewModel
              .accountPageGetTabularData.data?.userDetails?.profilePhoto
              .toString()
          // .accountPageGetTabularData.data!.userDetails!.profilePhoto
          // .toString()
          : imageNewName
    };

    print(mapData);
    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${data.token}',
        },
        body: jsonEncode(mapData),
      );

      if (response.statusCode == 200) {
        print('Successfully Updated Account Data');
        CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
            'Account Data Successfully Updated', context);
        fetchData();
        Future.delayed(const Duration(seconds: 1), () {
          // getData();
          fetchInitData();
        });
      } else {
        print('Error: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> resetPassword() async {
    print('reset1');
    const apiUrl =
        'https://atsdev2test.ariespro.com/civmapi/login_user/change_password';
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    print('reset password');
    Map mapData = {
      "userName": data.user!.email.toString(),
      "oldPassword": _currentPassword.text.toString(),
      "newPassword": _password.text.toString()
    };

    print(mapData);
    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${data.token}',
        },
        body: jsonEncode(mapData),
      );

      if (response.statusCode == 200) {
        print('Password Changed Successfully');
        CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
            'Password Changed Successfully', context);
      } else {
        print('Error: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<Map<String, dynamic>> fetchInitData() async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    final apiUrl =
        'https://atsdev2test.ariespro.com/civmapi/login_user/get_userDetails_by_username/${data.user?.email}';
    print(apiUrl);
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer ${data.token}',
        'Content-Type': 'application/json'
      },
    );

    if (response.statusCode == 200) {
      print(json.decode(response.body));
      setDataNew(response);
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  void setDataNew(http.Response response) {
    Map<String, dynamic> responseData = json.decode(response.body);
    Map<String, dynamic> userDetails = responseData['userDetails'];
    if (userDetails['userType'] == '1') {
      _userType.text = 'ADMIN';
    } else if (userDetails['userType'] == '2') {
      _userType.text = 'SUPERVISOR';
    } else if (userDetails['userType'] == '3') {
      _userType.text = 'CONTRACTOR';
    } else if (userDetails['userType'] == '4') {
      _userType.text = 'CREW';
    } else if (userDetails['userType'] == '6') {
      _userType.text = 'PLANNER';
    }
    _firstName.text = userDetails['fName'] ?? '';
    _lastName.text = userDetails['lName'] ?? '';
    _email.text = userDetails['email'] ?? '';
    _phoneNumber.text = userDetails['mobile'] ?? '';
    _address.text = userDetails['address'] ?? '';
    id = userDetails['id'];
    setState(() {
      _name = (userDetails['fName'] ?? '') + ' ' + (userDetails['lName'] ?? '');
      Image.network(
        'https://civm.ariespro.com/assets/clientuploads/${userDetails['profilePhoto']}',
      );
      String imageUrl =
          'https://civm.ariespro.com/assets/clientuploads/${userDetails['profilePhoto']}';
      _imagePath = imageUrl;
    });
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

  void openDailogDeleteAccount() => showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            content: SingleChildScrollView(
                child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Are you sure to delete this account?",
                      // textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color.fromARGB(255, 3, 47, 97),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            )),
            actions: [
              Align(
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Container(
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.15,
                            top: 6.0,
                            bottom: 10,
                            right: 2),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10.0),
                            // padding: const EdgeInsets.all(8),
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: 40,
                            decoration: BoxDecoration(
                                // shape: BoxShape.circle,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Color.fromARGB(255, 84, 7, 2),
                                      blurRadius: 5,
                                      offset: Offset(2.0, 5.0))
                                ],
                                color: Colors.black,
                                gradient: const LinearGradient(
                                  colors: [Colors.red, Colors.red],
                                )),
                            child: const Align(
                              alignment: Alignment.center,
                              child: Text(
                                "CANCEL",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        )),
                    Container(
                        margin: const EdgeInsets.only(
                            left: 6, top: 6.0, bottom: 10),
                        child: InkWell(
                          onTap: () {
                            deleteAccount(context);
                            // selfAssign(id, userName);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10.0),
                            // padding: const EdgeInsets.all(8),
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: 40,
                            decoration: BoxDecoration(
                                // shape: BoxShape.circle,

                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Color.fromARGB(255, 1, 91, 4),
                                      blurRadius: 5,
                                      offset: Offset(2.0, 5.0))
                                ],
                                color: Colors.black,
                                gradient: const LinearGradient(
                                  colors: [Colors.green, Colors.green],
                                )),
                            child: const Align(
                              alignment: Alignment.center,
                              child: Text(
                                "YES",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ],
          );
        });
      });

  Future<void> deleteAccount(BuildContext context) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://atsdev2test.ariespro.com/civmapi/lcp_CIVM_NEW/home'),
    );

    request.fields.addAll({'id': '79'}); // your parameter(s)

    try {
      http.StreamedResponse response = await request.send();
      print('delete account code ${response.statusCode}');
      if (response.statusCode == 200) {
        // ✅ Parse or print response if needed
        String responseData = await response.stream.bytesToString();
        print(responseData);

        // ✅ Navigate to login and clear backstack
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginPagePemc()),
          (Route<dynamic> route) => false,
        );
      } else {
        // ❌ Show error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed: ${response.reasonPhrase}")),
        );
      }
    } catch (e) {
      // ❌ Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }
}
