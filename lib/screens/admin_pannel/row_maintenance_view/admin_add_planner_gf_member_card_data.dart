import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/resources/app_url.dart';
import 'package:CIVM/screens/admin_pannel/row_maintenance_view/admin_add_planner_gf_member.dart';
import 'package:CIVM/screens/login_page.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:CIVM/utils/common_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminAddPlannerGFMemberCardData extends StatefulWidget {
  const AdminAddPlannerGFMemberCardData({super.key});

  @override
  State<AdminAddPlannerGFMemberCardData> createState() =>
      _AdminAddPlannerGFMemberCardDataState();
}

class _AdminAddPlannerGFMemberCardDataState
    extends State<AdminAddPlannerGFMemberCardData> {
  final Color primaryColor = const Color.fromARGB(255, 7, 59, 120);

  List<dynamic> members = [];
  bool isLoading = true;
  bool isDeleting = false;
  int? deletingMemberId;
  int? updatingStatusMemberId;
  List<dynamic> supervisorList = [];
  List<String> menu = [];
  final TextEditingController searchController = TextEditingController();

  List<dynamic> filteredMembers = [];

  @override
  void initState() {
    super.initState();
    getMembersData();
     _initializeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      // appBar: AppBar(
      //   backgroundColor: primaryColor,
      //   iconTheme: const IconThemeData(color: Colors.white),
      //   title: const Text(
      //     "Add Planner/GF Member",
      //     style: TextStyle(color: Colors.white),
      //   ),
      //   actions: <Widget>[
      //     IconButton(
      //       icon: const Icon(Icons.add, color: Colors.white),
      //       onPressed: () async {
      //         await Navigator.of(context).push(
      //           MaterialPageRoute(
      //             builder: (BuildContext context) =>
      //                 const AdminAddGfPlannerMember(),
      //           ),
      //         );
      //         getMembersData();
      //       },
      //     ),
      //   ],
      // ),
      // drawer: DrawerManu(menu: menu),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : members.isEmpty
          ? const Center(child: Text("No Members Found"))
          : Column(
              children: [
                progressHeaderCivm(
                  "Add Planner/GF Member",
                  onTap: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const AdminAddGfPlannerMember(),
                      ),
                    );
                    getMembersData();
                  },
                ),
               // SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: TextField(
                    controller: searchController,
                    onChanged: filterMembers,
                    decoration: InputDecoration(
                      hintText: "Search members...",
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                searchController.clear();
                                filterMembers('');
                              },
                            )
                          : null,
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                   // padding: const EdgeInsets.all(14),
                     padding: const EdgeInsets.only(top:6,right:14,left:14,bottom:14),
                    itemCount: filteredMembers.length,
                    itemBuilder: (context, index) {
                      // final item = members[index];
                      final item = filteredMembers[index];
                      final status = (item["status"] ?? "PENDING")
                          .toString()
                          .toUpperCase();
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.06),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            /// TOP HEADER
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(24),
                                  topRight: Radius.circular(24),
                                ),
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 28,
                                    backgroundColor: Colors.white,
                                    child: Text(
                                      "${index + 1}",
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 12),

                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${item["firstName"] ?? ""} ${item["lastName"] ?? ""}",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          getRole(
                                            item["primaryRole"]?.toString(),
                                          ),
                                          style: const TextStyle(
                                            color: Colors.white70,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: item["status"] == "ACTIVE"
                                          ? Colors.green
                                          : Colors.red,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Text(
                                      item["status"]?.toString() ?? "PENDING",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            /// BODY
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _infoTile(
                                          Icons.email_outlined,
                                          "EMAIL",
                                          item["email"]?.toString() ?? "-",
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: _infoTile(
                                          Icons.phone,
                                          "MOBILE",
                                          item["mobile"]?.toString() ?? "-",
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 12),

                                  Row(
                                    children: [
                                      Expanded(
                                        child: _infoTile(
                                          Icons.person_pin,
                                          "SUPERVISOR",
                                          item["supervisorName"]?.toString() ??
                                              "-",
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: _infoTile(
                                          Icons.calendar_month,
                                          "CREATED",
                                          _formatDate(item["createDtm"]),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 10),

                                  Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton.icon(
                                          icon:
                                              updatingStatusMemberId ==
                                                  item["id"]
                                              ? const SizedBox(
                                                  width: 18,
                                                  height: 18,
                                                  child:
                                                      CircularProgressIndicator(
                                                        color: Colors.white,
                                                        strokeWidth: 2,
                                                      ),
                                                )
                                              : Icon(
                                                  status == "ACTIVE"
                                                      ? Icons.block
                                                      : Icons.check_circle,
                                                ),

                                          label: Text(
                                            updatingStatusMemberId == item["id"]
                                                ? "Please Wait..."
                                                : status == "ACTIVE"
                                                ? "DENY"
                                                : "ALLOW",
                                          ),

                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: status == "ACTIVE"
                                                ? Colors.red
                                                : Colors.blue,
                                            foregroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                            ),
                                          ),

                                          onPressed:
                                              updatingStatusMemberId ==
                                                  item["id"]
                                              ? null
                                              : () {
                                                  updateMemberStatus(
                                                    item["id"],
                                                    status == "ACTIVE"
                                                        ? "PENDING"
                                                        : "ACTIVE",
                                                  );
                                                },
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: ElevatedButton.icon(
                                          icon: Icon(Icons.edit),

                                          label: Text('EDIT'),

                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green,
                                            foregroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                            ),
                                          ),

                                          onPressed: () {
                                            showEditMemberDialog(item);
                                          },
                                        ),
                                      ),

                                      //                                 Expanded(
                                      //                                   child: ElevatedButton.icon(
                                      //                                     icon: deletingMemberId == item["id"]
                                      //                                         ? const SizedBox(
                                      //                                             width: 18,
                                      //                                             height: 18,
                                      //                                             child: CircularProgressIndicator(
                                      //                                               strokeWidth: 2,
                                      //                                               color: Colors.white,
                                      //                                             ),
                                      //                                           )
                                      //                                         : const Icon(Icons.delete),

                                      //                                     label: Text(
                                      //                                       deletingMemberId == item["id"]
                                      //                                           ? "Deleting..."
                                      //                                           : "Delete",
                                      //                                     ),

                                      //                                     style: ElevatedButton.styleFrom(
                                      //                                       backgroundColor: Colors.orange,
                                      //                                       foregroundColor: Colors.white,
                                      //                                       shape: RoundedRectangleBorder(
                                      //                                         borderRadius: BorderRadius.circular(14),
                                      //                                       ),
                                      //                                     ),

                                      //                                    onPressed: () async {
                                      //   bool? confirm = await showDialog<bool>(
                                      //     context: context,
                                      //     builder: (context) => AlertDialog(
                                      //       title: const Text("Delete Member"),
                                      //       content: const Text(
                                      //         "Are you sure you want to delete this member?",
                                      //       ),
                                      //       actions: [
                                      //         TextButton(
                                      //           onPressed: () => Navigator.pop(context, false),
                                      //           child: const Text("Cancel"),
                                      //         ),
                                      //         ElevatedButton(
                                      //           onPressed: () => Navigator.pop(context, true),
                                      //           child: const Text("Delete"),
                                      //         ),
                                      //       ],
                                      //     ),
                                      //   );

                                      //   if (confirm == true) {
                                      //     deleteMember(item["id"]);
                                      //   }
                                      // },
                                      //                                   ),
                                      //                                 ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Widget _infoTile(IconData icon, String title, dynamic value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xffF5F7FB),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: primaryColor),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 4),
          Text(
            value?.toString() ?? "-",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Future<void> getMembersData() async {
    try {
      setState(() {
        isLoading = true;
      });
      final userPreferences = Provider.of<UserPref>(context, listen: false);
      UserModel data = await userPreferences.getUser();
      var uri = '${AppUrl.baseUrl}login_user/getAddMemberUserData';
      final response = await http.get(
        Uri.parse(uri),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${data.token}',
        },
      );

      print('uri:: $uri');

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        setState(() {
          members = jsonData['contractorAndPlannerList'] ?? [];
          filteredMembers = List.from(members);
          supervisorList = jsonData['supervisorList'] ?? [];
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });

        debugPrint('API Error : ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      debugPrint('Exception : $e');
    }
  }

  String getRole(String? userType) {
    switch (userType) {
      case "3":
        return "General Foreman";
      case "6":
        return "Planner";
      default:
        return "Unknown";
    }
  }

  String _formatDate(String? date) {
    if (date == null || date.isEmpty) return "-";

    try {
      return DateFormat('MM/dd/yyyy').format(DateTime.parse(date));
    } catch (e) {
      return "-";
    }
  }

  Future<void> deleteMember(int loginId) async {
    try {
      setState(() {
        deletingMemberId = loginId;
      });

      final userPreferences = Provider.of<UserPref>(context, listen: false);

      UserModel data = await userPreferences.getUser();

      final response = await http.delete(
        Uri.parse('${AppUrl.baseUrl}login_user/deleteMember?loginId=$loginId'),
        headers: {
          "Authorization": "Bearer ${data.token}",
          "Content-Type": "application/json",
        },
      );

      print("Delete Status: ${response.statusCode}");
      print("Delete Response: ${response.body}");

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Member Deleted Successfully"),
            backgroundColor: Colors.green,
          ),
        );

        await getMembersData(); // Refresh list
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.body), backgroundColor: Colors.red),
        );
      }
    } catch (e) {
      print("Delete Error: $e");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) {
        setState(() {
          deletingMemberId = null;
        });
      }
    }
  }

  Future<void> updateMemberStatus(int loginId, String status) async {
    try {
      setState(() {
        updatingStatusMemberId = loginId;
      });

      final userPreferences = Provider.of<UserPref>(context, listen: false);

      UserModel data = await userPreferences.getUser();

      final response = await http.get(
        Uri.parse(
          '${AppUrl.baseUrl}login_user/updateStatus?loginId=$loginId&status=$status',
        ),
        headers: {
          "Authorization": "Bearer ${data.token}",
          "Content-Type": "application/json",
        },
      );

      print("Status Update Code: ${response.statusCode}");
      print("Status Update Response: ${response.body}");

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              status == "ACTIVE"
                  ? "Member Allowed Successfully"
                  : "Member Denied Successfully",
            ),
            backgroundColor: Colors.green,
          ),
        );

        await getMembersData(); // Refresh list
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.body), backgroundColor: Colors.red),
        );
      }
    } catch (e) {
      print("Update Status Error: $e");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) {
        setState(() {
          updatingStatusMemberId = null;
        });
      }
    }
  }

  Future<void> showEditMemberDialog(Map<String, dynamic> item) async {
    final _editFormKey = GlobalKey<FormState>();
    final firstNameController = TextEditingController(
      text: item["firstName"]?.toString() ?? "",
    );

    final lastNameController = TextEditingController(
      text: item["lastName"]?.toString() ?? "",
    );

    final emailController = TextEditingController(
      text: item["email"]?.toString() ?? "",
    );

    final mobileController = TextEditingController(
      text: item["mobile"]?.toString() ?? "",
    );

    final addressController = TextEditingController(
      text: item["address"]?.toString() ?? "",
    );

    bool isUpdating = false;
    final passwordController = TextEditingController(
      text: item["password"]?.toString() ?? "",
    );

    String selectedRole = item["primaryRole"]?.toString() == "3"
        ? "General Foreman"
        : "Planner";

    String? selectedSupervisorId;
    bool isPasswordVisible = false;
    bool givePlannerAccess =
        (item["userType"]?.toString() == "3" &&
            item["additionalUserType"]?.toString() == "6") ||
        (item["userType"]?.toString() == "6" &&
            item["additionalUserType"]?.toString() == "3");
    selectedSupervisorId =
        supervisorList
            .where(
              (e) =>
                  e["userName"]?.toString() ==
                  item["supervisorName"]?.toString(),
            )
            .isNotEmpty
        ? supervisorList
              .firstWhere(
                (e) =>
                    e["userName"]?.toString() ==
                    item["supervisorName"]?.toString(),
              )["id"]
              .toString()
        : null;

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              title: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.edit_outlined,
                      color: Color(0xff0A4DA2),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      "Edit Member",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),

              content: Form(
                key: _editFormKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        value: selectedRole,
                        decoration: editInputDecoration(
                          label: "Role",
                          icon: Icons.badge_outlined,
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: "Planner",
                            child: Text("Planner"),
                          ),
                          DropdownMenuItem(
                            value: "General Foreman",
                            child: Text("General Foreman"),
                          ),
                        ],
                        onChanged: (value) {
                          setDialogState(() {
                            selectedRole = value!;
                          });
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: firstNameController,
                        decoration: editInputDecoration(
                          label: "First Name",
                          icon: Icons.person_outline,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please enter first name";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 12),

                      TextFormField(
                        controller: lastNameController,
                        decoration: editInputDecoration(
                          label: "Last Name",
                          icon: Icons.person,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please enter last name";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 12),

                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: editInputDecoration(
                          label: "Email/UserName",
                          icon: Icons.email_outlined,
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: passwordController,
                        obscureText: !isPasswordVisible,
                        decoration:
                            editInputDecoration(
                              label: "Password",
                              icon: Icons.lock_outline,
                            ).copyWith(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  isPasswordVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () {
                                  setDialogState(() {
                                    isPasswordVisible = !isPasswordVisible;
                                  });
                                },
                              ),
                            ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please enter password";
                          }
                          if (value.trim().length < 8) {
                            return "Password must be at least 8 characters";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 12),

                      TextFormField(
                        controller: mobileController,
                        keyboardType: TextInputType.phone,
                        decoration: editInputDecoration(
                          label: "Mobile",
                          icon: Icons.phone_outlined,
                        ),
                      ),
                      const SizedBox(height: 12),

                      TextFormField(
                        controller: addressController,
                        maxLines: 2,
                        decoration: editInputDecoration(
                          label: "Address",
                          icon: Icons.location_on_outlined,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // if (selectedRole == "General Foreman" ||
                      //     (selectedRole == "Planner" && givePlannerAccess))
                      //   DropdownButtonFormField<String>(
                      //     value: selectedSupervisorId,
                      //     decoration: editInputDecoration(
                      //       label: "Supervisor",
                      //       icon: Icons.supervisor_account_outlined,
                      //     ),
                      //     items: supervisorList.map((supervisor) {
                      //       return DropdownMenuItem<String>(
                      //         value: supervisor["id"].toString(),
                      //         child: Text(
                      //           "${supervisor["fName"]} ${supervisor["lName"]}",
                      //         ),
                      //       );
                      //     }).toList(),
                      //     onChanged: (value) {
                      //       setDialogState(() {
                      //         selectedSupervisorId = value;
                      //       });
                      //     },
                      //   ),
                      // const SizedBox(height: 20),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "ADDITIONAL ACCESS",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade700,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                        controlAffinity: ListTileControlAffinity.leading,
                        value: givePlannerAccess,
                        title: Text(
                          selectedRole == "General Foreman"
                              ? "Also give access as Planner"
                              : "Also give access as General Foreman",
                          style: const TextStyle(fontSize: 15),
                        ),
                        onChanged: (value) {
                          setDialogState(() {
                            givePlannerAccess = value ?? false;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),

              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),

                ElevatedButton(
                  onPressed: isUpdating
                      ? null
                      : () async {
                          if (!_editFormKey.currentState!.validate()) {
                            return;
                          }

                          // if ((selectedRole == "General Foreman" ||
                          //         (selectedRole == "Planner" &&
                          //             givePlannerAccess)) &&
                          //     selectedSupervisorId == null) {
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //     const SnackBar(
                          //       content: Text("Please select supervisor"),
                          //     ),
                          //   );
                          //   return;
                          // }

                          setDialogState(() {
                            isUpdating = true;
                          });

                          await updateMember(
                            loginId: item["id"],
                            role: selectedRole == "Planner" ? "6" : "3",
                            additionalUserType: givePlannerAccess
                                ? (selectedRole == "General Foreman"
                                      ? "6"
                                      : "3")
                                : "",
                            firstName: firstNameController.text.trim(),
                            lastName: lastNameController.text.trim(),
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                            mobile: mobileController.text.trim(),
                            address: addressController.text.trim(),
                            supervisorId: '29',
                            // selectedSupervisorId,
                            selectedRole: selectedRole,
                            givePlannerAccess: givePlannerAccess,
                          );

                          if (mounted) {
                            Navigator.pop(context);
                          }
                        },
                  child: isUpdating
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text("Update"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> updateMember({
    required int loginId,
    required String role,
    required String additionalUserType,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String mobile,
    required String address,
    String? supervisorId,
    String? selectedRole,
    bool? givePlannerAccess,
  }) async {
    try {
      final userPreferences = Provider.of<UserPref>(context, listen: false);

      UserModel data = await userPreferences.getUser();

      Map<String, dynamic> mappedData = {
        "loginId": loginId,
        "role": role,
        "additionalUserType": additionalUserType,
        "fName": firstName,
        "lName": lastName,
        "email": email,
        "password": password,
        "mobile": mobile,
        "address": address,
      };

      if (role == "3" || (selectedRole == "Planner" && givePlannerAccess!)) {
        mappedData["supervisorId"] = int.parse(supervisorId ?? "0");
      }

      print(jsonEncode(mappedData));

      final response = await http.post(
        Uri.parse('${AppUrl.baseUrl}login_user/updateMember'),
        headers: {
          "Authorization": "Bearer ${data.token}",
          "Content-Type": "application/json",
        },
        body: jsonEncode(mappedData),
      );

      print(response.body);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Member Updated Successfully"),
            backgroundColor: Colors.green,
          ),
        );

        await getMembersData();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.body), backgroundColor: Colors.red),
        );
      }
    } catch (e) {
      print("Update Error: $e");
    }
  }

  InputDecoration editInputDecoration({
    required String label,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: const Color(0xffF6F8FC),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xff0A4DA2), width: 1.5),
      ),
    );
  }

  void filterMembers(String query) {
    setState(() {
      if (query.trim().isEmpty) {
        filteredMembers = List.from(members);
      } else {
        final search = query.toLowerCase();

        filteredMembers = members.where((member) {
          final name =
              "${member["firstName"] ?? ""} ${member["lastName"] ?? ""}"
                  .toLowerCase();

          final email = (member["email"] ?? "").toString().toLowerCase();
          final mobile = (member["mobile"] ?? "").toString().toLowerCase();
          final supervisor = (member["supervisorName"] ?? "")
              .toString()
              .toLowerCase();
          final role = getRole(member["primaryRole"]?.toString()).toLowerCase();

          return name.contains(search) ||
              email.contains(search) ||
              mobile.contains(search) ||
              supervisor.contains(search) ||
              role.contains(search);
        }).toList();
      }
    });
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

// // ignore: must_be_immutable
// class DrawerManu extends StatefulWidget {
//   List<String> menu;
//   DrawerManu({Key? key, required this.menu}) : super(key: key);

//   @override
//   State<DrawerManu> createState() => _DrawerManuState();
// }

// class _DrawerManuState extends State<DrawerManu> {
//   String userName = '';

//   @override
//   void initState() {
//     setUserName();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final userPreferences = Provider.of<UserPref>(context);
//     var provider = Provider.of<LocationProvider>(context, listen: true);
//     return Drawer(
//       child: SafeArea(
//         child: Column(
//           // Important: Remove any padding from the ListView.
//           // padding: EdgeInsets.zero,
//           children: [
//             Container(
//               width: double.infinity,
//               height: 180,
//               color: const Color.fromARGB(255, 3, 47, 97),
//               padding: const EdgeInsets.only(top: 24),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   menuLogoLCP(),
//                   const SizedBox(height: 6),
//                   Text(
//                     userName,
//                     style: const TextStyle(fontSize: 18, color: Colors.white),
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: ListView(
//                 children: [
//                   ListTile(
//                     leading: const Icon(Icons.computer),
//                     title: const Text('Row Maintenance Plan'),
//                     textColor: const Color.fromARGB(255, 7, 59, 120),
//                     iconColor: const Color.fromARGB(255, 7, 59, 120),
//                     onTap: () {
//                       Navigator.of(context).push(
//                         MaterialPageRoute(
//                           builder: (BuildContext context) =>
//                               const EnergyAuditPannel(),
//                         ),
//                       );
//                     },
//                   ),
//                   ListTile(
//                     leading: const Icon(Icons.compare),
//                     title: const Text('Inspection'),
//                     textColor: const Color.fromARGB(255, 7, 59, 120),
//                     iconColor: const Color.fromARGB(255, 7, 59, 120),
//                     onTap: () {
//                       Navigator.of(context).push(
//                         MaterialPageRoute(
//                           builder: (BuildContext context) =>
//                               const InspectionZielies(),
//                         ),
//                       );
//                     },
//                   ),
//                   ListTile(
//               leading: const Icon(
//                 Icons.pending,
//               ),
//               title: const Text('Change Order Job List'),
//               textColor: const Color.fromARGB(255, 7, 59, 120),
//               iconColor: const Color.fromARGB(255, 7, 59, 120),
//               onTap: () {
//                Navigator.of(context).push(MaterialPageRoute(
//                             builder: (BuildContext context) =>
//                                  AdminChangeOrderAllStatus(source: '',)));
//               },
//             ),
//                   ListTile(
//                     leading: const Icon(Icons.airplane_ticket_sharp),
//                     title: const Text('IVM Maintenance Job List'),
//                     textColor: const Color.fromARGB(255, 7, 59, 120),
//                     iconColor: const Color.fromARGB(255, 7, 59, 120),
//                     onTap: () {
//                       Navigator.of(context).push(
//                         MaterialPageRoute(
//                           builder: (BuildContext context) =>
//                               const AdminAddNewRowTable(),
//                         ),
//                       );
//                       // Navigator.of(context).push(MaterialPageRoute(
//                       //     builder: (BuildContext context) => AddNewRowMaintenancePlan(
//                       //           tokenNo: '',
//                       //           index: '0',
//                       //           subStation: '',
//                       //           feeder: '',
//                       //           nextMaintYear: '',
//                       //           maintType: '',
//                       //           totalMiles: '',
//                       //           costPerMile: '',
//                       //           totalCost: '',
//                       //           budgetType: '',
//                       //           contractRowYear: '',
//                       //           rowCycle: '',
//                       //           rowYear: '',
//                       //           contractorCompany: '',
//                       //           assignForeman: '',
//                       //         )));
//                     },
//                   ),
//             //        ListTile(
//             //   leading: const Icon(
//             //     Icons.settings_applications_sharp,
//             //   ),
//             //   title: const Text('Maintenance Report View'),
//             //   textColor: const Color.fromARGB(255, 7, 59, 120),
//             //   iconColor: const Color.fromARGB(255, 7, 59, 120),
//             //   onTap: () {
//             //    Navigator.of(context).push(MaterialPageRoute(
//             //         builder: (BuildContext context) =>
//             //             const AdminMaintenanceReportViewNew()));
//             //   },
//             // ),
//                   ListTile(
//                     leading: const Icon(Icons.open_in_new),
//                     title: const Text('IVM Maintenance Progress'),
//                     textColor: const Color.fromARGB(255, 7, 59, 120),
//                     iconColor: const Color.fromARGB(255, 7, 59, 120),
//                     onTap: () {
//                       Navigator.of(context).push(
//                         MaterialPageRoute(
//                           builder: (BuildContext context) =>
//                               const RowMaintenanceProgress(),
//                         ),
//                       );
//                     },
//                   ),
//                   // ),
//                   // ListTile(
//                   //   leading: const Icon(
//                   //     Icons.closed_caption_off,
//                   //   ),
//                   //   title: const Text('Row Analytics Dashboard'),
//                   //   textColor: const Color.fromARGB(255, 7, 59, 120),
//                   //   iconColor: const Color.fromARGB(255, 7, 59, 120),
//                   //   onTap: () {
//                   //     Navigator.of(context).push(MaterialPageRoute(
//                   //         builder: (BuildContext context) =>
//                   //             const RowAnalyticsDashboard()));
//                   //   },
//                   // ),
//                   ListTile(
//                     leading: const Icon(Icons.data_usage),
//                     title: const Text('Budget Planning'),
//                     textColor: const Color.fromARGB(255, 7, 59, 120),
//                     iconColor: const Color.fromARGB(255, 7, 59, 120),
//                     onTap: () {
//                       Navigator.of(context).push(
//                         MaterialPageRoute(
//                           builder: (BuildContext context) =>
//                               const BudgetPlanning(),
//                         ),
//                       );
//                     },
//                   ),

//                   ListTile(
//                     leading: const Icon(Icons.location_on),
//                     title: const Text('Live IVM System Map'),
//                     textColor: const Color.fromARGB(255, 7, 59, 120),
//                     iconColor: const Color.fromARGB(255, 7, 59, 120),
//                     onTap: () {
//                       provider.getLocation();
//                       Navigator.of(context).push(
//                         MaterialPageRoute(
//                           builder: (context) => const MapScreenLeafLat(),
//                         ),
//                       );
//                     },
//                   ),

//                   //       ListTile(
//                   //   leading: const Icon(
//                   //     Icons.map,
//                   //   ),
//                   //   title: const Text('Location Map'),
//                   //   textColor: const Color.fromARGB(255, 7, 59, 120),
//                   //   iconColor: const Color.fromARGB(255, 7, 59, 120),
//                   //   onTap: () {
//                   //     provider.getLocation();
//                   //     Navigator.of(context)
//                   //         .push(MaterialPageRoute(builder: (context) => Maps()));
//                   //   },
//                   // ),
//                   ListTile(
//                     leading: const Icon(Icons.check),
//                     title: const Text('Approve CIVM Access'),
//                     textColor: const Color.fromARGB(255, 7, 59, 120),
//                     iconColor: const Color.fromARGB(255, 7, 59, 120),
//                     onTap: () {
//                       Navigator.of(context).push(
//                         MaterialPageRoute(
//                           builder: (BuildContext context) =>
//                               const ApproveCIVMAccess(),
//                         ),
//                       );
//                     },
//                   ),
//                   ListTile(
//                     leading: const Icon(Icons.add),
//                     title: const Text('Add Crew Member'),
//                     textColor: const Color.fromARGB(255, 7, 59, 120),
//                     iconColor: const Color.fromARGB(255, 7, 59, 120),
//                     onTap: () {
//                       Navigator.of(context).push(
//                         MaterialPageRoute(
//                           builder: (BuildContext context) =>
//                               const AddCrewMember(),
//                         ),
//                       );
//                     },
//                   ),
//                   ListTile(
//                     leading: const Icon(Icons.group_add),
//                     title: const Text('Add Planner/GF'),
//                     textColor: const Color.fromARGB(255, 7, 59, 120),
//                     iconColor: const Color.fromARGB(255, 7, 59, 120),
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                   ),

//                   ListTile(
//                     leading: const Icon(Icons.logout),
//                     title: const Text('Logout'),
//                     textColor: const Color.fromARGB(255, 7, 59, 120),
//                     iconColor: const Color.fromARGB(255, 7, 59, 120),
//                     onTap: () {
//                       // Constants.prefs.setBool("LoggedIn", false);
//                       userPreferences.remove().then((value) {
//                         // ignore: use_build_context_synchronously
//                         // Navigator.pushReplacement(context, RoutesName.login);
//                         // Navigator.pushNamed(
//                         //     context, RoutesName.login);
//                         Navigator.of(context).push(
//                           MaterialPageRoute(
//                             builder: (BuildContext context) =>
//                                 const LoginPage(),
//                           ),
//                         );
//                       });
//                       // Navigator.of(context).push(MaterialPageRoute(
//                       //     builder: (BuildContext context) => const LoginPage()));
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.symmetric(vertical: 12),
//               alignment: Alignment.center,
//               child: Column(
//                 children: [
//                   Text(
//                     'Version: ${Constants.prefs.getString('VERSION') ?? ''}',
//                     style: const TextStyle(
//                       fontSize: 13,
//                       color: Colors.grey,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   Text(
//                     'Updated: ${Constants.prefs.getString('VERSION_DATE') ?? ''}',
//                     style: const TextStyle(
//                       fontSize: 13,
//                       color: Colors.grey,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> setUserName() async {
//     final userPreferences = Provider.of<UserPref>(context, listen: false);
//     UserModel data = await userPreferences.getUser();
//     Image.network(
//       'https://civm.ariespro.com/assets/clientuploads/${data.user!.profilePhoto}',
//     );
//     setState(() {
//       userName = '${data.user!.fName} ${data.user!.lName}';
//     });
//   }

//  }
