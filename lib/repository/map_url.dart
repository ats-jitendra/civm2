class MapUrl {
  static var baseUrl = 'https://lcpmapapi.ariespro.com/main/';

// crew dashboard
  static String getCrewWithIdEndPoint(String id) {
    return '${baseUrl}crew_main/CIVM_Map/USRQWXH589Z/$id';
  }

// work order number, it is accessed from the form
  static String getCrewWithWorkOrderNoEndPoint(String tokenNo,String id) {
    return '${baseUrl}crew/CIVM_Map/$tokenNo/USRQWXH589Z/$id';
  }

  static String getSupervisorEndPoint(String tokenNo,String id) {
    return '${baseUrl}supervisor/CIVM_Map/$tokenNo/USRQWXH589Z/$id';
  }

  static String getPlannerWithoutTokenEndPoint(String id) {
    return '${baseUrl}planner/CIVM_Map/USRQWXH589Z/$id';
  }

  static String getPlannerSprayWithoutTokenEndPoint(String id) {
    return '${baseUrl}spray_map/CIVM_Map/USRQWXH589Z/$id';
  }

  static String getPlannerWithTokenEndPoint(String tokenNo,String id) {
    return '${baseUrl}planner/CIVM_Map/$tokenNo/USRQWXH589Z/$id';
  }

  static String getAdminEndPoint(String tokenNo,String id) {
    return '${baseUrl}admin/CIVM_Map/$tokenNo/USRQWXH589Z/$id';
  }

  static String getGfEndPoint(String tokenNo,String id) {
    return '${baseUrl}contractor/CIVM_Map/$tokenNo/USRQWXH589Z/$id';
  }
  
  static String getCrewEndPoint(String tokenNo,String id) {
    return '${baseUrl}crew/CIVM_Map/$tokenNo/USRQWXH589Z/$id';
  }

   static String getCreateChangeOrderFromPlannerEndPoint(String id) {
    return '${baseUrl}planner_change_order/CIVM_Map/USRQWXH589Z/$id';
  }
  ///new crew
  //   static String getCrewInitiatedEndPoint(String tokenNo,String id) {
  //   return '${baseUrl}planner/CIVM_Map/$tokenNo/USRQWXH589Z/$id';
  // }
}


//   https://lcpmapapi.ariespro.com/main/planner/CIVM_Map/USRQWXH589Z