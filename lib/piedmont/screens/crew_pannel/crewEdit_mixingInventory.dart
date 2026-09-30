// ignore: file_names
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:CIVM/piedmont/data/response/status.dart';
import 'package:CIVM/piedmont/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:CIVM/piedmont/view_model/mixing_inventory_view_model.dart';
import 'package:CIVM/piedmont/resources/app_colors.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/models/user_model.dart';

// ignore: must_be_immutable
class CrewEditMixingInventoryContractor extends StatefulWidget {
  String id;
  CrewEditMixingInventoryContractor({Key? key, required this.id})
      : super(key: key);

  @override
  State<CrewEditMixingInventoryContractor> createState() =>
      _CrewEditMixingInventoryContractorState();
}

class _CrewEditMixingInventoryContractorState
    extends State<CrewEditMixingInventoryContractor> {
  final TextEditingController _workOrderNo = TextEditingController();
  // final TextEditingController _date = TextEditingController();
  final TextEditingController _utility = TextEditingController();
  // final TextEditingController _weekStartDate = TextEditingController();

  // final TextEditingController _weekendDate = TextEditingController();
  final TextEditingController _foreman = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  bool isChemicalDescriptionSelected = true;
  bool isChemicalQuantitySelected = false;

  MixingInventoryViewModel mixingInventoryViewModel =
      MixingInventoryViewModel();

  late String dateSelected1 = 'MM-dd-yyyy';
  DateTime date1 = DateTime.now();

     bool _isVisibleSubmittingButton = false;
  bool _isVisibleSubmitButton = true;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(2010),
        lastDate: DateTime(2050));
    if (picked != null && picked != date) {
      setState(() {
        date = picked;
        formattedDate = DateFormat('MM-dd-yyyy').format(picked);
      });
    }
  }

  List<ChemicalDescriptionClass> chemicalDescription = [];
  List<ChemicalQuantityClass> chemicalQuantity = [];

  // ignore: non_constant_identifier_names
  final select_noOfChemicalQuantity = [
    '--SELECT--',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25'
  ];
  // ignore: non_constant_identifier_names
  String? noOfChemicalQuantity = '--SELECT--';

  int selectedDateFlag = 0;

  DateTimeRange dateRange =
      DateTimeRange(start: DateTime(2022, 11, 5), end: DateTime(2022, 12, 24));

  List<String> numberOfDays = [];
  List<List<Map<String, dynamic>>> tablesList = [];
  List<List<List<TextEditingController>>> controllerList = [];

  DateTimeRange? selectedDateRange;
  int numberOfDaysSelected = 0;
  int cardChemicalDescriptionLength = 0;

  late DateTime date;
  late String formattedDate;
  late String formattedDate1;
  late String formattedDate2;
  int flag = 0;

  @override
  void initState() {
    mixingInventoryViewModel.fetchMixingInventoryTabularListApi(
        context, widget.id);
    date = DateTime.now();
    formattedDate = DateFormat('MM-dd-yyyy').format(date);
    formattedDate1 = DateFormat('MM-dd-yyyy').format(date);
    formattedDate2 = DateFormat('MM-dd-yyyy').format(date);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'MIXING INVENTORY',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: AppColors.baseColor,
        ),
        // drawer: DrawerManu(menu: menu),
        body: ChangeNotifierProvider<MixingInventoryViewModel>(
            create: (BuildContext context) => mixingInventoryViewModel,
            child: Consumer<MixingInventoryViewModel>(
                builder: (context, value, _) {
              switch (value.mixingInventoryGetTabularData.status) {
                case Status.LOADING:
                  return const Center(child: CircularProgressIndicator());
                case Status.ERROR:
                  return
                      // CustomToastSnackBarProgressDialog.flushBarErrorMessage(
                      //     value.mixingInventoryGetTabularData.message.toString(),
                      //     context);
                      Padding(
                    padding: const EdgeInsets.only(
                        top: 16.0, bottom: 16, left: 8, right: 8),
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
                  print('123456789');
                  print(mixingInventoryViewModel.mixingInventoryGetTabularData
                      .data!.getAllChemicalDescriptions!.length);

                  if (flag == 0) {
                    flag = 1;
                    setData(value);
                    setDataChemicalDescription(value);
                    setDataChemicalQuantity(value);
                  }

                  return SingleChildScrollView(
                    child: DefaultTabController(
                      length: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Form(
                          key: _formkey,
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 4, right: 4, top: 10, bottom: 8),
                                padding: const EdgeInsets.all(8),
                                alignment: Alignment.center,
                                height: size.height * 0.5,
                                width: size.width * 0.99,
                                decoration: BoxDecoration(
                                    // shape: BoxShape.circle,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                                      BoxShadow(
                                          color:
                                              AppColors.baseColor,
                                          blurRadius: 10,
                                          offset: Offset(2.0, 5.0))
                                    ],
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color.fromARGB(255, 255, 255, 255),
                                        Color.fromARGB(255, 255, 255, 255),
                                      ],
                                    )),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 2.0,
                                                right: 2.0,
                                                bottom: 2.0,
                                                top: 8.0),
                                            child: Text(
                                              "WORK ORDER NUMBER",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color.fromARGB(
                                                      255, 7, 59, 120),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: TextFormField(
                                            enabled: false,
                                            //  key: formkey5,
                                            controller: _workOrderNo,
                                            style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 7, 59, 120),
                                                fontSize: 16),
                                            obscureText: false,
                                            // keyboardType: TextInputType.number,
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 7, 59, 120),
                                                ),
                                              ),
                                              hintText: 'work order no',
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Please enter work order no";
                                              } else {
                                                return null;
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                      const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 2.0,
                                                right: 2.0,
                                                bottom: 2.0,
                                                top: 8.0),
                                            child: Text(
                                              "DATE",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color.fromARGB(
                                                      255, 7, 59, 120),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Container(
                                            height: 65,
                                            width: size.width * 0.99,
                                            decoration: const BoxDecoration(
                                                // shape: BoxShape.circle,
                                                boxShadow: [],
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Color.fromARGB(
                                                        255, 7, 59, 120),
                                                    Color.fromARGB(
                                                        255, 7, 59, 120),
                                                  ],
                                                )),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(1.0),
                                              child: Container(
                                                width: size.width * 0.99,
                                                decoration: const BoxDecoration(
                                                    // shape: BoxShape.circle,
                                                    boxShadow: [],
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Colors.white,
                                                        Colors.white,
                                                      ],
                                                    )),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top: 2),
                                                              child: IconButton(
                                                                icon: const Icon(
                                                                    Icons
                                                                        .calendar_month),
                                                                iconSize: 22,
                                                                color: const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    7,
                                                                    59,
                                                                    120),
                                                                onPressed: () {
                                                                  selectDate(
                                                                      context);
                                                                  // print(date);
                                                                },
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 2),
                                                              child: Text(
                                                                  formattedDate,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            7,
                                                                            59,
                                                                            120),
                                                                  )),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 2.0,
                                                right: 2.0,
                                                bottom: 2.0,
                                                top: 8.0),
                                            child: Text(
                                              "UTILITY",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color.fromARGB(
                                                      255, 7, 59, 120),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: TextFormField(
                                            //enabled: false,
                                            //  key: formkey5,
                                            controller: _utility,
                                            style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 7, 59, 120),
                                                fontSize: 16),
                                            obscureText: false,
                                            // keyboardType: TextInputType.number,
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 7, 59, 120),
                                                ),
                                              ),
                                              hintText: 'utility',
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Please enter utility";
                                              } else {
                                                return null;
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                      const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 2.0,
                                                right: 2.0,
                                                bottom: 2.0,
                                                top: 8.0),
                                            child: Text(
                                              "FOREMAN",
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Color.fromARGB(
                                                      255, 7, 59, 120),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: TextFormField(
                                            //enabled: false,
                                            //  key: formkey5,
                                            controller: _foreman,
                                            style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 7, 59, 120),
                                                fontSize: 16),
                                            obscureText: false,
                                            // keyboardType: TextInputType.number,
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 7, 59, 120),
                                                ),
                                              ),
                                              hintText: 'foreman',
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Please enter foreman";
                                              } else {
                                                return null;
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                      const Row(
                                        children: [
                                          Expanded(
                                            child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 2.0,
                                                      right: 2.0,
                                                      bottom: 2.0,
                                                      top: 8.0),
                                                  child: Text(
                                                    "WEEK START DATE",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Color.fromARGB(
                                                            255, 7, 59, 120),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                )),
                                          ),
                                          Expanded(
                                            child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 2.0,
                                                      right: 2.0,
                                                      bottom: 2.0,
                                                      top: 8.0),
                                                  child: Text(
                                                    "WEEK END DATE",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Color.fromARGB(
                                                            255, 7, 59, 120),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                )),
                                          ),
                                        ],
                                      ),
                                      Row(children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 4.0,
                                                left: 2,
                                                right: 2,
                                                bottom: 4),
                                            child: InkWell(
                                              onTap: () {
                                                _selectDateRange(context);
                                              },
                                              child: Container(
                                                height: 65,
                                                width: size.width * 0.99,
                                                decoration: const BoxDecoration(
                                                    // shape: BoxShape.circle,
                                                    boxShadow: [],
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Color.fromARGB(
                                                            255, 7, 59, 120),
                                                        Color.fromARGB(
                                                            255, 7, 59, 120),
                                                      ],
                                                    )),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(1.0),
                                                  child: Container(
                                                    width: size.width * 0.99,
                                                    decoration:
                                                        const BoxDecoration(
                                                            // shape: BoxShape.circle,
                                                            boxShadow: [],
                                                            gradient:
                                                                LinearGradient(
                                                              colors: [
                                                                Colors.white,
                                                                Colors.white,
                                                              ],
                                                            )),
                                                    child: Row(
                                                      children: [
                                                        IconButton(
                                                          icon: const Icon(Icons
                                                              .calendar_month),
                                                          iconSize: 15,
                                                          color: const Color
                                                              .fromARGB(
                                                              255, 7, 59, 120),
                                                          onPressed: () {
                                                            _selectDateRange(
                                                                context);
                                                          },
                                                        ),
                                                        Text(
                                                          (selectedDateRange ==
                                                                      null ||
                                                                  selectedDateFlag ==
                                                                      0)
                                                              // ? 'Start Date'
                                                              ? formattedDate1
                                                              : DateFormat('MM-dd-yyyy').format(selectedDateRange!.start),
                                                              // '${selectedDateRange?.start.day}/${selectedDateRange?.start.month}/${selectedDateRange?.start.year}',
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 16,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    7,
                                                                    59,
                                                                    120),
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            IconButton(
                                                              icon: const Icon(Icons
                                                                  .linear_scale),
                                                              iconSize: 15,
                                                              color: const Color
                                                                  .fromARGB(255,
                                                                  7, 59, 120),
                                                              onPressed: () {
                                                                // Optional: Add any additional logic
                                                              },
                                                            ),
                                                            Text(
                                                              (selectedDateRange ==
                                                                          null ||
                                                                      selectedDateFlag ==
                                                                          0)
                                                                  // ? 'End Date'
                                                                  ? formattedDate2
                                                                  : DateFormat('MM-dd-yyyy').format(selectedDateRange!.end),
                                                                  // '${selectedDateRange?.end.day}/${selectedDateRange?.end.month}/${selectedDateRange?.end.year}',
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 16,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        7,
                                                                        59,
                                                                        120),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ])
                                    ],
                                  ),
                                ),
                              ),
                              // Container(
                              //   margin: const EdgeInsets.only(
                              //       left: 4, right: 4, top: 10, bottom: 8),
                              //   padding: const EdgeInsets.all(8),
                              //   alignment: Alignment.center,
                              //   // height: size.height * 0.5,
                              //   width: size.width * 0.99,
                              //   decoration: BoxDecoration(
                              //       // shape: BoxShape.circle,
                              //       borderRadius: BorderRadius.circular(10),
                              //       boxShadow: const [
                              //         BoxShadow(
                              //             color:
                              //                 AppColors.baseColor,
                              //             blurRadius: 10,
                              //             offset: Offset(2.0, 5.0))
                              //       ],
                              //       gradient: const LinearGradient(
                              //         colors: [
                              //           Color.fromARGB(255, 255, 255, 255),
                              //           Color.fromARGB(255, 255, 255, 255),
                              //         ],
                              //       )),
                              //   child: Column(
                              //     children: [
                              //       Container(
                              //         padding: const EdgeInsets.all(10),
                              //         alignment: Alignment.center,
                              //         width: size.width * 0.99,
                              //         // width: MediaQuery.of(context).size.width,
                              //         // height: 40,
                              //         decoration: const BoxDecoration(
                              //             // shape: BoxShape.circle,
                              //             //borderRadius: BorderRadius.circular(25),
                              //             boxShadow: [
                              //               BoxShadow(
                              //                   color: Color.fromARGB(
                              //                       255, 3, 47, 97),
                              //                   blurRadius: 5,
                              //                   offset: Offset(2.0, 5.0))
                              //             ],
                              //             gradient: LinearGradient(
                              //               colors: [
                              //                 AppColors.baseColor,
                              //                 Color.fromARGB(255, 7, 59, 120)
                              //               ],
                              //             )),
                              //         child: const Row(children: [
                              //           Align(
                              //             alignment: Alignment.centerLeft,
                              //             child: Text(
                              //               "CHEMICAL DESCRIPTION",
                              //               textAlign: TextAlign.left,
                              //               style: TextStyle(
                              //                 color: Colors.white,
                              //                 fontWeight: FontWeight.bold,
                              //                 fontSize: 20,
                              //               ),
                              //             ),
                              //           ),
                              //         ]),
                              //       ),
                              //       Container(
                              //         margin: const EdgeInsets.only(
                              //             left: 8, right: 8, top: 8, bottom: 8),
                              //         padding: const EdgeInsets.all(8),
                              //         alignment: Alignment.center,
                              //         height: size.height * 0.35,
                              //         width: size.width * 0.99,
                              //         decoration: BoxDecoration(
                              //             // shape: BoxShape.circle,
                              //             borderRadius:
                              //                 BorderRadius.circular(10),
                              //             boxShadow: const [
                              //               BoxShadow(
                              //                   color: Color.fromARGB(
                              //                       255, 7, 59, 120),
                              //                   blurRadius: 10,
                              //                   offset: Offset(2.0, 5.0))
                              //             ],
                              //             gradient: const LinearGradient(
                              //               colors: [
                              //                 Color.fromARGB(
                              //                     255, 255, 255, 255),
                              //                 Color.fromARGB(
                              //                     255, 255, 255, 255),
                              //               ],
                              //             )),
                              //         child: ListView.builder(
                              //             itemCount: chemicalDescription.length,
                              //             shrinkWrap: true,
                              //             itemBuilder:
                              //                 (BuildContext ctxt, int index) {
                              //               return Row(
                              //                 children: [
                              //                   Padding(
                              //                     padding:
                              //                         const EdgeInsets.only(
                              //                             top: 4.0,
                              //                             bottom: 4,
                              //                             left: 4),
                              //                     child: Container(
                              //                       width: size.width * 0.83,
                              //                       padding:
                              //                           const EdgeInsets.all(8),
                              //                       decoration: BoxDecoration(
                              //                           color: const Color
                              //                                   .fromARGB(
                              //                               255, 7, 59, 120),
                              //                           border: Border.all(
                              //                             color: Colors.white,
                              //                           ),
                              //                           borderRadius:
                              //                               const BorderRadius
                              //                                   .only(
                              //                             topRight:
                              //                                 Radius.circular(
                              //                                     10),
                              //                             bottomRight:
                              //                                 Radius.circular(
                              //                                     10),
                              //                             topLeft:
                              //                                 Radius.circular(
                              //                                     10),
                              //                             bottomLeft:
                              //                                 Radius.circular(
                              //                                     10),
                              //                           )),
                              //                       child: Column(children: [
                              //                         Row(
                              //                           children: [
                              //                             Expanded(
                              //                               child: Align(
                              //                                 alignment: Alignment
                              //                                     .centerRight,
                              //                                 child: Padding(
                              //                                   padding:
                              //                                       const EdgeInsets
                              //                                               .all(
                              //                                           2.0),
                              //                                   child:
                              //                                       TextFormField(
                              //                                     //  key: formkey5,
                              //                                     controller:
                              //                                         chemicalDescription[
                              //                                                 index]
                              //                                             .date,
                              //                                     style: const TextStyle(
                              //                                         color: Colors
                              //                                             .white,
                              //                                         fontSize:
                              //                                             12),
                              //                                     obscureText:
                              //                                         false,
                              //                                     // keyboardType: TextInputType.number,
                              //                                     decoration: const InputDecoration(
                              //                                         border: OutlineInputBorder(
                              //                                             // borderRadius: BorderRadius.circular(25),
                              //                                             ),
                              //                                         enabledBorder: OutlineInputBorder(
                              //                                           borderSide:
                              //                                               BorderSide(
                              //                                             color:
                              //                                                 Colors.white,
                              //                                           ),
                              //                                           // borderRadius: BorderRadius.circular(25),
                              //                                         ),
                              //                                         labelText: 'DATE',
                              //                                         labelStyle: TextStyle(color: Colors.white, fontSize: 12)),

                              //                                     validator:
                              //                                         (value) {
                              //                                       if (value!
                              //                                           .isEmpty) {
                              //                                         return "Please enter date";
                              //                                       } else {
                              //                                         return null;
                              //                                       }
                              //                                     },
                              //                                   ),
                              //                                 ),
                              //                               ),
                              //                             ),
                              //                             Expanded(
                              //                               child: Align(
                              //                                 alignment: Alignment
                              //                                     .centerRight,
                              //                                 child: Padding(
                              //                                   padding:
                              //                                       const EdgeInsets
                              //                                               .all(
                              //                                           2.0),
                              //                                   child:
                              //                                       TextFormField(
                              //                                     //  key: formkey5,
                              //                                     controller:
                              //                                         chemicalDescription[
                              //                                                 index]
                              //                                             .time,
                              //                                     style: const TextStyle(
                              //                                         color: Colors
                              //                                             .white,
                              //                                         fontSize:
                              //                                             12),
                              //                                     obscureText:
                              //                                         false,
                              //                                     // keyboardType: TextInputType.number,
                              //                                     decoration: const InputDecoration(
                              //                                         border: OutlineInputBorder(
                              //                                             // borderRadius: BorderRadius.circular(25),
                              //                                             ),
                              //                                         enabledBorder: OutlineInputBorder(
                              //                                           borderSide:
                              //                                               BorderSide(
                              //                                             color:
                              //                                                 Colors.white,
                              //                                           ),
                              //                                           // borderRadius: BorderRadius.circular(25),
                              //                                         ),
                              //                                         labelText: 'TIME',
                              //                                         labelStyle: TextStyle(color: Colors.white, fontSize: 12)),

                              //                                     validator:
                              //                                         (value) {
                              //                                       if (value!
                              //                                           .isEmpty) {
                              //                                         return "Please enter time";
                              //                                       } else {
                              //                                         return null;
                              //                                       }
                              //                                     },
                              //                                   ),
                              //                                 ),
                              //                               ),
                              //                             ),
                              //                           ],
                              //                         ),
                              //                         const Divider(
                              //                           color: Colors.grey,
                              //                         ),
                              //                         Row(
                              //                           children: [
                              //                             Expanded(
                              //                               child: Align(
                              //                                 alignment: Alignment
                              //                                     .centerRight,
                              //                                 child: Padding(
                              //                                   padding:
                              //                                       const EdgeInsets
                              //                                               .all(
                              //                                           2.0),
                              //                                   child:
                              //                                       TextFormField(
                              //                                     //  key: formkey5,
                              //                                     controller: chemicalDescription[
                              //                                             index]
                              //                                         .waterAmount,
                              //                                     style: const TextStyle(
                              //                                         color: Colors
                              //                                             .white,
                              //                                         fontSize:
                              //                                             12),
                              //                                     obscureText:
                              //                                         false,

                              //                                     decoration: const InputDecoration(
                              //                                         border: OutlineInputBorder(
                              //                                             // borderRadius: BorderRadius.circular(25),
                              //                                             ),
                              //                                         enabledBorder: OutlineInputBorder(
                              //                                           borderSide:
                              //                                               BorderSide(
                              //                                             color:
                              //                                                 Colors.white,
                              //                                           ),
                              //                                           // borderRadius: BorderRadius.circular(25),
                              //                                         ),
                              //                                         labelText: 'WATER AMOUNT',
                              //                                         labelStyle: TextStyle(color: Colors.white, fontSize: 12)),
                              //                                     onChanged:
                              //                                         (value) {
                              //                                       // calculateTotalCost(
                              //                                       //     index);
                              //                                       print(
                              //                                           '123456');
                              //                                     },
                              //                                     validator:
                              //                                         (value) {
                              //                                       if (value!
                              //                                           .isEmpty) {
                              //                                         return "Please enter water amount";
                              //                                       } else {
                              //                                         return null;
                              //                                       }
                              //                                     },
                              //                                   ),
                              //                                 ),
                              //                               ),
                              //                             ),
                              //                             Expanded(
                              //                               child: Align(
                              //                                 alignment: Alignment
                              //                                     .centerRight,
                              //                                 child: Padding(
                              //                                   padding:
                              //                                       const EdgeInsets
                              //                                               .all(
                              //                                           2.0),
                              //                                   child:
                              //                                       TextFormField(
                              //                                     //  key: formkey5,
                              //                                     controller:
                              //                                         chemicalDescription[
                              //                                                 index]
                              //                                             .batch,
                              //                                     style: const TextStyle(
                              //                                         color: Colors
                              //                                             .white,
                              //                                         fontSize:
                              //                                             12),
                              //                                     obscureText:
                              //                                         false,

                              //                                     decoration: const InputDecoration(
                              //                                         border: OutlineInputBorder(
                              //                                             // borderRadius: BorderRadius.circular(25),
                              //                                             ),
                              //                                         enabledBorder: OutlineInputBorder(
                              //                                           borderSide:
                              //                                               BorderSide(
                              //                                             color:
                              //                                                 Colors.white,
                              //                                           ),
                              //                                           // borderRadius: BorderRadius.circular(25),
                              //                                         ),
                              //                                         labelText: 'BATCH',
                              //                                         labelStyle: TextStyle(color: Colors.white, fontSize: 12)),
                              //                                     onChanged:
                              //                                         (value) {
                              //                                       // calculateTotalCost(
                              //                                       //     index);
                              //                                       print(
                              //                                           '123456');
                              //                                     },
                              //                                     validator:
                              //                                         (value) {
                              //                                       if (value!
                              //                                           .isEmpty) {
                              //                                         return "Please enter batch";
                              //                                       } else {
                              //                                         return null;
                              //                                       }
                              //                                     },
                              //                                   ),
                              //                                 ),
                              //                               ),
                              //                             ),
                              //                           ],
                              //                         ),
                              //                         const Divider(
                              //                           color: Colors.grey,
                              //                         ),
                              //                         SizedBox(
                              //                           child: ListView.builder(
                              //                               itemCount:
                              //                                   chemicalDescription[
                              //                                           index]
                              //                                       .additionalData!
                              //                                       .length,
                              //                               shrinkWrap: true,
                              //                               itemBuilder:
                              //                                   (BuildContext
                              //                                           ctxt,
                              //                                       int index2) {
                              //                                 return Container(
                              //                                   width:
                              //                                       size.width *
                              //                                           0.77,
                              //                                   padding:
                              //                                       const EdgeInsets
                              //                                               .only(
                              //                                           top: 4,
                              //                                           bottom:
                              //                                               4,
                              //                                           left:
                              //                                               4),
                              //                                   decoration:
                              //                                       BoxDecoration(
                              //                                           color: const Color.fromARGB(
                              //                                               255,
                              //                                               4,
                              //                                               172,
                              //                                               174),
                              //                                           border: Border
                              //                                               .all(
                              //                                             color:
                              //                                                 Colors.white,
                              //                                           ),
                              //                                           borderRadius:
                              //                                               const BorderRadius.only(
                              //                                             topRight:
                              //                                                 Radius.circular(10),
                              //                                             bottomRight:
                              //                                                 Radius.circular(10),
                              //                                             topLeft:
                              //                                                 Radius.circular(10),
                              //                                             bottomLeft:
                              //                                                 Radius.circular(10),
                              //                                           )),
                              //                                   child: Column(
                              //                                       children: [
                              //                                         Row(
                              //                                           children: [
                              //                                             Expanded(
                              //                                               flex:
                              //                                                   4,
                              //                                               child:
                              //                                                   Align(
                              //                                                 alignment: Alignment.centerRight,
                              //                                                 child: Padding(
                              //                                                   padding: const EdgeInsets.all(2.0),
                              //                                                   child: TextFormField(
                              //                                                     //  key: formkey5,
                              //                                                     controller: chemicalDescription[index].additionalData![index2].chemicalName,
                              //                                                     style: const TextStyle(color: Colors.white, fontSize: 12),
                              //                                                     obscureText: false,
                              //                                                     // keyboardType: TextInputType.number,
                              //                                                     decoration: const InputDecoration(
                              //                                                         border: OutlineInputBorder(
                              //                                                             // borderRadius: BorderRadius.circular(25),
                              //                                                             ),
                              //                                                         enabledBorder: OutlineInputBorder(
                              //                                                           borderSide: BorderSide(
                              //                                                             color: Colors.white,
                              //                                                           ),
                              //                                                           // borderRadius: BorderRadius.circular(25),
                              //                                                         ),
                              //                                                         labelText: 'CHEMICAL NAME',
                              //                                                         labelStyle: TextStyle(color: Colors.white, fontSize: 12)),

                              //                                                     validator: (value) {
                              //                                                       if (value!.isEmpty) {
                              //                                                         return "Please enter chemical name";
                              //                                                       } else {
                              //                                                         return null;
                              //                                                       }
                              //                                                     },
                              //                                                   ),
                              //                                                 ),
                              //                                               ),
                              //                                             ),
                              //                                             Expanded(
                              //                                               flex:
                              //                                                   4,
                              //                                               child:
                              //                                                   Align(
                              //                                                 alignment: Alignment.centerRight,
                              //                                                 child: Padding(
                              //                                                   padding: const EdgeInsets.all(2.0),
                              //                                                   child: TextFormField(
                              //                                                     //  key: formkey5,
                              //                                                     controller: chemicalDescription[index].additionalData![index2].chemicalAmount,
                              //                                                     style: const TextStyle(color: Colors.white, fontSize: 12),
                              //                                                     obscureText: false,
                              //                                                     // keyboardType: TextInputType.number,
                              //                                                     decoration: const InputDecoration(
                              //                                                         border: OutlineInputBorder(
                              //                                                             // borderRadius: BorderRadius.circular(25),
                              //                                                             ),
                              //                                                         enabledBorder: OutlineInputBorder(
                              //                                                           borderSide: BorderSide(
                              //                                                             color: Colors.white,
                              //                                                           ),
                              //                                                           // borderRadius: BorderRadius.circular(25),
                              //                                                         ),
                              //                                                         labelText: 'CHEMICAL AMOUNT',
                              //                                                         labelStyle: TextStyle(color: Colors.white, fontSize: 12)),

                              //                                                     validator: (value) {
                              //                                                       if (value!.isEmpty) {
                              //                                                         return "Please enter achemical amount";
                              //                                                       } else {
                              //                                                         return null;
                              //                                                       }
                              //                                                     },
                              //                                                   ),
                              //                                                 ),
                              //                                               ),
                              //                                             ),
                              //                                             Expanded(
                              //                                               flex:
                              //                                                   1,
                              //                                               child:
                              //                                                   Align(
                              //                                                 alignment: Alignment.centerRight,
                              //                                                 child: Padding(
                              //                                                     padding: const EdgeInsets.all(2.0),
                              //                                                     child: InkWell(
                              //                                                       onTap: () {
                              //                                                         setState(() {
                              //                                                           chemicalDescription[index].additionalData!.add(ChemicalDescriptionSubClass(TextEditingController(), TextEditingController()));
                              //                                                         });
                              //                                                       },
                              //                                                       child: const Icon(Icons.add, color: Colors.white),
                              //                                                     )),
                              //                                               ),
                              //                                             ),
                              //                                             Expanded(
                              //                                               flex:
                              //                                                   1,
                              //                                               child:
                              //                                                   Align(
                              //                                                 alignment: Alignment.centerRight,
                              //                                                 child: Padding(
                              //                                                     padding: const EdgeInsets.all(2.0),
                              //                                                     child: InkWell(
                              //                                                       onTap: () {
                              //                                                         setState(() {
                              //                                                           chemicalDescription[index].additionalData!.removeAt(index2);
                              //                                                         });
                              //                                                       },
                              //                                                       child: const Icon(Icons.delete, color: Colors.white),
                              //                                                     )),
                              //                                               ),
                              //                                             ),
                              //                                           ],
                              //                                         ),
                              //                                       ]),
                              //                                 );
                              //                               }),
                              //                         ),
                              //                         Row(
                              //                           children: [
                              //                             Expanded(
                              //                               child: Align(
                              //                                 alignment: Alignment
                              //                                     .centerRight,
                              //                                 child: Padding(
                              //                                     padding:
                              //                                         const EdgeInsets
                              //                                                 .all(
                              //                                             2.0),
                              //                                     child:
                              //                                         InkWell(
                              //                                       onTap: () {
                              //                                         setState(
                              //                                             () {
                              //                                           chemicalDescription.add(ChemicalDescriptionClass(
                              //                                               chemicalDescription[index].date,
                              //                                               TextEditingController(),
                              //                                               TextEditingController(),
                              //                                               TextEditingController(),
                              //                                               <ChemicalDescriptionSubClass>[
                              //                                                 ChemicalDescriptionSubClass(TextEditingController(), TextEditingController())
                              //                                               ]));
                              //                                         });
                              //                                       },
                              //                                       child: const Icon(
                              //                                           Icons
                              //                                               .add,
                              //                                           color: Colors
                              //                                               .white),
                              //                                     )),
                              //                               ),
                              //                             ),
                              //                             Expanded(
                              //                               child: Align(
                              //                                 alignment: Alignment
                              //                                     .centerRight,
                              //                                 child: Padding(
                              //                                     padding:
                              //                                         const EdgeInsets
                              //                                                 .all(
                              //                                             2.0),
                              //                                     child:
                              //                                         InkWell(
                              //                                       onTap: () {
                              //                                         setState(
                              //                                             () {
                              //                                           chemicalDescription
                              //                                               .removeAt(index);
                              //                                         });
                              //                                       },
                              //                                       child: const Icon(
                              //                                           Icons
                              //                                               .delete,
                              //                                           color: Colors
                              //                                               .white),
                              //                                     )),
                              //                               ),
                              //                             ),
                              //                           ],
                              //                         ),
                              //                       ]),
                              //                     ),
                              //                   ),
                              //                 ],
                              //               );
                              //             }),
                              //       ),
                              //     ],
                              //   ),
                              // ),

                              Container(
                                margin: const EdgeInsets.only(
                                    left: 4, right: 4, top: 10, bottom: 8),
                                padding: const EdgeInsets.all(8),
                                alignment: Alignment.center,
                                // height: size.height * 0.5,
                                width: size.width * 0.99,
                                decoration: BoxDecoration(
                                    // shape: BoxShape.circle,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                                      BoxShadow(
                                          color:
                                              AppColors.baseColor,
                                          blurRadius: 10,
                                          offset: Offset(2.0, 5.0))
                                    ],
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color.fromARGB(255, 255, 255, 255),
                                        Color.fromARGB(255, 255, 255, 255),
                                      ],
                                    )),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      alignment: Alignment.center,
                                      width: size.width * 0.99,
                                      // width: MediaQuery.of(context).size.width,
                                      // height: 40,
                                      decoration: const BoxDecoration(
                                          // shape: BoxShape.circle,
                                          //borderRadius: BorderRadius.circular(25),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Color.fromARGB(
                                                    255, 3, 47, 97),
                                                blurRadius: 5,
                                                offset: Offset(2.0, 5.0))
                                          ],
                                          gradient: LinearGradient(
                                            colors: [
                                              AppColors.baseColor,
                                              Color.fromARGB(255, 7, 59, 120)
                                            ],
                                          )),
                                      child: const Row(children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            // "CHEMICAL QUANTITY",
                                            "CHEMICAL DESCRIPTION",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ]),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child:
                                              DropdownButtonFormField<String>(
                                            hint: const Text('-Select-'),
                                            dropdownColor: Colors.white,
                                            value: noOfChemicalQuantity,
                                            style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 7, 59, 120),
                                                fontSize: 16),
                                            icon: const Icon(
                                              Icons.arrow_drop_down,
                                              color: Color.fromARGB(
                                                  255, 7, 59, 120),
                                              size: 40,
                                            ),
                                            decoration: const InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 7, 59, 120),
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 7, 59, 120),
                                                ),
                                              ),
                                            ),
                                            isExpanded: true,
                                            items: select_noOfChemicalQuantity
                                                .map(buildMenuItem)
                                                .toList(),
                                            onTap: () {},
                                            onChanged: (value) {
                                              setState(() {
                                                noOfChemicalQuantity = value;
                                              });
                                              createChemicalQuantityList(
                                                  int.parse(value.toString()));
                                            },
                                            validator: (value) => value == null
                                                ? 'field required'
                                                : null,
                                          ),
                                        ),
                                      ),
                                    ),
                                    noOfChemicalQuantity.toString() !=
                                            '--SELECT--'
                                        ? Container(
                                            margin: const EdgeInsets.only(
                                                left: 8,
                                                right: 8,
                                                top: 8,
                                                bottom: 8),
                                            padding: const EdgeInsets.all(8),
                                            alignment: Alignment.center,
                                            height: size.height * 0.35,
                                            width: size.width * 0.99,
                                            decoration: BoxDecoration(
                                                // shape: BoxShape.circle,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: const [
                                                  BoxShadow(
                                                      color: AppColors.baseColor,
                                                      blurRadius: 10,
                                                      offset: Offset(2.0, 5.0))
                                                ],
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Color.fromARGB(
                                                        255, 255, 255, 255),
                                                    Color.fromARGB(
                                                        255, 255, 255, 255),
                                                  ],
                                                )),
                                            child: ListView.builder(
                                                itemCount:
                                                    chemicalQuantity.length,
                                                itemBuilder: (BuildContext ctxt,
                                                    int index) {
                                                  return Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 4.0,
                                                                bottom: 4,
                                                                left: 4),
                                                        child: Container(
                                                          width:
                                                              size.width * 0.83,
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8),
                                                          decoration:
                                                              BoxDecoration(
                                                                  color: const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      7,
                                                                      59,
                                                                      120),
                                                                  border: Border
                                                                      .all(
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .only(
                                                                    topRight: Radius
                                                                        .circular(
                                                                            10),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            10),
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            10),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            10),
                                                                  )),
                                                          child: Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerRight,
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              2.0),
                                                                          child:
                                                                              TextFormField(
                                                                            //  key: formkey5,
                                                                            controller:
                                                                                chemicalQuantity[index].chemicalName,
                                                                            style:
                                                                                const TextStyle(color: Colors.white, fontSize: 12),
                                                                            obscureText:
                                                                                false,
                                                                            // keyboardType: TextInputType.number,
                                                                            decoration: const InputDecoration(
                                                                                border: OutlineInputBorder(
                                                                                    // borderRadius: BorderRadius.circular(25),
                                                                                    ),
                                                                                enabledBorder: OutlineInputBorder(
                                                                                  borderSide: BorderSide(
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                  // borderRadius: BorderRadius.circular(25),
                                                                                ),
                                                                                labelText: 'CHEMICAL NAME',
                                                                                labelStyle: TextStyle(color: Colors.white, fontSize: 12)),

                                                                            validator:
                                                                                (value) {
                                                                              if (value!.isEmpty) {
                                                                                return "Please enter chemical name";
                                                                              } else {
                                                                                return null;
                                                                              }
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerRight,
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              2.0),
                                                                          child:
                                                                              TextFormField(
                                                                            //  key: formkey5,
                                                                            controller:
                                                                                chemicalQuantity[index].startOfWeekAmount,
                                                                            style:
                                                                                const TextStyle(color: Colors.white, fontSize: 12),
                                                                            obscureText:
                                                                                false,
                                                                            // keyboardType: TextInputType.number,
                                                                            decoration: const InputDecoration(
                                                                                border: OutlineInputBorder(
                                                                                    // borderRadius: BorderRadius.circular(25),
                                                                                    ),
                                                                                enabledBorder: OutlineInputBorder(
                                                                                  borderSide: BorderSide(
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                  // borderRadius: BorderRadius.circular(25),
                                                                                ),
                                                                                labelText: 'START OF WEEK AMOUNT',
                                                                                labelStyle: TextStyle(color: Colors.white, fontSize: 12)),

                                                                            validator:
                                                                                (value) {
                                                                              if (value!.isEmpty) {
                                                                                return "Please enter start of week amount";
                                                                              } else {
                                                                                return null;
                                                                              }
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                const Divider(
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerRight,
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              2.0),
                                                                          child:
                                                                              TextFormField(
                                                                            //  key: formkey5,
                                                                            controller:
                                                                                chemicalQuantity[index].endOfWeekAmount,
                                                                            style:
                                                                                const TextStyle(color: Colors.white, fontSize: 12),
                                                                            obscureText:
                                                                                false,

                                                                            decoration: const InputDecoration(
                                                                                border: OutlineInputBorder(
                                                                                    // borderRadius: BorderRadius.circular(25),
                                                                                    ),
                                                                                enabledBorder: OutlineInputBorder(
                                                                                  borderSide: BorderSide(
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                  // borderRadius: BorderRadius.circular(25),
                                                                                ),
                                                                                labelText: 'END OF WEEK AMOUNT',
                                                                                labelStyle: TextStyle(color: Colors.white, fontSize: 12)),
                                                                            onChanged:
                                                                                (value) {
                                                                              // calculateTotalCost(
                                                                              //     index);
                                                                              print('123456');
                                                                            },
                                                                            validator:
                                                                                (value) {
                                                                              if (value!.isEmpty) {
                                                                                return "Please enter end of week amount";
                                                                              } else {
                                                                                return null;
                                                                              }
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerRight,
                                                                        child: Padding(
                                                                            padding: const EdgeInsets.all(2.0),
                                                                            child: InkWell(
                                                                              onTap: () {
                                                                                setState(() {
                                                                                  chemicalQuantity.removeAt(index);
                                                                                  noOfChemicalQuantity = cardLength(noOfChemicalQuantity.toString());
                                                                                  // noOfHerbicide = (int.parse(noOfHerbicide.toString()) - 1).toString();
                                                                                });
                                                                              },
                                                                              child: const Icon(Icons.delete, color: Colors.white),
                                                                            )),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ]),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                }),
                                          )
                                        : const Text(
                                            "",
                                            style: TextStyle(
                                              fontSize: 0.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {
                                          (noOfChemicalQuantity != '25' &&
                                                  noOfChemicalQuantity !=
                                                      '--SELECT--')
                                              ? setState(() {
                                                  noOfChemicalQuantity =
                                                      (int.parse(noOfChemicalQuantity
                                                                  .toString()) +
                                                              1)
                                                          .toString();
                                                })
                                              : (noOfChemicalQuantity ==
                                                      '--SELECT--')
                                                  ? setState(() {
                                                      noOfChemicalQuantity =
                                                          '1';
                                                    })
                                                  : CustomToastSnackBarProgressDialog
                                                      .snackBar(
                                                          'You Have Reached Maximum Limit of Chemical Quantity',
                                                          context);

                                          chemicalQuantity.add(
                                              ChemicalQuantityClass(
                                                  TextEditingController(),
                                                  TextEditingController(),
                                                  TextEditingController()));
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          alignment: Alignment.center,
                                          // width: size.width * 0.6,
                                          // width: MediaQuery.of(context).size.width,
                                          // height: 40,
                                          decoration: const BoxDecoration(
                                              // shape: BoxShape.circle,
                                              //borderRadius: BorderRadius.circular(25),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Color.fromARGB(
                                                        255, 155, 69, 3),
                                                    blurRadius: 5,
                                                    offset: Offset(2.0, 5.0))
                                              ],
                                              gradient: LinearGradient(
                                                colors: [
                                                  Color.fromARGB(
                                                      255, 255, 111, 0),
                                                  Color.fromARGB(
                                                      255, 255, 111, 0),
                                                ],
                                              )),
                                          child: const Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Add Another CHEMICAL DESCRIPTION",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                                Visibility(
                              visible: _isVisibleSubmitButton,
                                child: Container(
                                    margin: const EdgeInsets.only(
                                        left: 6, right: 6, top: 20.0, bottom: 10),
                                    child: InkWell(
                                      onTap: () {
                                        if (_formkey.currentState!.validate()) {
                                           setState(() {
                                            _isVisibleSubmitButton = false;
                                            _isVisibleSubmittingButton = true;
                                          });
                                          submitDataMainTopData();
                                        } else {}
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            left: 40, right: 40, bottom: 10.0),
                                        // padding: const EdgeInsets.all(8),
                                        alignment: Alignment.center,
                                        width: MediaQuery.of(context).size.width,
                                        height: 40,
                                        decoration: const BoxDecoration(
                                            // shape: BoxShape.circle,
                                            // borderRadius: BorderRadius.circular(25),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Color.fromARGB(
                                                      255, 3, 47, 97),
                                                  blurRadius: 5,
                                                  offset: Offset(2.0, 5.0))
                                            ],
                                            gradient: LinearGradient(
                                              colors: [
                                                AppColors.baseColor,
                                                Color.fromARGB(255, 7, 59, 120)
                                              ],
                                            )),
                                        child: const Row(children: [
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                "SUBMIT",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ]),
                                      ),
                                    )),
                              ),
                             Visibility(
                                    visible: _isVisibleSubmittingButton,
                                    child: Container(
                                        margin: const EdgeInsets.only(
                                            left: 6,
                                            right: 6,
                                            top: 10.0,
                                            bottom: 10),
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              left: 40,
                                              right: 40,
                                              bottom: 10.0),
                                          // padding: const EdgeInsets.all(8),
                                          alignment: Alignment.center,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 40,
                                          decoration: const BoxDecoration(
                                              // borderRadius:
                                              //     BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Color.fromARGB(
                                                        255, 3, 47, 97),
                                                    blurRadius: 5,
                                                    offset: Offset(2.0, 5.0))
                                              ],
                                              gradient: LinearGradient(
                                                colors: [
                                                  Color.fromARGB(
                                                      255, 7, 59, 120),
                                                  Color.fromARGB(
                                                      255, 7, 59, 120)
                                                ],
                                              )),
                                          child: const Row(children: [
                                            Expanded(
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "SUBMITTING...",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ]),
                                        )),
                                  ),
                                  Container(
                                margin: const EdgeInsets.only(
                                    left: 4, right: 4, top: 10, bottom: 8),
                                padding: const EdgeInsets.all(8),
                                alignment: Alignment.center,
                                // height: size.height * 0.5,
                                width: size.width * 0.99,
                                decoration: BoxDecoration(
                                    // shape: BoxShape.circle,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                                      BoxShadow(
                                          color:
                                              AppColors.baseColor,
                                          blurRadius: 10,
                                          offset: Offset(2.0, 5.0))
                                    ],
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color.fromARGB(255, 255, 255, 255),
                                        Color.fromARGB(255, 255, 255, 255),
                                      ],
                                    )),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      alignment: Alignment.center,
                                      width: size.width * 0.99,
                                      // width: MediaQuery.of(context).size.width,
                                      // height: 40,
                                      decoration: const BoxDecoration(
                                          // shape: BoxShape.circle,
                                          //borderRadius: BorderRadius.circular(25),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Color.fromARGB(
                                                    255, 1, 40, 84),
                                                blurRadius: 5,
                                                offset: Offset(2.0, 5.0))
                                          ],
                                          color: Colors.black,
                                          gradient: LinearGradient(
                                            colors: [
                                              AppColors.baseColor,
                                              AppColors.baseColor,
                                              AppColors.baseColor,
                                            ],
                                          )),
                                      child: const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "PREMIX 5: ",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Row(
                                      children: [
                                        Expanded(
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 2.0,
                                                    right: 2.0,
                                                    bottom: 2.0,
                                                    top: 10.0),
                                                child: Text(
                                                  "Garlon 3A",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color.fromARGB(
                                                        255, 7, 59, 120),
                                                    //fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              )),
                                        ),
                                        Expanded(
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 2.0,
                                                    right: 2.0,
                                                    bottom: 2.0,
                                                    top: 10.0),
                                                child: Text(
                                                  "50%",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color.fromARGB(
                                                        255, 7, 59, 120),
                                                    //fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              )),
                                        ),
                                      ],
                                    ),
                                    const Row(
                                      children: [
                                        Expanded(
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 2.0,
                                                    right: 2.0,
                                                    bottom: 2.0),
                                                child: Text(
                                                  "Polaris 3A",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color.fromARGB(
                                                        255, 7, 59, 120),
                                                    //fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              )),
                                        ),
                                        Expanded(
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                  left: 2.0,
                                                  right: 2.0,
                                                  bottom: 2.0,
                                                ),
                                                child: Text(
                                                  "50%",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color.fromARGB(
                                                        255, 7, 59, 120),
                                                    //fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              )),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      alignment: Alignment.center,
                                      width: size.width * 0.99,
                                      // width: MediaQuery.of(context).size.width,
                                      // height: 40,
                                      decoration: const BoxDecoration(
                                          // shape: BoxShape.circle,
                                          //borderRadius: BorderRadius.circular(25),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Color.fromARGB(
                                                    255, 1, 40, 84),
                                                blurRadius: 5,
                                                offset: Offset(2.0, 5.0))
                                          ],
                                          color: Colors.black,
                                          gradient: LinearGradient(
                                            colors: [
                                              AppColors.baseColor,
                                              AppColors.baseColor,
                                              AppColors.baseColor,
                                            ],
                                          )),
                                      child: const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "PREMIX 2:: ",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Row(
                                      children: [
                                        Expanded(
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 2.0,
                                                    right: 2.0,
                                                    bottom: 2.0,
                                                    top: 10.0),
                                                child: Text(
                                                  "Tardon K",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color.fromARGB(
                                                        255, 7, 59, 120),
                                                    //fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              )),
                                        ),
                                        Expanded(
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 2.0,
                                                    right: 2.0,
                                                    bottom: 2.0,
                                                    top: 10.0),
                                                child: Text(
                                                  "25%",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color.fromARGB(
                                                        255, 7, 59, 120),
                                                    //fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              )),
                                        ),
                                      ],
                                    ),
                                    const Row(
                                      children: [
                                        Expanded(
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 2.0,
                                                    right: 2.0,
                                                    bottom: 2.0),
                                                child: Text(
                                                  "Garlon 3A ",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color.fromARGB(
                                                        255, 7, 59, 120),
                                                    //fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              )),
                                        ),
                                        Expanded(
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                  left: 2.0,
                                                  right: 2.0,
                                                  bottom: 2.0,
                                                ),
                                                child: Text(
                                                  "71.8%",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color.fromARGB(
                                                        255, 7, 59, 120),
                                                    //fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              )),
                                        ),
                                      ],
                                    ),
                                    const Row(
                                      children: [
                                        Expanded(
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 2.0,
                                                    right: 2.0,
                                                    bottom: 2.0),
                                                child: Text(
                                                  "Arsenal PowerLine",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color.fromARGB(
                                                        255, 7, 59, 120),
                                                    //fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              )),
                                        ),
                                        Expanded(
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                  left: 2.0,
                                                  right: 2.0,
                                                  bottom: 2.0,
                                                ),
                                                child: Text(
                                                  "3.2%",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color.fromARGB(
                                                        255, 7, 59, 120),
                                                    //fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              )),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      alignment: Alignment.center,
                                      width: size.width * 0.99,
                                      // width: MediaQuery.of(context).size.width,
                                      // height: 40,
                                      decoration: const BoxDecoration(
                                          // shape: BoxShape.circle,
                                          //borderRadius: BorderRadius.circular(25),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Color.fromARGB(
                                                    255, 1, 40, 84),
                                                blurRadius: 5,
                                                offset: Offset(2.0, 5.0))
                                          ],
                                          color: Colors.black,
                                          gradient: LinearGradient(
                                            colors: [
                                              AppColors.baseColor,
                                              AppColors.baseColor,
                                              AppColors.baseColor,
                                            ],
                                          )),
                                      child: const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "PREMIX 3: ",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Row(
                                      children: [
                                        Expanded(
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 2.0,
                                                    right: 2.0,
                                                    bottom: 2.0,
                                                    top: 10.0),
                                                child: Text(
                                                  "Tardon K ",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color.fromARGB(
                                                        255, 7, 59, 120),
                                                    //fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              )),
                                        ),
                                        Expanded(
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 2.0,
                                                    right: 2.0,
                                                    bottom: 2.0,
                                                    top: 10.0),
                                                child: Text(
                                                  "38%",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color.fromARGB(
                                                        255, 7, 59, 120),
                                                    //fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              )),
                                        ),
                                      ],
                                    ),
                                    const Row(
                                      children: [
                                        Expanded(
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 2.0,
                                                    right: 2.0,
                                                    bottom: 2.0),
                                                child: Text(
                                                  "Arsenal PowerLine 4 oz.",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color.fromARGB(
                                                        255, 7, 59, 120),
                                                    //fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              )),
                                        ),
                                        Expanded(
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                  left: 2.0,
                                                  right: 2.0,
                                                  bottom: 2.0,
                                                ),
                                                child: Text(
                                                  "3%",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color.fromARGB(
                                                        255, 7, 59, 120),
                                                    //fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              )),
                                        ),
                                      ],
                                    ),
                                    const Row(
                                      children: [
                                        Expanded(
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 2.0,
                                                    right: 2.0,
                                                    bottom: 2.0),
                                                child: Text(
                                                  "Escort XP 1.5 oz.",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color.fromARGB(
                                                        255, 7, 59, 120),
                                                    //fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              )),
                                        ),
                                        Expanded(
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                  left: 2.0,
                                                  right: 2.0,
                                                  bottom: 2.0,
                                                ),
                                                child: Text(
                                                  "3%",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color.fromARGB(
                                                        255, 7, 59, 120),
                                                    //fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              )),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );

                default:
                  return const Text('data');
              }
            })));
  }

  setData(MixingInventoryViewModel value) {
    _workOrderNo.text = widget.id;
    if (mixingInventoryViewModel.mixingInventoryGetTabularData.data!
            .getChemicalQuantity!.isNotEmpty &&
        mixingInventoryViewModel
                .mixingInventoryGetTabularData.data!.getChemicalQuantity !=
            null &&
        mixingInventoryViewModel
                .mixingInventoryGetTabularData.data!.getChemicalQuantity
                .toString() !=
            'null') {
      // dateSelected1
      formattedDate = (mixingInventoryViewModel.mixingInventoryGetTabularData
                      .data!.getChemicalQuantity![0].date ==
                  null ||
              mixingInventoryViewModel.mixingInventoryGetTabularData.data!
                      .getChemicalQuantity![0].date
                      .toString() ==
                  'null')
          ? ''
          : mixingInventoryViewModel
              .mixingInventoryGetTabularData.data!.getChemicalQuantity![0].date
              .toString();

      _utility.text = (mixingInventoryViewModel.mixingInventoryGetTabularData
                      .data!.getChemicalQuantity![0].utility ==
                  null ||
              mixingInventoryViewModel.mixingInventoryGetTabularData.data!
                      .getChemicalQuantity![0].utility
                      .toString() ==
                  'null')
          ? ''
          : mixingInventoryViewModel.mixingInventoryGetTabularData.data!
              .getChemicalQuantity![0].utility
              .toString();

      _foreman.text = (mixingInventoryViewModel.mixingInventoryGetTabularData
                      .data!.getChemicalQuantity![0].forMan ==
                  null ||
              mixingInventoryViewModel.mixingInventoryGetTabularData.data!
                      .getChemicalQuantity![0].forMan
                      .toString() ==
                  'null')
          ? ''
          : mixingInventoryViewModel.mixingInventoryGetTabularData.data!
              .getChemicalQuantity![0].forMan
              .toString();

      formattedDate1 = (mixingInventoryViewModel.mixingInventoryGetTabularData
                      .data!.getChemicalQuantity![0].weekStartDate ==
                  null ||
              mixingInventoryViewModel.mixingInventoryGetTabularData.data!
                      .getChemicalQuantity![0].weekStartDate
                      .toString() ==
                  'null')
          ? ''
          : mixingInventoryViewModel.mixingInventoryGetTabularData.data!
              .getChemicalQuantity![0].weekStartDate
              .toString();

      formattedDate2 = (mixingInventoryViewModel.mixingInventoryGetTabularData
                      .data!.getChemicalQuantity![0].weekEndDate ==
                  null ||
              mixingInventoryViewModel.mixingInventoryGetTabularData.data!
                      .getChemicalQuantity![0].weekEndDate
                      .toString() ==
                  'null')
          ? ''
          : mixingInventoryViewModel.mixingInventoryGetTabularData.data!
              .getChemicalQuantity![0].weekEndDate
              .toString();
    }
  }

  createChemicalDecriptionList(int noOfResoureces) {
    chemicalDescription.clear();
    if (numberOfDaysSelected != 0) {
      for (int i = 0; i < noOfResoureces; i++) {
        chemicalDescription.add(ChemicalDescriptionClass(
          TextEditingController(),
          TextEditingController(),
          TextEditingController(),
          TextEditingController(),
          <ChemicalDescriptionSubClass>[
            ChemicalDescriptionSubClass(
                TextEditingController(), TextEditingController())
          ],
        ));
      }
    }
    print(chemicalQuantity.length);
  }

  createChemicalQuantityList(int noOfResoureces) {
    chemicalQuantity.clear();
    if (noOfChemicalQuantity != 0) {
      for (int i = 0; i < noOfResoureces; i++) {
        chemicalQuantity.add(ChemicalQuantityClass(TextEditingController(),
            TextEditingController(), TextEditingController()));
      }
    }
    print(chemicalQuantity.length);
  }

  setDataChemicalQuantity(MixingInventoryViewModel value) {
    chemicalQuantity.clear();
    if (mixingInventoryViewModel.mixingInventoryGetTabularData.data != null &&
        mixingInventoryViewModel.mixingInventoryGetTabularData.data!
                .getMixingInventoryFormDataOfChemicalQntityByOrderNo !=
            null) {
      for (int i = 0;
          i <
              mixingInventoryViewModel.mixingInventoryGetTabularData.data!
                  .getMixingInventoryFormDataOfChemicalQntityByOrderNo!.length;
          i++) {
        noOfChemicalQuantity = (mixingInventoryViewModel
                .mixingInventoryGetTabularData
                .data!
                .getMixingInventoryFormDataOfChemicalQntityByOrderNo!
                .isEmpty)
            ? '--SELECT--'
            : mixingInventoryViewModel.mixingInventoryGetTabularData.data!
                .getMixingInventoryFormDataOfChemicalQntityByOrderNo!.length
                .toString();
        String chemicalName = mixingInventoryViewModel
            .mixingInventoryGetTabularData
            .data!
            .getMixingInventoryFormDataOfChemicalQntityByOrderNo![i]
            .name
            .toString();
        String startOfWeekAmt = mixingInventoryViewModel
            .mixingInventoryGetTabularData
            .data!
            .getMixingInventoryFormDataOfChemicalQntityByOrderNo![i]
            .startWeekAmt
            .toString();
        String endOfWeekAmt = mixingInventoryViewModel
            .mixingInventoryGetTabularData
            .data!
            .getMixingInventoryFormDataOfChemicalQntityByOrderNo![i]
            .endWeekAmt
            .toString();

        chemicalQuantity.add(ChemicalQuantityClass(
          TextEditingController(text: chemicalName),
          TextEditingController(text: startOfWeekAmt),
          TextEditingController(text: endOfWeekAmt),
        ));
      }
    }
  }

  setDataChemicalDescription(MixingInventoryViewModel value) {
    chemicalDescription.clear();
    if (mixingInventoryViewModel.mixingInventoryGetTabularData.data != null &&
        mixingInventoryViewModel.mixingInventoryGetTabularData.data!
                .getAllChemicalDescriptions !=
            null) {
      for (int i = 0;
          i <
              mixingInventoryViewModel.mixingInventoryGetTabularData.data!
                  .getAllChemicalDescriptions!.length;
          i++) {
        List<ChemicalDescriptionSubClass> tempsub = [];
        for (int j = 0;
            j <
                mixingInventoryViewModel
                    .mixingInventoryGetTabularData
                    .data!
                    .getAllChemicalDescriptions![i]
                    .getChemicalNameAmtList!
                    .length;
            j++) {
          String chemicalName = mixingInventoryViewModel
              .mixingInventoryGetTabularData
              .data!
              .getAllChemicalDescriptions![i]
              .getChemicalNameAmtList![j]
              .name
              .toString();
          String chemicalAmount = mixingInventoryViewModel
              .mixingInventoryGetTabularData
              .data!
              .getAllChemicalDescriptions![i]
              .getChemicalNameAmtList![j]
              .amount
              .toString();
          tempsub.add(ChemicalDescriptionSubClass(
              TextEditingController(text: chemicalName),
              TextEditingController(text: chemicalAmount)));
        }
        String date = mixingInventoryViewModel.mixingInventoryGetTabularData
            .data!.getAllChemicalDescriptions![i].date
            .toString();
        String time = mixingInventoryViewModel.mixingInventoryGetTabularData
            .data!.getAllChemicalDescriptions![i].time
            .toString();
        String waterAmount = mixingInventoryViewModel
            .mixingInventoryGetTabularData
            .data!
            .getAllChemicalDescriptions![i]
            .waterAmt
            .toString();
        String batch = mixingInventoryViewModel.mixingInventoryGetTabularData
            .data!.getAllChemicalDescriptions![i].batch
            .toString();

        chemicalDescription.add(ChemicalDescriptionClass(
          TextEditingController(text: date),
          TextEditingController(text: time),
          TextEditingController(text: waterAmount),
          TextEditingController(text: batch),
          tempsub,
        ));
      }
    }
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(item,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 20,
          )));

  cardLength(String cardNo) {
    if (cardNo == '--SELECT--') {
      return '--SELECT--';
    } else if (cardNo == '1') {
      return '--SELECT--';
    } else if (cardNo == '2') {
      return '1';
    } else if (cardNo == '3') {
      return '2';
    } else if (cardNo == '4') {
      return '3';
    } else if (cardNo == '5') {
      return '4';
    } else if (cardNo == '6') {
      return '5';
    } else if (cardNo == '7') {
      return '6';
    } else if (cardNo == '8') {
      return '7';
    } else if (cardNo == '9') {
      return '8';
    } else if (cardNo == '10') {
      return '9';
    } else if (cardNo == '11') {
      return '10';
    } else if (cardNo == '12') {
      return '11';
    } else if (cardNo == '13') {
      return '12';
    } else if (cardNo == '14') {
      return '13';
    } else if (cardNo == '15') {
      return '14';
    } else if (cardNo == '16') {
      return '15';
    } else if (cardNo == '17') {
      return '16';
    } else if (cardNo == '18') {
      return '17';
    } else if (cardNo == '19') {
      return '18';
    } else if (cardNo == '20') {
      return '19';
    } else if (cardNo == '21') {
      return '20';
    } else if (cardNo == '22') {
      return '21';
    } else if (cardNo == '23') {
      return '22';
    } else if (cardNo == '24') {
      return '23';
    } else if (cardNo == '25') {
      return '24';
    }
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final initialDateRange = selectedDateRange ??
        DateTimeRange(start: DateTime.now(), end: DateTime.now());
    DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      initialDateRange: initialDateRange,
    );

    if (picked != null && picked != selectedDateRange) {
      setState(() {
        print('222222');
        selectedDateFlag = 1;
        selectedDateRange = picked;
        numberOfDaysSelected =
            selectedDateRange!.end.difference(selectedDateRange!.start).inDays +
                1;
        cardChemicalDescriptionLength = numberOfDaysSelected;
        createChemicalDecriptionList(numberOfDaysSelected);

        if (chemicalDescription.isNotEmpty) {
          List<String> dateRangeTexts = [];

          DateFormat formatter = DateFormat('MM/dd/yyyy');

          DateTime currentDate = selectedDateRange!.start;
          for (int i = 0; i < numberOfDaysSelected; i++) {
            dateRangeTexts.add(formatter.format(currentDate));
            currentDate = currentDate.add(const Duration(days: 1));
          }
          for (int i = 0; i < chemicalDescription.length; i++) {
            if (i < dateRangeTexts.length) {
              chemicalDescription[i].date!.text = dateRangeTexts[i];
            }
          }
        }
      });
    }
  }

  Future<void> submitDataMainTopData() async {
    const apiUrl =
        'http://civmapi.ariespro.com/civmapi/mixingInventory/insertSP_INSERT_MIXING_INVENTORY_FORMs';
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    DateFormat formatter = DateFormat('MM-dd-yyyy');
    final requestData = {
      "date": formattedDate,
      // "weekStartDate": (selectedDateRange == null || selectedDateFlag == 0)
      //     // ? 'Start Date'
      //     ? formattedDate1
      //     : '${selectedDateRange?.start.day}/${selectedDateRange?.start.month}/${selectedDateRange?.start.year}',
      "weekStartDate": (selectedDateRange == null || selectedDateFlag == 0)
    ? formattedDate1
    : formatter.format(selectedDateRange!.start),
      "utility": _utility.text,
      "forMan": _foreman.text,
      // "weekEndDate": (selectedDateRange == null || selectedDateFlag == 0)
      //     // ? 'Start Date'
      //     ? formattedDate2
      //     // : '${selectedDateRange?.end.day}/${selectedDateRange?.end.month}/${selectedDateRange?.end.year}',
      //     : '${selectedDateRange?.end.month}-${selectedDateRange?.end.day}-${selectedDateRange?.end.year}',
      "weekEndDate": (selectedDateRange == null || selectedDateFlag == 0)
    ? formattedDate2
    : formatter.format(selectedDateRange!.end),
      "workOrderNo": widget.id
    };
    print(requestData);
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${data.token}',
        },
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 200) {
        print('Request successful');
        print('Response: ${response.body}');
        if (noOfChemicalQuantity.toString() != '--SELECT--') {
          deleteData();
        }
        Future.delayed(const Duration(seconds: 3), () {
          print('navigation');
          Navigator.pop(context);
        });
      } else {
        print('Error: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> deleteData() async {
    final apiUrl =
        'http://civmapi.ariespro.com/civmapi/mixingInventory/deleteMIXING_INVENTORY_FORM_CHEMICALAndDeleteMIXING_INVENTORY_FORM_BATCH/${widget.id}';
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    try {
      final response = await http.delete(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${data.token}',
        },
      );

      if (response.statusCode == 200) {
        // Successful response, you can handle the result here
        print('Delete request successful');
        print('Response: ${response.body}');
        submitDataChemicalDescriptionMain();
        submitDataChemicalQuantity();
      } else {
        // Handle errors
        print('Error: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (error) {
      // Handle network errors
      print('Error: $error');
    }
  }

  Future<void> submitDataChemicalDescriptionMain() async {
    print('12345');
    const apiUrl =
        'http://civmapi.ariespro.com/civmapi/mixingInventory/insertSP_INSERT_MIXING_INVENTORY_FORM_BATCH';
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    print('chemical');
    List<Map<String, dynamic>> mapDataList = [];
    print('444444444444444');
    for (int i = 0; i < chemicalDescription.length; i++) {
      List<Map<String, dynamic>> mapSubDataList = [];

      for (int j = 0;
          j <
              int.parse(
                  chemicalDescription[i].additionalData!.length.toString());
          j++) {
        String chemicalValue = chemicalDescription[i]
                .additionalData![j]
                .chemicalName
                ?.text
                .toString() ??
            "";
        if (chemicalValue.isNotEmpty) {
          Map<String, dynamic> chemicalEntry = {
            "chemicalName": chemicalDescription[i]
                    .additionalData![j]
                    .chemicalName
                    ?.text
                    .toString() ??
                "",
            "chemicalAmount": chemicalDescription[i]
                    .additionalData![j]
                    .chemicalAmount
                    ?.text
                    .toString() ??
                "",
          };
          mapSubDataList.add(chemicalEntry);
        }
      }
      if (chemicalDescription[i].date?.text.toString() != "" ||
          chemicalDescription[i].batch?.text.toString() != "" ||
          chemicalDescription[i].time?.text.toString() != "" ||
          chemicalDescription[i].waterAmount?.text.toString() != "" ||
          (mapSubDataList.isNotEmpty)) {
        Map<String, dynamic> entry = {
          "date": chemicalDescription[i].date?.text.toString() ?? "",
          "batch": chemicalDescription[i].batch?.text.toString() ?? "",
          "time": chemicalDescription[i].time?.text.toString() ?? "",
          "waterAmount":
              chemicalDescription[i].waterAmount?.text.toString() ?? "",
          "workOrderNo": widget.id,
          "chemicalValue": mapSubDataList,
        };
        mapDataList.add(entry);
      }
    }
    print('mapDataList');
    print(mapDataList);
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${data.token}',
        },
        body: jsonEncode(mapDataList),
      );

      if (response.statusCode == 200) {
        print('Request successful Chemical Description');
        print('Response: ${response.body}');
        CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
            'Successfully Submitted', context);
        Future.delayed(const Duration(seconds: 3), () {
          print('navigation');
          Navigator.pop(context);
        });
      } else {
        print('Error: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> submitDataChemicalQuantity() async {
    const apiUrl =
        'http://civmapi.ariespro.com/civmapi/mixingInventory/insertSP_INSERT_MIXING_INVENTORY_FORM_EMPLOYEE';
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    Map<String, String?> a;
    List<Map<String, dynamic>> mapDataList = [];
    for (int i = 0; i < int.parse(noOfChemicalQuantity.toString()); i++) {
      if (chemicalQuantity[i].endOfWeekAmount?.text.toString() != "" ||
          chemicalQuantity[i].chemicalName?.text.toString() != "" ||
          chemicalQuantity[i].startOfWeekAmount?.text.toString() != "") {
        a = {
          "endWeekAmount":
              chemicalQuantity[i].endOfWeekAmount?.text.toString() ?? "",
          "name": chemicalQuantity[i].chemicalName?.text.toString() ?? "",
          "startWeekAmount":
              chemicalQuantity[i].startOfWeekAmount?.text.toString() ?? "",
          "workOrder": widget.id
        };
        mapDataList.add(a);
      }

      // a = {
      //   "endWeekAmount":
      //       chemicalQuantity[i].endOfWeekAmount?.text.toString() ?? "",
      //   "name": chemicalQuantity[i].chemicalName?.text.toString() ?? "",
      //   "startWeekAmount":
      //       chemicalQuantity[i].startOfWeekAmount?.text.toString() ?? "",
      //   "workOrder": widget.id
      // };
      // mapDataList.add(a);
    }
    print(mapDataList);
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${data.token}',
        },
        body: jsonEncode(mapDataList),
      );

      if (response.statusCode == 200) {
        print('Request successful Chemical Quantity');
        print('Response: ${response.body}');
        CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
            'Successfully Submitted', context);
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.pop(context);
          // Navigator.pop(context);
          // Navigator.pop(context);
          // Navigator.pop(context);
        });
      } else {
        print('Error: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}

class ChemicalDescriptionClass {
  TextEditingController? date;
  TextEditingController? time;
  TextEditingController? waterAmount;
  TextEditingController? batch;
  List<ChemicalDescriptionSubClass>? additionalData;
  ChemicalDescriptionClass(
      this.date, this.time, this.waterAmount, this.batch, this.additionalData);
}

class ChemicalDescriptionSubClass {
  TextEditingController? chemicalName;
  TextEditingController? chemicalAmount;

  ChemicalDescriptionSubClass(this.chemicalName, this.chemicalAmount);
}

class ChemicalQuantityClass {
  TextEditingController? chemicalName;
  TextEditingController? startOfWeekAmount;
  TextEditingController? endOfWeekAmount;

  ChemicalQuantityClass(
      this.chemicalName, this.startOfWeekAmount, this.endOfWeekAmount);
}
