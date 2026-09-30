import 'package:flutter/material.dart';
import 'package:CIVM/piedmont/resources/app_colors.dart';

class EdkoViewFile extends StatefulWidget {
  String jobNo;
  String substation;
  String feeder;
  String type;
  String maintType;
  String contractorCompany;
  String totalMiles;
  EdkoViewFile(
      {super.key,
      required this.jobNo,
      required this.substation,
      required this.feeder,
      required this.type,
      required this.maintType,
      required this.contractorCompany,
      required this.totalMiles});

  @override
  State<EdkoViewFile> createState() => _EdkoViewFileState();
}

class _EdkoViewFileState extends State<EdkoViewFile> {
  TextEditingController _jobNo = TextEditingController();
  TextEditingController _substation = TextEditingController();
  TextEditingController _feeder = TextEditingController();
  TextEditingController _type = TextEditingController();
  TextEditingController _maintType = TextEditingController();
  TextEditingController _contractorCompany = TextEditingController();
  TextEditingController _totalMiles = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'View Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.baseColor,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 2.0, right: 2.0, bottom: 2.0, top: 10.0),
            child: Row(
              children: [
                const Expanded(
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "JOB NO",
                        style: TextStyle(
                            fontSize: 16.0,
                            color: AppColors.baseColor,
                            fontWeight: FontWeight.bold),
                      )),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: TextFormField(
                        enabled: false,
                        // key: formkey6,
                        controller: _jobNo,
                        style: const TextStyle(
                            color: AppColors.baseColor, fontSize: 16),
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.baseColor,
                            ),
                          ),
                          hintText: '',
                        ),
                        // validator: (value) {
                        //   if (value!.isEmpty) {
                        //     return "Please enter total cost";
                        //   } else {
                        //     return null;
                        //   }
                        // },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 2.0, right: 2.0, bottom: 2.0, top: 10.0),
            child: Row(
              children: [
                const Expanded(
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "SUBSTATION",
                        style: TextStyle(
                            fontSize: 16.0,
                            color: AppColors.baseColor,
                            fontWeight: FontWeight.bold),
                      )),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: TextFormField(
                        enabled: false,
                        // key: formkey6,
                          controller: _substation,
                        style: const TextStyle(
                            color: AppColors.baseColor, fontSize: 16),
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.baseColor,
                            ),
                          ),
                          hintText: '',
                        ),
                        // validator: (value) {
                        //   if (value!.isEmpty) {
                        //     return "Please enter total cost";
                        //   } else {
                        //     return null;
                        //   }
                        // },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 2.0, right: 2.0, bottom: 2.0, top: 10.0),
            child: Row(
              children: [
                const Expanded(
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "FEEDER",
                        style: TextStyle(
                            fontSize: 16.0,
                            color: AppColors.baseColor,
                            fontWeight: FontWeight.bold),
                      )),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: TextFormField(
                        enabled: false,
                        // key: formkey6,
                        controller: _feeder,
                        style: const TextStyle(
                            color: AppColors.baseColor, fontSize: 16),
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.baseColor,
                            ),
                          ),
                          hintText: '',
                        ),
                        // validator: (value) {
                        //   if (value!.isEmpty) {
                        //     return "Please enter total cost";
                        //   } else {
                        //     return null;
                        //   }
                        // },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 2.0, right: 2.0, bottom: 2.0, top: 10.0),
            child: Row(
              children: [
                const Expanded(
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "TYPE",
                        style: TextStyle(
                            fontSize: 16.0,
                            color: AppColors.baseColor,
                            fontWeight: FontWeight.bold),
                      )),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: TextFormField(
                        enabled: false,
                        // key: formkey6,
                         controller: _type,
                        style: const TextStyle(
                            color: AppColors.baseColor, fontSize: 16),
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.baseColor,
                            ),
                          ),
                          hintText: '',
                        ),
                        // validator: (value) {
                        //   if (value!.isEmpty) {
                        //     return "Please enter total cost";
                        //   } else {
                        //     return null;
                        //   }
                        // },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 2.0, right: 2.0, bottom: 2.0, top: 10.0),
            child: Row(
              children: [
                const Expanded(
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "MAINT TYPE",
                        style: TextStyle(
                            fontSize: 16.0,
                            color: AppColors.baseColor,
                            fontWeight: FontWeight.bold),
                      )),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: TextFormField(
                        enabled: false,
                        // key: formkey6,
                          controller: _maintType,
                        style: const TextStyle(
                            color: AppColors.baseColor, fontSize: 16),
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.baseColor,
                            ),
                          ),
                          hintText: '',
                        ),
                        // validator: (value) {
                        //   if (value!.isEmpty) {
                        //     return "Please enter total cost";
                        //   } else {
                        //     return null;
                        //   }
                        // },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 2.0, right: 2.0, bottom: 2.0, top: 10.0),
            child: Row(
              children: [
                const Expanded(
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "CONTRACTOR COMPANY",
                        style: TextStyle(
                            fontSize: 16.0,
                            color: AppColors.baseColor,
                            fontWeight: FontWeight.bold),
                      )),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: TextFormField(
                        enabled: false,
                        // key: formkey6,
                          controller: _contractorCompany,
                        style: const TextStyle(
                            color: AppColors.baseColor, fontSize: 16),
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.baseColor,
                            ),
                          ),
                          hintText: '',
                        ),
                        // validator: (value) {
                        //   if (value!.isEmpty) {
                        //     return "Please enter total cost";
                        //   } else {
                        //     return null;
                        //   }
                        // },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 2.0, right: 2.0, bottom: 2.0, top: 10.0),
            child: Row(
              children: [
                const Expanded(
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "TOTAL MILES",
                        style: TextStyle(
                            fontSize: 16.0,
                            color: AppColors.baseColor,
                            fontWeight: FontWeight.bold),
                      )),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: TextFormField(
                        enabled: false,
                        // key: formkey6,
                          controller: _totalMiles,
                        style: const TextStyle(
                            color: AppColors.baseColor, fontSize: 16),
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.baseColor,
                            ),
                          ),
                          hintText: '',
                        ),
                        // validator: (value) {
                        //   if (value!.isEmpty) {
                        //     return "Please enter total cost";
                        //   } else {
                        //     return null;
                        //   }
                        // },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
