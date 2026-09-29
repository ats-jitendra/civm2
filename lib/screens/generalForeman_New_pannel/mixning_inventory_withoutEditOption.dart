import 'package:CIVM/data/response/status.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_model/mixing_inventory_view_model.dart';

// ignore: must_be_immutable
class MixingInventoryWithoutEditOptionContractor extends StatefulWidget {
  String id;
  MixingInventoryWithoutEditOptionContractor({Key? key, required this.id})
      : super(key: key);

  @override
  State<MixingInventoryWithoutEditOptionContractor> createState() =>
      _MixingInventoryWithoutEditOptionContractorState();
}

class _MixingInventoryWithoutEditOptionContractorState
    extends State<MixingInventoryWithoutEditOptionContractor> {
  final TextEditingController _workOrderNo = TextEditingController();
  final TextEditingController _date = TextEditingController();
  final TextEditingController _utility = TextEditingController();
  final TextEditingController _weekStartDate = TextEditingController();

  final TextEditingController _weekendDate = TextEditingController();
  final TextEditingController _foreman = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  bool _isVisibilityChemicalDescription = true;
  bool _isVisibilityChemicalQuantity = false;

  bool isChemicalDescriptionSelected = true;
  bool isChemicalQuantitySelected = false;

  MixingInventoryViewModel mixingInventoryViewModel =
      MixingInventoryViewModel();

  @override
  void initState() {
    mixingInventoryViewModel.fetchMixingInventoryTabularListApi(
        context, widget.id);
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
          backgroundColor: const Color.fromARGB(255, 7, 59, 120),
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
                              'assets/empty_box.png',
                              height: 200,
                              width: 200,
                              fit: BoxFit.cover,
                            ),
                            const Center(
                              child: Text(
                                'Sorry, Data Not Found!',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 7, 59, 120),
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
                  setData(value);
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
                                              Color.fromARGB(255, 7, 59, 120),
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
                                          child: TextFormField(
                                            enabled: false,
                                            //  key: formkey5,
                                            controller: _date,
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
                                              hintText: 'date',
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Please enter date";
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
                                            enabled: false,
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
                                              disabledBorder:
                                                  OutlineInputBorder(
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
                                            enabled: false,
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
                                              disabledBorder:
                                                  OutlineInputBorder(
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
                                      const Align(
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
                                            controller: _weekStartDate,
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
                                              hintText: 'week start date',
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Please enter week start date";
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
                                              "WEEK END DATE",
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
                                            controller: _weekendDate,
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
                                              hintText: 'weekend date',
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Please enter weekend date";
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
                              ),
                              // Align(
                              //   alignment: Alignment.centerRight,
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.end,
                              //     children: [
                              //       Container(
                              //         padding: const EdgeInsets.all(10),
                              //         alignment: Alignment.center,
                              //         height: size.height * 0.05,
                              //         width: size.width * 0.3,
                              //         decoration: const BoxDecoration(
                              //           boxShadow: [
                              //             BoxShadow(
                              //               color:
                              //                   Color.fromARGB(255, 135, 10, 1),
                              //               blurRadius: 5,
                              //               offset: Offset(2.0, 5.0),
                              //             ),
                              //           ],
                              //           // Use a ternary operator to set the background color based on the selection state
                              //           color: Colors.red,
                              //         ),
                              //         child: const Align(
                              //           alignment: Alignment.center,
                              //           child: Text(
                              //             "PRINT",
                              //             textAlign: TextAlign.left,
                              //             style: TextStyle(
                              //               color: Colors.white,
                              //               fontWeight: FontWeight.bold,
                              //               fontSize: 16,
                              //             ),
                              //           ),
                              //         ),
                              //       ),
                              //       const SizedBox(
                              //         width: 10,
                              //       ),
                              //       // Padding(
                              //       //   padding:
                              //       //       const EdgeInsets.only(right: 8.0),
                              //       //   child: InkWell(
                              //       //     onTap: () {
                              //       //       Navigator.of(context).push(
                              //       //           MaterialPageRoute(
                              //       //               builder: (BuildContext
                              //       //                       context) =>
                              //       //                   EditMixingInventoryContractor(
                              //       //                       id: widget.id)));
                              //       //     },
                              //       //     child: Container(
                              //       //       padding: const EdgeInsets.all(10),
                              //       //       alignment: Alignment.center,
                              //       //       height: size.height * 0.05,
                              //       //       width: size.width * 0.3,
                              //       //       decoration: const BoxDecoration(
                              //       //         boxShadow: [
                              //       //           BoxShadow(
                              //       //             color: Color.fromARGB(
                              //       //                 255, 1, 112, 5),
                              //       //             blurRadius: 5,
                              //       //             offset: Offset(2.0, 5.0),
                              //       //           ),
                              //       //         ],
                              //       //         // Use a ternary operator to set the background color based on the selection state
                              //       //         color: Colors.green,
                              //       //       ),
                              //       //       child: const Align(
                              //       //         alignment: Alignment.center,
                              //       //         child: Text(
                              //       //           "EDIT",
                              //       //           textAlign: TextAlign.left,
                              //       //           style: TextStyle(
                              //       //             color: Colors.white,
                              //       //             fontWeight: FontWeight.bold,
                              //       //             fontSize: 16,
                              //       //           ),
                              //       //         ),
                              //       //       ),
                              //       //     ),
                              //       //   ),
                              //       // ),

                              //     ],
                              //   ),
                              // ),

                              const Column(
                                children: [
                                  // Row(
                                  //   children: [
                                  //     Expanded(
                                  //       child: Container(
                                  //         padding: const EdgeInsets.all(10),
                                  //         alignment: Alignment.center,
                                  //         decoration: const BoxDecoration(
                                  //           boxShadow: [
                                  //             BoxShadow(
                                  //               color: Color.fromARGB(
                                  //                   255, 135, 10, 1),
                                  //               blurRadius: 5,
                                  //               offset: Offset(2.0, 5.0),
                                  //             ),
                                  //           ],
                                  //           // Use a ternary operator to set the background color based on the selection state
                                  //           color: Colors.red,
                                  //         ),
                                  //         child: const Align(
                                  //           alignment: Alignment.center,
                                  //           child: Text(
                                  //             "IVM TIMESHEET PRINT",
                                  //             textAlign: TextAlign.left,
                                  //             style: TextStyle(
                                  //               color: Colors.white,
                                  //               fontWeight: FontWeight.bold,
                                  //               fontSize: 16,
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //     const SizedBox(width: 8),
                                  //     Expanded(
                                  //       child: Container(
                                  //         padding: const EdgeInsets.all(10),
                                  //         alignment: Alignment.center,
                                  //         decoration: const BoxDecoration(
                                  //           boxShadow: [
                                  //             BoxShadow(
                                  //               color: Color.fromARGB(
                                  //                   255, 135, 10, 1),
                                  //               blurRadius: 5,
                                  //               offset: Offset(2.0, 5.0),
                                  //             ),
                                  //           ],
                                  //           // Use a ternary operator to set the background color based on the selection state
                                  //           color: Colors.red,
                                  //         ),
                                  //         child: const Align(
                                  //           alignment: Alignment.center,
                                  //           child: Text(
                                  //             "EMPLOYEE TIMESHEET PRINT",
                                  //             textAlign: TextAlign.left,
                                  //             style: TextStyle(
                                  //               color: Colors.white,
                                  //               fontWeight: FontWeight.bold,
                                  //               fontSize: 16,
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 4, right: 4, top: 10, bottom: 8),
                                padding: const EdgeInsets.all(8),
                                alignment: Alignment.center,
                                height: size.height * 0.4,
                                width: size.width * 0.99,
                                decoration: BoxDecoration(
                                    // shape: BoxShape.circle,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                                      BoxShadow(
                                          color:
                                              Color.fromARGB(255, 7, 59, 120),
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
                                    Row(
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              _isVisibilityChemicalDescription =
                                                  true;
                                              _isVisibilityChemicalQuantity =
                                                  false;
                                              setState(() {
                                                isChemicalDescriptionSelected =
                                                    true;
                                                isChemicalQuantitySelected =
                                                    false;
                                              });
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(10),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Color.fromARGB(
                                                        255, 3, 47, 97),
                                                    blurRadius: 5,
                                                    offset: Offset(2.0, 5.0),
                                                  ),
                                                ],
                                                // Use a ternary operator to set the background color based on the selection state
                                                color:
                                                    isChemicalDescriptionSelected
                                                        ? const Color.fromARGB(
                                                            255, 5, 119, 249)
                                                        : const Color.fromARGB(
                                                            255, 7, 59, 120),
                                              ),
                                              child: const Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "Chemical Description",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                _isVisibilityChemicalDescription =
                                                    false;
                                                _isVisibilityChemicalQuantity =
                                                    true;
                                                setState(() {
                                                  isChemicalDescriptionSelected =
                                                      false;
                                                  isChemicalQuantitySelected =
                                                      true;
                                                });
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      color: Color.fromARGB(
                                                          255, 3, 47, 97),
                                                      blurRadius: 5,
                                                      offset: Offset(2.0, 5.0),
                                                    ),
                                                  ],
                                                  // Use a ternary operator to set the background color based on the selection state
                                                  color:
                                                      isChemicalQuantitySelected
                                                          ? const Color
                                                              .fromARGB(
                                                              255, 5, 119, 249)
                                                          : const Color
                                                              .fromARGB(
                                                              255, 7, 59, 120),
                                                ),
                                                child: const Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "Chemical Quntity",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Visibility(
                                      visible: _isVisibilityChemicalDescription,
                                      child: Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: ListView.builder(
                                              itemCount: mixingInventoryViewModel
                                                  .mixingInventoryGetTabularData
                                                  .data!
                                                  .getAllChemicalDescriptions!
                                                  .length,
                                              // itemCount: historyList.length,
                                              itemBuilder: (BuildContext ctxt,
                                                  int index) {
                                                return Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.28,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.2,
                                                        // height: 190,
                                                        margin: const EdgeInsets
                                                            .only(
                                                            left: 4.0,
                                                            top: 5.0,
                                                            bottom: 5.0),
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
                                                                border:
                                                                    Border.all(
                                                                  color: const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      7,
                                                                      59,
                                                                      120),
                                                                ),
                                                                borderRadius: const BorderRadius
                                                                    .only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            10),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            10))),
                                                        child: Column(
                                                            children: [
                                                              Expanded(
                                                                // alignment: Alignment.topLeft,
                                                                child: Column(
                                                                  children: [
                                                                    const Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          Text(
                                                                        "DATE: ",
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          Text(
                                                                        (mixingInventoryViewModel.mixingInventoryGetTabularData.data!.getAllChemicalDescriptions![index].date == null ||
                                                                                mixingInventoryViewModel.mixingInventoryGetTabularData.data!.getAllChemicalDescriptions![index].date.toString() == 'null')
                                                                            ? ''
                                                                            : mixingInventoryViewModel.mixingInventoryGetTabularData.data!.getAllChemicalDescriptions![index].date.toString(),
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style: const TextStyle(
                                                                            fontSize: 12,
                                                                            // fontWeight:
                                                                            //     FontWeight.bold,
                                                                            color: Colors.white),
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
                                                                      child:
                                                                          Text(
                                                                        "Time: ",
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          Text(
                                                                        (mixingInventoryViewModel.mixingInventoryGetTabularData.data!.getAllChemicalDescriptions![index].time == null ||
                                                                                mixingInventoryViewModel.mixingInventoryGetTabularData.data!.getAllChemicalDescriptions![index].time.toString() == 'null')
                                                                            ? ''
                                                                            : mixingInventoryViewModel.mixingInventoryGetTabularData.data!.getAllChemicalDescriptions![index].time.toString(),
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style: const TextStyle(
                                                                            fontSize: 12,
                                                                            // fontWeight:
                                                                            //     FontWeight.bold,
                                                                            color: Colors.white),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Expanded(
                                                                //  flex: 4,
                                                                child: Column(
                                                                  children: [
                                                                    const Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          Text(
                                                                        "WATER AMOUNT:",
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: Colors.white),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          Text(
                                                                        (mixingInventoryViewModel.mixingInventoryGetTabularData.data!.getAllChemicalDescriptions![index].waterAmt == null ||
                                                                                mixingInventoryViewModel.mixingInventoryGetTabularData.data!.getAllChemicalDescriptions![index].waterAmt.toString() == 'null')
                                                                            ? ''
                                                                            : mixingInventoryViewModel.mixingInventoryGetTabularData.data!.getAllChemicalDescriptions![index].waterAmt.toString(),
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style: const TextStyle(
                                                                            fontSize: 12,
                                                                            // fontWeight:
                                                                            //     FontWeight.bold,
                                                                            color: Colors.white),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ]),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.25,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.2,
                                                        margin: const EdgeInsets
                                                            .only(
                                                            right: 4.0,
                                                            top: 5.0,
                                                            bottom: 5.0),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8),
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                border:
                                                                    Border.all(
                                                                  color: const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      7,
                                                                      59,
                                                                      120),
                                                                ),
                                                                borderRadius: const BorderRadius
                                                                    .only(
                                                                    topRight: Radius
                                                                        .circular(
                                                                            10),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            10))),
                                                        child: Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                    child: Row(
                                                                      children: [
                                                                        Expanded(
                                                                          // alignment: Alignment.topLeft,
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              const Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: Text(
                                                                                  "BATCH: ",
                                                                                  textAlign: TextAlign.left,
                                                                                  style: TextStyle(
                                                                                    fontSize: 12,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    color: Color.fromARGB(255, 7, 59, 120),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: Text(
                                                                                  (mixingInventoryViewModel.mixingInventoryGetTabularData.data!.getAllChemicalDescriptions![index].batch == null || mixingInventoryViewModel.mixingInventoryGetTabularData.data!.getAllChemicalDescriptions![index].batch.toString() == 'null') ? '' : mixingInventoryViewModel.mixingInventoryGetTabularData.data!.getAllChemicalDescriptions![index].batch.toString(),
                                                                                  textAlign: TextAlign.left,
                                                                                  style: const TextStyle(
                                                                                    fontSize: 12,
                                                                                    //  fontWeight:
                                                                                    //      FontWeight.bold,
                                                                                    color: Color.fromARGB(255, 7, 59, 120),
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
                                                              Expanded(
                                                                child: ListView
                                                                    .builder(
                                                                        itemCount: mixingInventoryViewModel
                                                                            .mixingInventoryGetTabularData
                                                                            .data!
                                                                            .getAllChemicalDescriptions![
                                                                                index]
                                                                            .getChemicalNameAmtList!
                                                                            .length,
                                                                        itemBuilder:
                                                                            (BuildContext ctxt,
                                                                                int i) {
                                                                          return Row(
                                                                            children: [
                                                                              Container(
                                                                                width: MediaQuery.of(context).size.width * 0.52,
                                                                                // height: MediaQuery.of(context).size.height * 0.1,
                                                                                margin: const EdgeInsets.only(right: 4.0, top: 5.0, bottom: 5.0),
                                                                                padding: const EdgeInsets.all(8),
                                                                                decoration: BoxDecoration(
                                                                                    color: const Color.fromARGB(255, 7, 59, 120),
                                                                                    border: Border.all(
                                                                                      color: Colors.white,
                                                                                    ),
                                                                                    borderRadius: const BorderRadius.only(
                                                                                      topRight: Radius.circular(10),
                                                                                      bottomRight: Radius.circular(10),
                                                                                      topLeft: Radius.circular(10),
                                                                                      bottomLeft: Radius.circular(10),
                                                                                    )),
                                                                                child: Column(children: [
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
                                                                                                    alignment: Alignment.topLeft,
                                                                                                    child: Text(
                                                                                                      "CHEMICAL NAME: ",
                                                                                                      textAlign: TextAlign.left,
                                                                                                      style: TextStyle(
                                                                                                        fontSize: 12,
                                                                                                        fontWeight: FontWeight.bold,
                                                                                                        color: Colors.white,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  Align(
                                                                                                    alignment: Alignment.topLeft,
                                                                                                    child: Text(
                                                                                                      (mixingInventoryViewModel.mixingInventoryGetTabularData.data!.getAllChemicalDescriptions![index].getChemicalNameAmtList![i].name == null || mixingInventoryViewModel.mixingInventoryGetTabularData.data!.getAllChemicalDescriptions![index].getChemicalNameAmtList![i].name.toString() == 'null') ? '' : mixingInventoryViewModel.mixingInventoryGetTabularData.data!.getAllChemicalDescriptions![index].getChemicalNameAmtList![i].name.toString(),
                                                                                                      textAlign: TextAlign.left,
                                                                                                      style: const TextStyle(
                                                                                                        fontSize: 12,
                                                                                                        //  fontWeight:
                                                                                                        //      FontWeight.bold,
                                                                                                        color: Colors.white,
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
                                                                                                    alignment: Alignment.topLeft,
                                                                                                    child: Text(
                                                                                                      "CHEMICAL AMOUNT(GALLONS): ",
                                                                                                      textAlign: TextAlign.left,
                                                                                                      style: TextStyle(
                                                                                                        fontSize: 12,
                                                                                                        fontWeight: FontWeight.bold,
                                                                                                        color: Colors.white,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  Align(
                                                                                                    alignment: Alignment.topLeft,
                                                                                                    child: Text(
                                                                                                      (mixingInventoryViewModel.mixingInventoryGetTabularData.data!.getAllChemicalDescriptions![index].getChemicalNameAmtList![i].amount == null || mixingInventoryViewModel.mixingInventoryGetTabularData.data!.getAllChemicalDescriptions![index].getChemicalNameAmtList![i].amount.toString() == 'null') ? '' : mixingInventoryViewModel.mixingInventoryGetTabularData.data!.getAllChemicalDescriptions![index].getChemicalNameAmtList![i].amount.toString(),
                                                                                                      textAlign: TextAlign.left,
                                                                                                      style: const TextStyle(
                                                                                                        fontSize: 12,
                                                                                                        //  fontWeight:
                                                                                                        //      FontWeight.bold,
                                                                                                        color: Colors.white,
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
                                                                                ]),
                                                                              ),
                                                                            ],
                                                                          );
                                                                        }),
                                                              ),
                                                            ]),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              }),
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: _isVisibilityChemicalQuantity,
                                      child: Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, left: 4),
                                          child: ListView.builder(
                                              itemCount: mixingInventoryViewModel
                                                  .mixingInventoryGetTabularData
                                                  .data!
                                                  .getMixingInventoryFormDataOfChemicalQntityByOrderNo!
                                                  .length,
                                              // itemCount: historyList.length,
                                              itemBuilder: (BuildContext ctxt,
                                                  int index) {
                                                return Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        top: 4.0,
                                                        bottom: 4,
                                                      ),
                                                      child: Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.9,
                                                        // height: MediaQuery.of(
                                                        //             context)
                                                        //         .size
                                                        //         .height *
                                                        //     0.1,
                                                        // margin:  EdgeInsets.only(
                                                        //     top: 5.0, bottom: 5.0, left: 2,right: 2),
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
                                                                border:
                                                                    Border.all(
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          10),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          10),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          10),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          10),
                                                                )),
                                                        child: Column(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            8.0),
                                                                child: Row(
                                                                  children: [
                                                                    Expanded(
                                                                      // alignment: Alignment.topLeft,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          const Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              "CHEMICAL NAME: ",
                                                                              textAlign: TextAlign.left,
                                                                              style: TextStyle(
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              (mixingInventoryViewModel.mixingInventoryGetTabularData.data!.getMixingInventoryFormDataOfChemicalQntityByOrderNo![index].name == null || mixingInventoryViewModel.mixingInventoryGetTabularData.data!.getMixingInventoryFormDataOfChemicalQntityByOrderNo![index].name.toString() == 'null') ? '' : mixingInventoryViewModel.mixingInventoryGetTabularData.data!.getMixingInventoryFormDataOfChemicalQntityByOrderNo![index].name.toString(),
                                                                              textAlign: TextAlign.left,
                                                                              style: const TextStyle(
                                                                                fontSize: 12,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      // alignment: Alignment.topLeft,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          const Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              "START OF WEEK AMOUNT: ",
                                                                              textAlign: TextAlign.left,
                                                                              style: TextStyle(
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              (mixingInventoryViewModel.mixingInventoryGetTabularData.data!.getMixingInventoryFormDataOfChemicalQntityByOrderNo![index].start == null || mixingInventoryViewModel.mixingInventoryGetTabularData.data!.getMixingInventoryFormDataOfChemicalQntityByOrderNo![index].start.toString() == 'null') ? '' : mixingInventoryViewModel.mixingInventoryGetTabularData.data!.getMixingInventoryFormDataOfChemicalQntityByOrderNo![index].start.toString(),
                                                                              textAlign: TextAlign.left,
                                                                              style: const TextStyle(
                                                                                fontSize: 12,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      // alignment: Alignment.topLeft,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          const Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              "END OF WEEK AMOUNT: ",
                                                                              textAlign: TextAlign.left,
                                                                              style: TextStyle(
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              (mixingInventoryViewModel.mixingInventoryGetTabularData.data!.getMixingInventoryFormDataOfChemicalQntityByOrderNo![index].endWeekAmt == null || mixingInventoryViewModel.mixingInventoryGetTabularData.data!.getMixingInventoryFormDataOfChemicalQntityByOrderNo![index].endWeekAmt.toString() == 'null') ? '' : mixingInventoryViewModel.mixingInventoryGetTabularData.data!.getMixingInventoryFormDataOfChemicalQntityByOrderNo![index].endWeekAmt.toString(),
                                                                              textAlign: TextAlign.left,
                                                                              style: const TextStyle(
                                                                                fontSize: 12,
                                                                                //  fontWeight:
                                                                                //      FontWeight.bold,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ]),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              }),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    alignment: Alignment.center,
                                    height: size.height * 0.05,
                                    width: size.width * 0.25,
                                    decoration: const BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              Color.fromARGB(255, 135, 10, 1),
                                          blurRadius: 5,
                                          offset: Offset(2.0, 5.0),
                                        ),
                                      ],
                                      color: Colors.red,
                                    ),
                                    child: const Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Close",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
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

    _date.text = (mixingInventoryViewModel.mixingInventoryGetTabularData.data!
                    .getChemicalQuantity![0].date ==
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
        : mixingInventoryViewModel
            .mixingInventoryGetTabularData.data!.getChemicalQuantity![0].utility
            .toString();

    _foreman.text = (mixingInventoryViewModel.mixingInventoryGetTabularData
                    .data!.getChemicalQuantity![0].forMan ==
                null ||
            mixingInventoryViewModel.mixingInventoryGetTabularData.data!
                    .getChemicalQuantity![0].forMan
                    .toString() ==
                'null')
        ? ''
        : mixingInventoryViewModel
            .mixingInventoryGetTabularData.data!.getChemicalQuantity![0].forMan
            .toString();

    _weekStartDate.text = (mixingInventoryViewModel
                    .mixingInventoryGetTabularData
                    .data!
                    .getChemicalQuantity![0]
                    .weekStartDate ==
                null ||
            mixingInventoryViewModel.mixingInventoryGetTabularData.data!
                    .getChemicalQuantity![0].weekStartDate
                    .toString() ==
                'null')
        ? ''
        : mixingInventoryViewModel.mixingInventoryGetTabularData.data!
            .getChemicalQuantity![0].weekStartDate
            .toString();

    _weekendDate.text = (mixingInventoryViewModel.mixingInventoryGetTabularData
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
