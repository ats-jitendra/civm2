import 'dart:async';
import 'dart:convert';
import 'dart:math';
// import 'dart:math';
import 'dart:ui';
import 'package:CIVM/piedmont/screens/login_page.dart';
import 'package:CIVM/piedmont/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
// import 'package:mailer/mailer.dart';
// import 'package:mailer/smtp_server/gmail.dart';

import 'package:http/http.dart' as http;

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final formkey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();

  // final bool _obscureText = true;

  DateTime now = DateTime.now();
  int currentYear = getCurrentYear();

  bool _isLoadingResetPassword = false;

  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmpassword = TextEditingController();

  int otp = 0;
  bool _isLoading = false;

  final List<TextEditingController> _controllers =
      List.generate(5, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(5, (_) => FocusNode());
  // late Timer _timer;
  Timer? _timer; // Change late Timer to nullable Timer?
  // int _remainingTime = 15;
  int _remainingTime = 300;
  bool _resendOtpVisibility = false;
  bool _enterOTPVisibility = false;
  bool _isVisibleGetOTPButton = true;
  bool _isVisibleRsetPassword = false;
  bool _isVisibleEmail = true;

  bool _obscureText = true;
  bool _obscureText2 = true;

  @override
  void initState() {
    super.initState();
    // _startTimer();
  }

  @override
  void dispose() {
    _controllers.forEach((controller) => controller.dispose());
    _focusNodes.forEach((focusNode) => focusNode.dispose());
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        // backgroundColor: const Color.fromARGB(255, 143, 141, 141),

        //backgroundColor: Colors.amber,
        body: Stack(children: [
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
          Stack(fit: StackFit.expand, children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.15,
                          left: 20,
                          right: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Column(children: [
                              Form(
                                  child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  // ignore: prefer_const_constructors
                                  children: [
                                    Image(
                                      image: const AssetImage(
                                          'assets/Ariespro full logo v2.png'),
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.12,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      "Reset Password",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 30,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Visibility(
                                      visible: _isVisibleEmail,
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          TextFormField(
                                            controller: _email,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              //hintMaxLines: 5,
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                color: Colors.white,
                                              )),
                                              labelText: 'Email ',
                                              prefixIcon: Icon(
                                                Icons.email,
                                                color: Colors.white,
                                              ),
                                              labelStyle: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty ||
                                                  !RegExp(r'^[a-z A-Z]+$')
                                                      .hasMatch(value)) {
                                                return "Please Enter Correct User Name";
                                              } else {
                                                return null;
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Column(
                                    //   children: [
                                    //     const SizedBox(
                                    //       height: 20,
                                    //     ),
                                    //     // TextFormField(
                                    //     //   controller: _email,
                                    //     //   style: const TextStyle(
                                    //     //       color: Colors.white,
                                    //     //       fontSize: 20),
                                    //     //   decoration: const InputDecoration(
                                    //     //     border: OutlineInputBorder(),
                                    //     //     //hintMaxLines: 5,
                                    //     //     enabledBorder: OutlineInputBorder(
                                    //     //         borderSide: BorderSide(
                                    //     //       color: Colors.white,
                                    //     //     )),
                                    //     //     labelText: 'Email ',
                                    //     //     prefixIcon: Icon(
                                    //     //       Icons.email,
                                    //     //       color: Colors.white,
                                    //     //     ),
                                    //     //     labelStyle: TextStyle(
                                    //     //       color: Colors.white,
                                    //     //     ),
                                    //     //   ),
                                    //     //   validator: (value) {
                                    //     //     if (value!.isEmpty ||
                                    //     //         !RegExp(r'^[a-z A-Z]+$')
                                    //     //             .hasMatch(value)) {
                                    //     //       return "Please Enter Correct User Name";
                                    //     //     } else {
                                    //     //       return null;
                                    //     //     }
                                    //     //   },
                                    //     // ),
                                    //   ],
                                    // ),
                                  ],
                                ),
                              )),
                              Visibility(
                                  visible: _isVisibleGetOTPButton,
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        left: 6, right: 6, top: 8.0),
                                    child: InkWell(
                                      onTap: _isLoading
                                          ? null
                                          : () =>
                                              _generateOtp(), // Disable when loading
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            left: 40, right: 40, bottom: 10.0),
                                        padding: const EdgeInsets.all(8),
                                        alignment: Alignment.center,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Color.fromARGB(
                                                    255, 33, 35, 37),
                                                blurRadius: 5,
                                                offset: Offset(2.0, 5.0))
                                          ],
                                          color: const Color.fromARGB(
                                              255, 34, 38, 41),
                                          gradient: const LinearGradient(
                                            colors: [
                                              Colors.white,
                                              Colors.white
                                            ],
                                          ),
                                        ),
                                        child: _isLoading
                                            ? const SizedBox(
                                                width: 24,
                                                height: 24,
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Color.fromARGB(
                                                      255, 7, 59, 120),
                                                  strokeWidth: 2,
                                                ),
                                              )
                                            : const Text(
                                                "Submit",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 7, 59, 120),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                ),
                                              ),
                                      ),
                                    ),
                                  )),
                              Visibility(
                                visible: _enterOTPVisibility,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Column(
                                        // ignore: prefer_const_constructors
                                        children: [
                                          const Text("Enter Secure Access Code",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                              )),
                                          Column(
                                            children: [
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 4.0,
                                                    left: 3.0,
                                                    bottom: 3),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children:
                                                      List.generate(5, (index) {
                                                    return Container(
                                                      width: 40,
                                                      margin: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 5),
                                                      child: TextFormField(
                                                        controller:
                                                            _controllers[index],
                                                        focusNode:
                                                            _focusNodes[index],
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        textAlign:
                                                            TextAlign.center,
                                                        maxLength: 1,
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 24,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                        decoration:
                                                            const InputDecoration(
                                                          counterText:
                                                              '', // hides the maxLength counter
                                                        ),
                                                        onChanged: (value) =>
                                                            _onDigitEntered(
                                                                value, index),
                                                      ),
                                                    );
                                                  }),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      "Time remaining: ${(_remainingTime ~/ 60).toString().padLeft(2, '0')}:${(_remainingTime % 60).toString().padLeft(2, '0')}",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              Visibility(
                                visible: _resendOtpVisibility,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Didn't Receive Code?",
                                      // "Resend Secure Access Code",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        _reGenerateOtp();
                                      },
                                      child: const Text(
                                        " RESEND",
                                        // "Resend Secure Access Code",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Visibility(
                              //   visible: _isVisibleRsetPassword,
                              //   child: Form(
                              //     key: formkey,
                              //     child: Column(
                              //       children: [
                              //         const SizedBox(
                              //           height: 20,
                              //         ),
                              //         Padding(
                              //           padding: const EdgeInsets.only(
                              //               right: 5.0, left: 5.0),
                              //           child: TextFormField(
                              //             controller: _password,
                              //             style: const TextStyle(
                              //                 color: Colors.white),
                              //             obscureText: _obscureText,
                              //             decoration: InputDecoration(
                              //               prefixIcon: const Icon(
                              //                 Icons.lock,
                              //                 color: Colors.white,
                              //               ),
                              //               border: const OutlineInputBorder(),
                              //               //hintMaxLines: 5,
                              //               enabledBorder:
                              //                   const OutlineInputBorder(
                              //                       borderSide: BorderSide(
                              //                 color: Colors.white,
                              //               )),
                              //               suffixIcon: GestureDetector(
                              //                 onTap: () {
                              //                   setState(() {
                              //                     _obscureText = !_obscureText;
                              //                   });
                              //                 },
                              //                 child: Icon(
                              //                   _obscureText
                              //                       ? Icons.visibility_off
                              //                       : Icons.visibility,
                              //                   color: Colors.white,
                              //                 ),
                              //               ),
                              //               labelText: 'Enter New Password ',
                              //               labelStyle: const TextStyle(
                              //                 color: Colors.white,
                              //               ),
                              //             ),
                              //             // validator: (value) {
                              //             //   if (value!.isEmpty) {
                              //             //     return "Please Enter Password";
                              //             //   } else {
                              //             //     return null;
                              //             //   }
                              //             // },
                              //             validator: (value) {
                              //               if (value == null ||
                              //                   value.isEmpty) {
                              //                 return "Please Enter Password";
                              //               }
                              //               if (value.length < 6) {
                              //                 return "Password must be at least 8 characters long";
                              //               }
                              //               if (!RegExp(r'[A-Za-z]')
                              //                   .hasMatch(value)) {
                              //                 return "Password must contain at least one letter";
                              //               }
                              //               if (!RegExp(r'\d')
                              //                   .hasMatch(value)) {
                              //                 return "Password must contain at least one number";
                              //               }
                              //               if (!RegExp(r'[!@#$%^&*]')
                              //                   .hasMatch(value)) {
                              //                 return "Password must contain at least one special character (@,!,\$,#,^,&,*)";
                              //               }
                              //               return null;
                              //             },
                              //           ),
                              //         ),
                              //         const SizedBox(
                              //           height: 20,
                              //         ),
                              //         Padding(
                              //           padding: const EdgeInsets.only(
                              //               right: 5.0, left: 5.0),
                              //           child: TextFormField(
                              //             controller: _confirmpassword,
                              //             style: const TextStyle(
                              //                 color: Colors.white,
                              //                 fontSize: 20),
                              //             obscureText: _obscureText2,
                              //             decoration: InputDecoration(
                              //               prefixIcon: const Icon(
                              //                 Icons.lock,
                              //                 color: Colors.white,
                              //               ),
                              //               border: const OutlineInputBorder(),
                              //               //hintMaxLines: 5,
                              //               enabledBorder:
                              //                   const OutlineInputBorder(
                              //                       borderSide: BorderSide(
                              //                 color: Colors.white,
                              //               )),
                              //               suffixIcon: GestureDetector(
                              //                 onTap: () {
                              //                   setState(() {
                              //                     _obscureText2 =
                              //                         !_obscureText2;
                              //                   });
                              //                 },
                              //                 child: Icon(
                              //                   _obscureText2
                              //                       ? Icons.visibility_off
                              //                       : Icons.visibility,
                              //                   color: Colors.white,
                              //                 ),
                              //               ),
                              //               labelText: 'Confirm Password ',
                              //               labelStyle: const TextStyle(
                              //                 color: Colors.white,
                              //               ),
                              //             ),
                              //             validator: (value) {
                              //               if (value!.isEmpty) {
                              //                 return "Please Enter Password again";
                              //               }
                              //               if (_password.text !=
                              //                   _confirmpassword.text) {
                              //                 return "Password does not match";
                              //               } else {
                              //                 return null;
                              //               }
                              //             },
                              //           ),
                              //         ),
                              //         const SizedBox(
                              //           height: 20,
                              //         ),
                              //         // Container(
                              //         // margin: const EdgeInsets.only(
                              //         //     left: 6, right: 6, top: 8.0),
                              //         // child: InkWell(
                              //         //   onTap: () {
                              //         //     if (formkey.currentState!.validate()) {
                              //         //       print('form validated');
                              //         //       resetPasswordAPI(_email.text.toString(), _password.text.toString());
                              //         //     }
                              //         //    },
                              //         //   child: Container(
                              //         //     margin: const EdgeInsets.only(
                              //         //         left: 40, right: 40, bottom: 10.0),
                              //         //     padding: const EdgeInsets.all(8),
                              //         //     alignment: Alignment.center,
                              //         //     width:
                              //         //         MediaQuery.of(context).size.width,
                              //         //     height: 40,
                              //         //     decoration: BoxDecoration(
                              //         //         // shape: BoxShape.circle,
                              //         //         borderRadius:
                              //         //             BorderRadius.circular(10),
                              //         //         boxShadow: const [
                              //         //           BoxShadow(
                              //         //               color: Color.fromARGB(255, 33, 35, 37),
                              //         //               blurRadius: 5,
                              //         //               offset: Offset(2.0, 5.0))
                              //         //         ],
                              //         //         color: const Color.fromARGB(255, 34, 38, 41),
                              //         //         gradient: const LinearGradient(
                              //         //           colors: [
                              //         //             Colors.white,
                              //         //             Colors.white
                              //         //           ],
                              //         //         )),
                              //         //     child: const Row(children: [
                              //         //       Expanded(
                              //         //         child: Align(
                              //         //           alignment: Alignment.center,
                              //         //           child: Text(
                              //         //             "Reset Password",
                              //         //             textAlign: TextAlign.left,
                              //         //             style: TextStyle(
                              //         //               color: Color.fromARGB(
                              //         //                 255, 7, 59, 120),
                              //         //               fontWeight: FontWeight.bold,
                              //         //               fontSize: 20,
                              //         //             ),
                              //         //           ),
                              //         //         ),
                              //         //       ),
                              //         //     ]),
                              //         //   ),
                              //         // )),
                              //         Container(
                              //           margin: const EdgeInsets.only(
                              //               left: 6, right: 6, top: 8.0),
                              //           child: InkWell(
                              //             onTap: _isLoadingResetPassword
                              //                 ? null
                              //                 : () async {
                              //                     if (formkey.currentState!
                              //                         .validate()) {
                              //                       setState(() {
                              //                         _isLoadingResetPassword =
                              //                             true; // Start loading
                              //                       });
                              //                       print('Form validated');
                              //                       await resetPasswordAPI(
                              //                           _email.text.toString(),
                              //                           _password.text
                              //                               .toString());
                              //                       setState(() {
                              //                         _isLoadingResetPassword =
                              //                             false; // Stop loading after API call
                              //                       });
                              //                     }
                              //                   },
                              //             child: Container(
                              //               margin: const EdgeInsets.only(
                              //                   left: 40,
                              //                   right: 40,
                              //                   bottom: 10.0),
                              //               padding: const EdgeInsets.all(8),
                              //               alignment: Alignment.center,
                              //               width: MediaQuery.of(context)
                              //                   .size
                              //                   .width,
                              //               height: 40,
                              //               decoration: BoxDecoration(
                              //                 borderRadius:
                              //                     BorderRadius.circular(10),
                              //                 boxShadow: const [
                              //                   BoxShadow(
                              //                       color: Color.fromARGB(
                              //                           255, 33, 35, 37),
                              //                       blurRadius: 5,
                              //                       offset: Offset(2.0, 5.0))
                              //                 ],
                              //                 color: const Color.fromARGB(
                              //                     255, 34, 38, 41),
                              //                 gradient: const LinearGradient(
                              //                   colors: [
                              //                     Colors.white,
                              //                     Colors.white
                              //                   ],
                              //                 ),
                              //               ),
                              //               child: _isLoadingResetPassword
                              //                   ? const SizedBox(
                              //                       width: 24,
                              //                       height: 24,
                              //                       child:
                              //                           CircularProgressIndicator(
                              //                         color: Color.fromARGB(
                              //                             255, 7, 59, 120),
                              //                         strokeWidth: 2,
                              //                       ),
                              //                     )
                              //                   : const Row(
                              //                       children: [
                              //                         Expanded(
                              //                           child: Align(
                              //                             alignment:
                              //                                 Alignment.center,
                              //                             child: Text(
                              //                               "Reset Password",
                              //                               textAlign:
                              //                                   TextAlign.left,
                              //                               style: TextStyle(
                              //                                 color: Color
                              //                                     .fromARGB(
                              //                                         255,
                              //                                         7,
                              //                                         59,
                              //                                         120),
                              //                                 fontWeight:
                              //                                     FontWeight
                              //                                         .bold,
                              //                                 fontSize: 20,
                              //                               ),
                              //                             ),
                              //                           ),
                              //                         ),
                              //                       ],
                              //                     ),
                              //             ),
                              //           ),
                              //         )
                              //       ],
                              //     ),
                              //   ),
                              // ),

                              Visibility(
                                visible: _isVisibleRsetPassword,
                                child: Form(
                                  key: formkey,
                                  child: Column(
                                    children: [
                                      // const SizedBox(
                                      //   height: 14,
                                      // ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 5.0, left: 5.0),
                                        child: TextFormField(
                                          controller: _password,
                                          style: const TextStyle(
                                              color: Colors.white),
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
                                            labelText: 'Enter New Password ',
                                            labelStyle: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          // validator: (value) {
                                          //   if (value!.isEmpty) {
                                          //     return "Please Enter Password";
                                          //   } else {
                                          //     return null;
                                          //   }
                                          // },
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Please Enter Password";
                                            }
                                            if (value.length < 6) {
                                              return "Password must be at least 8 characters long";
                                            }
                                            if (!RegExp(r'[A-Za-z]')
                                                .hasMatch(value)) {
                                              return "Password must contain at least one letter";
                                            }
                                            if (!RegExp(r'\d')
                                                .hasMatch(value)) {
                                              return "Password must contain at least one number";
                                            }
                                            if (!RegExp(r'[!@#$%^&*]')
                                                .hasMatch(value)) {
                                              return "Password must contain at least one special character (@,!,\$,#,^,&,*)";
                                            }
                                            return null;
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
                                              color: Colors.white,
                                              fontSize: 20),
                                          obscureText: _obscureText2,
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
                                            )),
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
                                            labelText: 'Confirm Password ',
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
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      // Container(
                                      // margin: const EdgeInsets.only(
                                      //     left: 6, right: 6, top: 8.0),
                                      // child: InkWell(
                                      //   onTap: () {
                                      //     if (formkey.currentState!.validate()) {
                                      //       print('form validated');
                                      //       resetPasswordAPI(_email.text.toString(), _password.text.toString());
                                      //     }
                                      //    },
                                      //   child: Container(
                                      //     margin: const EdgeInsets.only(
                                      //         left: 40, right: 40, bottom: 10.0),
                                      //     padding: const EdgeInsets.all(8),
                                      //     alignment: Alignment.center,
                                      //     width:
                                      //         MediaQuery.of(context).size.width,
                                      //     height: 40,
                                      //     decoration: BoxDecoration(
                                      //         // shape: BoxShape.circle,
                                      //         borderRadius:
                                      //             BorderRadius.circular(10),
                                      //         boxShadow: const [
                                      //           BoxShadow(
                                      //               color: Color.fromARGB(255, 33, 35, 37),
                                      //               blurRadius: 5,
                                      //               offset: Offset(2.0, 5.0))
                                      //         ],
                                      //         color: const Color.fromARGB(255, 34, 38, 41),
                                      //         gradient: const LinearGradient(
                                      //           colors: [
                                      //             Colors.white,
                                      //             Colors.white
                                      //           ],
                                      //         )),
                                      //     child: const Row(children: [
                                      //       Expanded(
                                      //         child: Align(
                                      //           alignment: Alignment.center,
                                      //           child: Text(
                                      //             "Reset Password",
                                      //             textAlign: TextAlign.left,
                                      //             style: TextStyle(
                                      //               color: Color.fromARGB(
                                      //                 255, 7, 59, 120),
                                      //               fontWeight: FontWeight.bold,
                                      //               fontSize: 20,
                                      //             ),
                                      //           ),
                                      //         ),
                                      //       ),
                                      //     ]),
                                      //   ),
                                      // )),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 6, right: 6, top: 8.0),
                                        child: InkWell(
                                          onTap: _isLoadingResetPassword
                                              ? null
                                              : () async {
                                                  if (formkey.currentState!
                                                      .validate()) {
                                                    setState(() {
                                                      _isLoadingResetPassword =
                                                          true; // Start loading
                                                    });

                                                    print('Form validated');
                                                    await resetPasswordAPI(
                                                        _email.text
                                                            .toString()
                                                            .trim(),
                                                        _password.text
                                                            .toString()
                                                            .trim());

                                                    setState(() {
                                                      _isLoadingResetPassword =
                                                          false; // Stop loading after API call
                                                    });
                                                  }
                                                },
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                left: 40,
                                                right: 40,
                                                bottom: 10.0),
                                            padding: const EdgeInsets.all(8),
                                            alignment: Alignment.center,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: const [
                                                BoxShadow(
                                                    color: Color.fromARGB(
                                                        255, 33, 35, 37),
                                                    blurRadius: 5,
                                                    offset: Offset(2.0, 5.0))
                                              ],
                                              color: const Color.fromARGB(
                                                  255, 34, 38, 41),
                                              gradient: const LinearGradient(
                                                colors: [
                                                  Colors.white,
                                                  Colors.white
                                                ],
                                              ),
                                            ),
                                            child: _isLoadingResetPassword
                                                ? const SizedBox(
                                                    width: 24,
                                                    height: 24,
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: Color.fromARGB(
                                                          255, 7, 59, 120),
                                                      strokeWidth: 2,
                                                    ),
                                                  )
                                                : const Row(
                                                    children: [
                                                      Expanded(
                                                        child: Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            "Reset Password",
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      7,
                                                                      59,
                                                                      120),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 20,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Already have an account? ",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.yellow,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        _timer
                                            ?.cancel(); // Stop the timer before leaving
                                        // Navigator.pushNamed(
                                        //     context, RoutesNamePemc.loginPemc);
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext contex) =>
                                                        const LoginPagePemc()));
                                      },
                                      child: const Row(children: [
                                        Text(
                                          "Sign In",
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
                              ),
                            ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.2,
                    ),
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
                              color: Color.fromARGB(255, 135, 242, 208),
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
          ]),
        ]),
      ),
    );
  }

  static int getCurrentYear() {
    DateTime now = DateTime.now();
    int currentYear = now.year;
    return currentYear;
  }

  String _generateOtp() {
    var random = Random();
    otp = random.nextInt(90000) + 10000;
    print('Secure Access Code $otp');
    DateTime now = DateTime.now();
    int timestamp = now.millisecondsSinceEpoch;
    Timer(const Duration(minutes: 3), () {
      print('Secure Access Code expired');
    });

    // Send OTP via email
    List<String> list = ['preetika.patel@ariespro.com'];
    var subject = 'LCP CIVM Secure Access Code';
    var msg =
        'Use secure access code for login to LCP CIVM portal: $otp. Access Code is valid for only 5 minutes.';
    _sendMail(list, subject, msg, otp);
    return '$otp,$timestamp';
  }

  Future<void> _sendMail(List<String> recipientsList, String subject,
      String content, int otpSendInTheEmail) async {
    _startTimer();
    String email = _email.text.toString().trim();
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
      ..from = Address(username, 'LCP CIVM')
      ..recipients.addAll([
        // _email.text.toString(),
        // 'preetika.patel@ariespro.com',
        //  'jyothi.andhavarapu@ariespro.com',
        _email.text.toString().trim(),
        // 'arjita.srivastava@ariespro.com'
        // 'jitendra.kushwaha@ariespro.com',
        // 'ace.kumar@ariespro.com',
        // 'dhiraj.kathroju@ariespro.com',
        // 'kanika.agrawal@ariespro.com'
      ])
      // ..recipients.add('jitendra.kushwaha@ariespro.com')
      // ..ccRecipients.addAll(recipientsList)
      // ..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject = subject
      // ..text = 'HMHP'
      ..html =
          "<h4>Hi $capitalizedName,</h4>\n<p>$content</p>\n<p>Note: DO NOT REPLY TO THIS EMAIL. If you did not request this code, or if you believe you have received this email in error, please email at it.support@ariespro.com.</p>\n<p>Thank you, </p>\n<p>AriesPro Utilities</p>";

    try {
      setState(() {
        _isLoading = true;
      });
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
      CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
          'Secure Access Code sent successfully to your email', context);
      setState(() {
        _isLoading = true;
        _isVisibleGetOTPButton = false;
        _enterOTPVisibility = true;
        _isVisibleEmail = false;
      });
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
      setState(() {
        _isLoading = false;
      });
      CustomToastSnackBarProgressDialog.flushBarErrorMessage(
          'Failed to send OTP. Please try again.', context);
    }
  }

  void _startTimer() {
    _resendOtpVisibility = false;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Secure Access Code Expired')));
          setState(() {
            _resendOtpVisibility = true;
          });
          _timer?.cancel(); // Stop the timer when time is up
        }
      });
    });
  }

  // void _startTimer() {
  //   // Cancel existing timer before starting a new one
  //   _timer?.cancel();

  //   _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
  //     setState(() {
  //       if (_remainingTime > 0) {
  //         _remainingTime--;
  //       } else {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //             const SnackBar(content: Text('Secure Access Code Expired')));

  //         _resendOtpVisibility = true;
  //         _timer?.cancel(); // Stop timer when time runs out
  //       }
  //     });
  //   });
  // }

  String _reGenerateOtp() {
    // Cancel existing timer if running
    _timer?.cancel();

    // Reset the countdown timer
    setState(() {
      _remainingTime = 300; // Reset to 5 minutes
      _resendOtpVisibility = false;
    });

    // Start new timer
    // _startTimer();

    var random = Random();
    otp = random.nextInt(90000) + 10000;
    print('Generated OTP: $otp');

    DateTime now = DateTime.now();
    int timestamp = now.millisecondsSinceEpoch;

    // Send OTP via email
    List<String> list = ['preetika.patel@ariespro.com'];
    var subject = 'LCP CIVM Secure Access Code';
    var msg =
        'Use secure access code for login to LCP CIVM portal: $otp. Access Code is valid for only 5 minutes.';

    _sendMail(list, subject, msg, otp);
    return '$otp,$timestamp';
  }

  void _onDigitEntered(String value, int index) {
    if (value.length == 1) {
      if (index < 4) {
        FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
      } else {
        FocusScope.of(context).unfocus();
        _validateOtp();
      }
    }
  }

  Future<void> _validateOtp() async {
    String enteredOtp = _controllers
        .map((controller) => controller.text.trim())
        .join(); // Trim each input
    String expectedOtp = otp.toString(); // Trim the expected OTP as well

    print('enteredOtp: "$enteredOtp"');
    print('otp: "$expectedOtp"');

    if (enteredOtp == expectedOtp) {
      setState(() {
        _isVisibleRsetPassword = true;
        _enterOTPVisibility = false;
        _resendOtpVisibility = false;
        _isVisibleEmail = false;
      });
      //       // Stop the timer here
      if (_timer != null && _timer!.isActive) {
        _timer!.cancel();
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid Secure Access Code')),
      );
      _controllers.forEach((controller) => controller.clear());
      _focusNodes.forEach((focusNode) => focusNode.unfocus());
    }
  }

  Future<void> resetPasswordAPI(String email, String newPassword) async {
    const String url =
        "https://atsdev2test.ariespro.com/civmapi/login_user/resetPassword";

    final Map<String, dynamic> body = {
      "email": email,
      "newPassword": newPassword
    };
    print('body $body');

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        print("Password reset successful: ${response.body}");
        CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
            'Password Changed Successfully.', context);
        await Future.delayed(const Duration(seconds: 2));
        Navigator.pop(context);
        Navigator.pop(context);
      } else {
        print("Failed to reset password: ${response.body}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
