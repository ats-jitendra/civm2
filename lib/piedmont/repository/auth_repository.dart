import 'package:CIVM/piedmont/models/account_page_model.dart';
import 'package:CIVM/piedmont/models/cancelInitiatedWorkForApprovalChangeOrderRecords_model.dart';
import 'package:CIVM/piedmont/models/contractor_change_order_model.dart';
import 'package:CIVM/piedmont/models/contractor_dispatcher_dashboard_model.dart';
import 'package:CIVM/piedmont/models/contractor_order_pending_model.dart';
import 'package:CIVM/piedmont/models/contractor_row_maintenance_progress_model.dart';
import 'package:CIVM/piedmont/models/create_invoice_contractor_model.dart';
import 'package:CIVM/piedmont/models/crewChangeOrderListModel.dart';
import 'package:CIVM/piedmont/models/daily_herbicide_model.dart';
import 'package:CIVM/piedmont/models/distributionIVM_rejected_model.dart';
import 'package:CIVM/piedmont/models/image_model.dart';
import 'package:CIVM/piedmont/models/invoice_create_invoice_model.dart';
import 'package:CIVM/piedmont/models/invoice_form_model.dart';
import 'package:CIVM/piedmont/models/invoice_get_token_model.dart';
import 'package:CIVM/piedmont/models/invoice_list_model.dart';
import 'package:CIVM/piedmont/models/invoice_model.dart';
import 'package:CIVM/piedmont/models/ivmMaintenance_table_model.dart';
import 'package:CIVM/piedmont/models/ivm_timesheet_model.dart';
import 'package:CIVM/piedmont/models/lcpChangeOrderModel.dart';
import 'package:CIVM/piedmont/models/lcp_work_order_pending_model.dart';
import 'package:CIVM/piedmont/models/maintenance_report_view_model.dart';
import 'package:CIVM/piedmont/models/maintenance_report_view_update_model.dart';
import 'package:CIVM/piedmont/models/mixing_inventory_model.dart';
import 'package:CIVM/piedmont/models/rowMaintenacePlanTabModel.dart';
import 'package:CIVM/piedmont/models/row_cost_analysis_by_season_model.dart';
import 'package:CIVM/piedmont/models/row_maint_image_uplaod_contractor.dart';
import 'package:CIVM/piedmont/models/row_maintenance_progress_contractor_insert_model.dart';
import 'package:CIVM/piedmont/models/supervisor_ordersPendingModel.dart';
import 'package:CIVM/piedmont/models/vegetation_growth_rate_model.dart';
import 'package:CIVM/piedmont/models/vegetation_management_dashboard_model.dart';
import 'package:CIVM/piedmont/data/network/baseApiServices.dart';
import 'package:CIVM/piedmont/data/network/networkApiServices.dart';

import 'package:CIVM/piedmont/models/add_budget_planning_model.dart';
import 'package:CIVM/piedmont/models/add_budget_planning_third_model.dart';
import 'package:CIVM/piedmont/models/add_crew_member_model.dart';
import 'package:CIVM/piedmont/models/add_new_row_maintenance_plan_model.dart';
import 'package:CIVM/piedmont/models/add_new_row_tabular_data.dart';
import 'package:CIVM/piedmont/models/approve_civm_access_model.dart';
import 'package:CIVM/piedmont/models/lcp_document_approval_model.dart';
import 'package:CIVM/piedmont/models/lcp_model.dart';
import 'package:CIVM/piedmont/models/lcp_work_order_closed_model.dart';
import 'package:CIVM/piedmont/models/lcp_work_order_reject_model.dart';
import 'package:CIVM/piedmont/models/maintenance_analysi_model.dart';

import 'package:CIVM/piedmont/models/row_cost_analysis_by_month_model.dart';
import 'package:CIVM/piedmont/models/row_cost_analysis_model.dart';
import 'package:CIVM/piedmont/models/row_maintenance_plan_dashboard_model.dart';
import 'package:CIVM/piedmont/models/row_maintenance_progress_dashboard_model.dart';
import 'package:CIVM/piedmont/models/row_maintenance_progress_new_model.dart';
import 'package:CIVM/piedmont/models/row_maintenance_progress_tab_model.dart';
import 'package:CIVM/piedmont/models/temperature_impact_analysis_model.dart';

import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/piedmont/models/vegetation_normalize_model.dart';
import 'package:CIVM/piedmont/models/vegetation_outage_by_type_model.dart';
import 'package:CIVM/piedmont/models/weather_impact_analysis_model.dart';
import 'package:CIVM/piedmont/resources/app_url.dart';

// class AuthRepository {
//   final BaseApiServices _apiServices = NetworkApiService();

//   Future<UserModel> loginApi(dynamic data) async {
//     try {
//       dynamic response =
//           await _apiServices.getPostApiResponse(AppUrl.loginEndPoint, data);
//       print('response111111111');
//       print(response);
//       return response = UserModel.fromJson(response);
//     } catch (e) {
//       rethrow;
//     }
//   }

class AuthRepositoryPemc {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<UserModel> loginApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponseLogin(
          AppUrl.loginEndPoint, data);

      // For success (200), parse into UserModel
      return UserModel.fromJson(response);
    } catch (e) {
      // Rethrow the error so ViewModel can catch it
      rethrow;
    }
  }

  Future<RowMaintenancePlanDashboardModel> rowMaintenancePlanDashboardListApi(
      String token) async {
    try {
      var response = await _apiServices.getGetApiResponse(
          AppUrl.listRowMaintenancePlanEndPoint, token);
      return RowMaintenancePlanDashboardModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<RowMaintenacePlanTabModel> rowMaintenancePlanTabViewApi(
      String yearList,
      String cycleList,
      String substationList,
      String feederList,
      String token) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          '${AppUrl.rowMaintenancePlanTabEndPoint}?yearList=$yearList&cycleList=$cycleList&substationList=$substationList&feederList=$feederList',
          token);
      return RowMaintenacePlanTabModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<RowMaintenacePlanTabModel> rowMaintenancePlanTabViewSubmitDataApi(
      dynamic data, String token) async {
    try {
      dynamic response = await _apiServices.getPutApiResponse1(
          AppUrl.rowMaintenancePlanTabViewSubmitDataEndPoint, data, token);
      return response = RowMaintenacePlanTabModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<AddNewRowMaintenancePlanModel> addNewRowMaintenancePlanGetApi(
      String substationId,
      String action,
      String supervisorId,
      String loginId,
      String substationName,
      String year,
      String feeder,
      String contractorCompany,
      String token) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          '${AppUrl.addNewRowMaintenancePlanEndPoint}?substationId=$substationId&action=$action&supervisorId=$supervisorId&loginId=$loginId&substationName=$substationName&year=$year&feeder=$feeder&contractorCompany=$contractorCompany',
          token);
      return AddNewRowMaintenancePlanModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<LcpCreateOrderModel> lcpChangeOrderGetApi(
      String substation,
      String userType,
      String action,
      String streetAddress,
      String location,
      String substationId,
      String contractorCompany,
      String token) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          '${AppUrl.lcpChangeOrderEndPoint}?substation=$substation&userType=$userType&action=$action&streetdAdress=$streetAddress&location=$location&substationId=$substationId&contractorCompany=$contractorCompany',
          token);
      return LcpCreateOrderModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<RowMaintenanceProgressTabModel> rowMaintenanceProgressTabApi(
      String cycleList,
      String subStationList,
      String feeder,
      String crew,
      String yearList,
      String token) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          '${AppUrl.rowMaintenanceProgressEndPoint}?cycleList=$cycleList&subStationList=$subStationList&feeder=$feeder&crew=$crew&yearList=$yearList',
          token);
      return RowMaintenanceProgressTabModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<RowCostAnalysisModel> rowCostAnanlysisApi(String substation,
      String fdrName, String nextMaintenanceDue, String token) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          '${AppUrl.rowCostAnanlysisEndPoint}?substation=$substation&fdrName=$fdrName&nextMaintenanceDue=$nextMaintenanceDue',
          token);
      return RowCostAnalysisModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<LCPModel> lcpApi(
      String contractorCompanyName,
      String status,
      String budgetType,
      String maintType,
      String id,
      String panel,
      String token) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          '${AppUrl.lcpEndPoint}?compnyName=$contractorCompanyName&status=$status&budgetType=$budgetType&maintType=$maintType&id=$id&panel=$panel',
          token);
      return LCPModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<MaintenanceAnalysisModel> maintenanceAnalysisApi(String substation,
      String fdrName, String nextMaintenanceDue, String token) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          '${AppUrl.maintenanceAnalysisEndPoint}?substation=$substation&fdrName=$fdrName&nextMaintenanceDue=$nextMaintenanceDue',
          token);
      return MaintenanceAnalysisModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<VegetationOutageByTypeModel> vegetationOutageByTypeApi(
      String delayCause,
      String substation,
      String fdrName,
      String outageCause,
      String token) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          '${AppUrl.vegetationOutageByTypeEndPoint}?delayCause=$delayCause&substation=$substation&fdrName=$fdrName&outageCause=$outageCause',
          token);
      return VegetationOutageByTypeModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<VegetationNormalizeModel> vegetationNormalizeApi(
      String substation,
      String fdrName,
      String outageCause,
      String sDate,
      String eDate,
      String delayCause,
      String token) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          '${AppUrl.vegetationNormalizeEndPoint}?substation=$substation&fdrName=$fdrName&outageCause=$outageCause&sDate=$sDate&eDate=$eDate&delayCause=$delayCause',
          token);
      return VegetationNormalizeModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<WeatherImpactAnalysisModel> weatherImpactAnalysisApi(
      String substation,
      String fdrName,
      String sDate,
      String eDate,
      String delayCause,
      String token) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          '${AppUrl.weatherImpactAnalysisEndPoint}?substation=$substation&feeder=$fdrName&sdate=$sDate&edate=$eDate&delayCause=$delayCause',
          token);
      return WeatherImpactAnalysisModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<TemperatureImpactAnalysisModel> temperatureImpactAnalysisApi(
      String substation,
      String feeder,
      String sDate,
      String eDate,
      String delayCause,
      String token) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          '${AppUrl.temperatureImpactAnalysisEndPoint}?substation=$substation&feeder=$feeder&sdate=$sDate&edate=$eDate&delayCause=$delayCause',
          token);
      return TemperatureImpactAnalysisModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<RowCostAnalysisByMonthModel> rowCostAnalysisByMonthApi(
      String substation,
      String feeder,
      String nextMaintDueYr,
      String nextMaintDueMonth,
      String token) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          '${AppUrl.rowCostAnalysisByMonthEndPoint}?substation=$substation&feeder=$feeder&nextMaintDueYr=$nextMaintDueYr&nextMaintDueMonth=$nextMaintDueMonth',
          token);
      return RowCostAnalysisByMonthModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<RowCostAnalysisBySeasonModel> rowCostAnalysisBySeasonApi(
      String substation,
      String feeder,
      String nextMaintDueYr,
      String season,
      String type,
      String nextMaintDueMonth,
      String token) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          '${AppUrl.rowCostAnalysisBySeasonEndPoint}?substation=$substation&feeder=$feeder&nextMaintDueYr=$nextMaintDueYr&season=$season&type=$type&nextMaintDueMonth=$nextMaintDueMonth',
          token);
      return RowCostAnalysisBySeasonModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<AddNewRowMaintenancePlanModel> addNewRowMaintenancePlanSubmitApi(
      dynamic data, String token) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse1(
          AppUrl.addNewRowMaintenancePlanSubmitApiEndPoint, data, token);
      return response = AddNewRowMaintenancePlanModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<LCPDocumentApprovalPendingModel> lcpDocumentPendingApprovalSubmitApi(
      String status, String adminNotes2, int tokenNo, String token) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          '${AppUrl.lcpDocumentPendingApprovalSubmitApiEndPoint}?status=$status&adminNotes2=$adminNotes2&tokenNo=$tokenNo',
          token);
      return response = LCPDocumentApprovalPendingModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<LCPDocumentApprovalPendingModel>
      lcpDocumentPendingApprovalAdminNewSubmitApi(
          String status, String adminNotes2, int tokenNo, String token) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          '${AppUrl.lcpDocumentPendingApprovalSubmitAdminNewApiEndPoint}?status=$status&adminNotes2=$adminNotes2&tokenNo=$tokenNo',
          token);
      return response = LCPDocumentApprovalPendingModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<LCPDocumentApprovalPendingModel>
      lcpDocumentPendingApprovalChangeStatusApi(
          String tokenNo, String status, String token) async {
    try {
      dynamic response = await _apiServices.getPutApiResponse(
          '${AppUrl.lcpDocumentPendingApprovalChangeStatusApiEndPoint}?tokenNo=$tokenNo&status=$status',
          token);
      return response = LCPDocumentApprovalPendingModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

// *********************LCP create order submit api*****************//
  Future<LcpCreateOrderModel> lcpCreateOrderSubmitApi(
      dynamic data, String token) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse1(
          AppUrl.lcpCreateOrderSubmitApiEndPoint, data, token);
      return response = LcpCreateOrderModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<ApproveCIVMAccessModel> approveCIVMSubmitApi(
      dynamic data, String token) async {
    try {
      dynamic response = await _apiServices.getPutApiResponse1(
          AppUrl.approveCIVMSubmitApiEndPoint, data, token);
      return response = ApproveCIVMAccessModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<ApproveCIVMAccessModel> approveCIVMSubmitApi2(
      dynamic data, String token) async {
    try {
      dynamic response = await _apiServices.getPutApiResponse1(
          AppUrl.approveCIVMSubmitApiEndPoint2, data, token);
      return response = ApproveCIVMAccessModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<ApproveCIVMAccessModel> approveCIVMSubmitApi3(
      String supervisor, String contractor, String token) async {
    try {
      print('api:::::');
      dynamic response = await _apiServices.getPutApiResponse(
          '${AppUrl.approveCIVMSubmitApiEndPoint3}?supervisor=$supervisor&contractor=$contractor',
          token);
          print('api 3::${AppUrl.approveCIVMSubmitApiEndPoint3}?supervisor=$supervisor&contractor=$contractor');
      return response = ApproveCIVMAccessModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<AddNewRowMaintenancePlanTabularDataModel>
      addNewRowMaintenancePlanTabularDataApi(String token, String year) async {
    try {
      var response = await _apiServices.getGetApiResponse(
          // AppUrl.addNewRowMaintenancePlanTabularDataEndPoint,
          '${AppUrl.addNewRowMaintenancePlanTabularDataEndPoint}?year=$year',
          token);
      return AddNewRowMaintenancePlanTabularDataModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<AddNewRowMaintenancePlanTabularDataModel>
      addNewRowMaintenancePlanSprayTabularDataApi(
          String token, String year) async {
    try {
      var response = await _apiServices.getGetApiResponse(
          // AppUrl.addNewRowMaintenancePlanTabularDataEndPoint,
          '${AppUrl.addNewRowMaintenancePlanSprayTabularDataEndPoint}?year=$year',
          token);
      return AddNewRowMaintenancePlanTabularDataModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  /// **************************approve CIVM Access ***************************
  Future<ApproveCIVMAccessModel> approveCIVMAccessTabularDataApi(
      String loginId, String id, String token) async {
    try {
      var response = await _apiServices.getGetApiResponse(
          '${AppUrl.approveCIVMAccessTabularDataEndPoint}?loginId=$loginId&id=$id&userType=3,5',
          token);
      return ApproveCIVMAccessModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  /// **************************approve CIVM Access ***************************
  Future<LCPWorkOrderPendingModel> lcpWorkOrderPendingTabularDataApi(
      String token,
      String status,
      String workOrderNo,
      String contractorCompany,
      String budgetType,
      String maintenanceType,
      String id,
      String pannel) async {
    try {
      var response = await _apiServices.getGetApiResponse(
          '${AppUrl.lcpWorkOrderPendingTabularDataEndPoint}?status=$status&changeOrder=$workOrderNo&contractorCompany=$contractorCompany&budgetType=$budgetType&maintType=$maintenanceType&id=$id&panel=$pannel',
          token);
      return LCPWorkOrderPendingModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  /// **************************approve CIVM Access ***************************
  Future<LCPDocumentApprovalPendingModel>
      lcpDocumentApprovalPendingTabularDataApi(
          String token,
          String substation,
          String status,
          String contractorCompany,
          String feeder,
          String budgetType,
          String maintenanceType) async {
    try {
      var response = await _apiServices.getGetApiResponse(
          '${AppUrl.lcpDocumentApprovalPendingTabularDataEndPoint}?substation=$substation&status=$status&contractorCompany=$contractorCompany&fdr=$feeder&budgetType=$budgetType&maintType=$maintenanceType',
          token);
      return LCPDocumentApprovalPendingModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  /// **************************LCP Work Order Closed ***************************
  Future<LCPWorkOrdersClosedModel> lcpWorkOrderClosedTabularDataApi(
      String token,
      String fdr,
      String substation,
      String status,
      String contractorCompany,
      String budgetType,
      String maintenanceType,
      String id,
      String panel) async {
    try {
      var response = await _apiServices.getGetApiResponse(
          '${AppUrl.lcpWorkOrderClosedTabularDataEndPoint}?fdr=$fdr&substation=$substation&status=$status&contractorCompany=$contractorCompany&budgetType=$budgetType&maintType=$maintenanceType&id=$id&panel=$panel',
          token);
      return LCPWorkOrdersClosedModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  /// **************************Daily Herbicide***************************
  Future<DailyHerbicideModel> dailyHerbicideTabularDataApi(
      String token, String id) async {
    try {
      var response = await _apiServices.getGetApiResponse(
          '${AppUrl.dailyHerbicideDataEndPoint}$id', token);
      return DailyHerbicideModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  /// ************************** Mixing Inventory***************************
  Future<MixingInventoryModel> mixingInventoryTabularDataApi(
      String token, String id) async {
    try {
      var response = await _apiServices.getGetApiResponse(
          '${AppUrl.mixingInventoryDataEndPoint}$id', token);
      return MixingInventoryModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  /// **************************IVM Timesheet***************************
  Future<IvmTimeSheetModel> ivmTimeSheetTabularDataApi(
      String token, String id) async {
    try {
      var response = await _apiServices.getGetApiResponse(
          '${AppUrl.ivmTimeSheetEndPoint}$id', token);
      return IvmTimeSheetModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  /// **************************approve CIVM Access ***************************
  Future<LCPWorkOrderRejectModel> lcpWorkOrderRejectTabularDataApi(
      String token,
      String feeder,
      String substation,
      String status,
      String contractorCompany,
      String budgetType,
      String maintenanceType,
      String id,
      String panel) async {
    try {
      var response = await _apiServices.getGetApiResponse(
          '${AppUrl.lcpWorkOrderRejectTabularDataEndPoint}?fdr=$feeder&substation=$substation&status=$status&contractorCompany=$contractorCompany&budgetType=$budgetType&maintType=$maintenanceType&id=$id&panel=$panel',
          token);
      return LCPWorkOrderRejectModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  /// **************************add budget planning***************************
  Future<AddBudgetPlanningModel> addBudgetPlanningGetDataApi(String budgetId,
      String year, String planDtlsId, String substationId, String token) async {
    try {
      var response = await _apiServices.getGetApiResponse(
          '${AppUrl.addBudgetPlanningGetDataEndPoint}?budgetId=$budgetId&year=$year&planDtlsId=$planDtlsId&substationId=$substationId',
          token);
      return AddBudgetPlanningModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  /// **************************add budget planning third page***************************
  Future<AddBudgetPlanThirdModel> addBudgetPlanningThirdGetDataApi(
      String id, String substation, String year, String token) async {
    try {
      var response = await _apiServices.getGetApiResponse(
          '${AppUrl.addBudgetPlanningThirdGetDataEndPoint}?id=$id&substation=$substation&year=$year',
          token);
      return AddBudgetPlanThirdModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<ApproveCIVMAccessModel> approveCIVMPutDataApi(
      String token, String status, String id) async {
    try {
      dynamic response = await _apiServices.getPutApiResponse(
          '${AppUrl.approveCIVMPostDataEndPoint}?status=$status&id=$id', token);

      return ApproveCIVMAccessModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<AddCrewMemberModel> addCrewMemberPutDataApi(
      String token, String status, String id) async {
    try {
      dynamic response = await _apiServices.getPutApiResponse(
          '${AppUrl.approveCIVMPostDataEndPoint}?status=$status&id=$id', token);

      return AddCrewMemberModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<AddCrewMemberModel> addCrewMemberInsertDataApi(
    String token,
    dynamic data,
  ) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse1(
          AppUrl.addCrewMemberInsertEndPoint, data, token);
      return AddCrewMemberModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<AddBudgetPlanningModel> addBudgetPlanningInsertDataApi(
      dynamic data, String token) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse1(
          AppUrl.addBudgetPlanningInsertEndPoint, data, token);
      return AddBudgetPlanningModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<AddBudgetPlanThirdModel> addBudgetPlanningThirdInsertDataApi(
      dynamic data, String token) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse1(
          AppUrl.addBudgetPlanningThirdInsertEndPoint, data, token);
      return AddBudgetPlanThirdModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  // Future<AddBudgetPlanThirdModel> addBudgetPlanningThirdBoxInsertDataApi(
  Future addBudgetPlanningThirdBoxInsertDataApi(
      dynamic data, String token) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse1(
          AppUrl.addBudgetPlanningThirdBoxInsertEndPoint, data, token);
      print('11111111111111111111111111111111');
      print(response);
      // return AddBudgetPlanThirdModel.fromJson(response);
    } catch (e) {
      print('error in model');
      rethrow;
    }
  }

  Future<AddCrewMemberModel> addCrewMemberDeleteDataApi(
      String token, String id) async {
    try {
      dynamic response = await _apiServices.getDeleteApiResponse(
          '${AppUrl.addCrewMemberDeleteEndPoint}$id', token);
      return AddCrewMemberModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

// ***********************add budget planning delete api****************************//
  // Future<AddBudgetPlanningModel> addBudgetPlanningDeleteDataApi(
  //     String token, String id) async {
  //   try {
  //     dynamic response = await _apiServices.getDeleteApiResponse(
  //         '${AppUrl.addBudgetPlanningDeleteEndPoint}$id', token);
  //     return AddBudgetPlanningModel.fromJson(response);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Future<AddBudgetPlanningModel> addBudgetPlanningDeleteDataApi(
      String token, String year, String id) async {
    try {
      dynamic response = await _apiServices.getDeleteApiResponse(
          '${AppUrl.addBudgetPlanningDeleteEndPoint}?year=$year&insertedBudgetAndYearOfGetId=$id',
          token);
      // Check if response is null
      if (response == null) {
        throw Exception('Response is null');
      }

      return AddBudgetPlanningModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<AddBudgetPlanningModel> addBudgetPlanningThirdDeleteDataApi(
      String id, String token) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          '${AppUrl.addBudgetPlanningThirdDeleteEndPoint}$id', token);
      // Check if response is null
      if (response == null) {
        throw Exception('Response is null');
      }

      return AddBudgetPlanningModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  /// **************************add crew member***************************//
  Future<AddCrewMemberModel> addCrewMemberTabularDataApi(String token) async {
    try {
      var response = await _apiServices.getGetApiResponse(
          AppUrl.addCrewMedmberTabularDataEndPoint, token);
      return AddCrewMemberModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<RowMaintenanceProgressDashboardModel>
      rowMaintenanceProgressDashboardApi(String token, String year) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          '${AppUrl.rowMaintenanceProgressDashboardEndPoint}?year=$year',
          token);
      print(response);
      return RowMaintenanceProgressDashboardModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<RowMaintenanceProgressNewModel> rowMaintenanceProgressNewApi(
      String token,
      String substation,
      String feeder,
      String cycle,
      String month,
      String year) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          '${AppUrl.rowMaintenanceProgressNewEndPoint}?substation=$substation&fdrName=$feeder&cycle=$cycle&month=$month&year=$year',
          token);
      print(response);
      return RowMaintenanceProgressNewModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

//*****************************************************************************//
// *****************row vegetation management view***********************//
  Future<VegetationManagementDashboardModel> vegetationManagementDashboardApi(
      String action,
      String selectSpray,
      String selectMowing,
      String selectMowingNoSpray,
      String selectJaraffMowingSprayWork,
      String selectGroundWork,
      String selectJaraffMowingNoSpray,
      String selectBucketWork,
      String substation,
      String year,
      String month,
      String dateFrom,
      String dateTo,
      String token) async {
    try {
      var response = await _apiServices.getGetApiResponse(
          '${AppUrl.vegetationManagementDataEndPoint}?action=$action&selectSpray=$selectSpray&selectMowing=$selectMowing&selectMowingNoSpray=$selectMowingNoSpray&selectJaraffMowingSprayWork=$selectJaraffMowingSprayWork&selectGroundWork=$selectGroundWork&selectJaraffMowingNoSpray=$selectJaraffMowingNoSpray&selectBucketWork=$selectBucketWork&substation=$substation&year=$year&month=$month&dateFrom=$dateFrom&dateTo=$dateTo',
          token);
      return VegetationManagementDashboardModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  // *****************row vegetation management view***********************//
  Future<VegetationGrowthRateModel> vegetationGrowthRateApi(
      String year,
      String growthRate,
      String treeType,
      String zipCode,
      String season,
      String token) async {
    try {
      var response = await _apiServices.getGetApiResponse(
          '${AppUrl.vegetationGrowthRateEndPoint}?year=$year&growSpeed=$growthRate&treeType=$treeType&zipCode=$zipCode&season=$season',
          token);
      return VegetationGrowthRateModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  /// **************************Supervisor pannel ***************************
  Future<SupervisorOrderPendingModel> supervisorOrderPendingTabularDataApi(
      String token,
      String status,
      String userId,
      String changeOrder,
      String budgetType,
      String maintType) async {
    try {
      var response = await _apiServices.getGetApiResponse(
          '${AppUrl.supervisorOrderPendingTabularDataEndPoint}?status=$status&userId=$userId&changeOrder=$changeOrder&budgetType=$budgetType&maintType=$maintType',
          token);
      return SupervisorOrderPendingModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<MaintenanceReportViewModel> maintenanceReportViewTabularDataApi(
      String token,
      String type,
      String substation,
      String feeder,
      String id,
      String vFlag) async {
    try {
      var response = await _apiServices.getGetApiResponse(
          '${AppUrl.supervisorMaintenanceReportViewEndPoint}?type=$type&substation=$substation&feeder=$feeder&id=$id&vFlag=$vFlag',
          token);
      return MaintenanceReportViewModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<MaintenanceReportViewUpdateModel> maintenanceReportViewUpdateDataApi(
      String token, String status, String tokenNo, String id) async {
    try {
      dynamic response = await _apiServices.getPutApiResponse(
          '${AppUrl.supervisorMaintenanceReportViewUpdateApi}?status=$status&tokenNo=$tokenNo&id=$id',
          token);
      return response = MaintenanceReportViewUpdateModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<ContractorRowMaintenanceProgressModel>
      contractorRowMaintenanceProgressTabularDataApi(
          String token,
          String contractor,
          // String substation,
          // String feeder,
          // String nextMaintDue,
          String tokenNo) async {
    try {
      var response = await _apiServices.getGetApiResponse(
          '${AppUrl.contractorRowMaintenanceProgressEndPoint}?contractor=$contractor&tokenNo=$tokenNo',
          token);
      return ContractorRowMaintenanceProgressModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<ContractorDispatcherDashboardModel>
      contractorDispatcherDashboardTabularDataApi(
          String token, String contractorId, String vFlag) async {
    try {
      var response = await _apiServices.getGetApiResponse(
          '${AppUrl.contractorDispatcherDashboardEndPoint}?contractorId=$contractorId&vFlag=$vFlag',
          token);
      return ContractorDispatcherDashboardModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<ContractorChangeOrderPendingModel>
      contractorOrderPendingTabularDataApi(
          String token, String userId, String changeOrder) async {
    try {
      var response = await _apiServices.getGetApiResponse(
          '${AppUrl.contractorChangeOrderPendingEndPoint}?userId=$userId&changeOrder=$changeOrder',
          token);
      return ContractorChangeOrderPendingModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<ContractorChangeOrderPendingModel> contractorOrderPendingStatusApi(
      String token, String status, String notes, int id) async {
    try {
      var response = await _apiServices.getGetApiResponse(
          '${AppUrl.contractorChangeOrderPendingStatusChangeEndPoint}?status=$status&adminNotes2=$notes&tokenNo=$id',
          token);
      return ContractorChangeOrderPendingModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<ContractorChangeOrderModel> contractorChangeOrderApi(
      String token) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          AppUrl.contractorChangeOrderEndPoint, token);
      return ContractorChangeOrderModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<CreateInvoiceContractorModel> createInvoiceContractorTabularDataApi(
      String token, String substationId, String feeder) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          '${AppUrl.createInvoiceContractorEndPoint}?substationId=$substationId&feeder=$feeder',
          token);
      return CreateInvoiceContractorModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<InvoiceListModel> invoiceListTabularDataApi(String token) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          AppUrl.invoiceListEndPoint, token);
      return InvoiceListModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<InvoiceModel> invoiceDataApi(String token, String tokenNo) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          '${AppUrl.invoiceEndPoint}$tokenNo', token);
      return InvoiceModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

//******************************contractor Invoice form*********************/
  Future<InvoiceFormModel> invoiceFormSubmitApi(
      dynamic data, String token) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse1(
          AppUrl.invoiceFormSubmitApiEndPoint, data, token);
      return response = InvoiceFormModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //******************************contractor Invoice form*********************/
  Future<InvoiceCreateInvoiceModel> invoiceCreateInvoiceSubmitApi(
      dynamic data, String token) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse1(
          AppUrl.invoiceCreateInvoiceSubmitApiEndPoint, data, token);
      return response = InvoiceCreateInvoiceModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<InvoiceGetTokenModel> invoiceGetDataApi(String token) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          AppUrl.invoiceGetTokenEndPoint, token);
      return InvoiceGetTokenModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //******************************row maintenance progress contractor*********************/
  Future<RowMaintenanceProgressContractorInsertModel>
      rowMaintenanceProgressContractorSubmitListApi(
          dynamic data, String token) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse1(
          AppUrl.rowMaintenanceProgressContractorSubmitApiEndPoint,
          data,
          token);
      return response =
          RowMaintenanceProgressContractorInsertModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<RowMaintenanceImageUploadContractorModel>
      rowMaintenanceUploadImageContractorApi(dynamic data, String token) async {
    try {
      dynamic response = await _apiServices.getPutApiResponseFormData(
          AppUrl.rowMaintenanceUploadImageContractorEndPoint, data, token);
      return response =
          RowMaintenanceImageUploadContractorModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  // ********************dailyHerbicideStatusChange*************************//
  Future<DailyHerbicideModel> dailyHerbicideStatusPutDataApi(
      String token, String tokenNo, String status) async {
    try {
      dynamic response = await _apiServices.getPutApiResponse(
          '${AppUrl.dailyHerbicideStatusChangePostDataEndPoint}?tokenNo=$tokenNo&status=$status',
          token);

      return DailyHerbicideModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  // ********************IvmTimeSheetStatusChange*************************//
  Future<IvmTimeSheetModel> ivmTimesheetStatusChangePutDataApi(
      String token, String tokenNo, String status) async {
    try {
      dynamic response = await _apiServices.getPutApiResponse(
          '${AppUrl.ivmTimeSheetStatusChangePostDataEndPoint}?tokenNo=$tokenNo&status=$status',
          token);

      return IvmTimeSheetModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  // ********************IvmTimeSheetStatusChange*************************//
  Future<MixingInventoryModel> mixingInventoryStatusChangePutDataApi(
      String token, String tokenNo, String status) async {
    try {
      dynamic response = await _apiServices.getPutApiResponse(
          '${AppUrl.mixingInventoryStatusChangePostDataEndPoint}?tokenNo=$tokenNo&status=$status',
          token);

      return MixingInventoryModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  // ********************IvmTimeSheetStatusChange*************************//
  Future<SupervisorOrderPendingModel> orderPendingStatusPutDataApi(
      String token, String folowUpDate, String insp, String tokenNo) async {
    try {
      dynamic response = await _apiServices.getPutApiResponse(
          '${AppUrl.orderPendingChangePostDataEndPoint}?folowUpDate=$folowUpDate&insp=$insp&tokenNo=$tokenNo',
          token);

      return SupervisorOrderPendingModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<ImageModel> imageApi(String token, String tokenNo) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          '${AppUrl.imageEndPoint}?tokenNo=$tokenNo', token);
      return ImageModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<AccountPageModel> accountPageGetDataApi(
      String token, String email) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          '${AppUrl.accountPageEndPoint}$email', token);
      return AccountPageModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  // contractor pannel row maint progress Submit for review
  Future<ContractorRowMaintenanceProgressModel> rowMaintSubmitForReviewApi(
      String tokenNo, String id) async {
    try {
      dynamic response = await _apiServices.getPutApiResponse(
          '${AppUrl.rowMaintSubmitFprReviewEndPoint}$id', tokenNo);

      return ContractorRowMaintenanceProgressModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  ///////////////////////crew data in cards///////////////////////////////////
  Future<IVMMaintenanceTableDataModel> crewIvmMaintenanceTabularDataApi(
      String token, String contractorId) async {
    try {
      var response = await _apiServices.getGetApiResponse(
          '${AppUrl.crewIvmMaintenanceTabularDataEndPoint}?contractor=$contractorId',
          token);
      return IVMMaintenanceTableDataModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<CancelWorkForApprovalInitiatedRecordChangeOrderModel>
      iniciatedCancelWorkApprovalTabularDataApi(
          String token, String status, String id) async {
    try {
      var response = await _apiServices.getGetApiResponse(
          '${AppUrl.iniciatedCancelWorkApprovalEndPoint}?status=$status&id=$id',
          token);
      return CancelWorkForApprovalInitiatedRecordChangeOrderModel.fromJson(
          response);
    } catch (e) {
      rethrow;
    }
  }

  Future<CancelWorkForApprovalInitiatedRecordChangeOrderModel>
      crewInitiatedTabularDataApi(
          String token, String status, String id) async {
    try {
      var response = await _apiServices.getGetApiResponse(
          '${AppUrl.crewiniciatedEndPoint}?status=$status&id=$id', token);
      return CancelWorkForApprovalInitiatedRecordChangeOrderModel.fromJson(
          response);
    } catch (e) {
      rethrow;
    }
  }

  /// **************************crew change order tabular records***************************
  Future<CrewChangeOrderModel> crewChangeOrderRecordsTabularDataApi(
      String token, String crewId) async {
    try {
      var response = await _apiServices.getGetApiResponse(
          '${AppUrl.crewChangeOrderTabularDataEndPoint}?crewId=$crewId', token);
      return CrewChangeOrderModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<CancelWorkForApprovalInitiatedRecordChangeOrderModel>
      crewPendingTabularDataApi(
          String token, String status, String visibilityFlag, String id) async {
    try {
      var response = await _apiServices.getGetApiResponse(
          '${AppUrl.crewPendingEndPoint}?status=$status&visibilityFlag=$visibilityFlag&id=$id',
          token);
      return CancelWorkForApprovalInitiatedRecordChangeOrderModel.fromJson(
          response);
    } catch (e) {
      rethrow;
    }
  }

  //////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////
  //////////***********PEMC new*/
  Future<LCPDocumentApprovalPendingModel> woTabularDataApi(
      String token,
      String substation,
      String status,
      String contractorCompany,
      String feeder,
      String budgetType,
      String maintenanceType,
      String pannel) async {
    try {
      var response = await _apiServices.getGetApiResponse(
          '${AppUrl.woTabularDataEndPoint}?substation=$substation&status=$status&fdr=$feeder&maintType=$maintenanceType&panel=$pannel&contractorCompany=$contractorCompany',
          token);
      return LCPDocumentApprovalPendingModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  /// **************************DistributionIVM ***************************
  Future<LCPWorkOrdersClosedModel> distributionIVmINPROGRESSTabularDataApi(
      String token,
      String status,
      String budgetType,
      String maintType,
      String panel,
      String planType,
      String contractorCompany) async {
    try {
      var response = await _apiServices.getGetApiResponse(
          '${AppUrl.lcpWorkOrderClosedTabularDataEndPoint}?status=$status&budgetType=$budgetType&maintType=$maintType&panel=$panel&planType=$planType&contractorCompany=$contractorCompany',
          token);
      return LCPWorkOrdersClosedModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<DistributionIVMRejected> distributionIVmRejectedTabularDataApi(
      String token, String status) async {
    try {
      var response = await _apiServices.getGetApiResponse(
          '${AppUrl.disIVmREJECTEDTabularDataEndPoint}?status=$status', token);
      return DistributionIVMRejected.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
