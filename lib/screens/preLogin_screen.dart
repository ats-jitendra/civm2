import 'package:CIVM/other/login_page_other.dart';
import 'package:CIVM/piedmont/screens/login_page.dart';
import 'package:CIVM/utils/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreLoginScreen extends StatefulWidget {
  const PreLoginScreen({super.key});

  @override
  State<PreLoginScreen> createState() => _PreLoginScreenState();
}

class _PreLoginScreenState extends State<PreLoginScreen> {
  final TextEditingController _typeAheadController = TextEditingController();

  List<String> applicationTypeData = [
    "Lake Country Power",
    "Blue Ridge Electric Member Cooperative",
    "Roanoke Electric Cooperative",
    "Duncan Power",
    "York Electric Cooperative",
    "Piedmont Electric Cooperative",
    "Broad River Electric Cooperative"
  ];

  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // important
      body: SafeArea(
        child: Container(
          /// Gradient Background
          decoration: const BoxDecoration(),

          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 20, left: 20, top: 0, bottom: 0),
                child: IntrinsicHeight(
                  child: Column(
                    //   mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ///Logo
                      Image.asset(
                        'assets/Ariespro full logo v2 without BG.png',
                        height: 90,
                      ),

                      const SizedBox(height: 20),

                      ///Description
                      const Text(
                        "At AriesPro, we recognize the critical role that vegetation management plays in maintaining the safety, reliability, and efficiency of transmission and distribution systems. Overgrown vegetation poses serious risks, including power outages, increased maintenance costs, and safety hazards to both workers and the public. Our Cloud Integrated Vegetation Management (CIVM) services are designed to address these challenges with precision and innovation.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          // color: Colors.white70,
                        ),
                      ),

                      const SizedBox(height: 40),

                      Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Utility Name',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold))),
                          ),

                          ///TypeAhead Field
                        TypeAheadField<String>(
  direction: VerticalDirection.up, // ✅ correct

  controller: _typeAheadController,

  builder: (context, controller, focusNode) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        hintText: "Search",
        filled: true,
        fillColor: Colors.grey.shade100,
        prefixIcon: const Icon(Icons.search),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.blue,
            width: 1.5,
          ),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.grey.shade400,
            width: 1.2,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFF4A90E2),
            width: 2,
          ),
        ),
      ),
    );
  },

  suggestionsCallback: (pattern) {
    if (pattern.isEmpty) {
      return [];
    }

    return applicationTypeData
        .where((item) =>
            item.toLowerCase().contains(pattern.toLowerCase()))
        .toList();
  },

  itemBuilder: (context, String suggestion) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          const Icon(Icons.apps, size: 18, color: Colors.grey),
          const SizedBox(width: 10),
          Text(
            suggestion,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  },

  /// ✅ REQUIRED in v5
  onSelected: (String suggestion) {
    _typeAheadController.text = suggestion;
    setState(() => isSelected = true);
  },

  /// ✅ replacement for suggestionsBoxDecoration
  decorationBuilder: (context, child) {
    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(12),
      color: Colors.white,
      shadowColor: Colors.black26,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 180),
        child: child,
      ),
    );
  },
)  ],
                      ),
                      //  ),

                      //  const Spacer(),
                      const SizedBox(height: 40),

                      /// Next Button
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: GestureDetector(
                          onTap: isSelected
                              ? () {
                                  storeApplicationType(
                                      _typeAheadController.text);
                                  if (_typeAheadController.text ==
                                      "Lake Country Power") {
                                    Navigator.pushNamed(
                                        context, RoutesName.login);
                                    print(
                                        'application prelogin ${_typeAheadController.text}');
                                  } else if (_typeAheadController.text ==
                                      "Piedmont Electric Cooperative") {
                                    // Navigator.pushNamed(
                                    //     context, RoutesNamePemc.loginPemc);
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginPagePemc()));
                                    print(
                                        'application prelogin ${_typeAheadController.text}');
                                  } else {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginPageOther()));
                                  }
                                }
                              : null,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient:
                                  // isSelected
                                  //     ?
                                  const LinearGradient(
                                colors: [
                                  Color(0xFF4A90E2),
                                  Color(0xFF4A90E2),
                                  //  Color(0xFF6A11CB)
                                ],
                              ),
                              // : LinearGradient(
                              //     colors: [
                              //       Colors.grey.shade400,
                              //       Colors.grey.shade300
                              //     ],
                              //   ),
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                if (isSelected)
                                  const BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 8,
                                    offset: Offset(0, 4),
                                  )
                              ],
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              "Next",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
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

  storeApplicationType(
    String applicationType,
  ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('applicationType', applicationType);
    print('applicationType $applicationType');
  }
}
