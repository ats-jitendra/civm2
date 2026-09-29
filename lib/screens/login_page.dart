import 'dart:ui';

import 'package:CIVM/screens/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:CIVM/models/login_model.dart';
import 'package:CIVM/resources/component/round_button.dart';
import 'package:CIVM/utils/routes/route_name.dart';
import 'package:CIVM/view_model/login_view_model.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formkey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscureText = true;
  LoginModel? loginmodel;

  bool isCheckedRememberMe = false;

  DateTime now = DateTime.now();
  int currentYear = getCurrentYear();
  bool dynamicIsCheckedRememberMe = false;
  @override
  void initState() {
    super.initState();
    _loadRememberMeStatus();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<LoginViewModel>(context);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor:
            Color.fromARGB(255, 7, 59, 120), // navigation bar color
        statusBarColor: Color.fromARGB(255, 7, 59, 120)));

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: Stack(children: [
          // Background container with blur effect applied only to the image
          Positioned.fill(
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/bac3.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      color:
                          Colors.black.withOpacity(0.3), // Ensures transparency
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
                padding: const EdgeInsets.only(top: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            left: 10, right: 10, top: 70.0),
                        padding: const EdgeInsets.all(8),
                        alignment: Alignment.center,
                      ),
                      Column(children: [
                        Form(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
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
                              //   width: MediaQuery.of(context).size.width * 0.9,
                              //   height:
                              //       MediaQuery.of(context).size.height * 0.12,
                              // ),
                              const Padding(
                                padding: EdgeInsets.only(top: 20.0),
                                child: Text(
                                  "Login",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 35,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const Text(
                                "Access to Our Dashboard",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Form(
                                key: formkey,
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 5.0, left: 5.0),
                                      child: TextFormField(
                                        controller: _userNameController,
                                        cursorColor: Colors.white,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            //  Color.fromARGB(
                                            //     255, 7, 59, 120),
                                            fontSize: 20),
                                        obscureText: false,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),

                                          //hintMaxLines: 5,
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                              //  Color.fromARGB(
                                              //     255, 7, 59, 120),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors
                                                  .white, // White color for the border when focused
                                            ),
                                          ),
                                          labelText: 'Username',
                                          labelStyle: TextStyle(
                                            color: Colors.white,
                                            //  Color.fromARGB(
                                            //     255, 47, 62, 74),
                                          ),
                                          prefixIcon: Icon(
                                            Icons.person,
                                            color: Colors.white,
                                          ),
                                        ),
                                        // validator: (value) {
                                        //   if (value!.isEmpty ||
                                        //       !RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                        //           .hasMatch(value)) {
                                        //     return "Please Enter Correct User Name";
                                        //   } else {
                                        //     return null;
                                        //   }
                                        // },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 5.0, left: 5.0, bottom: 10.0),
                                      child: TextFormField(
                                        controller: _passwordController,
                                        cursorColor: Colors.white,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            // Color.fromARGB(
                                            //     255, 7, 59, 120),
                                            fontSize: 20),
                                        obscureText: _obscureText,
                                        decoration: InputDecoration(
                                          prefixIcon: const Icon(
                                            Icons.lock,
                                            color: Colors.white,
                                          ),
                                          border: const OutlineInputBorder(),
                                          //hintMaxLines: 5,
                                          enabledBorder:
                                              const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                            color: Colors.white,
                                            //  Color.fromARGB(
                                            //     255, 7, 59, 120),
                                          )),
                                          suffixIcon: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _obscureText = !_obscureText;
                                              });
                                            },
                                            child: Icon(
                                              _obscureText
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              color: Colors.white,
                                            ),
                                          ),
                                          focusedBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors
                                                  .white, // White color for the border when focused
                                            ),
                                          ),
                                          labelText: 'Password ',
                                          labelStyle: const TextStyle(
                                            color: Colors.white,
                                            // Color.fromARGB(
                                            //     255, 47, 62, 74),
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
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height: 24.0,
                                      width: 24.0,
                                      child: Theme(
                                        data: ThemeData(
                                          unselectedWidgetColor: Colors.white,
                                        ),
                                        child: Checkbox(
                                          activeColor: const Color.fromARGB(
                                              255, 7, 59, 120),
                                          value: isCheckedRememberMe,
                                          side: const BorderSide(
                                              color: Colors.white, width: 2),
                                          onChanged: (value) {
                                            // Call the onChanged callback with the updated value
                                            setState(() {
                                              isCheckedRememberMe = value!;
                                            });
                                            
                                            actionRememberMe(
                                                value!); // Call your function with the updated value
                                          },
                                        ),
                                      ),
                                    ),
                                    const Text(
                                      "Remember Me",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // const SizedBox(width: 10.0),

                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, RoutesName.forgotPassword);
                                },
                                child: const Text(
                                  "Forgot Password?",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        RoundButton(
                          title: 'Sign In',
                          loading: authViewModel.loading,
                          onPress: () {
                            if (formkey.currentState!.validate()) {
                              Map data = {
                                'username':
                                    _userNameController.text.toString().trim(),
                                'password':
                                    _passwordController.text.toString().trim(),
                              };
                              getTokenAndUseIt();
                              // authViewModel.loginApi(data, context);
                            } else {
                              print("Incorrect User Id or Password!!!");
                            }
                          },
                        ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        // const SizedBox(
                        //               height: 50,
                        //             ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account? ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.yellow,
                                  fontWeight: FontWeight.bold),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const RagistrationPage()));
                              },
                              child: const Row(children: [
                                Text(
                                  "Sign Up",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
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

                      // Card(
                      //   color:
                      //   //  Colors.white.withOpacity(0.5),
                      //   Color.fromARGB(
                      //                                 255, 7, 59, 120).withOpacity(0.5),
                      //   margin: const EdgeInsets.only(
                      //       left: 16.0, right: 16, bottom: 16, top: 10),
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(10.0),
                      //     child: Column(children: [
                      //       Form(
                      //           child: Padding(
                      //         padding: const EdgeInsets.all(16.0),
                      //         child: Column(
                      //           // ignore: prefer_const_constructors
                      //           children: [
                      //             Image(
                      //               image: const AssetImage(
                      //                   'assets/civm_logo.png'),
                      //               width:
                      //                   MediaQuery.of(context).size.width * 0.9,
                      //               height: MediaQuery.of(context).size.height *
                      //                   0.12,
                      //             ),
                      //             const Padding(
                      //               padding: EdgeInsets.only(top: 8.0),
                      //               child: Text(
                      //                 "Login",
                      //                 textAlign: TextAlign.center,
                      //                 style: TextStyle(
                      //                     fontSize: 35,
                      //                     color:
                      //                         Color.fromARGB(255, 7, 59, 120),
                      //                     fontWeight: FontWeight.bold),
                      //               ),
                      //             ),
                      //             const Text(
                      //               "Access to Our Dashboard",
                      //               textAlign: TextAlign.center,
                      //               style: TextStyle(
                      //                   fontSize: 15,
                      //                   color: Colors.white,
                      //                   fontWeight: FontWeight.bold),
                      //             ),
                      //             const SizedBox(
                      //               height: 20,
                      //             ),
                      //             Form(
                      //               key: formkey,
                      //               child: Column(
                      //                 children: [
                      //                   const SizedBox(
                      //                     height: 20,
                      //                   ),
                      //                   Padding(
                      //                     padding: const EdgeInsets.only(
                      //                         right: 5.0, left: 5.0),
                      //                     child: TextFormField(
                      //                       controller: _userNameController,
                      //                       style: const TextStyle(
                      //                         color:Colors.white,
                      //                         //  Color.fromARGB(
                      //                         //     255, 7, 59, 120),
                      //                         fontSize: 20
                      //                       ),
                      //                       obscureText: false,
                      //                       decoration: const InputDecoration(
                      //                         border: OutlineInputBorder(),

                      //                         //hintMaxLines: 5,
                      //                         enabledBorder: OutlineInputBorder(
                      //                           borderSide: BorderSide(
                      //                             color:Colors.white,
                      //                             //  Color.fromARGB(
                      //                             //     255, 7, 59, 120),
                      //                           ),
                      //                         ),
                      //                         labelText: 'User Name ',
                      //                         labelStyle: TextStyle(
                      //                           color:Colors.white,
                      //                           //  Color.fromARGB(
                      //                           //     255, 47, 62, 74),
                      //                         ),
                      //                         prefixIcon: Icon(Icons.person),
                      //                       ),
                      //                       // validator: (value) {
                      //                       //   if (value!.isEmpty ||
                      //                       //       !RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                      //                       //           .hasMatch(value)) {
                      //                       //     return "Please Enter Correct User Name";
                      //                       //   } else {
                      //                       //     return null;
                      //                       //   }
                      //                       // },
                      //                     ),
                      //                   ),
                      //                   const SizedBox(
                      //                     height: 20,
                      //                   ),
                      //                   Padding(
                      //                     padding: const EdgeInsets.only(
                      //                         right: 5.0,
                      //                         left: 5.0,
                      //                         bottom: 10.0
                      //                         ),
                      //                     child: TextFormField(
                      //                       controller: _passwordController,
                      //                       style: const TextStyle(
                      //                           color: Colors.white,
                      //                           // Color.fromARGB(
                      //                           //     255, 7, 59, 120),
                      //                           fontSize: 20),
                      //                       obscureText: _obscureText,
                      //                       decoration: InputDecoration(
                      //                         prefixIcon:
                      //                             const Icon(Icons.lock),
                      //                         border:
                      //                             const OutlineInputBorder(),
                      //                         //hintMaxLines: 5,
                      //                         enabledBorder:
                      //                             const OutlineInputBorder(
                      //                                 borderSide: BorderSide(
                      //                           color:Colors.white,
                      //                           //  Color.fromARGB(
                      //                           //     255, 7, 59, 120),
                      //                         )),
                      //                         suffixIcon: GestureDetector(
                      //                           onTap: () {
                      //                             setState(() {
                      //                               _obscureText =
                      //                                   !_obscureText;
                      //                             });
                      //                           },
                      //                           child: Icon(_obscureText
                      //                               ? Icons.visibility_off
                      //                               : Icons.visibility),
                      //                         ),
                      //                         labelText: 'Password ',
                      //                         labelStyle: const TextStyle(
                      //                           color: Colors.white,
                      //                           // Color.fromARGB(
                      //                           //     255, 47, 62, 74),
                      //                         ),
                      //                       ),
                      //                       validator: (value) {
                      //                         if (value!.isEmpty) {
                      //                           return "Please Enter Correct Password";
                      //                         } else {
                      //                           return null;
                      //                         }
                      //                       },
                      //                     ),
                      //                   ),
                      //                 ],
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       )),
                      //       const SizedBox(
                      //         height: 10,
                      //       ),
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           SizedBox(
                      //             height: 24.0,
                      //             width: 24.0,
                      //             child: Theme(
                      //               data: ThemeData(
                      //                 unselectedWidgetColor:
                      //                     const Color.fromARGB(255, 7, 59, 120),
                      //               ),
                      //               child: Checkbox(
                      //                 activeColor:
                      //                     const Color.fromARGB(255, 7, 59, 120),
                      //                 value: isCheckedRememberMe,
                      //                 onChanged: (value) {
                      //                   // Call the onChanged callback with the updated value
                      //                   setState(() {
                      //                     isCheckedRememberMe = value!;
                      //                   });
                      //                   actionRememberMe(
                      //                       value!); // Call your function with the updated value
                      //                 },
                      //               ),
                      //             ),
                      //           ),
                      //           const SizedBox(width: 10.0),
                      //           const Text(
                      //             "Remember Me",
                      //             style: TextStyle(
                      //               color: Colors.black,
                      //               fontSize: 16,
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //       const SizedBox(
                      //         height: 20,
                      //       ),
                      //       RoundButton(
                      //         title: 'Sign In',
                      //         loading: authViewModel.loading,
                      //         onPress: () {
                      //           if (formkey.currentState!.validate()) {
                      //             Map data = {
                      //               'username': _userNameController.text
                      //                   .toString()
                      //                   .trim(),
                      //               'password': _passwordController.text
                      //                   .toString()
                      //                   .trim(),
                      //             };
                      //             authViewModel.loginApi(data, context);
                      //           } else {
                      //             print("Incorrect User Id or Password!!!");
                      //           }
                      //         },
                      //       ),
                      //       const SizedBox(
                      //         height: 20,
                      //       ),
                      //       InkWell(
                      //         onTap: () {
                      //           Navigator.pushNamed(
                      //               context, RoutesName.forgotPassword);
                      //         },
                      //         child: const Text(
                      //           "Forgot Password?",
                      //           textAlign: TextAlign.center,
                      //           style: TextStyle(
                      //               fontSize: 20,
                      //               color: Colors.white,
                      //               fontWeight: FontWeight.bold),
                      //         ),
                      //       ),
                      //       const SizedBox(
                      //         height: 20,
                      //       ),
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           const Text(
                      //             "Don't have an account? ",
                      //             textAlign: TextAlign.center,
                      //             style: TextStyle(
                      //                 fontSize: 18,
                      //                 color: Colors.black,
                      //                 fontWeight: FontWeight.bold),
                      //           ),
                      //           InkWell(
                      //             onTap: () {
                      //               Navigator.of(context).push(
                      //                   MaterialPageRoute(
                      //                       builder: (BuildContext context) =>
                      //                           const RagistrationPage()));
                      //             },
                      //             child: Container(
                      //               child: const Row(children: [
                      //                 Text(
                      //                   "Sign Up",
                      //                   textAlign: TextAlign.center,
                      //                   style: TextStyle(
                      //                     color: Colors.white,
                      //                     fontWeight: FontWeight.bold,
                      //                     fontSize: 18,
                      //                   ),
                      //                 ),
                      //               ]),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //       const SizedBox(
                      //         height: 20,
                      //       ),
                      //     ]),
                      //   ),
                      // ),

                      const SizedBox(
                        height: 160,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // alignment: Alignment.bottomCenter,
                          children: [
                            Text(
                              "Copyright © $currentYear ",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              "AriesPro. ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 2, 144, 99),
                                  fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              "All rights reserved. ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }

  void getTokenAndUseIt() async {
    final prefs = await SharedPreferences.getInstance();
    String secureAccessCodeEmail;
    secureAccessCodeEmail = _userNameController.text.toString().trim();
    // prefs.getString('userName').toString();
    print('secureAccessCodeEmail: $secureAccessCodeEmail');
    print(
        'secureAccessCodeEmail value: ${prefs.getString(secureAccessCodeEmail)}');

    String? storedUserName = prefs.getString('Email');
    String? savedTime = prefs.getString(secureAccessCodeEmail);

    bool isTokenValid = false;

    if (savedTime != null) {
      DateTime savedDateTime = DateTime.parse(savedTime);
      Duration difference = DateTime.now().difference(savedDateTime);

      if (difference.inHours < 2160) {
        isTokenValid = true;
      }
    }

    final authViewModel = Provider.of<LoginViewModel>(context, listen: false);

    Map data = {
      'username': _userNameController.text.toString(),
      'password': _passwordController.text.toString(),
    };
    print('data:$data');
    if (isTokenValid && storedUserName != null
        //  &&
        // storedDeviceToken==true &&
        // storedUserName == _userNameController.text.toString()
        ) {
      print(
          "✅ Token exists, is within 24 hours, and belongs to this username.");
      setState(() {
        dynamicIsCheckedRememberMe = true;
      });
      authViewModel.loginApi(
          data,
          dynamicIsCheckedRememberMe,
          _userNameController.text.toString().trim(),
          _passwordController.text.toString().trim(),
          context);
    } else {
      print("❌ Token missing, expired, or username mismatch.");
      setState(() {
        dynamicIsCheckedRememberMe = false;
      });
      authViewModel.loginApi(
          data,
          dynamicIsCheckedRememberMe,
          _userNameController.text.toString().trim(),
          _passwordController.text.toString().trim(),
          context);
    }
  }

  void actionRememberMe(bool value) async {
    isCheckedRememberMe = value; // Update the state
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("remember_me", value);
    print('value');
    print(value);
    prefs.setString('Email', _userNameController.text);
    await prefs.setString('password', _passwordController.text);
    print('prefs.setString');
    print(await prefs.getString('password'));
    print(_passwordController.text); // Print the saved password
  }

  void _loadRememberMeStatus() async {
    print('Loading Remember Me Status');
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('Email');
    final savedPassword = prefs.getString('password');

    print('Saved Email: $savedEmail');
    print('Saved Password: $savedPassword');

    setState(() {
      isCheckedRememberMe = prefs.getBool("remember_me") ?? false;

      if (isCheckedRememberMe) {
        _userNameController.text = savedEmail ?? "";
        // Delay setting the password until you have successfully retrieved it
        if (savedPassword != null) {
          _passwordController.text = savedPassword;
        }
      } else {
        _userNameController.text = "";
        _passwordController.text = "";
      }
    });
  }

  static int getCurrentYear() {
    DateTime now = DateTime.now();
    int currentYear = now.year;
    return currentYear;
  }
}
