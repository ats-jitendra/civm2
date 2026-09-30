class AppUrl {
  static var baseUrl = 'https://atsdev2test.ariespro.com/civmapi/';

  static var loginEndPoint = '${baseUrl}login';
  // static var registerEndPoint = '${baseUrl}';
  static var updatePassowrdEndPoint = '${baseUrl}change_password';

  static var progressBarRowMaintenancePlanEndPoint =
      '${baseUrl}rowMaintenancePlanTabViewAndDashboard/get_allProgressBar';

  static var listRowMaintenancePlanEndPoint =
      '${baseUrl}rowMaintenancePlanTabViewAndDashboard/row_maintenance_plan_list';
  static var admindatalist =
      '${baseUrl}rowVegetationManagementDashboard/Admindatalist';
  static var gf1Datalist =
      '${baseUrl}rowVegetationManagementDashboard/gf1Datalist';
  static var gf2Datalist =
      '${baseUrl}rowVegetationManagementDashboard/gf2Datalist';

  static var rowMaintenancePlanTabEndPoint =
      '${baseUrl}rowMaintenancePlanTabViewAndDashboard/getByYrCycleSubstationFdrROWMAINTENANCEPLAN';

  static var rowMaintenancePlanTabViewSubmitDataEndPoint =
      '${baseUrl}rowMaintenancePlanTabViewAndDashboard/getAllUpdate';

  static var addNewRowMaintenancePlanEndPoint =
      '${baseUrl}vma_row_custom_main_plan/get_allDropdownValue';

  static var lcpChangeOrderEndPoint =
      '${baseUrl}changeOrderLcpCreateOrder/createChangeOrderPageIntegratedApi';

  static var addNewRowMaintenancePlanSubmitApiEndPoint =
      '${baseUrl}vma_row_custom_main_plan/VMA_ROW_CUSTOMMAINTPLAN_INSERT';
  static var insertOrUpdateAnnualHerbicideApiEndPoint =
      '${baseUrl}maintenance/insertOrUpdateAnnualHerbicide';
  static var uploadFilesApiEndPoint = '${baseUrl}contractorPanel/uploadFiles';

  static var lcpDocumentPendingApprovalSubmitApiEndPoint =
      '${baseUrl}work_order_pending_approval/updateStatusAndAdminNotes2ByTokenNo';

  ///new

  static var getDashboardWeeklyMilesData =
      '${baseUrl}getDashboardWeeklyMilesData';
  static var getTransmissionIVMDashboardWeeklyMilesData =
      '${baseUrl}getTransmissionIVMDashboardWeeklyMilesData';
  static var getTransmissionHerbDashboardWeeklyMilesData =
      '${baseUrl}getTransmissionHerbDashboardWeeklyMilesData';

  static var getDashboardFirstGraphData =
      '${baseUrl}getDashboardFirstGraphData';
  static var getTransmissionHerbDashboardFirstGraphData =
      '${baseUrl}getTransmissionHerbDashboardFirstGraphData';
  static var getTransmissionIVMDashboardFirstGraphData =
      '${baseUrl}getTransmissionIVMDashboardFirstGraphData';

  static var getReadyForReviewData =
      '${baseUrl}workOrder/GetReadyForReviewData';
  static var assetsClientuploads =
      'https://pemccivm.ariespro.com/assets/clientuploads/';
  static var updateImageVEGETATIONCREWFORMs =
      '${baseUrl}contractorPanel/updateImageVEGETATION_CREW_FORMs';
  static var updateImageVEGETATIONCREWFORMsFORFINALSUBMIT =
      '${baseUrl}contractorPanel/updateImageVEGETATION_CREW_FORMs_FOR_FINAL_SUBMIT';

  static var approveAndSrejectPendingApprovalServiceOrder =
      '${baseUrl}changeOrderLcpCreateOrder/approve_and_sreject_pending_approval_serviceOrder';
  static var deleteFileEndPoint =
      '${baseUrl}changeOrderLcpCreateOrder/deleteFile';
  static var updateVegetationCrewFormSetStatusApprovedAndRejectedByIds =
      '${baseUrl}maintenanceReportView/updateVegetation_crew_formSetStatusApprovedAndRejectedByIds';
  static var updateVegetationCrewFormSetStatusApprovedByIdsForSingleData =
      '${baseUrl}maintenanceReportView/updateVegetation_crew_formSetStatusApprovedByIds_ForSingleData';
  static var lcpDocumentPendingApprovalSubmitAdminNewApiEndPoint =
      '${baseUrl}work_order_pending_approval/updateStatusAnd_New_AdminNotes_2ByTokenNo';

  static var lcpDocumentPendingApprovalChangeStatusApiEndPoint =
      '${baseUrl}work_order_pending_approval/updateStatusByTokenNo';

  static var lcpCreateOrderSubmitApiEndPoint =
      '${baseUrl}changeOrderLcpCreateOrder/SP_INSERT_SM_MAINT_TEST_RESULT_REQUEST';

  static var approveCIVMSubmitApiEndPoint =
      '${baseUrl}login_user/update_userByIdAnd';

  static var approveCIVMSubmitApiEndPoint2 =
      '${baseUrl}login_user/update_contractorMasterByName';

  static var approveCIVMSubmitApiEndPoint3 =
      '${baseUrl}login_user/updateSM_MAINT_TEST_RESULT_REQUESTByContractor';

  static var rowMaintenanceProgressEndPoint =
      '${baseUrl}row_maintenance_progress/ROW_MAINTENANCE_PROGRESS';

  static var rowCostAnanlysisEndPoint =
      '${baseUrl}rowCostAnalysis/rowCostAnalysis_page';

  static var lcpEndPoint =
      '${baseUrl}changeOrderLcpCreateOrder/countChangeOrders/';

  static var maintenanceAnalysisEndPoint =
      '${baseUrl}maintenanceAnalysisReport/getSP_MAINTENANCE_ANALYSIS';

  static var vegetationOutageByTypeEndPoint =
      '${baseUrl}vegetationOutageByType/getAllOutage_By_Vegetation';

  static var vegetationNormalizeEndPoint =
      '${baseUrl}vegetationNormalizeReport/getSP_VMA_VEGETATION_NORMALIZE_DYNAMIC';

  static var weatherImpactAnalysisEndPoint =
      '${baseUrl}weatherImpactAnalysis/get_data';

  static var temperatureImpactAnalysisEndPoint =
      '${baseUrl}TemperatureImpactAnalysis/getImpactAnalysis_data';

  static var rowCostAnalysisByMonthEndPoint =
      '${baseUrl}rowCostAnalysisByMonth/rowCostAnalysisByMonth_page';

  static var rowCostAnalysisBySeasonEndPoint =
      '${baseUrl}RowCostAnalysisBySeason/all_data_pages';

  static var addNewRowMaintenancePlanTabularDataEndPoint =
      '${baseUrl}vma_row_custom_main_plan/getAlls';

  static var addNewRowMaintenancePlanSprayTabularDataEndPoint =
      '${baseUrl}vma_row_custom_main_plan/getallSprayRecords';

  static var rowMaintenanceProgressDashboardEndPoint =
      '${baseUrl}row_maintenance_progress/row_maintenance_data_progress_dashboard';

  static var approveCIVMAccessTabularDataEndPoint =
      '${baseUrl}login_user/getAllSupervisorsAndContractors';

  static var lcpWorkOrderPendingTabularDataEndPoint =
      '${baseUrl}workOrderPendingAndReject/findAllTableData';

  static var lcpDocumentApprovalPendingTabularDataEndPoint =
      '${baseUrl}work_order_pending_approval/findApprovalPageData';

  static var lcpWorkOrderClosedTabularDataEndPoint =
      '${baseUrl}work_order_closed/findClosedPendingPageData';

  static var dailyHerbicideDataEndPoint =
      '${baseUrl}workOrderPendingAndReject/getAllDailyHerbicideApplicationPageDatas/';

  static var ivmTimeSheetEndPoint =
      '${baseUrl}workOrderPendingAndReject/getAllIvmTimesSheetPageDatas/';

  static var mixingInventoryDataEndPoint =
      '${baseUrl}workOrderPendingAndReject/getMixingInventoryFormDataByTokenNo/';

  static var lcpWorkOrderRejectTabularDataEndPoint =
      '${baseUrl}workOrderPendingAndReject/findPendingAndRejectAndApprovalPageData';

  static var addBudgetPlanningGetDataEndPoint =
      '${baseUrl}budgetPlanning/getBudgetPlaning1Datas';

  static var addBudgetPlanningThirdGetDataEndPoint =
      '${baseUrl}budgetPlanning/getBudgetPlannigPage3';

  static var approveCIVMPostDataEndPoint =
      '${baseUrl}login_user/updateStatusById';

  static var addCrewMemberInsertEndPoint = '${baseUrl}login_user/insertCrews';

  static var addBudgetPlanningInsertEndPoint =
      '${baseUrl}budgetPlanning/insertBUDGET_BIDSValues';

  static var addBudgetPlanningThirdInsertEndPoint =
      '${baseUrl}budgetPlanning/insertBudgetPlanSubFdrDetls';

  static var addBudgetPlanningThirdBoxInsertEndPoint =
      '${baseUrl}budgetPlanning/insertBudgetPlanDtls';

  static var addCrewMemberDeleteEndPoint = '${baseUrl}login_user/deleteById/';

  static var addBudgetPlanningDeleteEndPoint =
      '${baseUrl}budgetPlanning/deleteBUDGET_BIDSByBudgetId';

  static var addBudgetPlanningThirdDeleteEndPoint =
      '${baseUrl}budgetPlanning/deleteBUDGET_PLAN_SUB_FDR_DTLSByPlanDtlsId/';

  static var addCrewMedmberTabularDataEndPoint =
      '${baseUrl}login_user/getAllCewMemberData';

  static var rowMaintenanceProgressNewEndPoint =
      '${baseUrl}maintenanceAnalysisReport/getSP_MAINTENANCE_ANALYSIS_new';

  static var vegetationManagementDataEndPoint =
      '${baseUrl}rowVegetationManagementDashboard/getAllDefaultPageData';

  static var vegetationGrowthRateEndPoint =
      '${baseUrl}vegetationGrowthRate/findVegetationGrowthRatePagesData';

  static var supervisorOrderPendingTabularDataEndPoint =
      '${baseUrl}supervisor_workOrderPending/findAllTableData';

  static var supervisorMaintenanceReportViewEndPoint =
      '${baseUrl}maintenanceReportView/findAllJoinDatasOfReportViewPage';

  static var supervisorMaintenanceReportViewUpdateApi =
      '${baseUrl}maintenanceReportView/updateVegetation_crew_formSetStatusApprovedAndRejectedByIds';

  static var contractorRowMaintenanceProgressEndPoint =
      '${baseUrl}contractorPanel/rowMProgressPage_api';

  static var contractorDispatcherDashboardEndPoint =
      '${baseUrl}contractorDashboard/contractorDisPacherPageData';

  static var contractorChangeOrderPendingEndPoint =
      '${baseUrl}contractor_panel/findAllTableDataOfContractorPanelOfChangeOrderPending';

  static var contractorChangeOrderPendingStatusChangeEndPoint =
      '${baseUrl}contractor_panel/updateStatusAndAdminNotes2ByTokenNo';

  static var contractorChangeOrderEndPoint =
      '${baseUrl}changeOrderLcpCreateOrder/countAllChangeOrders';

  static var createInvoiceContractorEndPoint =
      '${baseUrl}createInvoice/findBySearchs';

  static var invoiceListEndPoint =
      '${baseUrl}invoice_list/findInvoiceListDatas';

  static var invoiceEndPoint = '${baseUrl}invoice_list/findInvoiceByTokenNo/';

  static var invoiceFormSubmitApiEndPoint =
      '${baseUrl}invoiceFormReport/createInvoice';

  static var invoiceCreateInvoiceSubmitApiEndPoint =
      '${baseUrl}createInvoice/createSP_VMA_EMP_INVOICE_INSERT';

  static var invoiceGetTokenEndPoint =
      '${baseUrl}createInvoice/findInvoiceCreateOrEditData';

  static var rowMaintenanceProgressContractorSubmitApiEndPoint =
      '${baseUrl}contractorPanel/insertIntoVegetationCrewForm';

  static var rowMaintenanceUploadImageContractorEndPoint =
      '${baseUrl}contractorPanel/updateImageVEGETATION_CREW_FORMs';

  static var dailyHerbicideStatusChangePostDataEndPoint =
      '${baseUrl}work_order_pending_approval/updateDailyHerbicideFormStatusByTokenNo';

  static var ivmTimeSheetStatusChangePostDataEndPoint =
      '${baseUrl}work_order_pending_approval/updateLAKE_COUNTRY_POWER_TIME_REPORTStatusByTokenNo';

  static var mixingInventoryStatusChangePostDataEndPoint =
      '${baseUrl}work_order_pending_approval/updateMIXING_INVENTORY_FORMStatusByTokenNo';

  static var orderPendingChangePostDataEndPoint =
      '${baseUrl}supervisor_workOrderPending/updateSupervisorFalowUpDateAndInspectionByTokenNo';

  static var imageEndPoint = '${baseUrl}changeOrderLcpCreateOrder/findImages';

  static var accountPageEndPoint =
      '${baseUrl}login_user/get_userDetails_by_username/';

  static var rowMaintSubmitFprReviewEndPoint =
      '${baseUrl}contractorPanel/updateStatusByIds/';

  static var crewIvmMaintenanceTabularDataEndPoint =
      '${baseUrl}contractorPanel/getAllTableData';

  static var iniciatedCancelWorkApprovalEndPoint =
      '${baseUrl}changeOrderLcpCreateOrder/getAllDataByStatus';

  static var crewChangeOrderTabularDataEndPoint =
      '${baseUrl}changeOrderLcpCreateOrder/getAllDataByCrewId';

  ///new
  static var crewiniciatedEndPoint =
      '${baseUrl}changeOrderLcpCreateOrder/GetChangeOrderByStatus_CrewId';
/////pending crew//////////////////////////////////
  static var crewPendingEndPoint =
      '${baseUrl}changeOrderLcpCreateOrder/GetChangeOrderByStatus_VisibilityFlag';

  ////////
  static var crewList = '${baseUrl}login_user/getAllCrewFromCREWMASTER';
  // static var addCrewMemberInsertEndPoint = 'https://lcpmapapi.ariespro.com/main/create_crew';

  /////////////////PEMC new////////////////////////
  static var getAllSupervisorsAndContractors =
      '${baseUrl}login_user/getAllSupervisorsAndContractors';

  static var woTabularDataEndPoint =
      '${baseUrl}work_order_closed/findClosedPendingPageData';
  static var soTabularDataEndPoint = '${baseUrl}GetServiceOrderByStatus';

  static var disIVmREJECTEDTabularDataEndPoint =
      '${baseUrl}Get_Distribution_IVM_By_Status';

  static var updateShareJobNoGF = '${baseUrl}update_Share_JobNo_GF';
  static var getServiceOrderByStatus = '${baseUrl}GetServiceOrderByStatus';
  static var crewpanelserviceordereditapi =
      '${baseUrl}work_order_pending_approval/crew_panel_service_order_edit_api';
  static var updateStatusAndCrewNotesByTokenNo =
      '${baseUrl}changeOrderLcpCreateOrder/updateStatusAndCrewNotesByTokenNo';
  static var distributionIVMShareApi =
      '${baseUrl}vma_row_custom_main_plan/distributionIVMShareApi';
  static var distributionIVMShareApiNew =
      '${baseUrl}vma_row_custom_main_plan/distributionIVMShareApiNew';
  static var shareserviceorderforreview =
      '${baseUrl}changeOrderLcpCreateOrder/share_service_order_for_review';
  static var generalForemanIVMtabdata =
      '${baseUrl}changeOrderLcpCreateOrder/generalForemanIVMtabdata';
  static var generalForemanIVMAnnualHerbicidetabdata =
      '${baseUrl}changeOrderLcpCreateOrder/generalForemanIVMAnnualHerbicidetabdata';
  static var findClosedPendingPageData =
      '${baseUrl}work_order_closed/findClosedPendingPageData';
  static var getTransmissionIVMReadyForReviewData =
      '${baseUrl}work_order_closed/getTransmissionIVMReadyForReviewData';
  static var getTransmissionIVMRejectedData =
      '${baseUrl}work_order_closed/getTransmissionIVMRejectedData';
  static var getTransmissionHerbicideData =
      '${baseUrl}Get_Transmission_Herbicide_Data';
  static var getTransmissionHerbicideDataBySTATUS =
      '${baseUrl}get_Transmission_Herbicide_Data_By_STATUS';
  static var getTransmissionReadyForReview =
      '${baseUrl}transmission_Herbicide/GetTransmissionReadyForReview';
  static var supervisorAnnualHerbicidedata =
      '${baseUrl}changeOrderLcpCreateOrder/supervisorAnnualHerbicidedata';
  static var updateCommentsAndGallonsForAnnualHerbicide =
      '${baseUrl}contractorPanel/updateCommentsAndGallonsForAnnualHerbicide';
  static var getgeneralForemanDashboardData =
      '${baseUrl}rowVegetationManagementDashboard/getgeneralForemanDashboardData';
  static var workAndServiceOrderCount =
      '${baseUrl}rowVegetationManagementDashboard/workAndServiceOrderCount';
  static var getInvoiceListReport = '${baseUrl}Invoice/getInvoiceListReport';
  static var workProgressByMaintType = '${baseUrl}login_user/workProgressByMaintType';
  static var workProgressByMiles = '${baseUrl}login_user/workProgressByMiles';
  static var deleteRecordCivm = '${baseUrl}delete_record_civm';
  static var deleteAnnualRecordCivm = '${baseUrl}delete_annual_record_civm';
  static var totalWorkProgress = '${baseUrl}login_user/totalWorkProgress';
}
