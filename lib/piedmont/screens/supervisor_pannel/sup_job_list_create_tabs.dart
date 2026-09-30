import 'package:CIVM/piedmont/resources/app_colors.dart';
import 'package:CIVM/piedmont/screens/supervisor_pannel/sup_job_list_tab1_distri_IVM_create.dart';
import 'package:CIVM/piedmont/screens/supervisor_pannel/sup_job_list_tab2_trans_IVM_create.dart';
import 'package:CIVM/piedmont/screens/supervisor_pannel/sup_job_list_tab3_trans_herbicide_create.dart';
import 'package:CIVM/piedmont/screens/supervisor_pannel/sup_job_list_tab4_annual_herbicide_create.dart';
import 'package:CIVM/piedmont/view_model/row_maintenance_plan_dashboard_view_model.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// ignore: must_be_immutable
class SupJobListCreateTabs extends StatefulWidget {
  String index;
  SupJobListCreateTabs({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<SupJobListCreateTabs> createState() => _SupJobListCreateTabsState();
}

class _SupJobListCreateTabsState extends State<SupJobListCreateTabs> {
  RowMaintenancePlanViewModel rowMaintenancePlanViewModel =
      RowMaintenancePlanViewModel();
  // int _currentIndex = 0;
  // final List<Widget> _children = [
  //   RowMaintenancePlan(),
  //   // BottomNavigationHomePage(),
  //   // BottomNavigationAccountPage()
  // ];
  List<String> menu = [];

  onTappedBar(int index) {
    setState(() {
      // _currentIndex = index;
    });
  }

  @override
  void initState() {
    // getOwnPermissions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'Create Job List',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: AppColors.baseColor,
        ),
        body: DefaultTabController(
          initialIndex: int.parse(widget.index),
          length: 4,
          // initialIndex: int.parse(widget.index),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(4),
                  height: 45,
                  decoration: const BoxDecoration(
                    color: AppColors.lightGreen,
                    // borderRadius: BorderRadius.circular(25.0)
                  ),
                  child: const TabBar(
                    indicator: BoxDecoration(
                      color: AppColors.baseColor,
                      // borderRadius: BorderRadius.circular(25.0),
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: Colors.white,
                    unselectedLabelColor: AppColors.baseColor,
                    tabs: [
                      Tab(
                        // icon: Icon(Icons.tab, color: Colors.white),
                        text: 'D. IVM',
                      ),
                      Tab(
                        // icon: Icon(Icons.map, color: Colors.white),
                        text: 'T. IVM',
                      ),
                      Tab(
                        // icon: Icon(Icons.tab, color: Colors.white),
                        text: 'T. Herbicide',
                      ),
                      Tab(
                        // icon: Icon(Icons.map, color: Colors.white),
                        text: 'A. Herbicide',
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      SupJobListDistriIVMCreate(),
                      SupJobListtransIVMCreate(),
                      SupJobListTransHerbicideCreate(),
                      SupJobListAnnualHerbicideCreate()
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
