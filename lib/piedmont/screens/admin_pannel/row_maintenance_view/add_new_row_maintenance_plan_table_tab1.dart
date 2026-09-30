import 'package:CIVM/piedmont/models/add_new_row_maint_model.dart';
import 'package:CIVM/piedmont/repository/map_url.dart';
import 'package:CIVM/piedmont/resources/app_colors.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/add_new_row_maintenance_plan.dart';
import 'package:CIVM/piedmont/screens/my_chrome_safari_map_recording.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../data/response/status.dart';
import '../../../view_model/add_new_row_maintenance_plan_view_model.dart';

class AddNewRowMaintenancePlanTableTab1 extends StatefulWidget {
  const AddNewRowMaintenancePlanTableTab1({Key? key}) : super(key: key);

  @override
  State<AddNewRowMaintenancePlanTableTab1> createState() =>
      _AddNewRowMaintenancePlanTableTab1State();
}

class _AddNewRowMaintenancePlanTableTab1State
    extends State<AddNewRowMaintenancePlanTableTab1> {
  AddNewRowMaintModel? addNewRowMaintModel;

  final TextEditingController _input = TextEditingController();

  onTappedBar(int index) {
    setState(() {
      // _currentIndex = index;
    });
  }

  String now = DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now());

  AddNewRowMaintenancePlanViewModel addNewRowMaintenancePlanViewModel =
      AddNewRowMaintenancePlanViewModel();

  final browser = MyChromeSafariBrowser();
  int currentYear = DateTime.now().year;
  // ignore: prefer_typing_uninitialized_variables
  var selectedYear;

  @override
  void initState() {
    selectedYear = currentYear.toString();
    addNewRowMaintenancePlanViewModel
        .fetchAddNewRowMaintenancePlanTabularListApi(
            context, currentYear.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
       backgroundColor:AppColors.backgroundColor,
        body: ChangeNotifierProvider<AddNewRowMaintenancePlanViewModel>(
            create: (BuildContext context) => addNewRowMaintenancePlanViewModel,
            child: Consumer<AddNewRowMaintenancePlanViewModel>(
                builder: (context, value, _) {
              switch (value.addNewRowMaintenancePlanGetTabularData.status) {
                case Status.LOADING:
                  return const Center(child: CircularProgressIndicator());
                case Status.ERROR:
                  return Padding(
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

                // CustomToastSnackBarProgressDialog.flushBarErrorMessage(
                //     value.addNewRowMaintenancePlanGetTabularData.message
                //         .toString(),
                //     context);

                case Status.COMPLETED:
                  return RefreshIndicator(
                    onRefresh: () async {
                      _input.clear();
                      selectedYear = currentYear.toString();
                      await addNewRowMaintenancePlanViewModel
                          .fetchAddNewRowMaintenancePlanTabularListApi(
                              context, currentYear.toString());
                    },
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.center,
                          height: size.height * 1,
                          width: size.width * 0.99,
                          decoration: const BoxDecoration(
                              // shape: BoxShape.circle,

                              boxShadow: [
                                BoxShadow(
                                    color: AppColors.baseColor,
                                    blurRadius: 10,
                                    offset: Offset(2.0, 5.0))
                              ],
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 255, 255, 255),
                                  Color.fromARGB(255, 255, 255, 255),
                                ],
                              )),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: DropdownButtonFormField<String>(
                                    hint: const Text('-Select Year-'),
                                    dropdownColor: Colors.white,
                                    value: selectedYear,
                                    style: const TextStyle(
                                        color: AppColors.baseColor,
                                        fontSize: 16),
                                    icon: const Icon(
                                      Icons.arrow_drop_down,
                                      color: AppColors.baseColor,
                                      size: 40,
                                    ),
                                    decoration: const InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              AppColors.baseColor,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              AppColors.baseColor,
                                        ),
                                      ),
                                    ),
                                    isExpanded: true,
                                    items: addNewRowMaintenancePlanViewModel
                                        .addNewRowMaintenancePlanGetTabularData
                                        .data!
                                        .yearList!
                                        .map((e) {
                                      return DropdownMenuItem(
                                        value: e.year.toString(),
                                        child: Text(e.year.toString()),
                                      );
                                    }).toList(),
                                    onChanged: (val) {
                                      setState(() {
                                        selectedYear = val;
                                      });

                                      addNewRowMaintenancePlanViewModel
                                          .fetchAddNewRowMaintenancePlanTabularListApi(
                                              context, selectedYear);
                                    },
                                    validator: (value) =>
                                        value == null ? 'field required' : null,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(top: 8.0, left: 8),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Total Record : ",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color:
                                              AppColors.baseColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      addNewRowMaintenancePlanViewModel
                                          .addNewRowMaintenancePlanGetTabularData
                                          .data!
                                          .getAlls!
                                          .length
                                          .toString(),
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                        color: AppColors.baseColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 4.0, right: 4.0, top: 4, bottom: 4),
                                  child: TextFormField(
                                    onChanged: (value) => _filterData(value),
                                    //  key: formkey2,
                                    controller: _input,
                                    style: const TextStyle(
                                        color: AppColors.baseColor,
                                        fontSize: 16),
                                    obscureText: false,

                                    //keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color.fromARGB(255, 23, 1, 88),
                                        ),
                                      ),
                                      hintText: 'Search your input...',
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
                                child: Align(
                                  alignment: Alignment.center,
                                  child: ListView.builder(
                                      itemCount: addNewRowMaintenancePlanViewModel
                                          .addNewRowMaintenancePlanGetTabularData
                                          .data!
                                          .getAlls!
                                          .length,
                                      // itemCount: historyList.length,
                                      itemBuilder:
                                          (BuildContext ctxt, int index) {
                                        // String formattedDate = '';
                                        // if (addNewRowMaintenancePlanViewModel
                                        //         .addNewRowMaintenancePlanGetTabularData
                                        //         .data!
                                        //         .getAlls![index]
                                        //         .nextMaintDue !=
                                        //     null) {
                                        //   print('not null next maint due');
                                        //   String? dateString =
                                        //       addNewRowMaintenancePlanViewModel
                                        //           .addNewRowMaintenancePlanGetTabularData
                                        //           .data!
                                        //           .getAlls![index]
                                        //           .nextMaintDue.toString();
                                        //   DateTime date =
                                        //       DateTime.parse(dateString);
                                        //   formattedDate = DateFormat('MM/dd/yyyy')
                                        //       .format(date);
                                        // }
                                        return Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 4.0, bottom: 4, left: 4),
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.925,
                                                // margin:  EdgeInsets.only(
                                                //     top: 5.0, bottom: 5.0, left: 2,right: 2),
                                                padding:
                                                    const EdgeInsets.all(8),
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
                                                        begin:
                                                            Alignment.topLeft,
                                                        end: Alignment
                                                            .bottomRight,
                                                      ),
                                                      border: Border.all(
                                                        color: Colors.white,
                                                      ),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
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

                                                child: Column(children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
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
                                                                  "VIEW: ",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  if (addNewRowMaintenancePlanViewModel
                                                                              .addNewRowMaintenancePlanGetTabularData
                                                                              .data!
                                                                              .getAlls![
                                                                                  index]
                                                                              .maintType ==
                                                                          'RegularMaint' &&
                                                                      addNewRowMaintenancePlanViewModel
                                                                              .addNewRowMaintenancePlanGetTabularData
                                                                              .data!
                                                                              .getAlls![
                                                                                  index]
                                                                              .rowYear !=
                                                                          '' &&
                                                                      addNewRowMaintenancePlanViewModel
                                                                              .addNewRowMaintenancePlanGetTabularData
                                                                              .data!
                                                                              .getAlls![
                                                                                  index]
                                                                              .rowYear !=
                                                                          'N/A') {
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) => AddNewRowMaintenancePlan(
                                                                                  tokenNo: (addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].tokenNo == null) ? '' : addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].tokenNo.toString(),
                                                                                  nextMaintYear: addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].nextMaintDue == null ? '' : addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].nextMaintDue.toString(),
                                                                                  subStation: addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].substation == null ? '' : addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].substation.toString(),
                                                                                  feeder: addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].feeder == null ? '' : addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].feeder.toString(),
                                                                                  maintType: addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].type == null ? '' : addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].type.toString(),
                                                                                  totalMiles: addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].totalMiles == null ? '' : addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].totalMiles.toString(),
                                                                                  totalCost: addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].totalCost == null ? '' : addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].totalCost.toString(),
                                                                                  costPerMile: addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].costPerMile == null ? '' : addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].costPerMile.toString(),
                                                                                  budgetType: addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].budgetType == null ? '' : addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].budgetType.toString(),
                                                                                  contractRowYear: addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].contractYear == null ? '' : addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].contractYear.toString(),
                                                                                  rowCycle: addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].cycle == null ? '' : addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].cycle.toString(),
                                                                                  rowYear: addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].rowYear == null ? '' : addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].rowYear.toString(),
                                                                                  contractorCompany: addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].contractorCompany == null ? '' : addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].contractorCompany.toString(),
                                                                                  assignForeman: addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].contractor == null ? '' : addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].contractor.toString(),
                                                                                  index: '0',
                                                                                )));
                                                                  } else if (addNewRowMaintenancePlanViewModel
                                                                              .addNewRowMaintenancePlanGetTabularData
                                                                              .data!
                                                                              .getAlls![
                                                                                  index]
                                                                              .maintType ==
                                                                          'RegularMaint' &&
                                                                      addNewRowMaintenancePlanViewModel
                                                                              .addNewRowMaintenancePlanGetTabularData
                                                                              .data!
                                                                              .getAlls![
                                                                                  index]
                                                                              .rowYear ==
                                                                          '' &&
                                                                      addNewRowMaintenancePlanViewModel
                                                                              .addNewRowMaintenancePlanGetTabularData
                                                                              .data!
                                                                              .getAlls![index]
                                                                              .rowYear !=
                                                                          'N/A') {
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) => AddNewRowMaintenancePlan(
                                                                                  tokenNo: (addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].tokenNo == null) ? '' : addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].tokenNo.toString(),
                                                                                  nextMaintYear: addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].nextMaintDue == null ? '' : addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].nextMaintDue.toString(),
                                                                                  subStation: addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].substation == null ? '' : addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].substation.toString(),
                                                                                  feeder: addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].feeder == null ? '' : addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].feeder.toString(),
                                                                                  maintType: addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].type == null ? '' : addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].type.toString(),
                                                                                  totalMiles: addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].totalMiles == null ? '' : addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].totalMiles.toString(),
                                                                                  totalCost: addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].totalCost == null ? '' : addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].totalCost.toString(),
                                                                                  costPerMile: addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].costPerMile == null ? '' : addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].costPerMile.toString(),
                                                                                  budgetType: addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].budgetType == null ? '' : addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].budgetType.toString(),
                                                                                  contractRowYear: addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].contractYear == null ? '' : addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].contractYear.toString(),
                                                                                  rowCycle: addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].cycle == null ? '' : addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].cycle.toString(),
                                                                                  rowYear: addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].rowYear == null ? '' : addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].rowYear.toString(),
                                                                                  contractorCompany: addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].contractorCompany == null ? '' : addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].contractorCompany.toString(),
                                                                                  assignForeman: addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].contractor == null ? '' : addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].contractor.toString(),
                                                                                  index: '1',
                                                                                )));
                                                                  }
                                                                },
                                                                child:
                                                                    const Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .topLeft,
                                                                  child: Icon(
                                                                    Icons
                                                                        .visibility,
                                                                    color: Colors
                                                                        .red,
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
                                                                  "SERIAL: ",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child: Text(
                                                                  (index + 1)
                                                                      .toString(),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    //  fontWeight:
                                                                    //      FontWeight.bold,
                                                                    color: Colors
                                                                        .white,
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
                                                                  "JOB NO: ",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child: Text(
                                                                  (addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].tokenNo ==
                                                                              null ||
                                                                          addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].tokenNo.toString() ==
                                                                              'null')
                                                                      ? ''
                                                                      : addNewRowMaintenancePlanViewModel
                                                                          .addNewRowMaintenancePlanGetTabularData
                                                                          .data!
                                                                          .getAlls![
                                                                              index]
                                                                          .tokenNo
                                                                          .toString(),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    //  fontWeight:
                                                                    //      FontWeight.bold,
                                                                    color: Colors
                                                                        .white,
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
                                                                  "SUBSTATION: ",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child: Text(
                                                                  (addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].substation ==
                                                                              null ||
                                                                          addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].substation.toString() ==
                                                                              'null')
                                                                      ? ''
                                                                      : addNewRowMaintenancePlanViewModel
                                                                          .addNewRowMaintenancePlanGetTabularData
                                                                          .data!
                                                                          .getAlls![
                                                                              index]
                                                                          .substation
                                                                          .toString(),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    //  fontWeight:
                                                                    //      FontWeight.bold,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const Divider(
                                                    color: Colors.grey,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
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
                                                                  "FEEDER: ",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child: Text(
                                                                  (addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].feeder ==
                                                                              null ||
                                                                          addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].feeder.toString() ==
                                                                              'null')
                                                                      ? ''
                                                                      : addNewRowMaintenancePlanViewModel
                                                                          .addNewRowMaintenancePlanGetTabularData
                                                                          .data!
                                                                          .getAlls![
                                                                              index]
                                                                          .feeder
                                                                          .toString(),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    //  fontWeight:
                                                                    //      FontWeight.bold,
                                                                    color: Colors
                                                                        .white,
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
                                                                  "MAINTENANCE TYPE: ",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child: Text(
                                                                  (addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].type ==
                                                                              null ||
                                                                          addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].type.toString() ==
                                                                              'null')
                                                                      ? ''
                                                                      : addNewRowMaintenancePlanViewModel
                                                                          .addNewRowMaintenancePlanGetTabularData
                                                                          .data!
                                                                          .getAlls![
                                                                              index]
                                                                          .type
                                                                          .toString(),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    //  fontWeight:
                                                                    //      FontWeight.bold,
                                                                    color: Colors
                                                                        .white,
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
                                                                  "SUPERVISER: ",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child: Text(
                                                                  (addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].superviser ==
                                                                              null ||
                                                                          addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].superviser.toString() ==
                                                                              'null')
                                                                      ? ''
                                                                      : addNewRowMaintenancePlanViewModel
                                                                          .addNewRowMaintenancePlanGetTabularData
                                                                          .data!
                                                                          .getAlls![
                                                                              index]
                                                                          .superviser
                                                                          .toString(),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    //  fontWeight:
                                                                    //      FontWeight.bold,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const Divider(
                                                    color: Colors.grey,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
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
                                                                  "TOTAL MILES:",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child: Text(
                                                                  (addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].totalMiles ==
                                                                              null ||
                                                                          addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].totalMiles.toString() ==
                                                                              'null')
                                                                      ? ''
                                                                      : addNewRowMaintenancePlanViewModel
                                                                          .addNewRowMaintenancePlanGetTabularData
                                                                          .data!
                                                                          .getAlls![
                                                                              index]
                                                                          .totalMiles
                                                                          .toString(),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    //  fontWeight:
                                                                    //      FontWeight.bold,
                                                                    color: Colors
                                                                        .white,
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
                                                                  "COST PER MILE: ",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child: Text(
                                                                  (addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].costPerMile ==
                                                                              null ||
                                                                          addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].costPerMile.toString() ==
                                                                              'null')
                                                                      ? ''
                                                                      : addNewRowMaintenancePlanViewModel
                                                                          .addNewRowMaintenancePlanGetTabularData
                                                                          .data!
                                                                          .getAlls![
                                                                              index]
                                                                          .costPerMile
                                                                          .toString(),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    //  fontWeight:
                                                                    //      FontWeight.bold,
                                                                    color: Colors
                                                                        .white,
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
                                                                  "TOTAL COST: ",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child: Text(
                                                                  (addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].totalCost ==
                                                                              null ||
                                                                          addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].totalCost.toString() ==
                                                                              'null')
                                                                      ? ''
                                                                      : addNewRowMaintenancePlanViewModel
                                                                          .addNewRowMaintenancePlanGetTabularData
                                                                          .data!
                                                                          .getAlls![
                                                                              index]
                                                                          .totalCost
                                                                          .toString(),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    //  fontWeight:
                                                                    //      FontWeight.bold,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const Divider(
                                                    color: Colors.grey,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
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
                                                                  "BUDGET TYPE: ",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child: Text(
                                                                  (addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].budgetType ==
                                                                              null ||
                                                                          addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].budgetType.toString() ==
                                                                              'null')
                                                                      ? ''
                                                                      : addNewRowMaintenancePlanViewModel
                                                                          .addNewRowMaintenancePlanGetTabularData
                                                                          .data!
                                                                          .getAlls![
                                                                              index]
                                                                          .budgetType
                                                                          .toString(),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    //  fontWeight:
                                                                    //      FontWeight.bold,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        // Expanded(
                                                        //   // alignment: Alignment.topLeft,
                                                        //   child: Column(
                                                        //     children: [
                                                        //       const Align(
                                                        //         alignment:
                                                        //             Alignment
                                                        //                 .topLeft,
                                                        //         child: Text(
                                                        //           "CONTRACT ROW YEAR: ",
                                                        //           textAlign:
                                                        //               TextAlign
                                                        //                   .left,
                                                        //           style:
                                                        //               TextStyle(
                                                        //             fontSize: 12,
                                                        //             fontWeight:
                                                        //                 FontWeight
                                                        //                     .bold,
                                                        //             color: Colors
                                                        //                 .white,
                                                        //           ),
                                                        //         ),
                                                        //       ),
                                                        //       Align(
                                                        //         alignment:
                                                        //             Alignment
                                                        //                 .topLeft,
                                                        //         child: Text(
                                                        //           (addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].contractYear ==
                                                        //                       null ||
                                                        //                   addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].contractYear.toString() ==
                                                        //                       'null')
                                                        //               ? ''
                                                        //               : addNewRowMaintenancePlanViewModel
                                                        //                   .addNewRowMaintenancePlanGetTabularData
                                                        //                   .data!
                                                        //                   .getAlls![
                                                        //                       index]
                                                        //                   .contractYear
                                                        //                   .toString(),
                                                        //           textAlign:
                                                        //               TextAlign
                                                        //                   .left,
                                                        //           style:
                                                        //               const TextStyle(
                                                        //             fontSize: 12,
                                                        //             //  fontWeight:
                                                        //             //      FontWeight.bold,
                                                        //             color: Colors
                                                        //                 .white,
                                                        //           ),
                                                        //         ),
                                                        //       ),
                                                        //     ],
                                                        //   ),
                                                        // ),

                                                        Expanded(
                                                          // alignment: Alignment.topLeft,
                                                          child: Column(
                                                            children: [
                                                              const Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child: Text(
                                                                  "CYCLE: ",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child: Text(
                                                                  (addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].cycle ==
                                                                              null ||
                                                                          addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].cycle.toString() ==
                                                                              'null')
                                                                      ? ''
                                                                      : addNewRowMaintenancePlanViewModel
                                                                          .addNewRowMaintenancePlanGetTabularData
                                                                          .data!
                                                                          .getAlls![
                                                                              index]
                                                                          .cycle
                                                                          .toString(),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    //  fontWeight:
                                                                    //      FontWeight.bold,
                                                                    color: Colors
                                                                        .white,
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
                                                                  "NEXT MAINT YEAR: ",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child: Text(
                                                                  (addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].nextMaintDue ==
                                                                              null ||
                                                                          addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].nextMaintDue.toString() ==
                                                                              'null')
                                                                      ? ''
                                                                      : addNewRowMaintenancePlanViewModel
                                                                          .addNewRowMaintenancePlanGetTabularData
                                                                          .data!
                                                                          .getAlls![
                                                                              index]
                                                                          .nextMaintDue
                                                                          .toString(),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    //  fontWeight:
                                                                    //      FontWeight.bold,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  // const Divider(
                                                  //   color: Colors.grey,
                                                  // ),
                                                  // Padding(
                                                  //   padding:
                                                  //       const EdgeInsets.only(
                                                  //           left: 8.0),
                                                  //   child: Row(
                                                  //     children: [
                                                  //       // Expanded(
                                                  //       //   // alignment: Alignment.topLeft,
                                                  //       //   child: Column(
                                                  //       //     children: [
                                                  //       //       const Align(
                                                  //       //         alignment:
                                                  //       //             Alignment
                                                  //       //                 .topLeft,
                                                  //       //         child: Text(
                                                  //       //           "CONTRACT END YEAR : ",
                                                  //       //           textAlign:
                                                  //       //               TextAlign
                                                  //       //                   .left,
                                                  //       //           style:
                                                  //       //               TextStyle(
                                                  //       //             fontSize: 12,
                                                  //       //             fontWeight:
                                                  //       //                 FontWeight
                                                  //       //                     .bold,
                                                  //       //             color: Colors
                                                  //       //                 .white,
                                                  //       //           ),
                                                  //       //         ),
                                                  //       //       ),
                                                  //       //       Align(
                                                  //       //         alignment:
                                                  //       //             Alignment
                                                  //       //                 .topLeft,
                                                  //       //         child: Text(
                                                  //       //           (addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].contractEndYear ==
                                                  //       //                       null ||
                                                  //       //                   addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].contractEndYear.toString() ==
                                                  //       //                       'null')
                                                  //       //               ? ''
                                                  //       //               : addNewRowMaintenancePlanViewModel
                                                  //       //                   .addNewRowMaintenancePlanGetTabularData
                                                  //       //                   .data!
                                                  //       //                   .getAlls![
                                                  //       //                       index]
                                                  //       //                   .contractEndYear
                                                  //       //                   .toString(),
                                                  //       //           textAlign:
                                                  //       //               TextAlign
                                                  //       //                   .left,
                                                  //       //           style:
                                                  //       //               const TextStyle(
                                                  //       //             fontSize: 12,
                                                  //       //             //  fontWeight:
                                                  //       //             //      FontWeight.bold,
                                                  //       //             color: Colors
                                                  //       //                 .white,
                                                  //       //           ),
                                                  //       //         ),
                                                  //       //       ),
                                                  //       //     ],
                                                  //       //   ),
                                                  //       // ),

                                                  //       Expanded(
                                                  //         // alignment: Alignment.topLeft,
                                                  //         child: Column(
                                                  //           children: [
                                                  //             const Align(
                                                  //               alignment:
                                                  //                   Alignment
                                                  //                       .topLeft,
                                                  //               child: Text(
                                                  //                 "ESTIMATED COST : ",
                                                  //                 textAlign:
                                                  //                     TextAlign
                                                  //                         .left,
                                                  //                 style:
                                                  //                     TextStyle(
                                                  //                   fontSize: 12,
                                                  //                   fontWeight:
                                                  //                       FontWeight
                                                  //                           .bold,
                                                  //                   color: Colors
                                                  //                       .white,
                                                  //                 ),
                                                  //               ),
                                                  //             ),
                                                  //             Align(
                                                  //               alignment:
                                                  //                   Alignment
                                                  //                       .topLeft,
                                                  //               child: Text(
                                                  //                 (addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].estCost ==
                                                  //                             null ||
                                                  //                         addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].estCost.toString() ==
                                                  //                             'null')
                                                  //                     ? ''
                                                  //                     : addNewRowMaintenancePlanViewModel
                                                  //                         .addNewRowMaintenancePlanGetTabularData
                                                  //                         .data!
                                                  //                         .getAlls![
                                                  //                             index]
                                                  //                         .estCost
                                                  //                         .toString(),
                                                  //                 textAlign:
                                                  //                     TextAlign
                                                  //                         .left,
                                                  //                 style:
                                                  //                     const TextStyle(
                                                  //                   fontSize: 12,
                                                  //                   //  fontWeight:
                                                  //                   //      FontWeight.bold,
                                                  //                   color: Colors
                                                  //                       .white,
                                                  //                 ),
                                                  //               ),
                                                  //             ),
                                                  //           ],
                                                  //         ),
                                                  //       ),
                                                  //       Expanded(
                                                  //         // alignment: Alignment.topLeft,
                                                  //         child: Column(
                                                  //           children: [
                                                  //             const Align(
                                                  //               alignment:
                                                  //                   Alignment
                                                  //                       .topLeft,
                                                  //               child: Text(
                                                  //                 "ESTIMATED TIME : ",
                                                  //                 textAlign:
                                                  //                     TextAlign
                                                  //                         .left,
                                                  //                 style:
                                                  //                     TextStyle(
                                                  //                   fontSize: 12,
                                                  //                   fontWeight:
                                                  //                       FontWeight
                                                  //                           .bold,
                                                  //                   color: Colors
                                                  //                       .white,
                                                  //                 ),
                                                  //               ),
                                                  //             ),
                                                  //             Align(
                                                  //               alignment:
                                                  //                   Alignment
                                                  //                       .topLeft,
                                                  //               child: Text(
                                                  //                 (addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].estTime ==
                                                  //                             null ||
                                                  //                         addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].estTime.toString() ==
                                                  //                             'null')
                                                  //                     ? ''
                                                  //                     : addNewRowMaintenancePlanViewModel
                                                  //                         .addNewRowMaintenancePlanGetTabularData
                                                  //                         .data!
                                                  //                         .getAlls![
                                                  //                             index]
                                                  //                         .estTime
                                                  //                         .toString(),
                                                  //                 textAlign:
                                                  //                     TextAlign
                                                  //                         .left,
                                                  //                 style:
                                                  //                     const TextStyle(
                                                  //                   fontSize: 12,
                                                  //                   //  fontWeight:
                                                  //                   //      FontWeight.bold,
                                                  //                   color: Colors
                                                  //                       .white,
                                                  //                 ),
                                                  //               ),
                                                  //             ),
                                                  //           ],
                                                  //         ),
                                                  //       ),
                                                  //       Expanded(
                                                  //         flex: 1,
                                                  //         // alignment: Alignment.topLeft,
                                                  //         child: Column(
                                                  //           children: [
                                                  //             const Align(
                                                  //               alignment:
                                                  //                   Alignment
                                                  //                       .topLeft,
                                                  //               child: Text(
                                                  //                 "ACTUAL COST : ",
                                                  //                 textAlign:
                                                  //                     TextAlign
                                                  //                         .left,
                                                  //                 style:
                                                  //                     TextStyle(
                                                  //                   fontSize: 12,
                                                  //                   fontWeight:
                                                  //                       FontWeight
                                                  //                           .bold,
                                                  //                   color: Colors
                                                  //                       .white,
                                                  //                 ),
                                                  //               ),
                                                  //             ),
                                                  //             Align(
                                                  //               alignment:
                                                  //                   Alignment
                                                  //                       .topLeft,
                                                  //               child: Text(
                                                  //                 (addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].actualCost ==
                                                  //                             null ||
                                                  //                         addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].actualCost.toString() ==
                                                  //                             'null')
                                                  //                     ? ''
                                                  //                     : addNewRowMaintenancePlanViewModel
                                                  //                         .addNewRowMaintenancePlanGetTabularData
                                                  //                         .data!
                                                  //                         .getAlls![
                                                  //                             index]
                                                  //                         .actualCost
                                                  //                         .toString(),
                                                  //                 textAlign:
                                                  //                     TextAlign
                                                  //                         .left,
                                                  //                 style:
                                                  //                     const TextStyle(
                                                  //                   fontSize: 12,
                                                  //                   //  fontWeight:
                                                  //                   //      FontWeight.bold,
                                                  //                   color: Colors
                                                  //                       .white,
                                                  //                 ),
                                                  //               ),
                                                  //             ),
                                                  //           ],
                                                  //         ),
                                                  //       ),
                                                  //     ],
                                                  //   ),
                                                  // ),

                                                  const Divider(
                                                    color: Colors.grey,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
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
                                                                  "SHARE: ",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                              (addNewRowMaintenancePlanViewModel
                                                                              .addNewRowMaintenancePlanGetTabularData
                                                                              .data!
                                                                              .getAlls![
                                                                                  index]
                                                                              .visibilityFlag
                                                                              .toString() ==
                                                                          '1' ||
                                                                      addNewRowMaintenancePlanViewModel
                                                                              .addNewRowMaintenancePlanGetTabularData
                                                                              .data!
                                                                              .getAlls![index]
                                                                              .visibilityFlag
                                                                              .toString() ==
                                                                          '2')
                                                                  ? Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          InkWell(
                                                                        onTap:
                                                                            () async {},
                                                                        child: const Align(
                                                                            alignment: Alignment.topLeft,
                                                                            child: Icon(
                                                                              Icons.share,
                                                                              color: Colors.green,
                                                                            )),
                                                                      ),
                                                                    )
                                                                  : Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          InkWell(
                                                                        onTap:
                                                                            () async {},
                                                                        child: const Align(
                                                                            alignment: Alignment.topLeft,
                                                                            child: Icon(
                                                                              Icons.share,
                                                                              color: Colors.blue,
                                                                            )),
                                                                      ),
                                                                    )
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 2,
                                                          child: Column(
                                                            children: [
                                                              Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .topLeft,
                                                                  child:
                                                                      InkWell(
                                                                    onTap:
                                                                        () async {
                                                                      String
                                                                          id =
                                                                          '';
                                                                      final userPreferences1 = Provider.of<
                                                                              UserPref>(
                                                                          context,
                                                                          listen:
                                                                              false);
                                                                      UserModel
                                                                          data =
                                                                          await userPreferences1
                                                                              .getUser();
                                                                      id = data
                                                                          .user!
                                                                          .id
                                                                          .toString();
                                                                          // Navigator
                                                                          //     .push(
                                                                          //   context,
                                                                          //   MaterialPageRoute(
                                                                          //     builder: (context) => MapViewPage(
                                                                          //       url: MapUrl.getAdminEndPoint(addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].tokenNo.toString(), id),
                                                                          //     ),
                                                                          //   ),
                                                                          // );
                                                                      await browser.open(
                                                                          url: WebUri(MapUrl.getAdminEndPoint(addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].tokenNo.toString(), id)
                                                                              // "https://mapapi.ariespro.com/main/admin/CIVM_Map/${addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].tokenNo.toString()}/USRQWXH589Z"
                                                                              ),
                                                                          settings: ChromeSafariBrowserSettings(shareState: CustomTabsShareState.SHARE_STATE_OFF, barCollapsingEnabled: true));
                                                                    },
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      child:
                                                                          Container(
                                                                        // margin: const EdgeInsets.only(
                                                                        //     left: 40, right: 40, bottom: 10.0),
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            8),
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        width:
                                                                            80,
                                                                        // MediaQuery.of(context).size.width,
                                                                        // height: MediaQuery.of(context).size.height * 0.4,
                                                                        decoration: const BoxDecoration(
                                                                            // shape: BoxShape.circle,

                                                                            color: Color.fromARGB(255, 0, 58, 106),
                                                                            gradient: LinearGradient(
                                                                              colors: [
                                                                                Color.fromARGB(255, 0, 79, 215),
                                                                                Colors.blue,
                                                                                Color.fromARGB(255, 0, 79, 215),
                                                                              ],
                                                                            )),
                                                                        child:
                                                                            const Align(
                                                                          alignment:
                                                                              Alignment.center,
                                                                          child:
                                                                              Text(
                                                                            "VIEW MAP",
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 10,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )),
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
                            ],
                          ),
                        )),
                  );

                default:
                  return const Text('data');
              }
            })));
  }

  Future<void> _filterData(String query) async {
    if (query.isEmpty) {
      addNewRowMaintenancePlanViewModel
          .fetchAddNewRowMaintenancePlanTabularListApi(context, selectedYear);
    } else {
      addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data?.getAlls = addNewRowMaintenancePlanViewModel
          .addNewRowMaintenancePlanGetTabularData.data?.getAlls
          ?.where((item) =>
              item.tokenNo.toString().toLowerCase().contains(query.toLowerCase()) ||
              item.status
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              item.substation
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              item.type
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              item.superviser
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              item.cycle
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              item.costPerMile
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              item.budgetType
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              item.contractEndYear.toString().toLowerCase().contains(query.toLowerCase()) ||
              item.totalMiles.toString().toLowerCase().contains(query.toLowerCase()) ||
              item.totalCost.toString().toLowerCase().contains(query.toLowerCase()) ||
              item.contractYear.toString().toLowerCase().contains(query.toLowerCase()) ||
              item.costPerMile.toString().toLowerCase().contains(query.toLowerCase()) ||
              item.totalCost.toString().toLowerCase().contains(query.toLowerCase()) ||
              item.nextMaintDue.toString().toLowerCase().contains(query.toLowerCase()) ||
              item.feeder.toString().toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    setState(() {});
  }
}
