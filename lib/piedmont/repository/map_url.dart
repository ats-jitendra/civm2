class MapUrl {
  static var baseUrl = 'https://atsdev3test.ariespro.com/main/';

  // crew dashboard
  static String getCrewWithIdEndPoint(String id) {
    return '${baseUrl}crew_main/CIVM_Map/USRQWXH589Z/$id';
  }

  // work order number, it is accessed from the form
  static String getCrewWithWorkOrderNoEndPoint(String tokenNo, String id) {
    return '${baseUrl}crew/CIVM_Map/$tokenNo/USRQWXH589Z/$id';
  }

  static String getSupervisorEndPoint(String tokenNo, String id) {
    return '${baseUrl}supervisor/CIVM_Map/$tokenNo/USRQWXH589Z/$id';
  }

  static String getsupervisorTransEndPoint(String tokenNo, String id) {
    return '${baseUrl}supervisor_trans/CIVM_Map/$tokenNo/USRQWXH589Z/$id';
  }

  static String getsupervisorPemcEndPoint(String tokenNo, String id) {
    return '${baseUrl}supervisor_pemc/CIVM_Map/$tokenNo/USRQWXH589Z/$id';
  }

  static String getcontractorPemcEndPoint(String tokenNo, String id) {
    return '${baseUrl}contractor_pemc/CIVM_Map/$tokenNo/USRQWXH589Z/$id';
  }

  static String getPlannerWithoutTokenEndPoint(String id) {
    return '${baseUrl}planner/CIVM_Map/USRQWXH589Z/$id';
  }

  static String getPlannerSprayWithoutTokenEndPoint(String id) {
    return '${baseUrl}spray_map/CIVM_Map/USRQWXH589Z/$id';
  }

  static String getPlannerWithTokenEndPoint(String tokenNo, String id) {
    return '${baseUrl}planner/CIVM_Map/$tokenNo/USRQWXH589Z/$id';
  }

  static String getAdminEndPoint(String tokenNo, String id) {
    return '${baseUrl}admin/CIVM_Map/$tokenNo/USRQWXH589Z/$id';
  }

  static String getGfEndPoint(String tokenNo, String id) {
    return '${baseUrl}contractor/CIVM_Map/$tokenNo/USRQWXH589Z/$id';
  }

  static String getcontractorTransEndPoint(String tokenNo, String id) {
    return '${baseUrl}contractor_trans/CIVM_Map/$tokenNo/USRQWXH589Z/$id';
  }

  static String supervisorTransEndPoint(String tokenNo, String id) {
    return '${baseUrl}supervisor_trans/CIVM_Map/$tokenNo/USRQWXH589Z/$id';
  }

  static String adminTransEndPoint(String tokenNo, String id) {
    return '${baseUrl}admin_trans/CIVM_Map/$tokenNo/USRQWXH589Z/$id';
  }

  static String getcontractorEndPoint(String tokenNo, String id) {
    return '${baseUrl}contractor/CIVM_Map/$tokenNo/USRQWXH589Z/$id';
  }

  static String getCreateChangeOrderFromPlannerEndPoint(String id) {
    return '${baseUrl}planner_change_order/CIVM_Map/USRQWXH589Z/$id';
  }

  static String getPlannerDistributionMapEndPoint(String id) {
    return '${baseUrl}pemc_ivm_map/CIVM_Map/USRQWXH589Z/$id';
  }

  static String getPlannerTransmissionMapEndPoint(String id) {
    return '${baseUrl}transmission_map/CIVM_Map/USRQWXH589Z/$id';
  }

  static String midTransmissionMapEndPoint(String id) {
    return '${baseUrl}mid_transmission_map/CIVM_Map/USRQWXH589Z/$id';
  }

  static String officeTransmissionMapEndPoint(String id) {
    return '${baseUrl}office_transmission_map/CIVM_Map/USRQWXH589Z/$id';
  }

  ////so map url
   static String adminServiceMapEndPoint(String id, String soNo) {
    return '${baseUrl}admin_service/CIVM_Map/$soNo/USRQWXH589Z/$id';
  }
  static String supervisorServiceMapEndPoint(String id, String soNo) {
    return '${baseUrl}supervisor_service/CIVM_Map/$soNo/USRQWXH589Z/$id';
  }

  static String foremanServiceMapEndPoint(String id, String soNo) {
    return '${baseUrl}foreman_service/CIVM_Map/$soNo/USRQWXH589Z/$id';
  }
}


//   https://lcpmapapi.ariespro.com/main/planner/CIVM_Map/USRQWXH589Z