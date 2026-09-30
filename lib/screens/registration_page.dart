import 'dart:convert';

import 'package:CIVM/screens/login_page.dart';
import 'package:CIVM/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/utils/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class RagistrationPage extends StatefulWidget {
  const RagistrationPage({Key? key}) : super(key: key);
  @override
  _RagistrationPageState createState() => _RagistrationPageState();
}

class _RagistrationPageState extends State<RagistrationPage> {
  TextEditingController _firstName = TextEditingController();
  TextEditingController _lastName = TextEditingController();
  TextEditingController _email = TextEditingController();

  TextEditingController _password = TextEditingController();
  TextEditingController _confirmpassword = TextEditingController();

  final formkey = GlobalKey<FormState>();

  bool _obscureText = true;
  bool _obscureText2 = true;

  //final userNameController = TextEditingController();
  //final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor:
            Color.fromARGB(255, 7, 59, 120), // navigation bar color
        statusBarColor: Color.fromARGB(255, 7, 59, 120)));

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
        body: Stack(children: [
          Container(
            decoration: const BoxDecoration(
                // image: DecorationImage(
                //   image: const AssetImage('assets/bac3.jpg'),
                //   fit: BoxFit.cover,
                //   colorFilter: ColorFilter.mode(
                //       Colors.black.withOpacity(0.45), BlendMode.darken),
                // ),
                ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 60),
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            left: 10, right: 10, top: 10.0),
                        padding: const EdgeInsets.all(8),
                        alignment: Alignment.center,
                        height: size.height * 0.01,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Column(children: [
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
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(
                                    'assets/civm_logo.png',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                                // Image(
                                //   image: const AssetImage(
                                //       'assets/Ariespro full logo v2.png'),
                                //   width:
                                //       MediaQuery.of(context).size.width * 0.9,
                                //   height:
                                //       MediaQuery.of(context).size.height * 0.12,
                                // ),
                                const Text(
                                  "Register",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 35,
                                      color: Color.fromARGB(255, 7, 59, 120),
                                      fontWeight: FontWeight.bold),
                                ),
                                const Text(
                                  "Access to Our Dashboard",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Color.fromARGB(255, 7, 59, 120),
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Form(
                                  key: formkey,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 5.0, left: 5.0),
                                        child: TextFormField(
                                          controller: _firstName,
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 7, 59, 120),
                                              fontSize: 20),
                                          obscureText: false,
                                          decoration: const InputDecoration(
                                            prefixIcon: Icon(Icons.person),

                                            border: OutlineInputBorder(),

                                            //hintMaxLines: 5,
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 7, 59, 120),
                                              ),
                                            ),
                                            labelText: 'Enter Your First Name ',
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty ||
                                                !RegExp(r'^[a-z A-Z]+$')
                                                    .hasMatch(value)) {
                                              return "Please Enter Correct First Name";
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 5.0, left: 5.0),
                                        child: TextFormField(
                                          controller: _lastName,
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 7, 59, 120),
                                              fontSize: 20),
                                          obscureText: false,
                                          decoration: const InputDecoration(
                                            prefixIcon: Icon(Icons.person_add),
                                            border: OutlineInputBorder(),
                                            //hintMaxLines: 5,
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 7, 59, 120),
                                            )),
                                            labelText: 'Enter Your Last Name ',
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty ||
                                                !RegExp(r'^[a-z A-Z]+$')
                                                    .hasMatch(value)) {
                                              return "Please Enter Correct Last Name";
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                      ),
                                      // const SizedBox(
                                      //   height: 20,
                                      // ),
                                      // Padding(
                                      //   padding: const EdgeInsets.only(
                                      //       right: 5.0, left: 5.0),
                                      //   child: TextFormField(
                                      //     controller: _userName,
                                      //     style: const TextStyle(
                                      //         color: Color.fromARGB(
                                      //             255, 7, 59, 120),
                                      //         fontSize: 20),
                                      //     obscureText: false,
                                      //     decoration: const InputDecoration(
                                      //       prefixIcon: Icon(Icons
                                      //           .person_add_alt_1_outlined),
                                      //       border: OutlineInputBorder(),
                                      //       //hintMaxLines: 5,
                                      //       enabledBorder: OutlineInputBorder(
                                      //           borderSide: BorderSide(
                                      //         color: Color.fromARGB(
                                      //             255, 7, 59, 120),
                                      //       )),
                                      //       labelText: 'Enter Your User Name ',
                                      //     ),
                                      //     validator: (value) {
                                      //       if (value!.isEmpty ||
                                      //           !RegExp(r'^[a-z A-Z]+$')
                                      //               .hasMatch(value)) {
                                      //         return "Please Enter Correct User Name";
                                      //       } else {
                                      //         return null;
                                      //       }
                                      //     },
                                      //   ),
                                      // ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 5.0, left: 5.0),
                                        child: TextFormField(
                                          controller: _email,
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 7, 59, 120),
                                              fontSize: 20),
                                          obscureText: false,
                                          decoration: const InputDecoration(
                                            prefixIcon: Icon(Icons.email),
                                            border: OutlineInputBorder(),
                                            //hintMaxLines: 5,
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 7, 59, 120),
                                            )),
                                            labelText: 'Enter Your E-mail ID ',
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty ||
                                                !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}')
                                                    .hasMatch(value)) {
                                              return "Please Enter Correct E-mail";
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 5.0, left: 5.0),
                                        child: TextFormField(
                                          controller: _password,
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 7, 59, 120),
                                              fontSize: 20),
                                          obscureText: _obscureText,
                                          decoration: InputDecoration(
                                            prefixIcon: const Icon(Icons.lock),
                                            border: const OutlineInputBorder(),
                                            //hintMaxLines: 5,
                                            enabledBorder:
                                                const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 7, 59, 120),
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
                                            labelText: 'Enter Password ',
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
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 5.0, left: 5.0),
                                        child: TextFormField(
                                          controller: _confirmpassword,
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 7, 59, 120),
                                              fontSize: 20),
                                          obscureText: _obscureText2,
                                          decoration: InputDecoration(
                                            prefixIcon: const Icon(Icons.lock),
                                            border: const OutlineInputBorder(),
                                            //hintMaxLines: 5,
                                            enabledBorder:
                                                const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 7, 59, 120),
                                            )),
                                            suffixIcon: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _obscureText2 =
                                                      !_obscureText2;
                                                });
                                              },
                                              child: Icon(_obscureText2
                                                  ? Icons.visibility_off
                                                  : Icons.visibility),
                                            ),
                                            labelText: 'Confirm Password ',
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
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                          //checkbox(value: "", onChanged: onChanged),
                          //SizedBox(
                          //height: 20,
                          //),
                          Container(
                              margin: const EdgeInsets.only(
                                  left: 6, right: 6, top: 8.0),
                              child: InkWell(
                                onTap: () {
                                  if (formkey.currentState!.validate()) {
                                    // final snackBar = const SnackBar(
                                    //     content: Text('Submitting Form'));
                                    _showSubmitDataDialog();

                                    // _scaffoldkey.currentState!.showSnackBar(SnackBar);
                                  }

                                  //Constants.prefs.setBool("LoggedIn", true);
                                  //_showSubmitDataDialog();
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 40, right: 40, bottom: 10.0),
                                  padding: const EdgeInsets.all(8),
                                  alignment: Alignment.center,
                                  width: MediaQuery.of(context).size.width,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      // shape: BoxShape.circle,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: const [
                                        BoxShadow(
                                            color:
                                                Color.fromARGB(255, 3, 47, 97),
                                            blurRadius: 5,
                                            offset: Offset(2.0, 5.0))
                                      ],
                                      color:
                                          const Color.fromARGB(255, 3, 47, 97),
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color.fromARGB(255, 7, 59, 120),
                                          Color.fromARGB(255, 7, 59, 120),
                                        ],
                                      )),
                                  child: const Row(children: [
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Sign Up",
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

                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Already have an account? ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const LoginPage()));
                                },
                                child: const Row(children: [
                                  Text(
                                    "Sign In",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 7, 59, 120),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ]),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ]),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: const [
                      //     Text(
                      //       "Powered by ",
                      //       textAlign: TextAlign.center,
                      //       style: TextStyle(
                      //           fontSize: 15,
                      //           color: Colors.black,
                      //           fontWeight: FontWeight.bold),
                      //     ),
                      //     Text(
                      //       "AriesPro",
                      //       textAlign: TextAlign.center,
                      //       style: TextStyle(
                      //           fontSize: 20,
                      //           color: Colors.purple,
                      //           fontWeight: FontWeight.bold),
                      //     ),
                      //   ],
                      // ),
                    ],
                  )),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  void _showSubmitDataDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return Container(
            child: AlertDialog(
              title: const Text('Are you sure to submit?'),
              // content: Text("Are you sure to submit?"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("NO")),
                TextButton(
                    onPressed: () {
                      // sendData();
                      Navigator.pop(context);
                      //  Navigator.pushReplacementNamed(context, "/login");
                      registrationUser();
                    },
                    child: const Text("Yes")),
              ],
            ),
          );
        });
  }

  Future<void> registrationUser() async {
    var APIURL = "https://civm2.ariespro.com/civm2/login_user/signup_user/";
    //  "http://civmapi.ariespro.com/api/login/SignUp"; // old API, new integrated on 07Oct2025
    Map<String, dynamic> mappedData = {
      "email": _email.text.trim(),
      "userName": _email.text.trim(),
      "fName": _firstName.text.trim(),
      "lName": _lastName.text.trim(),
      "password": _password.text.trim(),
      "userType": "6"
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
            'Registered successfully, admin will approve soon.', context);
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushNamed(context, RoutesName.login);
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }
}
