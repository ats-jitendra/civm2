import 'package:CIVM/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/resources/app_url.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class SupervisorAddGfPlannerMember extends StatefulWidget {
  const SupervisorAddGfPlannerMember({super.key});

  @override
  State<SupervisorAddGfPlannerMember> createState() =>
      _SupervisorAddGfPlannerMemberState();
}

class _SupervisorAddGfPlannerMemberState extends State<SupervisorAddGfPlannerMember> {
  final _formkey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  final Color primaryColor = const Color.fromARGB(255, 7, 59, 120);

  List<String> roles = ['Planner', 'General Foreman'];
  String selectedRole = 'Planner';

  List<dynamic> supervisorList = [];
  String? selectedSupervisor;

  bool isLoadingSupervisor = false;
  bool _obscurePassword = true;
  bool isSaving = false;

  @override
  void initState() {
    getSupervisorList();
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
          'Add New Member',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
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
                Text(
                  "SELECT ROLE",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),

                const SizedBox(height: 8),

                DropdownButtonFormField<String>(
                  value: selectedRole,
                  decoration: _inputDecoration("Role"),
                  items: roles.map((role) {
                    return DropdownMenuItem<String>(
                      value: role,
                      child: Text(role),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedRole = value!;
                      if (selectedRole == 'General Foreman') {
                      } else {
                      }
                    });
                  },
                ),
                const SizedBox(height: 16),
                _buildLabeledTextField(
                  label: "FIRST NAME",
                  controller: firstNameController,
                  icon: Icons.person_outline,
                ),

                const SizedBox(height: 16),

                _buildLabeledTextField(
                  label: "LAST NAME",
                  controller: lastNameController,
                  icon: Icons.person,
                ),

                const SizedBox(height: 16),

                _buildLabeledTextField(
                  label: "EMAIL / USERNAME",
                  controller: emailController,
                  icon: Icons.email_outlined,
                ),

                const SizedBox(height: 16),

                _buildLabeledTextField(
                  label: "PASSWORD",
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
                  controller: mobileController,
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                ),

                const SizedBox(height: 16),

                _buildLabeledTextField(
                  label: "ADDRESS",
                  controller: addressController,
                  icon: Icons.location_on_outlined,
                  maxLines: 3,
                ),

                const SizedBox(height: 20),
                // Visibility(
                //   visible: _isVisibleGF,
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text(
                //         "GENERAL FOREMAN ADDITIONAL INFORMATION",
                //         style: TextStyle(
                //           fontSize: 16,
                //           fontWeight: FontWeight.bold,
                //           color: primaryColor,
                //         ),
                //       ),
                  
                //       const SizedBox(height: 20),
                  
                //       Text(
                //         "ASSIGN SUPERVISOR",
                //         style: TextStyle(
                //           fontSize: 14,
                //           fontWeight: FontWeight.w600,
                //           color: primaryColor,
                //         ),
                //       ),
                  
                //       const SizedBox(height: 8),
                  
                //       isLoadingSupervisor
                //           ? const Center(child: CircularProgressIndicator())
                //           : DropdownButtonFormField<String>(
                //               value: selectedSupervisor,
                //               decoration: _inputDecoration(
                //                 "Assign Supervisor",
                //               ),
                //               items: supervisorList.map((supervisor) {
                //                 return DropdownMenuItem<String>(
                //                   value: supervisor["id"].toString(),
                //                   child: Text(
                //                     "${supervisor["fName"] ?? ""} ${supervisor["lName"] ?? ""}",
                //                   ),
                //                 );
                //               }).toList(),
                //               onChanged: (value) {
                //                 setState(() {
                //                   selectedSupervisor = value;
                //                 });
                //                 print(
                //                   'selectedSupervisor:: $selectedSupervisor',
                //                 );
                //               },
                //             ),
                //     ],
                //   ),
                // ),

                // const SizedBox(height: 24),

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
                              if (selectedRole == "General Foreman" &&
                                  selectedSupervisor == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Please select supervisor"),
                                  ),
                                );
                                return;
                              }

                              addMember();
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
                              Icon(Icons.save, color: Colors.white),
                              SizedBox(width: 8),
                              Text(
                                "SUBMIT",
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
    );
  }

  Widget _buildLabeledTextField({
  required String label,
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
        decoration: _inputDecoration("").copyWith(
          hintText: "Enter ${label.toLowerCase()}",
          prefixIcon: Icon(icon, color: primaryColor),
          suffixIcon: suffixIcon,
        ),
        validator: (value) {
          if(controller != mobileController && controller !=addressController){
               if (value == null || value.trim().isEmpty) {
              return "Please enter $label";
            }
            }
          if (controller == emailController) {
              final emailRegex = RegExp(
                r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$',
              );

              if (!emailRegex.hasMatch(value!.trim())) {
                return "Please enter a valid email address";
              }
            }
          if (isPassword && value!.trim().length < 8) {
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

  Future<void> getSupervisorList() async {
    try {
      setState(() {
        isLoadingSupervisor = true;
      });

      final userPreferences = Provider.of<UserPref>(context, listen: false);
      UserModel data = await userPreferences.getUser();
      var uri = '${AppUrl.baseUrl}login_user/getAddMemberUserData';

      final response = await http.get(
        Uri.parse(uri),
        headers: {
          'Authorization': 'Bearer ${data.token}',
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          supervisorList = data["supervisorList"] ?? [];

          if (supervisorList.isNotEmpty) {
            selectedSupervisor = supervisorList.first["id"].toString();
          }
        });
      }
    } catch (e) {
      debugPrint("Supervisor Error: $e");
    } finally {
      setState(() {
        isLoadingSupervisor = false;
      });
    }
  }

  Future<void> addMember() async {
    setState(() {
      isSaving = true;
    });

    try {
      final userPreferences = Provider.of<UserPref>(context, listen: false);

      UserModel data = await userPreferences.getUser();

      String roleId = selectedRole == "Planner" ? "6" : "3";

      Map<String, dynamic> mappedData = {
        "role": roleId,
        "additionalUserType": "",
        "fName": firstNameController.text.trim(),
        "lName": lastNameController.text.trim(),
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
        "mobile": mobileController.text.trim(),
        "address": addressController.text.trim(),
      };

      // Only for General Foreman
      if (roleId == "3") {
        mappedData["supervisorId"] = '29';
        // selectedSupervisor;
      }

      print("mappedData:: ${jsonEncode(mappedData)}");

      var uri = "${AppUrl.baseUrl}login_user/addMember";

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
              content: Text("Member Added Successfully"),
              backgroundColor: Colors.green,
            ),
          );
        }

        firstNameController.clear();
        lastNameController.clear();
        emailController.clear();
        passwordController.clear();
        mobileController.clear();
        addressController.clear();

        setState(() {
          selectedRole = "Planner";

          if (supervisorList.isNotEmpty) {
            selectedSupervisor = supervisorList.first["id"].toString();
          }
        });
        await Future.delayed(const Duration(seconds: 3));
        if (mounted) {
          Navigator.pop(context, true);
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.body), backgroundColor: Colors.red),
        );
      }
    } catch (e) {
      print("addMember Error:: $e");

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
