import 'package:CIVM/screens/generalForeman_New_pannel/contractor_bottom_navigation.dart';
import 'package:CIVM/screens/crew_pannel/crew_bottom_navigation_pannel.dart';
import 'package:CIVM/screens/planner_pannel.dart/planner_bottom_navigation.dart';
import 'package:CIVM/screens/supervisor_pannel/supervisor_bottom_navigation_pannel.dart';
import 'package:CIVM/utils/routes/route_name.dart';
import 'package:flutter/material.dart';
import '../../screens/admin_pannel/row_maintenance_view/admin_pannel.dart';
import '../../screens/forget_password.dart';
import '../../screens/login_page.dart';
import '../../screens/splash_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(
            builder: (BuildContext contex) => const SplashScreen());

      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext contex) => const LoginPage());

      case RoutesName.forgotPassword:
        return MaterialPageRoute(
            builder: (BuildContext contex) => const ForgotPassword());

      case RoutesName.adminHome:
        return MaterialPageRoute(
            builder: (BuildContext contex) => const EnergyAuditPannel());

      case RoutesName.contractorHome:
        return MaterialPageRoute(
            builder: (BuildContext contex) =>
                const ContractorBottomNavigationPannel());

      case RoutesName.supervisorHome:
        return MaterialPageRoute(
            builder: (BuildContext contex) =>
                const SupervisorBottomNavigationPannel());

      case RoutesName.crewHome:
        return MaterialPageRoute(
            builder: (BuildContext contex) =>
                const CrewBottomNavigationPannel());
      case RoutesName.plannerHome:
        return MaterialPageRoute(
            builder: (BuildContext contex) =>
                const PlannerBottomNavigationPannel());

// ************************************admin pannel********************//

      // case RoutesName.maintenanceAnalysisReport:
      //   return MaterialPageRoute(
      //       builder: (BuildContext contex) =>
      //           const MaintenanceAnalysisReport());

      // case RoutesName.rowMaintenanceProgressAINew:
      //   return MaterialPageRoute(
      //       builder: (BuildContext contex) =>
      //           const RowMaintenanceProgressAINew());

      // case RoutesName.outageByVegetationReport:
      //   return MaterialPageRoute(
      //       builder: (BuildContext contex) => const OutageByVegetationReport());

      // case RoutesName.vegetationOutageByType:
      //   return MaterialPageRoute(
      //       builder: (BuildContext contex) => const VegetationOutageByType());

      // case RoutesName.vegetationNormalize:
      //   return MaterialPageRoute(
      //       builder: (BuildContext contex) => const VegetationNormalize());

      // case RoutesName.temperatureEffectOnOutage:
      //   return MaterialPageRoute(
      //       builder: (BuildContext contex) =>
      //           const TemperatureEffectOnOutage());

      // case RoutesName.temperatureImpactAnalysis:
      //   return MaterialPageRoute(
      //       builder: (BuildContext contex) =>
      //           const TemperatureImpactAnalysis());

      // case RoutesName.weatherImpactAnalysis:
      //   return MaterialPageRoute(
      //       builder: (BuildContext contex) => const WeatherImpactAnalysis());

      // case RoutesName.vegetationCostAnalysis:
      //   return MaterialPageRoute(
      //       builder: (BuildContext contex) => const VegetationCostAnalysis());

      // case RoutesName.rowCostAnalysis:
      //   return MaterialPageRoute(
      //       builder: (BuildContext contex) => const RowCostAnalysis());

      // case RoutesName.rowCostAnalysisByMonth:
      //   return MaterialPageRoute(
      //       builder: (BuildContext contex) => const RowCostAnalysisByMonth());

      // case RoutesName.rowCostAnalysisBySeason:
      //   return MaterialPageRoute(
      //       builder: (BuildContext contex) => const RowCostAnalysisBySeason());

      // case RoutesName.rowMaintenanceReportNew:
      //   return MaterialPageRoute(
      //       builder: (BuildContext contex) => const RowMaintenanceReportNew());

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }
  }
}
