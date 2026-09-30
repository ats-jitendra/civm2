// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/admin_pannel.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/maintenance_analysis_report.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/outage_by_vegetation_report.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/row_cost_analysis.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/row_cost_analysis_by_month.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/row_cost_analysis_by_season.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/row_maintenance_progress_AI_new.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/row_maintenance_progress_new.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/temperature_effect_on_outage.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/temperature_impact_analysis.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/vegetation_cost_analysis.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/vegetation_normalize.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/vegetation_outage_by_type.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/weather_impact_analysis.dart';
// import 'package:CIVM/piedmont/screens/forget_password.dart';
// import 'package:CIVM/piedmont/screens/generalForeman_New_pannel/contractor_bottom_navigation.dart';
// import 'package:CIVM/piedmont/screens/crew_pannel/crew_bottom_navigation_pannel.dart';
// import 'package:CIVM/piedmont/screens/login_page.dart';
// import 'package:CIVM/piedmont/screens/planner_pannel.dart/planner_bottom_navigation.dart';
// import 'package:CIVM/piedmont/screens/splash_screen.dart';
// import 'package:CIVM/piedmont/screens/supervisor_pannel/supervisor_bottom_navigation_pannel.dart';
// import 'package:CIVM/piedmont/utils/routes/route_name.dart';
// import 'package:flutter/material.dart';

// class RoutesPemc {
//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case RoutesNamePemc.splash:
//         return MaterialPageRoute(
//             builder: (BuildContext contex) => const SplashScreen());

//       case RoutesNamePemc.loginPemc:
//         return MaterialPageRoute(
//             builder: (BuildContext contex) => const LoginPagePemc());

//       case RoutesNamePemc.forgotPassword:
//         return MaterialPageRoute(
//             builder: (BuildContext contex) => const ForgotPassword());

//       case RoutesNamePemc.adminHome:
//         return MaterialPageRoute(
//             builder: (BuildContext contex) => const EnergyAuditPannel());

//       case RoutesNamePemc.contractorHome:
//         return MaterialPageRoute(
//             builder: (BuildContext contex) =>
//                 const ContractorBottomNavigationPannel());

//       case RoutesNamePemc.supervisorHome:
//         return MaterialPageRoute(
//             builder: (BuildContext contex) =>
//                 const SupervisorBottomNavigationPannel());

//       case RoutesNamePemc.crewHome:
//         return MaterialPageRoute(
//             builder: (BuildContext contex) =>
//                 const CrewBottomNavigationPannel());
//       case RoutesNamePemc.plannerHome:
//         return MaterialPageRoute(
//             builder: (BuildContext contex) =>
//                 const PlannerBottomNavigationPannel());

// // ************************************admin pannel********************//

//       case RoutesNamePemc.maintenanceAnalysisReport:
//         return MaterialPageRoute(
//             builder: (BuildContext contex) =>
//                 const MaintenanceAnalysisReport());

//       case RoutesNamePemc.rowMaintenanceProgressAINew:
//         return MaterialPageRoute(
//             builder: (BuildContext contex) =>
//                 const RowMaintenanceProgressAINew());

//       case RoutesNamePemc.outageByVegetationReport:
//         return MaterialPageRoute(
//             builder: (BuildContext contex) => const OutageByVegetationReport());

//       case RoutesNamePemc.vegetationOutageByType:
//         return MaterialPageRoute(
//             builder: (BuildContext contex) => const VegetationOutageByType());

//       case RoutesNamePemc.vegetationNormalize:
//         return MaterialPageRoute(
//             builder: (BuildContext contex) => const VegetationNormalize());

//       case RoutesNamePemc.temperatureEffectOnOutage:
//         return MaterialPageRoute(
//             builder: (BuildContext contex) =>
//                 const TemperatureEffectOnOutage());

//       case RoutesNamePemc.temperatureImpactAnalysis:
//         return MaterialPageRoute(
//             builder: (BuildContext contex) =>
//                 const TemperatureImpactAnalysis());

//       case RoutesNamePemc.weatherImpactAnalysis:
//         return MaterialPageRoute(
//             builder: (BuildContext contex) => const WeatherImpactAnalysis());

//       case RoutesNamePemc.vegetationCostAnalysis:
//         return MaterialPageRoute(
//             builder: (BuildContext contex) => const VegetationCostAnalysis());

//       case RoutesNamePemc.rowCostAnalysis:
//         return MaterialPageRoute(
//             builder: (BuildContext contex) => const RowCostAnalysis());

//       case RoutesNamePemc.rowCostAnalysisByMonth:
//         return MaterialPageRoute(
//             builder: (BuildContext contex) => const RowCostAnalysisByMonth());

//       case RoutesNamePemc.rowCostAnalysisBySeason:
//         return MaterialPageRoute(
//             builder: (BuildContext contex) => const RowCostAnalysisBySeason());

//       case RoutesNamePemc.rowMaintenanceReportNew:
//         return MaterialPageRoute(
//             builder: (BuildContext contex) => const RowMaintenanceReportNew());

//       default:
//         return MaterialPageRoute(builder: (_) {
//           return const Scaffold(
//             body: Center(
//               child: Text('No route defined'),
//             ),
//           );
//         });
//     }
//   }
// }
