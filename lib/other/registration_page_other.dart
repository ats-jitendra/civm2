import 'dart:convert';
import 'dart:ui';

import 'package:CIVM/other/login_page_other.dart';
import 'package:CIVM/piedmont/resources/app_colors.dart';
import 'package:CIVM/piedmont/screens/login_page.dart';
import 'package:CIVM/piedmont/utils/custom_toast_snackbar_progressdialog.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RagistrationPageOther extends StatefulWidget {
  const RagistrationPageOther({Key? key}) : super(key: key);
  @override
  _RagistrationPageOtherState createState() => _RagistrationPageOtherState();
}

class _RagistrationPageOtherState extends State<RagistrationPageOther> {
  TextEditingController _firstName = TextEditingController();
  TextEditingController _lastName = TextEditingController();
  TextEditingController _email = TextEditingController();

  TextEditingController _password = TextEditingController();
  TextEditingController _confirmpassword = TextEditingController();

  final formkey = GlobalKey<FormState>();

  bool _obscureText = true;
  bool _obscureText2 = true;

  String applicationType = "";
  String otherLogo = "";

  //final userNameController = TextEditingController();
  //final passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getInitData();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor:
            Color.fromRGBO(41, 60, 82, 1), // navigation bar color
        statusBarColor: Color.fromRGBO(41, 60, 82, 1)));

    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,

        //backgroundColor: Colors.amber,
        body: Stack(
          children: [
            // Background container with blur effect applied only to the image
            // Background container with blur effect applied only to the image
            Positioned.fill(
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/login_bg.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        color: Colors.black.withOpacity(
                          0.3,
                        ), // Ensures transparency
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 60),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                            top: 10.0,
                          ),
                          padding: const EdgeInsets.all(8),
                          alignment: Alignment.center,
                          height: size.height * 0.01,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Column(
                            children: [
                              Form(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    // ignore: prefer_const_constructors
                                    children: [
                                      Container(
                                        width: 230,
                                        height: 90,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          child: otherLogo.isNotEmpty
                                              ? Image.asset(
                                                  otherLogo,
                                                  fit: BoxFit.fill,
                                                )
                                              : const SizedBox(),
                                        ),
                                      ),
                                      const Text(
                                        "Register",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 35,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Text(
                                        "Access to Our Dashboard",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Form(
                                        key: formkey,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                right: 5.0,
                                                left: 5.0,
                                              ),
                                              child: TextFormField(
                                                controller: _firstName,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                ),
                                                obscureText: false,
                                                decoration: const InputDecoration(
                                                  prefixIcon: Icon(
                                                    Icons.person,
                                                    color: Colors.white,
                                                  ),

                                                  border: OutlineInputBorder(),

                                                  //hintMaxLines: 5,
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                  labelText:
                                                      'Enter Your First Name ',
                                                  labelStyle: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                validator: (value) {
                                                  if (value!.isEmpty ||
                                                      !RegExp(
                                                        r'^[a-z A-Z]+$',
                                                      ).hasMatch(value)) {
                                                    return "Please Enter Correct First Name";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                right: 5.0,
                                                left: 5.0,
                                              ),
                                              child: TextFormField(
                                                controller: _lastName,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                ),
                                                obscureText: false,
                                                decoration: const InputDecoration(
                                                  prefixIcon: Icon(
                                                    Icons.person_add,
                                                    color: Colors.white,
                                                  ),
                                                  border: OutlineInputBorder(),
                                                  //hintMaxLines: 5,
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                  labelText:
                                                      'Enter Your Last Name ',
                                                  labelStyle: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                validator: (value) {
                                                  if (value!.isEmpty ||
                                                      !RegExp(
                                                        r'^[a-z A-Z]+$',
                                                      ).hasMatch(value)) {
                                                    return "Please Enter Correct Last Name";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                right: 5.0,
                                                left: 5.0,
                                              ),
                                              child: TextFormField(
                                                controller: _email,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                ),
                                                obscureText: false,
                                                decoration: const InputDecoration(
                                                  prefixIcon: Icon(Icons.email,color: Colors.white,),
                                                  border: OutlineInputBorder(),
                                                  //hintMaxLines: 5,
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                  labelText:
                                                      'Enter Your E-mail ID ',
                                                  labelStyle: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                validator: (value) {
                                                  if (value!.isEmpty ||
                                                      !RegExp(
                                                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}',
                                                      ).hasMatch(value)) {
                                                    return "Please Enter Correct E-mail";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                right: 5.0,
                                                left: 5.0,
                                              ),
                                              child: TextFormField(
                                                controller: _password,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                ),
                                                obscureText: _obscureText,
                                                decoration: InputDecoration(
                                                  prefixIcon: const Icon(
                                                    Icons.lock,
                                                    color: Colors.white,
                                                  ),
                                                  border:
                                                      const OutlineInputBorder(),
                                                  //hintMaxLines: 5,
                                                  enabledBorder:
                                                      const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                  suffixIcon: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        _obscureText =
                                                            !_obscureText;
                                                      });
                                                    },
                                                    child: Icon(
                                                      _obscureText
                                                          ? Icons.visibility_off
                                                          : Icons.visibility,
                                                          color: Colors.white,
                                                    ),
                                                  ),
                                                  labelText: 'Enter Password ',
                                                  labelStyle: const TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Please Enter Password";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                right: 5.0,
                                                left: 5.0,
                                              ),
                                              child: TextFormField(
                                                controller: _confirmpassword,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                ),
                                                obscureText: _obscureText2,
                                                decoration: InputDecoration(
                                                  prefixIcon: const Icon(
                                                    Icons.lock,
                                                    color: Colors.white,
                                                  ),
                                                  border:
                                                      const OutlineInputBorder(),
                                                  //hintMaxLines: 5,
                                                  enabledBorder:
                                                      const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                  suffixIcon: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        _obscureText2 =
                                                            !_obscureText2;
                                                      });
                                                    },
                                                    child: Icon(
                                                      _obscureText2
                                                          ? Icons.visibility_off
                                                          : Icons.visibility,
                                                          color: Colors.white,
                                                    ),
                                                  ),
                                                  labelText:
                                                      'Confirm Password ',
                                                  labelStyle: const TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Please Enter Password again";
                                                  }
                                                  if (_password.text !=
                                                      _confirmpassword.text) {
                                                    return "Password does not match";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              //checkbox(value: "", onChanged: onChanged),
                              //SizedBox(
                              //height: 20,
                              //),
                              Container(
                                margin: const EdgeInsets.only(
                                  left: 6,
                                  right: 6,
                                  top: 8.0,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    if (formkey.currentState!.validate()) {
                                      // _showSubmitDataDialog();
                                      Navigator.pop(context);
                                    }

                                    //Constants.prefs.setBool("LoggedIn", true);
                                    //_showSubmitDataDialog();
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                      left: 40,
                                      right: 40,
                                      bottom: 10.0,
                                    ),
                                    padding: const EdgeInsets.all(8),
                                    alignment: Alignment.center,
                                    width: MediaQuery.of(context).size.width,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      // shape: BoxShape.circle,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 5,
                                          offset: Offset(2.0, 5.0),
                                        ),
                                      ],
                                      color: Colors.black,
                                      gradient: const LinearGradient(
                                        colors: [
                                          AppColors.white,
                                          AppColors.white,
                                        ],
                                      ),
                                    ),
                                    child: const Row(
                                      children: [
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Sign Up",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color: AppColors.baseColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Already have an account? ",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.yellowAccent,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              const LoginPageOther(),
                                        ),
                                      );
                                    },
                                    child: const Row(
                                      children: [
                                        Text(
                                          "Sign In",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> registrationUser() async {
    var APIURL =
        "https://atsdev2test.ariespro.com/civmapi/login_user/signup_user/";
    //  "http://civmapi.ariespro.com/api/login/SignUp"; // old API, new integrated on 07Oct2025
    Map<String, dynamic> mappedData = {
      "email": _email.text.trim(),
      "userName": _email.text.trim(),
      "fName": _firstName.text.trim(),
      "lName": _lastName.text.trim(),
      "password": _password.text.trim(),
      "userType": "6",
    };

    print("Json data: $mappedData");

    try {
      final response = await http.post(
        Uri.parse(APIURL),
        headers: {
          "Content-Type": "application/json", // Important!
          "Accept": "application/json",
        },
        body: jsonEncode(mappedData), // Convert to JSON
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        print('Navigating to login');
        CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
          'Registered successfully, admin will approve soon.',
          context,
        );
        Future.delayed(const Duration(seconds: 2), () {
          // Navigator.pushNamed(context, RoutesNamePemc.loginPemc);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext contex) => const LoginPagePemc(),
            ),
          );
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Something went wrong! Please try again.'),
          ),
        );
      }
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  void getInitData() async {
    final prefs = await SharedPreferences.getInstance();

    applicationType = prefs.getString("applicationType") ?? "";

    if (applicationType == "Blue Ridge Electric Member Cooperative") {
      otherLogo = 'assets/blueridge_logo.png';
    } else if (applicationType == "Roanoke Electric Cooperative") {
      otherLogo = 'assets/rec_logo.png';
    } else if (applicationType == "Duncan Power") {
      otherLogo = 'assets/duncan_logo.png';
    } else if (applicationType == "York Electric Cooperative") {
      otherLogo = 'assets/yec_logo.jpg';
    } else if (applicationType == "Broad River Electric Cooperative") {
      otherLogo = 'assets/broadriver_logo.png';
    } else {
      otherLogo = 'assets/Ariespro full logo v2 without BG.png';
    }

    if (mounted) {
      setState(() {});
    }
  }
}
