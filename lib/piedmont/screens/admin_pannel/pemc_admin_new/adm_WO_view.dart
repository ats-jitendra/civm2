import 'dart:convert';
import 'package:CIVM/piedmont/models/lcp_document_approval_model.dart';
import 'package:CIVM/piedmont/resources/app_colors.dart';
import 'package:CIVM/piedmont/resources/app_url.dart';
import 'package:CIVM/piedmont/utils/common_functions.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/models/user_model.dart'; 
// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class AdmWOView extends StatefulWidget {
  String tokenNo;
  String status;

  AdmWOView({
    Key? key,
    required this.tokenNo,
    required this.status,
  }) : super(key: key);

  @override
  State<AdmWOView> createState() => _AdmWOViewState();
}

class _AdmWOViewState extends State<AdmWOView> {
  DateTime currentDate = DateTime.now();

  final TextEditingController _estimatedTime = TextEditingController();
  final TextEditingController _followUpDate = TextEditingController();
  final TextEditingController _createdBy = TextEditingController();
  late final TextEditingController _dateOfInspection = TextEditingController();
  final TextEditingController _substation = TextEditingController();
  final TextEditingController _feeder = TextEditingController();
  final TextEditingController _nextMaintYear = TextEditingController();
  final TextEditingController _maintType = TextEditingController();
  final TextEditingController _foremanNotes = TextEditingController();
  final TextEditingController _contractorCompany = TextEditingController();
  Future? myFuture;
  @override
  void initState() {
    myFuture = fetchDetails(context);
    print('widget.tokenNo ${widget.tokenNo}');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Work Order Data",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.baseColor,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: FutureBuilder(
          future: myFuture,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            // SUCCESS DATA
            return GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.all(12),
                        width: size.width,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.baseColor,
                              blurRadius: 10,
                              offset: Offset(2.0, 5.0),
                            ),
                          ],
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            // /// HEADER
                            // Container(
                            //   height: 50,
                            //   width: double.infinity,
                            //   padding: const EdgeInsets.all(10),
                            //   decoration: const BoxDecoration(
                            //     gradient: LinearGradient(
                            //       colors: [
                            //         AppColors.baseColor,
                            //         AppColors.buttonOrange,
                            //         AppColors.baseColor,
                            //       ],
                            //     ),
                            //   ),
                            //   child: const Align(
                            //     alignment: Alignment.centerLeft,
                            //     child: Text(
                            //       "IVM MAINTENANCE PLAN",
                            //       style: TextStyle(
                            //         color: Colors.white,
                            //         fontWeight: FontWeight.bold,
                            //         fontSize: 20,
                            //       ),
                            //     ),
                            //   ),
                            // ),

                            buildField("SUBSTATION", _substation),
                            buildField("FEEDER", _feeder),
                            buildField("CREATED BY", _createdBy),
                            buildField("MAINTENANCE TYPE", _maintType),
                            buildField("NEXT MAINT YEAR", _nextMaintYear),
                            buildField(
                                "CONTRACTOR COMPANY", _contractorCompany),
                            buildField("DATE OF INSPECTION", _dateOfInspection),
                            buildField("FOLLOW UP DATE", _followUpDate),
                            buildField("ESTIMATED TIME(HOURS)", _estimatedTime),
                            buildField("FOREMAN NOTES", _foremanNotes),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
        ),
      );

  WOFindAllTableData? item;
  String id = '';
  Future<void> fetchDetails(BuildContext context) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    id = data.user!.id.toString();
    var url =
        "${AppUrl.woTabularDataEndPoint}?substation=&status=${widget.status}&fdr=&maintType=ChangeOrder&panel=supervisor&contractorCompany=Lewis Tree&tokenNo=${widget.tokenNo}";

    print('url $url');

    var headers = {
      "Content-Type": "application/json",
      // "Authorization": "Bearer $token", //  Add this line
      "Authorization": 'Bearer ${data.token!}'
    };

    try {
      var response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        var res = jsonDecode(response.body);

        print(response.body);

        List list = res["findAllTableData"];

        if (list.isNotEmpty) {
          item = WOFindAllTableData.fromJson(list[0]);

          WidgetsBinding.instance.addPostFrameCallback((_) {
            setData();
          });

          setState(() {});
        }
      } else {
        // setState(() => isLoading = false);
      }
    } catch (e) {
      // setState(() => isLoading = false);
    }
  }

  void setData() {
    _nextMaintYear.text = getYearOrNA(item?.nextMaintDue ?? '');
    _substation.text = item?.substation ?? '';
    _feeder.text = getFeederName(item?.fdrName ?? '');
    _createdBy.text = item?.createdBy ?? '';
    _dateOfInspection.text = formatDateIfNeeded(item?.dateOfInspection ?? '');
    _followUpDate.text = formatDateIfNeeded(item?.followUpDate ?? '');
    _maintType.text = item?.type ?? '';
    _contractorCompany.text = item?.contractorCompany ?? '';
    _estimatedTime.text = item?.estTime ?? '';
    _foremanNotes.text = item?.crewNotes ?? '';
  }

  String getFeederName(String input) {
    //  return input.split('(')[0].replaceAll('.', '').trim();
    return input.split('(')[0].trim();
  }
}
