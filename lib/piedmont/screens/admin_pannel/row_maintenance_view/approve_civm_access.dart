import 'package:CIVM/piedmont/data/response/status.dart';
import 'package:CIVM/piedmont/resources/app_colors.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/pemc_admin_new/adm_invoice_list.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/pemc_admin_new/adm_service_order.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/add_crew_member.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/add_new_row_table.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/admin_pannel.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/budget_planning.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/pemc_admin_new/inspection_zielies.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/ivm_maintenance_progress.dart';
import 'package:CIVM/piedmont/screens/leaflat_map/leaf_lat_map_wakeLock.dart';
import 'package:CIVM/piedmont/screens/login_page.dart';
import 'package:CIVM/piedmont/screens/map/provider/location_provider.dart';
import 'package:CIVM/piedmont/utils/common_functions.dart';
import 'package:CIVM/piedmont/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/piedmont/view_model/approve_civm_view_model.dart';
import 'package:CIVM/sharedPrefs/constants.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:provider/provider.dart';
import 'package:CIVM/piedmont/repository/map_url.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:CIVM/piedmont/screens/my_chrome_safari_map_recording.dart';

class ApproveCIVMAccess extends StatefulWidget {
  const ApproveCIVMAccess({Key? key}) : super(key: key);

  @override
  State<ApproveCIVMAccess> createState() => _ApproveCIVMAccessState();
}

class _ApproveCIVMAccessState extends State<ApproveCIVMAccess> {
  // int _currentIndex = 0;
  // final List<Widget> _children = [
  //   RowMaintenancePlan(),
  //   // BottomNavigationHomePage(),
  //   // BottomNavigationAccountPage()
  // ];
  List<String> menu = [];

  DateTime now = DateTime.now();
  var formatter = DateFormat('yyyy-MM-dd');

  // ignore: prefer_typing_uninitialized_variables
  var selectedSubstation;
  int substationId = 0;

  final TextEditingController _input = TextEditingController();
  final TextEditingController _input2 = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _fName = TextEditingController();
  final TextEditingController _lName = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _emailSendRecipient = TextEditingController();
  final TextEditingController _subject = TextEditingController();
  final TextEditingController _message = TextEditingController();

  onTappedBar(int index) {
    setState(() {
      // _currentIndex = index;
    });
  }

  ApproveCIVMAccessViewModel approveCIVMAccessViewModel =
      ApproveCIVMAccessViewModel();

  late bool _isLoading;

  @override
  void initState() {
    approveCIVMAccessViewModel.fetchApproveCIVMAccessTabularListApi(
      context,
      '',
      '',
    );
    // getOwnPermissions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Approve CIVM Access',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.baseColor,
      ),
      drawer: DrawerManu(menu: menu),
      body: ChangeNotifierProvider<ApproveCIVMAccessViewModel>(
        create: (BuildContext context) => approveCIVMAccessViewModel,
        child: Consumer<ApproveCIVMAccessViewModel>(
          builder: (context, value, _) {
            switch (value.approveCIVMAccessTabularData.status) {
              case Status.LOADING:
                return const Center(child: CircularProgressIndicator());
              case Status.ERROR:
                return
                // CustomToastSnackBarProgressDialog.flushBarErrorMessage(
                //     value.approveCIVMAccessTabularData.message.toString(),
                //     context);
                Padding(
                  padding: const EdgeInsets.only(
                    top: 16.0,
                    bottom: 16,
                    left: 8,
                    right: 8,
                  ),
                  child: Center(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/empty_box_pemc.png',
                            height: 200,
                            width: 200,
                            fit: BoxFit.cover,
                          ),
                          const Center(
                            child: Text(
                              'Sorry, Data Not Found!',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: AppColors.baseColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );

              case Status.COMPLETED:
                return RefreshIndicator(
                  onRefresh: () async {
                    _input.clear();
                    _input2.clear();
                    await approveCIVMAccessViewModel
                        .fetchApproveCIVMAccessTabularListApi(context, '', '');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                              bottom: 10.0,
                              top: 10,
                              right: 8,
                              left: 8,
                            ),
                            padding: const EdgeInsets.all(8),
                            alignment: Alignment.centerLeft,
                            // width: size.width * 0.8,
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.baseColor,
                                  blurRadius: 5,
                                  spreadRadius: 2,
                                  offset: Offset(5.0, 5.0),
                                ),
                              ],
                              gradient: LinearGradient(
                                colors: [Colors.white, Colors.white],
                              ),
                            ),
                            child: const Row(
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Approve Employee List",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: AppColors.baseColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              left: 8,
                              right: 8,
                              top: 10,
                              bottom: 8,
                            ),
                            padding: const EdgeInsets.all(8),
                            alignment: Alignment.center,
                            height: size.height * 0.5,
                            width: size.width * 0.99,
                            decoration: BoxDecoration(
                              // shape: BoxShape.circle,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: AppColors.baseColor,
                                  blurRadius: 10,
                                  offset: Offset(2.0, 5.0),
                                ),
                              ],
                              gradient: const LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 255, 255, 255),
                                  Color.fromARGB(255, 255, 255, 255),
                                ],
                              ),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                    bottom: 10.0,
                                    top: 10,
                                    right: 8,
                                    left: 8,
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  alignment: Alignment.centerLeft,
                                  // width: size.width * 0.8,
                                  width: MediaQuery.of(context).size.width,
                                  height: 40,
                                  decoration: const BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.black,
                                        blurRadius: 5,
                                        spreadRadius: 2,
                                        offset: Offset(5.0, 5.0),
                                      ),
                                    ],
                                    gradient: LinearGradient(
                                      colors: [
                                        AppColors.baseColor,
                                        AppColors.baseColor,
                                      ],
                                    ),
                                  ),
                                  child: const Row(
                                    children: [
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "SUPERVISOR",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 8.0,
                                      right: 8.0,
                                    ),
                                    child: TextFormField(
                                      onChanged: (value) => _filterData1(value),
                                      //  key: formkey2,
                                      controller: _input,
                                      style: const TextStyle(
                                        color: AppColors.baseColor,
                                        fontSize: 16,
                                      ),
                                      obscureText: false,

                                      //keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                          // borderRadius:
                                          //     BorderRadius.circular(25),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color.fromARGB(
                                              255,
                                              7,
                                              59,
                                              120,
                                            ),
                                          ),
                                          // borderRadius:
                                          //     BorderRadius.circular(25),
                                        ),
                                        hintText: 'Search your input...',
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Please search your input";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: approveCIVMAccessViewModel
                                          .approveCIVMAccessTabularData
                                          .data!
                                          .findAllSupervisorList!
                                          .length,
                                      itemBuilder: (context, index) {
                                        return Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                width:
                                                    MediaQuery.of(
                                                      context,
                                                    ).size.width *
                                                    0.28,
                                                // height: MediaQuery.of(context)
                                                //         .size
                                                //         .height *
                                                //     0.25,
                                                // height: 190,
                                                margin: const EdgeInsets.only(
                                                  left: 8.0,
                                                  right: 8.0,
                                                  top: 5.0,
                                                  bottom: 5.0,
                                                ),
                                                padding: const EdgeInsets.all(
                                                  8,
                                                ),
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      AppColors.green1
                                                          .withOpacity(0.9),
                                                      AppColors.green2
                                                          .withOpacity(0.7),
                                                      AppColors.green1
                                                          .withOpacity(0.9),
                                                    ],
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                  ),
                                                  border: Border.all(
                                                    color: Colors.white,
                                                  ),
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                        topRight:
                                                            Radius.circular(10),
                                                        bottomRight:
                                                            Radius.circular(10),
                                                        topLeft:
                                                            Radius.circular(10),
                                                        bottomLeft:
                                                            Radius.circular(10),
                                                      ),
                                                ),

                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                // alignment: Alignment.topLeft,
                                                                child: Column(
                                                                  children: [
                                                                    const Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child: Text(
                                                                        "SERIAL: ",
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style: TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color:
                                                                              AppColors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child: Text(
                                                                        (approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllSupervisorList![index].id ==
                                                                                    null ||
                                                                                approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllSupervisorList![index].id.toString() ==
                                                                                    'null')
                                                                            ? ''
                                                                            : approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllSupervisorList![index].id.toString(),
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style: const TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          color:
                                                                              AppColors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Expanded(
                                                                // alignment: Alignment.topLeft,
                                                                child: Column(
                                                                  children: [
                                                                    const Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child: Text(
                                                                        "NAME: ",
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style: TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color:
                                                                              AppColors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child: Text(
                                                                        (approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllSupervisorList![index].fName ==
                                                                                        null &&
                                                                                    approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllSupervisorList![index].lName ==
                                                                                        null ||
                                                                                approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllSupervisorList![index].fName.toString() ==
                                                                                        'null' &&
                                                                                    approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllSupervisorList![index].lName.toString() ==
                                                                                        'null' ||
                                                                                approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllSupervisorList![index].fName!.isEmpty &&
                                                                                    approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllSupervisorList![index].lName!.isEmpty)
                                                                            ? ''
                                                                            : ('${approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllSupervisorList![index].fName.toString()} ${approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllSupervisorList![index].lName.toString()}'),
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style: const TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          //  fontWeight:
                                                                          //      FontWeight.bold,
                                                                          color:
                                                                              AppColors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const Divider(
                                                      color: Colors.grey,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                // alignment: Alignment.topLeft,
                                                                child: Column(
                                                                  children: [
                                                                    const Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child: Text(
                                                                        "USER NAME: ",
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style: TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color:
                                                                              AppColors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child: Text(
                                                                        (approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllSupervisorList![index].fName ==
                                                                                    null ||
                                                                                approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllSupervisorList![index].fName.toString() ==
                                                                                    'null' ||
                                                                                approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllSupervisorList![index].fName!.isEmpty)
                                                                            ? ''
                                                                            : approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllSupervisorList![index].fName.toString(),
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style: const TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          //  fontWeight:
                                                                          //      FontWeight.bold,
                                                                          color:
                                                                              AppColors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Expanded(
                                                                // alignment: Alignment.topLeft,
                                                                child: Column(
                                                                  children: [
                                                                    const Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child: Text(
                                                                        "EMAIL: ",
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style: TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color:
                                                                              AppColors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child: Text(
                                                                        (approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllSupervisorList![index].email ==
                                                                                    null ||
                                                                                approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllSupervisorList![index].email.toString() ==
                                                                                    'null' ||
                                                                                approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllSupervisorList![index].email!.isEmpty)
                                                                            ? ''
                                                                            : approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllSupervisorList![index].email.toString(),
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style: const TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          //  fontWeight:
                                                                          //      FontWeight.bold,
                                                                          color:
                                                                              AppColors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const Divider(
                                                      color: Colors.grey,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                // alignment: Alignment.topLeft,
                                                                child: Column(
                                                                  children: [
                                                                    const Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child: Text(
                                                                        "ROLE: ",
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style: TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color:
                                                                              AppColors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child: Text(
                                                                        (approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllSupervisorList![index].role ==
                                                                                    null ||
                                                                                approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllSupervisorList![index].role.toString() ==
                                                                                    'null' ||
                                                                                approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllSupervisorList![index].role!.isEmpty)
                                                                            ? ''
                                                                            : approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllSupervisorList![index].role.toString(),
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style: const TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          //  fontWeight:
                                                                          //      FontWeight.bold,
                                                                          color:
                                                                              AppColors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Expanded(
                                                                // alignment: Alignment.topLeft,
                                                                child: Column(
                                                                  children: [
                                                                    const Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child: Text(
                                                                        "ADMIN: ",
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style: TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color:
                                                                              AppColors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child: Text(
                                                                        (approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllSupervisorList![index].adminId ==
                                                                                    null ||
                                                                                approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllSupervisorList![index].adminId.toString() ==
                                                                                    'null' ||
                                                                                approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllSupervisorList![index].adminId!.isEmpty)
                                                                            ? ''
                                                                            : approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllSupervisorList![index].adminId.toString(),
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style: const TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          //  fontWeight:
                                                                          //      FontWeight.bold,
                                                                          color:
                                                                              AppColors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const Divider(
                                                      color: Colors.grey,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                // alignment: Alignment.topLeft,
                                                                child: Row(
                                                                  children: [
                                                                    const Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child: Text(
                                                                        "ACTION: ",
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style: TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color:
                                                                              AppColors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child: InkWell(
                                                                        onTap: () {
                                                                          denySupervisor(
                                                                            (approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllSupervisorList![index].status!.isNotEmpty &&
                                                                                    approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllSupervisorList![index].status!.toString() ==
                                                                                        'PENDING')
                                                                                ? 'ACCEPT'
                                                                                : 'REJECT',
                                                                            index,
                                                                            approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllSupervisorList![index].id.toString(),
                                                                            approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllSupervisorList![index].status.toString(),
                                                                          );
                                                                        },
                                                                        child: Container(
                                                                          // padding: const EdgeInsets.all(2),
                                                                          alignment:
                                                                              Alignment.center,
                                                                          height:
                                                                              30,
                                                                          width:
                                                                              90,
                                                                          decoration: BoxDecoration(
                                                                            // shape: BoxShape.circle,
                                                                            // borderRadius: BorderRadius.circular(10),
                                                                            boxShadow:
                                                                                (approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllSupervisorList![index].status!.toString().isNotEmpty &&
                                                                                    approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllSupervisorList![index].status!.toString() ==
                                                                                        'PENDING')
                                                                                ? [
                                                                                    const BoxShadow(
                                                                                      color: Color.fromARGB(
                                                                                        255,
                                                                                        2,
                                                                                        43,
                                                                                        113,
                                                                                      ),
                                                                                      blurRadius: 5,
                                                                                      offset: Offset(
                                                                                        2.0,
                                                                                        5.0,
                                                                                      ),
                                                                                    ),
                                                                                  ]
                                                                                : [
                                                                                    const BoxShadow(
                                                                                      color: Color.fromARGB(
                                                                                        255,
                                                                                        117,
                                                                                        10,
                                                                                        2,
                                                                                      ),
                                                                                      blurRadius: 5,
                                                                                      offset: Offset(
                                                                                        2.0,
                                                                                        5.0,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                            color:
                                                                                Colors.black,
                                                                            gradient: LinearGradient(
                                                                              colors:
                                                                                  (approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllSupervisorList![index].status!.toString().isNotEmpty &&
                                                                                      approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllSupervisorList![index].status.toString() ==
                                                                                          'ACTIVE')
                                                                                  ? (approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllSupervisorList![index].status!.toString().isNotEmpty &&
                                                                                            approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllSupervisorList![index].status.toString() ==
                                                                                                'PENDING')
                                                                                        ? [
                                                                                            const Color.fromARGB(
                                                                                              255,
                                                                                              243,
                                                                                              128,
                                                                                              119,
                                                                                            ),
                                                                                            const Color.fromARGB(
                                                                                              255,
                                                                                              243,
                                                                                              128,
                                                                                              119,
                                                                                            ),
                                                                                            const Color.fromARGB(
                                                                                              255,
                                                                                              243,
                                                                                              128,
                                                                                              119,
                                                                                            ),
                                                                                          ]
                                                                                        : [
                                                                                            Colors.red,
                                                                                            Colors.red,
                                                                                            Colors.red,
                                                                                          ]
                                                                                  : [
                                                                                      Colors.blueAccent,
                                                                                      const Color.fromARGB(
                                                                                        255,
                                                                                        3,
                                                                                        91,
                                                                                        242,
                                                                                      ),
                                                                                      Colors.blueAccent,
                                                                                    ],
                                                                            ),
                                                                          ),
                                                                          child: Column(
                                                                            children: [
                                                                              Expanded(
                                                                                child: Align(
                                                                                  alignment: Alignment.center,
                                                                                  child: Text(
                                                                                    (approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllSupervisorList![index].status!.toString().isNotEmpty &&
                                                                                            approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllSupervisorList![index].status!.toString() ==
                                                                                                'PENDING')
                                                                                        ? 'ACCEPT'
                                                                                        : 'REJECT',
                                                                                    textAlign: TextAlign.center,
                                                                                    style: const TextStyle(
                                                                                      color: Colors.white,
                                                                                      fontWeight: FontWeight.bold,
                                                                                      fontSize: 15,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Row(
                                                            children: [
                                                              const Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child: Text(
                                                                  "SEND EMAIL: ",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: AppColors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    String
                                                                    email = approveCIVMAccessViewModel
                                                                        .approveCIVMAccessTabularData
                                                                        .data!
                                                                        .findAllSupervisorList![index]
                                                                        .email!
                                                                        .toString();
                                                                    onPressedSendMail(
                                                                      email,
                                                                    );
                                                                  },
                                                                  child: const Icon(
                                                                    Icons.mail,
                                                                    color: Colors
                                                                        .red,
                                                                    size: 40,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              left: 8,
                              right: 8,
                              top: 10,
                              bottom: 8,
                            ),
                            padding: const EdgeInsets.all(8),
                            alignment: Alignment.center,
                            height: size.height * 0.5,
                            width: size.width * 0.99,
                            decoration: BoxDecoration(
                              // shape: BoxShape.circle,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: AppColors.baseColor,
                                  blurRadius: 10,
                                  offset: Offset(2.0, 5.0),
                                ),
                              ],
                              gradient: const LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 255, 255, 255),
                                  Color.fromARGB(255, 255, 255, 255),
                                ],
                              ),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                    bottom: 10.0,
                                    top: 10,
                                    right: 8,
                                    left: 8,
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  alignment: Alignment.centerLeft,
                                  // width: size.width * 0.8,
                                  width: MediaQuery.of(context).size.width,
                                  height: 40,
                                  decoration: const BoxDecoration(
                                    // shape: BoxShape.circle,
                                    //////////////borderRadius: BorderRadius.circular(25),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.black,
                                        blurRadius: 5,
                                        spreadRadius: 2,
                                        offset: Offset(5.0, 5.0),
                                      ),
                                    ],
                                    gradient: LinearGradient(
                                      colors: [
                                        AppColors.baseColor,
                                        AppColors.baseColor,
                                      ],
                                    ),
                                  ),
                                  child: const Row(
                                    children: [
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "GENERAL FOREMAN",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 8.0,
                                      right: 8.0,
                                    ),
                                    child: TextFormField(
                                      onChanged: (value) => _filterData2(value),
                                      //  key: formkey2,
                                      controller: _input2,
                                      style: const TextStyle(
                                        color: AppColors.baseColor,
                                        fontSize: 16,
                                      ),
                                      obscureText: false,
                                      //keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                          // borderRadius:
                                          //     BorderRadius.circular(25),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color.fromARGB(
                                              255,
                                              7,
                                              59,
                                              120,
                                            ),
                                          ),
                                          // borderRadius:
                                          //     BorderRadius.circular(25),
                                        ),
                                        hintText: 'Search your input...',
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Please search your input";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: approveCIVMAccessViewModel
                                          .approveCIVMAccessTabularData
                                          .data!
                                          .findAllContractorList!
                                          .length,
                                      itemBuilder: (context, index) {
                                        return Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                width:
                                                    MediaQuery.of(
                                                      context,
                                                    ).size.width *
                                                    0.28,
                                                // height: MediaQuery.of(context)
                                                //         .size
                                                //         .height *
                                                //     0.285,
                                                // height: 190,
                                                margin: const EdgeInsets.only(
                                                  left: 8.0,
                                                  right: 8.0,
                                                  top: 5.0,
                                                  bottom: 5.0,
                                                ),
                                                padding: const EdgeInsets.all(
                                                  8,
                                                ),
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      AppColors.green1
                                                          .withOpacity(0.9),
                                                      AppColors.green2
                                                          .withOpacity(0.7),
                                                      AppColors.green1
                                                          .withOpacity(0.9),
                                                    ],
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                  ),
                                                  border: Border.all(
                                                    color: Colors.white,
                                                  ),
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                        topRight:
                                                            Radius.circular(10),
                                                        bottomRight:
                                                            Radius.circular(10),
                                                        topLeft:
                                                            Radius.circular(10),
                                                        bottomLeft:
                                                            Radius.circular(10),
                                                      ),
                                                ),

                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                // alignment: Alignment.topLeft,
                                                                child: Column(
                                                                  children: [
                                                                    const Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child: Text(
                                                                        "SERIAL: ",
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style: TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color:
                                                                              AppColors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child: Text(
                                                                        (approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllContractorList![index].id ==
                                                                                    null ||
                                                                                approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllContractorList![index].id.toString() ==
                                                                                    'null')
                                                                            ? ''
                                                                            : approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllContractorList![index].id.toString(),
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style: const TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          //  fontWeight:
                                                                          //      FontWeight.bold,
                                                                          color:
                                                                              AppColors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Expanded(
                                                                // alignment: Alignment.topLeft,
                                                                child: Column(
                                                                  children: [
                                                                    const Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child: Text(
                                                                        "NAME: ",
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style: TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color:
                                                                              AppColors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child: Text(
                                                                        (approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllContractorList![index].fName ==
                                                                                        null &&
                                                                                    approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllContractorList![index].lName ==
                                                                                        null ||
                                                                                approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllContractorList![index].fName.toString() ==
                                                                                        'null' &&
                                                                                    approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllContractorList![index].lName.toString() ==
                                                                                        'null' ||
                                                                                approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllContractorList![index].fName!.isEmpty &&
                                                                                    approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllContractorList![index].lName!.isEmpty)
                                                                            ? ''
                                                                            : ('${approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllContractorList![index].fName.toString()} ${approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllContractorList![index].lName.toString()}'),
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style: const TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          //  fontWeight:
                                                                          //      FontWeight.bold,
                                                                          color:
                                                                              AppColors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const Divider(
                                                      color: Colors.grey,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                // alignment: Alignment.topLeft,
                                                                child: Column(
                                                                  children: [
                                                                    const Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child: Text(
                                                                        "USER NAME: ",
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style: TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color:
                                                                              AppColors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child: Text(
                                                                        (approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllContractorList![index].fName ==
                                                                                    null ||
                                                                                approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllContractorList![index].fName.toString() ==
                                                                                    'null')
                                                                            ? ''
                                                                            : approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllContractorList![index].fName.toString(),
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style: const TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          //  fontWeight:
                                                                          //      FontWeight.bold,
                                                                          color:
                                                                              AppColors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Expanded(
                                                                // alignment: Alignment.topLeft,
                                                                child: Column(
                                                                  children: [
                                                                    const Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child: Text(
                                                                        "EMAIL: ",
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style: TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color:
                                                                              AppColors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child: Text(
                                                                        (approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllContractorList![index].email ==
                                                                                    null ||
                                                                                approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllContractorList![index].email.toString() ==
                                                                                    'null')
                                                                            ? ''
                                                                            : approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllContractorList![index].email.toString(),
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style: const TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          //  fontWeight:
                                                                          //      FontWeight.bold,
                                                                          color:
                                                                              AppColors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const Divider(
                                                      color: Colors.grey,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                // alignment: Alignment.topLeft,
                                                                child: Column(
                                                                  children: [
                                                                    const Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child: Text(
                                                                        "ROLE: ",
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style: TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color:
                                                                              AppColors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child: Text(
                                                                        (approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllContractorList![index].role ==
                                                                                    null ||
                                                                                approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllContractorList![index].role.toString() ==
                                                                                    'null')
                                                                            ? ''
                                                                            : approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllContractorList![index].role.toString(),
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style: const TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          //  fontWeight:
                                                                          //      FontWeight.bold,
                                                                          color:
                                                                              AppColors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Expanded(
                                                                // alignment: Alignment.topLeft,
                                                                child: Column(
                                                                  children: [
                                                                    const Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child: Text(
                                                                        "SUPERVISOR: ",
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style: TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color:
                                                                              AppColors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child: Text(
                                                                        (approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllContractorList![index].adminId ==
                                                                                    null ||
                                                                                approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllContractorList![index].adminId.toString() ==
                                                                                    'null')
                                                                            ? ''
                                                                            : approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllContractorList![index].adminId.toString(),
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style: const TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          //  fontWeight:
                                                                          //      FontWeight.bold,
                                                                          color:
                                                                              AppColors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const Divider(
                                                      color: Colors.grey,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                // alignment: Alignment.topLeft,
                                                                child: Row(
                                                                  children: [
                                                                    const Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child: Text(
                                                                        "ACTION: ",
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style: TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color:
                                                                              AppColors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child: InkWell(
                                                                        onTap: () {
                                                                          denyContractor(
                                                                            (approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllContractorList![index].status!.isNotEmpty &&
                                                                                    approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllContractorList![index].status!.toString() ==
                                                                                        'PENDING')
                                                                                ? 'ACCEPT'
                                                                                : 'REJECT',
                                                                            index,
                                                                            approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllContractorList![index].id.toString(),
                                                                            approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllContractorList![index].status.toString(),
                                                                          );
                                                                        },
                                                                        child: Container(
                                                                          // padding: const EdgeInsets.all(2),
                                                                          alignment:
                                                                              Alignment.center,
                                                                          height:
                                                                              30,
                                                                          width:
                                                                              100,
                                                                          decoration: BoxDecoration(
                                                                            // shape: BoxShape.circle,
                                                                            // borderRadius: BorderRadius.circular(10),
                                                                            boxShadow:
                                                                                (approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllContractorList![index].status!.toString().isNotEmpty &&
                                                                                    approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllContractorList![index].status!.toString() ==
                                                                                        'PENDING')
                                                                                ? [
                                                                                    const BoxShadow(
                                                                                      color: Color.fromARGB(
                                                                                        255,
                                                                                        2,
                                                                                        43,
                                                                                        113,
                                                                                      ),
                                                                                      blurRadius: 5,
                                                                                      offset: Offset(
                                                                                        2.0,
                                                                                        5.0,
                                                                                      ),
                                                                                    ),
                                                                                  ]
                                                                                : [
                                                                                    const BoxShadow(
                                                                                      color: Color.fromARGB(
                                                                                        255,
                                                                                        117,
                                                                                        10,
                                                                                        2,
                                                                                      ),
                                                                                      blurRadius: 5,
                                                                                      offset: Offset(
                                                                                        2.0,
                                                                                        5.0,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                            color:
                                                                                Colors.black,
                                                                            gradient: LinearGradient(
                                                                              colors:
                                                                                  (approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllContractorList![index].status!.toString().isNotEmpty &&
                                                                                      approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllContractorList![index].status.toString() ==
                                                                                          'ACTIVE')
                                                                                  ? (approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllContractorList![index].status!.toString().isNotEmpty &&
                                                                                            approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllContractorList![index].status.toString() ==
                                                                                                'PENDING')
                                                                                        ? [
                                                                                            const Color.fromARGB(
                                                                                              255,
                                                                                              243,
                                                                                              128,
                                                                                              119,
                                                                                            ),
                                                                                            const Color.fromARGB(
                                                                                              255,
                                                                                              243,
                                                                                              128,
                                                                                              119,
                                                                                            ),
                                                                                            const Color.fromARGB(
                                                                                              255,
                                                                                              243,
                                                                                              128,
                                                                                              119,
                                                                                            ),
                                                                                          ]
                                                                                        : [
                                                                                            Colors.red,
                                                                                            Colors.red,
                                                                                            Colors.red,
                                                                                          ]
                                                                                  : [
                                                                                      Colors.blueAccent,
                                                                                      const Color.fromARGB(
                                                                                        255,
                                                                                        3,
                                                                                        91,
                                                                                        242,
                                                                                      ),
                                                                                      Colors.blueAccent,
                                                                                    ],
                                                                            ),
                                                                          ),
                                                                          child: Column(
                                                                            children: [
                                                                              Expanded(
                                                                                child: Align(
                                                                                  alignment: Alignment.center,
                                                                                  child: Text(
                                                                                    (approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllContractorList![index].status!.toString().isNotEmpty &&
                                                                                            approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllContractorList![index].status!.toString() ==
                                                                                                'PENDING')
                                                                                        ? 'ACCEPT'
                                                                                        : 'REJECT',
                                                                                    textAlign: TextAlign.center,
                                                                                    style: const TextStyle(
                                                                                      color: Colors.white,
                                                                                      fontWeight: FontWeight.bold,
                                                                                      fontSize: 15,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 20,
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child: InkWell(
                                                                        onTap: () {
                                                                          fetchDataAndOpenMethod(
                                                                            approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllContractorList![index].id.toString(),
                                                                            approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllContractorList![index].userName.toString(),
                                                                            approveCIVMAccessViewModel.approveCIVMAccessTabularData.data!.findAllContractorList![index].fName.toString(),
                                                                          );
                                                                          //      setState(
                                                                          //     () {
                                                                          //   setDataInEditDailog();
                                                                          // });
                                                                        },
                                                                        child: Container(
                                                                          // padding: const EdgeInsets.all(2),
                                                                          alignment:
                                                                              Alignment.center,
                                                                          height:
                                                                              30,
                                                                          width:
                                                                              100,
                                                                          decoration: const BoxDecoration(
                                                                            // shape: BoxShape.circle,
                                                                            // borderRadius: BorderRadius.circular(10),
                                                                            boxShadow: [
                                                                              BoxShadow(
                                                                                color: Color.fromARGB(
                                                                                  255,
                                                                                  1,
                                                                                  94,
                                                                                  4,
                                                                                ),
                                                                                blurRadius: 10,
                                                                                offset: Offset(
                                                                                  2.0,
                                                                                  5.0,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                            color:
                                                                                Colors.black,
                                                                            gradient: LinearGradient(
                                                                              colors: [
                                                                                Colors.green,
                                                                                Colors.green,
                                                                                // Color.fromARGB(255, 3, 224, 10),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          child: const Column(
                                                                            children: [
                                                                              Expanded(
                                                                                child: Align(
                                                                                  alignment: Alignment.center,
                                                                                  child: Text(
                                                                                    'EDIT',
                                                                                    textAlign: TextAlign.center,
                                                                                    style: TextStyle(
                                                                                      color: Colors.white,
                                                                                      fontWeight: FontWeight.bold,
                                                                                      fontSize: 15,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const Divider(
                                                      color: Colors.grey,
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Text(
                                                            "SEND EMAIL: ",
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: AppColors
                                                                  .white,
                                                            ),
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: InkWell(
                                                            onTap: () {
                                                              // String
                                                              // formattedDate =
                                                              // formatter
                                                              //     .format(
                                                              //         now);
                                                              String
                                                              email = approveCIVMAccessViewModel
                                                                  .approveCIVMAccessTabularData
                                                                  .data!
                                                                  .findAllContractorList![index]
                                                                  .email!
                                                                  .toString();
                                                              onPressedSendMail(
                                                                email,
                                                              );
                                                            },
                                                            child: const Icon(
                                                              Icons.mail,
                                                              color: Colors.red,
                                                              size: 40,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );

              default:
                return const Text('data');
            }
          },
        ),
      ),
    );
  }

  Future<void> _filterData1(String query) async {
    if (query.isEmpty) {
      approveCIVMAccessViewModel.fetchApproveCIVMAccessTabularListApi(
        context,
        '',
        '',
      );
    } else {
      approveCIVMAccessViewModel
          .approveCIVMAccessTabularData
          .data!
          .findAllSupervisorList = approveCIVMAccessViewModel
          .approveCIVMAccessTabularData
          .data!
          .findAllSupervisorList!
          .where(
            (item) =>
                item.userName!.toLowerCase().contains(query.toLowerCase()) ||
                item.email!.toString().toLowerCase().contains(
                  query.toLowerCase(),
                ),
          )
          .toList();
    }
    setState(() {});
  }

  Future<void> _filterData2(String query) async {
    if (query.isEmpty) {
      approveCIVMAccessViewModel.fetchApproveCIVMAccessTabularListApi(
        context,
        '',
        '',
      );
    } else {
      approveCIVMAccessViewModel
          .approveCIVMAccessTabularData
          .data
          ?.findAllContractorList = approveCIVMAccessViewModel
          .approveCIVMAccessTabularData
          .data
          ?.findAllContractorList
          ?.where(
            (item) =>
                item.email?.toLowerCase().contains(query.toLowerCase()) ==
                    true ||
                item.fName?.toLowerCase().contains(query.toLowerCase()) == true,
          )
          .toList();
    }
    setState(() {});
  }

  Future denySupervisor(var data, int ind, String userName, String status) =>
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Column(
            children: [
              Text(
                'Are you sure you want to ${data} this user?',
                style: const TextStyle(
                  color: AppColors.baseColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0, left: 60),
              child: Align(
                alignment: Alignment.centerRight,
                child: Row(
                  children: [
                    InkWell(
                      onTap: (() {
                        if (data == 'REJECT') {
                          approveCIVMAccessViewModel
                                  .approveCIVMAccessTabularData
                                  .data!
                                  .findAllSupervisorList![ind]
                                  .status =
                              'PENDING';
                        } else {
                          approveCIVMAccessViewModel
                                  .approveCIVMAccessTabularData
                                  .data!
                                  .findAllSupervisorList![ind]
                                  .status =
                              'ACTIVE';
                        }
                        approveCIVMAccessViewModel
                            .fetchApproveCIVMUpdatePutListApi(
                              context,
                              (data == 'REJECT') ? 'PENDING' : 'ACTIVE',
                              userName,
                            );
                        Navigator.of(context).pop();
                      }),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.height * 0.052,
                        decoration: const BoxDecoration(
                          // shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 142, 209, 145),
                              blurRadius: 5,
                              offset: Offset(2.0, 5.0),
                            ),
                          ],
                          color: Colors.black,
                          gradient: LinearGradient(
                            colors: [Colors.green, Colors.green],
                          ),
                        ),
                        child: const Row(
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Yes",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (() {
                        Navigator.of(context).pop();
                      }),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: MediaQuery.of(context).size.height * 0.052,
                          decoration: const BoxDecoration(
                            // shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 253, 138, 176),
                                blurRadius: 5,
                                offset: Offset(2.0, 5.0),
                              ),
                            ],
                            color: Colors.black,
                            gradient: LinearGradient(
                              colors: [Colors.red, Colors.red],
                            ),
                          ),
                          child: const Row(
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Cancel",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  Future denyContractor(var data, int ind, String userName, String status) =>
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Column(
            children: [
              Text(
                'Are you sure you want to ${data} this user?',
                style: const TextStyle(
                  color: AppColors.baseColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0, left: 60),
              child: Align(
                alignment: Alignment.centerRight,
                child: Row(
                  children: [
                    InkWell(
                      onTap: (() {
                        if (data == 'REJECT') {
                          approveCIVMAccessViewModel
                                  .approveCIVMAccessTabularData
                                  .data!
                                  .findAllContractorList![ind]
                                  .status =
                              'PENDING';
                        } else {
                          approveCIVMAccessViewModel
                                  .approveCIVMAccessTabularData
                                  .data!
                                  .findAllContractorList![ind]
                                  .status =
                              'ACTIVE';
                        }
                        approveCIVMAccessViewModel
                            .fetchApproveCIVMUpdatePutListApi(
                              context,
                              (data == 'REJECT') ? 'PENDING' : 'ACTIVE',
                              userName,
                            );
                        Navigator.of(context).pop();
                      }),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.height * 0.052,
                        decoration: const BoxDecoration(
                          // shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 142, 209, 145),
                              blurRadius: 5,
                              offset: Offset(2.0, 5.0),
                            ),
                          ],
                          color: Colors.black,
                          gradient: LinearGradient(
                            colors: [Colors.green, Colors.green],
                          ),
                        ),
                        child: const Row(
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Yes",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (() {
                        Navigator.of(context).pop();
                      }),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: MediaQuery.of(context).size.height * 0.052,
                          decoration: const BoxDecoration(
                            // shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 253, 138, 176),
                                blurRadius: 5,
                                offset: Offset(2.0, 5.0),
                              ),
                            ],
                            color: Colors.black,
                            gradient: LinearGradient(
                              colors: [Colors.red, Colors.red],
                            ),
                          ),
                          child: const Row(
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Cancel",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
    value: item,
    child: Text(
      item,
      style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
    ),
  );

  Future<void> fetchDataAndOpenMethod(
    String id,
    String userName,
    String fName,
  ) async {
    try {
      // CustomToastSnackBarProgressDialog.showLoaderDialog(context);
      await approveCIVMAccessViewModel
          .fetchApproveCIVMAccessTabularListApi(context, id, id)
          .then((value) async {
            await Future.delayed(const Duration(seconds: 5), () {
              setState(() {
                _isLoading = false;
              });
            });
            _isLoading
                ? CustomToastSnackBarProgressDialog.showLoaderDialog(context)
                : onPressedEdit(id, userName, fName);
          });
    } catch (error) {
      print("Error: $error");
    }
  }

  setDataInEditDailog() {
    // _email.text = (approveCIVMAccessViewModel
    //                 .approveCIVMAccessTabularData.data!.loginData!.email ==
    //             null ||
    //         approveCIVMAccessViewModel
    //                 .approveCIVMAccessTabularData.data!.loginData!.email
    //                 .toString() ==
    //             'null' ||
    //         approveCIVMAccessViewModel
    //             .approveCIVMAccessTabularData.data!.loginData!.email
    //             .toString()
    //             .isEmpty)
    //     ? ''
    //     : approveCIVMAccessViewModel
    //         .approveCIVMAccessTabularData.data!.loginData!.email
    //         .toString();

    // _fName.text = (approveCIVMAccessViewModel
    //                 .approveCIVMAccessTabularData.data!.loginData!.fName ==
    //             null ||
    //         approveCIVMAccessViewModel
    //                 .approveCIVMAccessTabularData.data!.loginData!.fName
    //                 .toString() ==
    //             'null' ||
    //         approveCIVMAccessViewModel
    //             .approveCIVMAccessTabularData.data!.loginData!.fName
    //             .toString()
    //             .isEmpty)
    //     ? ''
    //     : approveCIVMAccessViewModel
    //         .approveCIVMAccessTabularData.data!.loginData!.fName
    //         .toString();

    // _lName.text = (approveCIVMAccessViewModel
    //                 .approveCIVMAccessTabularData.data!.loginData!.lName ==
    //             null ||
    //         approveCIVMAccessViewModel
    //                 .approveCIVMAccessTabularData.data!.loginData!.lName
    //                 .toString() ==
    //             'null' ||
    //         approveCIVMAccessViewModel
    //             .approveCIVMAccessTabularData.data!.loginData!.lName
    //             .toString()
    //             .isEmpty)
    //     ? ''
    //     : approveCIVMAccessViewModel
    //         .approveCIVMAccessTabularData.data!.loginData!.lName
    //         .toString();

    // _password.text = (approveCIVMAccessViewModel
    //                 .approveCIVMAccessTabularData.data!.loginData!.password ==
    //             null ||
    //         approveCIVMAccessViewModel
    //                 .approveCIVMAccessTabularData.data!.loginData!.password
    //                 .toString() ==
    //             'null' ||
    //         approveCIVMAccessViewModel
    //             .approveCIVMAccessTabularData.data!.loginData!.password
    //             .toString()
    //             .isEmpty)
    //     ? ''
    //     : approveCIVMAccessViewModel
    //         .approveCIVMAccessTabularData.data!.loginData!.password
    //         .toString();
    final loginData =
        approveCIVMAccessViewModel.approveCIVMAccessTabularData.data?.loginData;

    if (loginData == null) {
      return;
    }
    substationId = approveCIVMAccessViewModel
        .approveCIVMAccessTabularData
        .data
        ?.contractorMasterDataList
        ?.isNotEmpty == true
    ? (approveCIVMAccessViewModel
            .approveCIVMAccessTabularData
            .data
            ?.contractorMasterDataList?[0]
            .sUPERVISORID ??
        0)
    : 0;

selectedSubstation = approveCIVMAccessViewModel
        .approveCIVMAccessTabularData
        .data
        ?.contractorMasterDataList
        ?.isNotEmpty == true
    ? (approveCIVMAccessViewModel
            .approveCIVMAccessTabularData
            .data
            ?.contractorMasterDataList?[0]
            .sUPERVISORID
            ?.toString() ??
        '')
    : null;
    _email.text = loginData.email ?? '';
    _fName.text = loginData.fName ?? '';
    _lName.text = loginData.lName ?? '';
    _password.text = loginData.password ?? '';
  }

  onPressedEdit(String id, String userName, String fName) {
    print(
      "data = ${approveCIVMAccessViewModel.approveCIVMAccessTabularData.data}",
    );
    print(
      "loginData = ${approveCIVMAccessViewModel.approveCIVMAccessTabularData.data?.loginData}",
    );

    if (approveCIVMAccessViewModel
            .approveCIVMAccessTabularData
            .data
            ?.loginData ==
        null) {
      print("loginData is null");
      return;
    }
    setDataInEditDailog();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                'CONTACT DETAILS',
                style: TextStyle(
                  color: AppColors.baseColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Text(
                          "Assign To ",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: AppColors.baseColor,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: DropdownButtonFormField<String>(
                          hint: const Text('-Select-'),
                          dropdownColor: Colors.white,
                          // value: selectedSubstation,
                          value:
                              approveCIVMAccessViewModel
                                  .approveCIVMAccessTabularData
                                  .data!
                                  .getAllAssignToContractorList!
                                  .any(
                                    (e) =>
                                        e.id.toString() == selectedSubstation,
                                  )
                              ? selectedSubstation
                              : null,
                          style: const TextStyle(
                            color: AppColors.baseColor,
                            fontSize: 16,
                          ),
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: AppColors.baseColor,
                            size: 40,
                          ),
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.baseColor,
                              ),
                              // borderRadius: BorderRadius.circular(25),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.baseColor,
                              ),
                              // borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          isExpanded: true,
                          items: approveCIVMAccessViewModel
                              .approveCIVMAccessTabularData
                              .data!
                              .getAllAssignToContractorList!
                              .map((e) {
                                return DropdownMenuItem(
                                  value: e.id.toString(),
                                  // e.getIdAndSubstationByCountId![0].subStation.toString(),
                                  child: Text(e.name.toString()),
                                );
                              })
                              .toList(),
                          onChanged: (val) {
                            substationId = int.parse(val!);
                            setState(() {
                              selectedSubstation = val;
                            });
                          },
                          validator: (value) =>
                              value == null ? 'field required' : null,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Text(
                          "Email",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: AppColors.baseColor,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: TextFormField(
                          //  key: formkey2,
                          controller: _email,
                          style: const TextStyle(
                            color: AppColors.baseColor,
                            fontSize: 16,
                          ),
                          obscureText: false,
                          // keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              // borderRadius: BorderRadius.circular(25),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.baseColor,
                              ),
                              // borderRadius: BorderRadius.circular(25),
                            ),
                            hintText: 'Email',
                            // prefixIcon: const Icon(
                            //   Icons.person,
                            //   color: AppColors.baseColor,
                            // ),
                          ),

                          validator: (value) {
                            if (value.toString() == '') {
                              return "Please enter email";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Text(
                          "First Name",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: AppColors.baseColor,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: TextFormField(
                          //  key: formkey2,
                          controller: _fName,
                          style: const TextStyle(
                            color: AppColors.baseColor,
                            fontSize: 16,
                          ),
                          obscureText: false,
                          // keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              // borderRadius: BorderRadius.circular(25),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.baseColor,
                              ),
                              // borderRadius: BorderRadius.circular(25),
                            ),
                            hintText: 'First Name',
                            // prefixIcon: const Icon(
                            //   Icons.person,
                            //   color: AppColors.baseColor,
                            // ),
                          ),

                          validator: (value) {
                            if (value.toString() == '') {
                              return "Please enter email";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Text(
                          "Last Name",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: AppColors.baseColor,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: TextFormField(
                          //  key: formkey2,
                          controller: _lName,
                          style: const TextStyle(
                            color: AppColors.baseColor,
                            fontSize: 16,
                          ),
                          obscureText: false,
                          // keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              // borderRadius: BorderRadius.circular(25),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.baseColor,
                              ),
                              // borderRadius: BorderRadius.circular(25),
                            ),
                            hintText: 'Last Name',
                            // prefixIcon: const Icon(
                            //   Icons.person,
                            //   color: AppColors.baseColor,
                            // ),
                          ),

                          validator: (value) {
                            if (value.toString() == '') {
                              return "Please enter email";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Text(
                          "Password",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: AppColors.baseColor,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: TextFormField(
                          //  key: formkey2,
                          controller: _password,
                          style: const TextStyle(
                            color: AppColors.baseColor,
                            fontSize: 16,
                          ),
                          obscureText: false,
                          // keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              // borderRadius: BorderRadius.circular(25),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.baseColor,
                              ),
                              // borderRadius: BorderRadius.circular(25),
                            ),
                            hintText: 'Password',
                            // prefixIcon: const Icon(
                            //   Icons.person,
                            //   color: AppColors.baseColor,
                            // ),
                          ),

                          validator: (value) {
                            if (value.toString() == '') {
                              return "Please enter email";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  left: 6,
                  right: 6,
                  top: 6.0,
                  bottom: 10,
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 10, bottom: 10.0),
                    // padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: 40,
                    decoration: const BoxDecoration(
                      // shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 131, 11, 2),
                          blurRadius: 5,
                          offset: Offset(2.0, 5.0),
                        ),
                      ],
                      color: Colors.black,
                      gradient: LinearGradient(
                        colors: [Colors.red, Colors.red],
                      ),
                    ),
                    child: const Row(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Close",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 6,
                  right: 6,
                  top: 6.0,
                  bottom: 10,
                ),
                child: InkWell(
                  onTap: () {
                    print("object");
                    Map mappedData = {
                      "id": approveCIVMAccessViewModel
                          .approveCIVMAccessTabularData
                          .data!
                          .loginData!
                          .id
                          .toString(),
                      "userName": approveCIVMAccessViewModel
                          .approveCIVMAccessTabularData
                          .data!
                          .loginData!
                          .userName
                          .toString(),
                      "password": _password.text.toString(),
                      "fName": _fName.text.toString(),
                      "lName": _lName.text.toString(),
                      "email": _email.text.toString(),
                    };

                    print('mappedData');
                    print(mappedData);

                    approveCIVMAccessViewModel.fetchApproveCIVMSubmitListApi1(
                      context,
                      mappedData,
                    );

                    secondApi(id, fName);

                    // Future.delayed(const Duration(seconds: 2));
                    // Navigator.pop(context);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 10, bottom: 10.0),
                    // padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.37,
                    height: 40,
                    decoration: const BoxDecoration(
                      // shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black,
                          blurRadius: 5,
                          offset: Offset(2.0, 5.0),
                        ),
                      ],
                      color: Colors.black,
                      gradient: LinearGradient(
                        colors: [AppColors.baseColor, AppColors.baseColor],
                      ),
                    ),
                    child: const Row(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Save Changes",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  onPressedSendMail(String email) {
    _emailSendRecipient.text = email;
    _subject.text = 'Reminder';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10.0),
                // padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.7,
                height: 40,
                decoration: const BoxDecoration(
                  // shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 116, 70, 1),
                      blurRadius: 5,
                      offset: Offset(2.0, 5.0),
                    ),
                  ],
                  color: Colors.black,
                  gradient: LinearGradient(
                    colors: [Colors.orange, Colors.orange],
                  ),
                ),
                child: const Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Compose Email",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Text(
                          "To:",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: AppColors.baseColor,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: TextFormField(
                          //  key: formkey2,
                          controller: _emailSendRecipient,
                          style: const TextStyle(
                            color: AppColors.baseColor,
                            fontSize: 16,
                          ),
                          obscureText: false,
                          // keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              // borderRadius: BorderRadius.circular(25),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.baseColor,
                              ),
                              // borderRadius: BorderRadius.circular(25),
                            ),
                            hintText: 'Email',
                            // prefixIcon: const Icon(
                            //   Icons.person,
                            //   color: AppColors.baseColor,
                            // ),
                          ),

                          validator: (value) {
                            if (value.toString() == '') {
                              return "Please enter email";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Text(
                          "Subject:",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: AppColors.baseColor,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: TextFormField(
                          //  key: formkey2,
                          controller: _subject,
                          style: const TextStyle(
                            color: AppColors.baseColor,
                            fontSize: 16,
                          ),
                          obscureText: false,
                          // keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              // borderRadius: BorderRadius.circular(25),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.baseColor,
                              ),
                              // borderRadius: BorderRadius.circular(25),
                            ),
                            hintText: 'Subject',
                            // prefixIcon: const Icon(
                            //   Icons.person,
                            //   color: AppColors.baseColor,
                            // ),
                          ),

                          validator: (value) {
                            if (value.toString() == '') {
                              return "Please enter subject";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Text(
                          "Message:",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: AppColors.baseColor,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: TextFormField(
                          //  key: formkey2,
                          controller: _message,
                          style: const TextStyle(
                            color: AppColors.baseColor,
                            fontSize: 16,
                          ),
                          obscureText: false,
                          minLines: 4,
                          maxLines: 10,
                          // keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              // borderRadius: BorderRadius.circular(25),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.baseColor,
                              ),
                              // borderRadius: BorderRadius.circular(25),
                            ),
                            hintText: 'Type your message here',
                            // prefixIcon: const Icon(
                            //   Icons.person,
                            //   color: AppColors.baseColor,
                            // ),
                          ),

                          validator: (value) {
                            if (value.toString() == '') {
                              return "Please enter message";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(
              left: 6,
              right: 6,
              top: 6.0,
              bottom: 10,
            ),
            child: InkWell(
              onTap: () {
                List<String> list = [
                  // 'jitendra.kushwaha@ariespro.com',
                  'preetika.patel@ariespro.com',
                ];
                _sendMail(
                  list,
                  _subject.text.toString(),
                  _message.text.toString(),
                  _emailSendRecipient.text.toString(),
                );
              },
              child: Center(
                child: Container(
                  margin: const EdgeInsets.only(left: 10, bottom: 10.0),
                  // padding: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.37,
                  height: 40,
                  decoration: const BoxDecoration(
                    // shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 0, 79, 215),
                        blurRadius: 5,
                        offset: Offset(2.0, 5.0),
                      ),
                    ],
                    color: Colors.black,
                    gradient: LinearGradient(
                      colors: [Colors.blue, Colors.blue],
                    ),
                  ),
                  child: const Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Send Email",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

   Future<void> _sendMail(
    List<String> recipientsList,
    String subject,
    String content,
    String email,
  ) async {
    String username = 'ats.ariespro@gmail.com';
    String password = 'ahbfhcshjujvkgge';

    final smtpServer = gmail(username, password);

    print('SMTP Host: mail.ariespro.com');
    print('Username: $username');
    print('Recipient: $email');

    final message = Message()
      ..from = Address(username, 'CIVM')
      ..recipients.add(email)
      ..subject = subject
      ..html = "<h4>Hi,</h4><p>$content</p>";

    try {
      final sendReport = await send(message, smtpServer);

      print('Message sent: $sendReport');

      CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
        'Email Sent',
        context,
      );
      await Future.delayed(const Duration(seconds: 2));

      if (context.mounted) {
        Navigator.pop(context);
        Navigator.pop(context);
      }
    } on MailerException catch (e) {
      print('Message not sent.');

      for (var p in e.problems) {
        print('Problem: ${p.code}');
        print('Message: ${p.msg}');
      }

      CustomToastSnackBarProgressDialog.flushBarErrorMessage(
        'Email Not Sent',
        context,
      );
    } catch (e, stackTrace) {
      print('Unexpected error: $e');
      print(stackTrace);

      CustomToastSnackBarProgressDialog.flushBarErrorMessage(
        'Email Not Sent',
        context,
      );
    }
  }

  void secondApi(String id, String fName) {
    Map mappedData2 = {
      "NAME": fName,
      "SUPERVISOR_ID": substationId,
      "LOGIN_ID": id,
    };
    print('mappedData2');
    print(mappedData2);
    approveCIVMAccessViewModel.fetchApproveCIVMSubmitListApi2(
      context,
      mappedData2,
    );
    thirdApi();
  }

  void thirdApi() {
    print('22222222222');
    print(approveCIVMAccessViewModel.approveCIVMAccessTabularData.data);
    print(
      approveCIVMAccessViewModel
          .approveCIVMAccessTabularData
          .data
          ?.contractorMasterDataList,
    );

    print(
      approveCIVMAccessViewModel
          .approveCIVMAccessTabularData
          .data
          ?.contractorMasterDataList
          ?.isNotEmpty,
    );

    // print(approveCIVMAccessViewModel
    //     .approveCIVMAccessTabularData.data?.contractorMasterDataList?[0]
    //     .contractorMasterData);

    // print(approveCIVMAccessViewModel
    //     .approveCIVMAccessTabularData.data?.contractorMasterDataList?[0]
    //     .contractorMasterData?.supervisorId);

    print(
      approveCIVMAccessViewModel
          .approveCIVMAccessTabularData
          .data
          ?.contractorMasterDataList?[0]
          .lOGINID,
    );
    approveCIVMAccessViewModel.fetchApproveCIVMSubmitListApi3(
      context,
      approveCIVMAccessViewModel
          .approveCIVMAccessTabularData
          .data!
          .contractorMasterDataList![0]
          .sUPERVISORID
          .toString(),
      approveCIVMAccessViewModel
          .approveCIVMAccessTabularData
          .data!
          .contractorMasterDataList![0]
          .lOGINID
          .toString(),
    );
    print('111111');
    Future.delayed(Duration(seconds: 5));
    if (context.mounted) {
      Navigator.pop(context);
      approveCIVMAccessViewModel.fetchApproveCIVMAccessTabularListApi(
        context,
        '',
        '',
      );
    }
  }
}

// ignore: must_be_immutable
class DrawerManu extends StatefulWidget {
  List<String> menu;
  DrawerManu({Key? key, required this.menu}) : super(key: key);

  @override
  State<DrawerManu> createState() => _DrawerManuState();
}

class _DrawerManuState extends State<DrawerManu> {
  String userName = '';
  String? _imagePath;

  @override
  void initState() {
    setUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userPreferences = Provider.of<UserPref>(context);
    var provider = Provider.of<LocationProviderPemc>(context, listen: true);
    final browser = MyChromeSafariBrowser();
    return Drawer(
      child: SafeArea(
        child: Column(
          // Important: Remove any padding from the ListView.
          // padding: EdgeInsets.zero,
          children: [
            Container(
              width: double.infinity,
              height: 180,
              color: AppColors.lighterBaseColor,
              padding: const EdgeInsets.only(top: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  menuLogo(),
                  const SizedBox(height: 6),
                  Text(
                    userName,
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: const Icon(Icons.computer),
                    title: const Text('Row Maintenance Plan'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const EnergyAuditPannel(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.compare),
                    title: const Text('Inspection'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const InspectionZielies(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.pending),
                    title: const Text('Service Order'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const AdmServiceOrder(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.airplane_ticket_sharp),
                    title: const Text('Job List'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              AdminAddNewRowTable(index: '0'),
                        ),
                      );
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (BuildContext context) => AddNewRowMaintenancePlan(
                      //           tokenNo: '',
                      //           index: '0',
                      //           subStation: '',
                      //           feeder: '',
                      //           nextMaintYear: '',
                      //           maintType: '',
                      //           totalMiles: '',
                      //           costPerMile: '',
                      //           totalCost: '',
                      //           budgetType: '',
                      //           contractRowYear: '',
                      //           rowCycle: '',
                      //           rowYear: '',
                      //           contractorCompany: '',
                      //           assignForeman: '',
                      //         )));
                    },
                  ),
                  // Visibility(
                  //   visible: (widget.menu.isNotEmpty &&
                  //           widget.menu.contains('Energy Audit Ticket'))
                  //       ? true
                  //       : false,
                  // child:
                  ///////////new added maps for PEMC
                  ListTile(
                    leading: const Icon(Icons.vertical_distribute),
                    title: const Text('Add ROW Distribution Map'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () async {
                      String id = '';
                      final userPreferences1 = Provider.of<UserPref>(
                        context,
                        listen: false,
                      );
                      UserModel data = await userPreferences1.getUser();
                      id = data.user!.id.toString();
                      await browser.open(
                        url: WebUri(
                          MapUrl.getPlannerDistributionMapEndPoint(id),
                        ),
                        settings: ChromeSafariBrowserSettings(
                          shareState: CustomTabsShareState.SHARE_STATE_OFF,
                          barCollapsingEnabled: true,
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.maps_ugc),
                    title: const Text('Add ROW Transmission Map'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () async {
                      String id = '';
                      final userPreferences1 = Provider.of<UserPref>(
                        context,
                        listen: false,
                      );
                      UserModel data = await userPreferences1.getUser();
                      id = data.user!.id.toString();
                      await browser.open(
                        url: WebUri(
                          MapUrl.getPlannerTransmissionMapEndPoint(id),
                        ),
                        settings: ChromeSafariBrowserSettings(
                          shareState: CustomTabsShareState.SHARE_STATE_OFF,
                          barCollapsingEnabled: true,
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.map),
                    title: const Text('Add Herbicide Transmission Map'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () async {
                      String id = '';
                      final userPreferences1 = Provider.of<UserPref>(
                        context,
                        listen: false,
                      );
                      UserModel data = await userPreferences1.getUser();
                      id = data.user!.id.toString();
                      await browser.open(
                        url: WebUri(MapUrl.midTransmissionMapEndPoint(id)),
                        settings: ChromeSafariBrowserSettings(
                          shareState: CustomTabsShareState.SHARE_STATE_OFF,
                          barCollapsingEnabled: true,
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.maps_ugc_rounded),
                    title: const Text('Add Annual Herbicide Map'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () async {
                      String id = '';
                      final userPreferences1 = Provider.of<UserPref>(
                        context,
                        listen: false,
                      );
                      UserModel data = await userPreferences1.getUser();
                      id = data.user!.id.toString();
                      await browser.open(
                        url: WebUri(MapUrl.officeTransmissionMapEndPoint(id)),
                        settings: ChromeSafariBrowserSettings(
                          shareState: CustomTabsShareState.SHARE_STATE_OFF,
                          barCollapsingEnabled: true,
                        ),
                      );
                    },
                  ),

                  ////////////////////////////////////
                  ListTile(
                    leading: const Icon(Icons.open_in_new),
                    title: const Text('IVM Maintenance Progress'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const RowMaintenanceProgress(),
                        ),
                      );
                    },
                  ),
                  // ),
                  // ListTile(
                  //   leading: const Icon(
                  //     Icons.closed_caption_off,
                  //   ),
                  //   title: const Text('Row Analytics Dashboard'),
                  //   textColor: AppColors.baseColor,
                  //   iconColor: AppColors.baseColor,
                  //   onTap: () {
                  //     Navigator.of(context).push(MaterialPageRoute(
                  //         builder: (BuildContext context) =>
                  //             const RowAnalyticsDashboard()));
                  //   },
                  // ),
                  ListTile(
                    leading: const Icon(Icons.list),
                    title: const Text('Invoice List'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const AdmInvoiceList(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.data_usage),
                    title: const Text('Budget Planning'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const BudgetPlanning(),
                        ),
                      );
                    },
                  ),

                  ListTile(
                    leading: const Icon(Icons.location_on),
                    title: const Text('Live IVM System Map'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      provider.getLocation();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const MapScreenLeafLat(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.check),
                    title: const Text('Approve CIVM Access'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.add),
                    title: const Text('Add Crew Member'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const AddCrewMember(),
                        ),
                      );
                    },
                  ),

                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Logout'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      // Constants.prefs.setBool("LoggedIn", false);
                      userPreferences.remove().then((value) {
                        // ignore: use_build_context_synchronously
                        // Navigator.pushReplacement(context, RoutesName.login);
                        // Navigator.pushNamed(
                        //     context, RoutesName.login);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const LoginPagePemc(),
                          ),
                        );
                      });
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (BuildContext context) => const LoginPage()));
                    },
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(
                    'Version: ${Constants.prefs.getString('VERSION') ?? ''}',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Updated: ${Constants.prefs.getString('VERSION_DATE') ?? ''}',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> setUserName() async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    Image.network(
      'https://atsdev2test.ariespro.com/assets/clientuploads/${data.user!.profilePhoto}',
    );
    String imageUrl =
        'https://atsdev2test.ariespro.com/assets/clientuploads/${data.user!.profilePhoto}';
    _imagePath = imageUrl;
    setState(() {
      userName = '${data.user!.fName} ${data.user!.lName}';
    });
  }
}
