import 'dart:io';

import 'package:CIVM/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/resources/app_url.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upgrader/upgrader.dart';

// ignore: must_be_immutable
class AdminAddSupervisor extends StatefulWidget {
  const AdminAddSupervisor({super.key});

  @override
  State<AdminAddSupervisor> createState() => _AdminAddSupervisorState();
}

class _AdminAddSupervisorState extends State<AdminAddSupervisor> {
  final _formkey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  final Color primaryColor = const Color.fromARGB(255, 7, 59, 120);

  List<dynamic> supervisorList = [];
  String? selectedSupervisor;

  bool isLoadingSupervisor = false;
  bool _obscurePassword = true;
  bool isSaving = false;
  bool? _active = false;
  @override
  void initState() {
    super.initState();
     _initializeScreen();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Add a Supervisor',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryColor,
      ),
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
          messages: UpgraderMessages(code: "Kindly update your app."),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formkey,
            child: Container(
              width: size.width,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.15),
                    blurRadius: 15,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabeledTextField(
                    label: "FIRST NAME *",
                    hint: "FIRST NAME",
                    controller: firstNameController,
                    icon: Icons.person_outline,
                  ),
                  const SizedBox(height: 16),
                  _buildLabeledTextField(
                    label: "LAST NAME *",
                    hint: "LAST NAME",
                    controller: lastNameController,
                    icon: Icons.person,
                  ),

                  const SizedBox(height: 16),

                  _buildLabeledTextField(
                    label: "EMAIL / USERNAME *",
                    hint: "EMAIL / USERNAME",
                    controller: emailController,
                    icon: Icons.email_outlined,
                  ),

                  const SizedBox(height: 16),

                  _buildLabeledTextField(
                    label: "PASSWORD *",
                    hint: "PASSWORD",
                    controller: passwordController,
                    icon: Icons.lock_outline,
                    obscureText: _obscurePassword,
                    isPassword: true,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: primaryColor,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  _buildLabeledTextField(
                    label: "MOBILE",
                    hint: "MOBILE",
                    controller: mobileController,
                    icon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                  ),

                  const SizedBox(height: 16),

                  _buildLabeledTextField(
                    label: "ADDRESS",
                    hint: "ADDRESS",
                    controller: addressController,
                    icon: Icons.location_on_outlined,
                    maxLines: 3,
                  ),

                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Text(
                        "Activate Immediately",
                        style: TextStyle(
                          color: Color.fromARGB(255, 7, 59, 120),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Switch(
                        value: _active ?? false,
                        onChanged: (value) {
                          setState(() {
                            _active = value;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 26),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: isSaving
                          ? null
                          : () {
                              if (_formkey.currentState!.validate()) {
                                addSupervisor();
                              }
                            },
                      child: isSaving
                          ? SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  primaryColor,
                                ),
                              ),
                            )
                          : const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Icon(Icons.save, color: Colors.white),
                                // SizedBox(width: 8),
                                Text(
                                  "ADD SUPERVISOR",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabeledTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    int maxLines = 1,
    Widget? suffixIcon,
    bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          maxLines: maxLines,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: _inputDecoration("").copyWith(
            hintText: "Enter ${hint.toLowerCase()}",
            prefixIcon: Icon(icon, color: primaryColor),
            suffixIcon: suffixIcon,
          ),
          validator: (value) {
            final text = value?.trim() ?? "";

            if (text.isEmpty) {
              if (controller == firstNameController) {
                return "Please enter First Name";
              }

              if (controller == lastNameController) {
                return "Please enter Last Name";
              }

              if (controller == emailController) {
                return "Please enter Email";
              }

              if (isPassword) {
                return "Please enter Password";
              }

              return "Please enter $hint";
            }
            if (value == null || value.trim().isEmpty) {
              return "Please enter $label";
            }
            if (controller == emailController) {
              final emailRegex = RegExp(
                r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$',
              );

              if (!emailRegex.hasMatch(value.trim())) {
                return "Please enter a valid email address";
              }
            }

            if (isPassword && value.trim().length < 8) {
              return "Password must be at least 8 characters";
            }

            return null;
          },
        ),
      ],
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: const Color(0xffF7F9FC),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: primaryColor, width: 1.5),
      ),
    );
  }

  Future<void> addSupervisor() async {
    setState(() {
      isSaving = true;
    });
    String status = "";
    if (_active == false) {
      status = "PENDING";
    } else {
      status = "ACTIVE";
    }
    try {
      final userPreferences = Provider.of<UserPref>(context, listen: false);

      UserModel data = await userPreferences.getUser();

      Map<String, dynamic> mappedData = {
        "fname": firstNameController.text.trim(),
        "lname": lastNameController.text.trim(),
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
        "mobile": mobileController.text.trim(),
        "address": addressController.text.trim(),
        "status": status,
        "createdBy": data.user!.id,
      };

      // Only for General Foreman

      print("mappedData:: ${jsonEncode(mappedData)}");

      var uri = "${AppUrl.baseUrl}/login_user/addSupervisor";

      final response = await http.post(
        Uri.parse(uri),
        headers: {
          "Authorization": "Bearer ${data.token}",
          "Content-Type": "application/json",
        },
        body: jsonEncode(mappedData),
      );

      print("Status Code:: ${response.statusCode}");
      print("Response:: ${response.body}");

      if (response.statusCode == 200) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Supervisor Added Successfully"),
              backgroundColor: Colors.green,
            ),
          );
        }

        // firstNameController.clear();
        // lastNameController.clear();
        // emailController.clear();
        // passwordController.clear();
        // mobileController.clear();
        // addressController.clear();

        setState(() {});
        // await Future.delayed(const Duration(seconds: 3));
        if (mounted) {
          Navigator.pop(context, true);
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.body), backgroundColor: Colors.red),
        );
      }
    } catch (e) {
      print("addSupervisor Error:: $e");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) {
        setState(() {
          isSaving = false;
        });
      }
    }
  }

   Future<void> checkCurrentUser() async {
    print('planner authentication');

    try {
      final prefs = await SharedPreferences.getInstance();

      final fcmToken = prefs.getString('device_token_for_logOut');

      if (fcmToken == null || fcmToken.isEmpty) {
        print("FCM token not found in SharedPreferences");
        return;
      }
      final userPreferences1 = Provider.of<UserPref>(context, listen: false);

      UserModel data = await userPreferences1.getUser();

      final String id = data.user!.id.toString();

      final apiUrl =
          "${AppUrl.baseUrl}login_user/checkCurrentUser"
          "?fcmToken=${Uri.encodeQueryComponent(fcmToken)}"
          "&userId=${Uri.encodeQueryComponent(id)}";

      final url = Uri.parse(apiUrl);

      print("API URL for authentication: $url");
      print("Bearer Token: ${data.token}");

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer ${data.token!}',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      print("Status Code: ${response.statusCode}");
      print("Response: ${response.body}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        print("Current User Response: $responseData");

        if (responseData == false) {
          final userPreferences = Provider.of<UserPref>(context, listen: false);

          await userPreferences.remove();

          if (!mounted) return;

          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (BuildContext context) => const LoginPage(),
            ),
            (route) => false,
          );
        }
      } else if (response.statusCode == 401) {
        print("Unauthorized - Bearer token is invalid or expired");
      } else {
        print(
          "checkCurrentUser failed: "
          "${response.statusCode} - ${response.body}",
        );
      }
    } catch (e) {
      print("checkCurrentUser Error: $e");
    }
  }
 Future<void> _initializeScreen() async {
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    await checkCurrentUser();
  }

}
