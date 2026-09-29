// import 'package:CIVM/screens/planner_pannel.dart/planner_add_new_row_maintenance_plan_tab_1.dart';
// import 'package:CIVM/screens/planner_pannel.dart/planner_add_new_row_maintenance_plan_tab_2.dart';
// import 'package:CIVM/view_model/row_maintenance_plan_dashboard_view_model.dart';
// import 'package:flutter/material.dart';

// // ignore: must_be_immutable
// class PlannerAddNewRowMaintenancePlan extends StatefulWidget {
//   String tokenNo;
//   String index;
//   String subStation;
//   String feeder;
//   String nextMaintYear;
//   String maintType;
//   String totalMiles;
//   String costPerMile;
//   String totalCost;
//   dynamic budgetType;
//   String contractRowYear;
//   String rowCycle;
//   String rowYear;
//   dynamic contractorCompany;
//   dynamic assignForeman;
//   String task;

//   PlannerAddNewRowMaintenancePlan({
//     Key? key,
//     required this.tokenNo,
//     required this.index,
//     required this.subStation,
//     required this.feeder,
//     required this.nextMaintYear,
//     required this.maintType,
//     required this.totalMiles,
//     required this.costPerMile,
//     required this.totalCost,
//     required this.budgetType,
//     required this.contractRowYear,
//     required this.rowCycle,
//     required this.rowYear,
//     required this.contractorCompany,
//     required this.assignForeman,
//     required this.task,
//   }) : super(key: key);

//   @override
//   State<PlannerAddNewRowMaintenancePlan> createState() =>
//       _PlannerAddNewRowMaintenancePlanState();
// }

// class _PlannerAddNewRowMaintenancePlanState
//     extends State<PlannerAddNewRowMaintenancePlan> {
//   RowMaintenancePlanViewModel rowMaintenancePlanViewModel =
//       RowMaintenancePlanViewModel();
//   // int _currentIndex = 0;
//   // final List<Widget> _children = [
//   //   RowMaintenancePlan(),
//   //   // BottomNavigationHomePage(),
//   //   // BottomNavigationAccountPage()
//   // ];
//   List<String> menu = [];

//   onTappedBar(int index) {
//     setState(() {
//       // _currentIndex = index;
//     });
//   }

//   @override
//   void initState() {
//     // getOwnPermissions();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Size size = MediaQuery.of(context).size;
//     return Scaffold(
//         appBar: AppBar(
//           iconTheme: const IconThemeData(color: Colors.white),
//           title: const Text(
//             'Job List',
//             style: TextStyle(
//               color: Colors.white,
//             ),
//           ),
//           backgroundColor: const Color.fromARGB(255, 7, 59, 120),
//           actions: [
//             // IconButton(
//             //   icon: const Icon(
//             //     Icons.table_chart_outlined,
//             //     color: Colors.white,
//             //   ),
//             //   onPressed: () {
//             //     // Navigator.of(context).push(MaterialPageRoute(
//             //     //     builder: (BuildContext context) =>
//             //     //         const PlannerAddNewRowTable()));
//             //   },
//             // ),
                        
//           ],
//         ),
//         body: DefaultTabController(
//           length: 2,
//           initialIndex: int.parse(widget.index),
//           child: Padding(
//             padding: const EdgeInsets.all(4.0),
//             child: Column(
//               children: [
//                 Container(
//                   margin: const EdgeInsets.all(4),
//                   height: 45,
//                   decoration: const BoxDecoration(
//                     color: Color.fromARGB(255, 132, 179, 233),
//                     // borderRadius: BorderRadius.circular(25.0)
//                   ),
//                   child: const TabBar(
//                     indicator: BoxDecoration(
//                       color: Color.fromARGB(255, 7, 59, 120),
//                       // borderRadius: BorderRadius.circular(25.0),
//                     ),
//                     indicatorSize: TabBarIndicatorSize.tab,
//                     labelColor: Colors.white,
//                     unselectedLabelColor: Color.fromARGB(255, 7, 59, 120),
//                     tabs: [
//                       Tab(
//                         // icon: Icon(Icons.tab, color: Colors.white),
//                         text: 'IVM WORK PLAN',
//                       ),
//                       Tab(
//                         // icon: Icon(Icons.map, color: Colors.white),
//                         text: 'MIDCYCLE HERBICIDE WORK PLAN',
//                       ),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: TabBarView(
//                     children: [
//                       PlannerAddNewRowMaintenancePlanTab1(
//                         index: '0',
//                         tokenNo: widget.tokenNo,
//                         totalMiles:
//                             (widget.index == '0') ? widget.totalMiles : '',
//                         subStation:
//                             (widget.index == '0') ? widget.subStation : '',
//                         feeder: (widget.index == '0') ? widget.feeder : '',
//                         nextMaintYear:
//                             (widget.index == '0') ? widget.nextMaintYear : '',
//                         maintType:
//                             (widget.index == '0') ? widget.maintType : '',
//                         totalCost:
//                             (widget.index == '0') ? widget.totalCost : '',
//                         costPerMile:
//                             (widget.index == '0') ? widget.costPerMile : '',
//                         budgetType:
//                             (widget.index == '0') ? widget.budgetType : '',
//                         contractRowYear:
//                             (widget.index == '0') ? widget.contractRowYear : '',
//                         rowCycle: (widget.index == '0') ? widget.rowCycle : '',
//                         rowYear: (widget.index == '0') ? widget.rowYear : '',
//                         contractorCompany: (widget.index == '0')
//                             ? widget.contractorCompany
//                             : '',
//                         assignForeman:
//                             (widget.index == '0') ? widget.assignForeman : '',
//                         task: widget.task,
//                       ),
//                       PlannerAddNewRowMaintenancePlanTab2(
//                         index: '1',
//                         tokenNo: widget.tokenNo,
//                         totalMiles:
//                             (widget.index == '1') ? widget.totalMiles : '',
//                         subStation:
//                             (widget.index == '1') ? widget.subStation : '',
//                         feeder: (widget.index == '1') ? widget.feeder : '',
//                         nextMaintYear:
//                             (widget.index == '1') ? widget.nextMaintYear : '',
//                         maintType:
//                             (widget.index == '1') ? widget.maintType : '',
//                         totalCost:
//                             (widget.index == '1') ? widget.totalCost : '',
//                         costPerMile:
//                             (widget.index == '1') ? widget.costPerMile : '',
//                         budgetType:
//                             (widget.index == '1') ? widget.budgetType : '',
//                         contractRowYear:
//                             (widget.index == '1') ? widget.contractRowYear : '',
//                         rowCycle: (widget.index == '1') ? widget.rowCycle : '',
//                         rowYear: (widget.index == '1') ? widget.rowYear : '',
//                         contractorCompany: (widget.index == '1')
//                             ? widget.contractorCompany
//                             : '',
//                         assignForeman:
//                             (widget.index == '1') ? widget.assignForeman : '',
//                         task: widget.task,
//                       ),
//                       // EcAnalysisTabView(rateID: widget.rateID, ac: widget.ac),
//                       // EcSavingTipsTabView(rateID: widget.rateID, ac: widget.ac),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ));
//   }
// }
