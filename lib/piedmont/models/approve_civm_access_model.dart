class ApproveCIVMAccessModel {
  List<ContractorMasterDataList>? contractorMasterDataList;
  LoginData? loginData;
  List<FindAllSupervisorList>? findAllSupervisorList;
  List<FindAllContractorList>? findAllContractorList;
  List<ContractorListNameId>? contractorListNameId;
  List<GetAllAssignToContractorList>? getAllAssignToContractorList;

  ApproveCIVMAccessModel(
      {this.contractorMasterDataList,
      this.loginData,
      this.findAllSupervisorList,
      this.findAllContractorList,
      this.contractorListNameId,
      this.getAllAssignToContractorList});

  ApproveCIVMAccessModel.fromJson(Map<String, dynamic> json) {
    if (json['ContractorMasterDataList'] != null) {
      contractorMasterDataList = <ContractorMasterDataList>[];
      json['ContractorMasterDataList'].forEach((v) {
        contractorMasterDataList!.add(ContractorMasterDataList.fromJson(v));
      });
    }
    loginData = json['LoginData'] != null
        ? LoginData.fromJson(json['LoginData'])
        : null;
    if (json['findAllSupervisorList'] != null) {
      findAllSupervisorList = <FindAllSupervisorList>[];
      json['findAllSupervisorList'].forEach((v) {
        findAllSupervisorList!.add(FindAllSupervisorList.fromJson(v));
      });
    }
    if (json['findAllContractorList'] != null) {
      findAllContractorList = <FindAllContractorList>[];
      json['findAllContractorList'].forEach((v) {
        findAllContractorList!.add(FindAllContractorList.fromJson(v));
      });
    }
    if (json['contractorListNameId'] != null) {
      contractorListNameId = <ContractorListNameId>[];
      json['contractorListNameId'].forEach((v) {
        contractorListNameId!.add(ContractorListNameId.fromJson(v));
      });
    }
    if (json['getAllAssignToContractorList'] != null) {
      getAllAssignToContractorList = <GetAllAssignToContractorList>[];
      json['getAllAssignToContractorList'].forEach((v) {
        getAllAssignToContractorList!
            .add(GetAllAssignToContractorList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (contractorMasterDataList != null) {
      data['ContractorMasterDataList'] =
          contractorMasterDataList!.map((v) => v.toJson()).toList();
    }
    if (loginData != null) {
      data['LoginData'] = loginData!.toJson();
    }
    if (findAllSupervisorList != null) {
      data['findAllSupervisorList'] =
          findAllSupervisorList!.map((v) => v.toJson()).toList();
    }
    if (findAllContractorList != null) {
      data['findAllContractorList'] =
          findAllContractorList!.map((v) => v.toJson()).toList();
    }
    if (contractorListNameId != null) {
      data['contractorListNameId'] =
          contractorListNameId!.map((v) => v.toJson()).toList();
    }
    if (getAllAssignToContractorList != null) {
      data['getAllAssignToContractorList'] =
          getAllAssignToContractorList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetAllAssignToContractorList {
  String? name;
  int? id;

  GetAllAssignToContractorList({this.name, this.id});

  GetAllAssignToContractorList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    return data;
  }
}

class FindAllContractorList {
  String? lName;
  String? fName;
  String? role;
  String? adminId;
  int? id;
  String? userName;
  String? email;
  String? status;

  FindAllContractorList(
      {this.lName,
      this.fName,
      this.role,
      this.adminId,
      this.id,
      this.userName,
      this.email,
      this.status});

  FindAllContractorList.fromJson(Map<String, dynamic> json) {
    lName = json['lName'];
    fName = json['fName'];
    role = json['role'];
    adminId = json['adminId'];
    id = json['id'];
    userName = json['userName'];
    email = json['email'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lName'] = lName;
    data['fName'] = fName;
    data['role'] = role;
    data['adminId'] = adminId;
    data['id'] = id;
    data['userName'] = userName;
    data['email'] = email;
    data['status'] = status;
    return data;
  }
}

// class ContractorMasterDataList {
//   ContractorMasterData? contractorMasterData;

//   ContractorMasterDataList({this.contractorMasterData});

//   ContractorMasterDataList.fromJson(Map<String, dynamic> json) {
//     contractorMasterData = json['ContractorMasterData'] != null
//         ? ContractorMasterData.fromJson(json['ContractorMasterData'])
//         : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (contractorMasterData != null) {
//       data['ContractorMasterData'] = contractorMasterData!.toJson();
//     }
//     return data;
//   }
// }

// class ContractorMasterData {
//   int? id;
//   String? name;
//   int? supervisorId;
//   int? loginId;

//   ContractorMasterData({this.id, this.name, this.supervisorId, this.loginId});

//   ContractorMasterData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     supervisorId = json['supervisorId'];
//     loginId = json['loginId'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['name'] = name;
//     data['supervisorId'] = supervisorId;
//     data['loginId'] = loginId;
//     return data;
//   }
// }

class ContractorMasterDataList {
  int? iD;
  String? nAME;
  int? sUPERVISOR;
  int? lOGINID;
  int? sUPERVISORID;
  String? cONTRACTORCOMPANY;

  ContractorMasterDataList(
      {this.iD,
      this.nAME,
      this.sUPERVISOR,
      this.lOGINID,
      this.sUPERVISORID,
      this.cONTRACTORCOMPANY});

  ContractorMasterDataList.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    nAME = json['NAME'];
    sUPERVISOR = json['SUPERVISOR'];
    lOGINID = json['LOGIN_ID'];
    sUPERVISORID = json['SUPERVISOR_ID'];
    cONTRACTORCOMPANY = json['CONTRACTOR_COMPANY'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['NAME'] = nAME;
    data['SUPERVISOR'] = sUPERVISOR;
    data['LOGIN_ID'] = lOGINID;
    data['SUPERVISOR_ID'] = sUPERVISORID;
    data['CONTRACTOR_COMPANY'] = cONTRACTORCOMPANY;
    return data;
  }
}


class LoginData {
  int? id;
  String? userName;
  String? password;
  String? userType;
  String? fName;
  String? lName;
  String? mobile;
  String? email;
  String? address;
  String? dob;
  String? profilePhoto;
  String? createDtm;
  String? status;

  LoginData(
      {this.id,
      this.userName,
      this.password,
      this.userType,
      this.fName,
      this.lName,
      this.mobile,
      this.email,
      this.address,
      this.dob,
      this.profilePhoto,
      this.createDtm,
      this.status});

  LoginData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    password = json['password'];
    userType = json['userType'];
    fName = json['fName'];
    lName = json['lName'];
    mobile = json['mobile'];
    email = json['email'];
    address = json['address'];
    dob = json['dob'];
    profilePhoto = json['profilePhoto'];
    createDtm = json['createDtm'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userName'] = userName;
    data['password'] = password;
    data['userType'] = userType;
    data['fName'] = fName;
    data['lName'] = lName;
    data['mobile'] = mobile;
    data['email'] = email;
    data['address'] = address;
    data['dob'] = dob;
    data['profilePhoto'] = profilePhoto;
    data['createDtm'] = createDtm;
    data['status'] = status;
    return data;
  }
}

class FindAllSupervisorList {
  String? lName;
  String? fName;
  String? role;
  String? adminId;
  int? id;
  String? userName;
  String? email;
  String? status;

  FindAllSupervisorList(
      {this.lName,
      this.fName,
      this.role,
      this.adminId,
      this.id,
      this.userName,
      this.email,
      this.status});

  FindAllSupervisorList.fromJson(Map<String, dynamic> json) {
    lName = json['lName'];
    fName = json['fName'];
    role = json['role'];
    adminId = json['adminId'];
    id = json['id'];
    userName = json['userName'];
    email = json['email'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lName'] = lName;
    data['fName'] = fName;
    data['role'] = role;
    data['adminId'] = adminId;
    data['id'] = id;
    data['userName'] = userName;
    data['email'] = email;
    data['status'] = status;
    return data;
  }
}

class ContractorListNameId {
  String? name;
  int? id;

  ContractorListNameId({this.name, this.id});

  ContractorListNameId.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    return data;
  }
}
