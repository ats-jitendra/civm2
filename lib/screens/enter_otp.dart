import 'dart:async';
import 'dart:math';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/utils/routes/route_name.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class EnterOTP extends StatefulWidget {
  int otp;
  String email;
  String password;
  String userType;
  String status;
  UserModel value;

  EnterOTP(
      {super.key,
      required this.otp,
      required this.email,
      required this.password,
      required this.userType,
      required this.status,
      required this.value});

  @override
  State<EnterOTP> createState() => _EnterOTPState();
}

class _EnterOTPState extends State<EnterOTP> {
  final formkey = GlobalKey<FormState>();
  // final TextEditingController _otp = TextEditingController();
  final List<TextEditingController> _controllers =
      List.generate(5, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(5, (_) => FocusNode());
  late Timer _timer;
  int _remainingTime = 300;
  bool _resendOtpVisibility = false;
  // In your initState:
  List<FocusNode> _textFieldFocusNodes = List.generate(5, (_) => FocusNode());
  List<FocusNode> _keyboardFocusNodes = List.generate(5, (_) => FocusNode());

  int resendOtp = 0;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _controllers.forEach((controller) => controller.dispose());
    _focusNodes.forEach((focusNode) => focusNode.dispose());
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _resendOtpVisibility = false;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          // ScaffoldMessenger.of(context)
          //     .showSnackBar(const SnackBar(content: Text('Secure Access Code Expired')));
          setState(() {
            _resendOtpVisibility = true;
          });
          _timer.cancel(); // Stop the timer when time is up
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        //backgroundColor: Colors.amber,
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bac3.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 20.0, left: 20, right: 20, bottom: 20),
                child: Card(
                  color: Colors.white.withOpacity(0.6),
                  // color: Color.fromARGB(255, 117, 153, 150).withOpacity(0.8),
                  child: Stack(
                    // fit: StackFit.expand,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        child: SingleChildScrollView(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 10, right: 10, top: 30),
                              // padding: const EdgeInsets.all(8),
                              alignment: Alignment.center,
                              // width: 300,
                              //height: 80,
                              child: const Row(children: []),
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
                                      const Text(
                                        "Enter Secure Access Code",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 35,
                                            color:
                                                Color.fromARGB(255, 75, 38, 96),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Column(
                                        children: [
                                          const SizedBox(
                                            height: 40,
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
                                                      .symmetric(horizontal: 5),
                                                  child: RawKeyboardListener(
                                                    focusNode: _keyboardFocusNodes[
                                                        index], // separate for keyboard event
                                                    onKey: (RawKeyEvent event) {
                                                      if (event
                                                              is RawKeyDownEvent &&
                                                          event.logicalKey ==
                                                              LogicalKeyboardKey
                                                                  .backspace) {
                                                        if (_controllers[index]
                                                                .text
                                                                .isEmpty &&
                                                            index > 0) {
                                                          _textFieldFocusNodes[
                                                                  index - 1]
                                                              .requestFocus();
                                                          _controllers[
                                                                  index - 1]
                                                              .text = '';
                                                        }
                                                      }
                                                    },
                                                    child: TextFormField(
                                                      controller:
                                                          _controllers[index],
                                                      focusNode:
                                                          _textFieldFocusNodes[
                                                              index], // real focus
                                                      keyboardType:
                                                          TextInputType.number,
                                                      textAlign:
                                                          TextAlign.center,
                                                      maxLength: 1,
                                                      decoration:
                                                          const InputDecoration(
                                                              counterText: ''),
                                                      onChanged: (value) =>
                                                          _onDigitEntered(
                                                              value, index),
                                                    ),
                                                  ),
                                                );
                                              }),
                                            ),

                                            //  children: List.generate(5, (index) {
                                            //   return Container(
                                            //     width: 40,
                                            //     margin:
                                            //         const EdgeInsets.symmetric(
                                            //             horizontal: 5),
                                            //     child: TextFormField(
                                            //       controller:
                                            //           _controllers[index],
                                            //       focusNode: _focusNodes[index],
                                            //       keyboardType:
                                            //           TextInputType.number,
                                            //       textAlign: TextAlign.center,
                                            //       maxLength: 1,
                                            //       decoration:
                                            //           const InputDecoration(
                                            //         counterText:
                                            //             '', // hides the maxLength counter
                                            //       ),
                                            //       onChanged: (value) =>
                                            //           _onDigitEntered(
                                            //               value, index),
                                            //     ),
                                            //   );
                                            // }),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                                const SizedBox(height: 20),
                                Text(
                                  "Time remaining: ${(_remainingTime ~/ 60).toString().padLeft(2, '0')}:${(_remainingTime % 60).toString().padLeft(2, '0')}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black54,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                // Visibility(
                                //   visible: _resendOtpVisibility,
                                //   child: InkWell(
                                //     onTap: () {
                                //       _generateOtp();
                                //     },
                                //     child: const Text(
                                //       "Resend Secure Access Code",
                                //       style: TextStyle(
                                //           fontSize: 16,
                                //           color:
                                //               Color.fromARGB(255, 75, 38, 96),
                                //           fontWeight: FontWeight.bold),
                                //     ),
                                //   ),
                                // ),
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
                                         _generateOtp();
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
                                const SizedBox(
                                  height: 40,
                                ),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Powered by ",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 16,
                                          color:
                                              Color.fromARGB(255, 75, 38, 96),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "AriesPro",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20,
                                          color:
                                              Color.fromARGB(255, 75, 38, 96),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ]),
                            ),
                          ],
                        )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // void _onDigitEntered(String value, int index) {
  //   if (value.length == 1) {
  //     if (index < 4) {
  //       FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
  //     } else {
  //       FocusScope.of(context).unfocus();
  //       _validateOtp();
  //     }

  //     if (value.isNotEmpty && index < 4) {
  //       _textFieldFocusNodes[index + 1].requestFocus();
  //       _onDigitEntered(value, index);
  //     }
  //   }
  // }

  void _onDigitEntered(String value, int index) {
  if (value.isNotEmpty) {
    if (index < 4) {
      FocusScope.of(context).requestFocus(_textFieldFocusNodes[index + 1]);
    } else {
      FocusScope.of(context).unfocus();
      _validateOtp();
    }
  } else if (value.isEmpty && index > 0) {
    FocusScope.of(context).requestFocus(_textFieldFocusNodes[index - 1]);
  }
}


  Future<void> _validateOtp() async {
    String enteredOtp =
        _controllers.map((controller) => controller.text).join();
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    if (enteredOtp == widget.otp.toString() || enteredOtp == resendOtp.toString()) {
      if (widget.userType == '1') {
        print('enterOTP 111111111125615621652156151451561262156');
        print('context mounted? => ${context.mounted}');
        // Navigator.pushNamed(context, RoutesName.auditorHome);
        userPreferences.saveUser(widget.value, widget.email);
        print(" widget.value ${widget.value},");
        Navigator.pushNamed(context, RoutesName.adminHome);
      } else if (widget.userType == '2') {
        print('enterOTP 22222');
        userPreferences.saveUser(widget.value, widget.email);
        Navigator.pushNamed(context, RoutesName.supervisorHome);
      } else if (widget.userType == '3') {
        print('enterOTP 22222');
        userPreferences.saveUser(widget.value, widget.email);
        Navigator.pushNamed(context, RoutesName.contractorHome);
      } else if (widget.userType == '4') {
        print('enterOTP 22222');
        userPreferences.saveUser(widget.value, widget.email);
        Navigator.pushNamed(context, RoutesName.crewHome);
      } else if (widget.userType == '6') {
        print('enterOTP 22222');
        userPreferences.saveUser(widget.value, widget.email);
        Navigator.pushNamed(context, RoutesName.plannerHome);
      }
    } else {
      print('enterOTP :::::::::no route defined enter otp page');
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid Secure Access Code')));
      _controllers.forEach((controller) => controller.clear());
      _focusNodes.forEach((focusNode) => focusNode.unfocus());
    }
  }

  String _generateOtp() {
    var random = Random();
    // int otp = random.nextInt(90000) + 10000;
    resendOtp = random.nextInt(90000) + 10000;
    print('otp $resendOtp');
    DateTime now = DateTime.now();
    int timestamp = now.millisecondsSinceEpoch;
    Timer(const Duration(minutes: 3), () {
      print('OTP expired');
    });

    // Send OTP via email
    List<String> list = ['preetika.patel@ariespro.com'];
    var subject = 'Secure Access Code for CIVM login';
    var msg =
        'Use secure access code for login to CIVM: $resendOtp. Access Code is valid for only 5 minutes.';
    _sendMail(list, subject, msg, resendOtp);
    return '$resendOtp,$timestamp';
  }

  Future<void> _sendMail(List<String> recipientsList, String subject,
      String content, int otpSendInTheEmail) async {
    String email = widget.email;
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
      ..from = Address(username, 'CIVM')
      ..recipients.addAll([
        // 'preetika.patel@ariespro.com',
        // 'jyothi.andhavarapu@ariespro.com',
        //temp commented
        widget.email
      ])
      ..bccRecipients
          .addAll(['ace.kumar@ariespro.com', 'jitendra.kushwaha@ariespro.com'])
      ..subject = subject
      // ..text = 'HMHP'
      ..html =
          "<h4>Hi $capitalizedName,</h4>\n<p>$content</p>\n<p>Note: DO NOT REPLY TO THIS EMAIL. If you did not request this code, or if you believe you have received this email in error, please email at  it.support@ariespro.com.</p>\n<p>Thank you, </p>\n<p>AriesPro Utilities</p>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
      _remainingTime = 300;
      _startTimer();
      _controllers.forEach((controller) => controller.clear());
      _focusNodes.forEach((focusNode) => focusNode.unfocus());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }
}
