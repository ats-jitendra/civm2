// ignore: file_names
class LcpCreateOrderModel {
  List<FindTypeByCountyAndSubstationAndFeeder>?
      findTypeByCountyAndSubstationAndFeeder;
  List<ContractorGetInsert>? contractorGetInsert;
  List<GetAllLocationsListBySubstationAndStAddress>?
      getAllLocationsListBySubstationAndStAddress;
  List<FindAllIdAndSubstation>? findAllIdAndSubstation;
  List<GetAllUserNameByUserType>? getAllUserNameByUserType;
  List<GetAllStAddressListBySubstation>? getAllStAddressListBySubstation;
  List<GetIdAndFeederBySubstationId>? getIdAndFeederBySubstationId;
  List<AllCrewListOfCrewMASTER>? allCrewListOfCrewMASTER;

  List<Response>? response;

  LcpCreateOrderModel(
      {this.findTypeByCountyAndSubstationAndFeeder,
      this.contractorGetInsert,
      this.getAllLocationsListBySubstationAndStAddress,
      this.findAllIdAndSubstation,
      this.getAllUserNameByUserType,
      this.getAllStAddressListBySubstation,
      this.response,
      this.allCrewListOfCrewMASTER});

  LcpCreateOrderModel.fromJson(Map<String, dynamic> json) {
    if (json['findTypeByCountyAndSubstationAndFeeder'] != null) {
      findTypeByCountyAndSubstationAndFeeder =
          <FindTypeByCountyAndSubstationAndFeeder>[];
      json['findTypeByCountyAndSubstationAndFeeder'].forEach((v) {
        findTypeByCountyAndSubstationAndFeeder!
            .add(FindTypeByCountyAndSubstationAndFeeder.fromJson(v));
      });
    }
    if (json['contractor_get_insert'] != null) {
      contractorGetInsert = <ContractorGetInsert>[];
      json['contractor_get_insert'].forEach((v) {
        contractorGetInsert!.add(ContractorGetInsert.fromJson(v));
      });
    }
    if (json['getAllLocationsListBySubstationAndStAddress'] != null) {
      getAllLocationsListBySubstationAndStAddress =
          <GetAllLocationsListBySubstationAndStAddress>[];
      json['getAllLocationsListBySubstationAndStAddress'].forEach((v) {
        getAllLocationsListBySubstationAndStAddress!
            .add(GetAllLocationsListBySubstationAndStAddress.fromJson(v));
      });
    }
    if (json['findAllIdAndSubstation'] != null) {
      findAllIdAndSubstation = <FindAllIdAndSubstation>[];
      json['findAllIdAndSubstation'].forEach((v) {
        findAllIdAndSubstation!.add(FindAllIdAndSubstation.fromJson(v));
      });
    }
    if (json['getAllUserNameByUserType'] != null) {
      getAllUserNameByUserType = <GetAllUserNameByUserType>[];
      json['getAllUserNameByUserType'].forEach((v) {
        getAllUserNameByUserType!.add(GetAllUserNameByUserType.fromJson(v));
      });
    }
    if (json['getAllStAddressListBySubstation'] != null) {
      getAllStAddressListBySubstation = <GetAllStAddressListBySubstation>[];
      json['getAllStAddressListBySubstation'].forEach((v) {
        getAllStAddressListBySubstation!
            .add(GetAllStAddressListBySubstation.fromJson(v));
      });
    }

    if (json['getIdAndFeederBySubstationId'] != null) {
      getIdAndFeederBySubstationId = <GetIdAndFeederBySubstationId>[];
      json['getIdAndFeederBySubstationId'].forEach((v) {
        getIdAndFeederBySubstationId!
            .add(GetIdAndFeederBySubstationId.fromJson(v));
      });
    }

    if (json['response'] != null) {
      response = <Response>[];
      json['response'].forEach((v) {
        response!.add(Response.fromJson(v));
      });
    }
     if (json['AllCrewListOfCrewMASTER'] != null) {
      allCrewListOfCrewMASTER = <AllCrewListOfCrewMASTER>[];
      json['AllCrewListOfCrewMASTER'].forEach((v) {
        allCrewListOfCrewMASTER!.add(new AllCrewListOfCrewMASTER.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (findTypeByCountyAndSubstationAndFeeder != null) {
      data['findTypeByCountyAndSubstationAndFeeder'] =
          findTypeByCountyAndSubstationAndFeeder!
              .map((v) => v.toJson())
              .toList();
    }
    if (contractorGetInsert != null) {
      data['contractor_get_insert'] =
          contractorGetInsert!.map((v) => v.toJson()).toList();
    }
    if (getAllLocationsListBySubstationAndStAddress != null) {
      data['getAllLocationsListBySubstationAndStAddress'] =
          getAllLocationsListBySubstationAndStAddress!
              .map((v) => v.toJson())
              .toList();
    }
    if (findAllIdAndSubstation != null) {
      data['findAllIdAndSubstation'] =
          findAllIdAndSubstation!.map((v) => v.toJson()).toList();
    }
    if (getAllUserNameByUserType != null) {
      data['getAllUserNameByUserType'] =
          getAllUserNameByUserType!.map((v) => v.toJson()).toList();
    }
    if (getAllStAddressListBySubstation != null) {
      data['getAllStAddressListBySubstation'] =
          getAllStAddressListBySubstation!.map((v) => v.toJson()).toList();
    }
    if (getIdAndFeederBySubstationId != null) {
      data['getIdAndFeederBySubstationId'] =
          getIdAndFeederBySubstationId!.map((v) => v.toJson()).toList();
    }
    if (response != null) {
      data['response'] = response!.map((v) => v.toJson()).toList();
    }
      if (this.allCrewListOfCrewMASTER != null) {
      data['AllCrewListOfCrewMASTER'] =
          this.allCrewListOfCrewMASTER!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FindTypeByCountyAndSubstationAndFeeder {
  String? type;

  FindTypeByCountyAndSubstationAndFeeder({this.type});

  FindTypeByCountyAndSubstationAndFeeder.fromJson(Map<String, dynamic> json) {
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    return data;
  }
}

class ContractorGetInsert {
  int? loginId;
  String? name;

  ContractorGetInsert({this.loginId, this.name});

  ContractorGetInsert.fromJson(Map<String, dynamic> json) {
    loginId = json['loginId'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['loginId'] = loginId;
    data['name'] = name;
    return data;
  }
}

class GetAllLocationsListBySubstationAndStAddress {
  String? serviceAddressLocation;

  GetAllLocationsListBySubstationAndStAddress({this.serviceAddressLocation});

  GetAllLocationsListBySubstationAndStAddress.fromJson(
      Map<String, dynamic> json) {
    serviceAddressLocation = json['serviceAddressLocation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['serviceAddressLocation'] = serviceAddressLocation;
    return data;
  }
}

class FindAllIdAndSubstation {
  String? subStation;
  int? id;

  FindAllIdAndSubstation({this.subStation, this.id});

  FindAllIdAndSubstation.fromJson(Map<String, dynamic> json) {
    subStation = json['subStation'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subStation'] = subStation;
    data['id'] = id;
    return data;
  }
}

class GetAllUserNameByUserType {
  String? userName;
  int? id;

  GetAllUserNameByUserType({this.userName, this.id});

  GetAllUserNameByUserType.fromJson(Map<String, dynamic> json) {
    userName = json['UserName'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UserName'] = userName;
    data['id'] = id;
    return data;
  }
}

class GetAllStAddressListBySubstation {
  String? serviceAddress;

  GetAllStAddressListBySubstation({this.serviceAddress});

  GetAllStAddressListBySubstation.fromJson(Map<String, dynamic> json) {
    serviceAddress = json['serviceAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['serviceAddress'] = serviceAddress;
    return data;
  }
}

class Response {
  String? tokenNo;
  String? message;

  Response({this.tokenNo, this.message});

  Response.fromJson(Map<String, dynamic> json) {
    tokenNo = json['tokenNo'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tokenNo'] = tokenNo;
    data['message'] = message;
    return data;
  }
}

class GetIdAndFeederBySubstationId {
  String? feeder;
  int? id;

  GetIdAndFeederBySubstationId({this.feeder, this.id});

  GetIdAndFeederBySubstationId.fromJson(Map<String, dynamic> json) {
    feeder = json['feeder'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['feeder'] = feeder;
    data['id'] = id;
    return data;
  }
}
class AllCrewListOfCrewMASTER {
  int? loginId;
  int? contractorId;
  String? name;
  int? id;

  AllCrewListOfCrewMASTER(
      {this.loginId, this.contractorId, this.name, this.id});

  AllCrewListOfCrewMASTER.fromJson(Map<String, dynamic> json) {
    loginId = json['loginId'];
    contractorId = json['contractorId'];
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['loginId'] = loginId;
    data['contractorId'] = contractorId;
    data['name'] = name;
    data['id'] = id;
    return data;
  }}