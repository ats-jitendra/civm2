class AddCrewMemberModel {
  List<GetaAllCewMemberTableDatas>? getaAllCewMemberTableDatas;
  List<ContractorListNameId>? contractorListNameId;

  AddCrewMemberModel(
      {this.getaAllCewMemberTableDatas, this.contractorListNameId});

  AddCrewMemberModel.fromJson(Map<String, dynamic> json) {
    if (json['getaAllCewMemberTableDatas'] != null) {
      getaAllCewMemberTableDatas = <GetaAllCewMemberTableDatas>[];
      json['getaAllCewMemberTableDatas'].forEach((v) {
        getaAllCewMemberTableDatas!
            .add(GetaAllCewMemberTableDatas.fromJson(v));
      });
    }
    if (json['contractorListNameId'] != null) {
      contractorListNameId = <ContractorListNameId>[];
      json['contractorListNameId'].forEach((v) {
        contractorListNameId!.add(ContractorListNameId.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getaAllCewMemberTableDatas != null) {
      data['getaAllCewMemberTableDatas'] =
          getaAllCewMemberTableDatas!.map((v) => v.toJson()).toList();
    }
    if (contractorListNameId != null) {
      data['contractorListNameId'] =
          contractorListNameId!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetaAllCewMemberTableDatas {
  String? contractor;
  String? lName;
  String? crewType;
  String? fName;
  String? name;
  int? id;
  String? supervisor;
  String? status;

  GetaAllCewMemberTableDatas(
      {this.contractor,
      this.lName,
      this.crewType,
      this.fName,
      this.name,
      this.id,
      this.supervisor,
      this.status});

  GetaAllCewMemberTableDatas.fromJson(Map<String, dynamic> json) {
    contractor = json['contractor'];
    lName = json['lName'];
    crewType = json['crewType'];
    fName = json['fName'];
    name = json['name'];
    id = json['id'];
    supervisor = json['supervisor'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['contractor'] = contractor;
    data['lName'] = lName;
    data['crewType'] = crewType;
    data['fName'] = fName;
    data['name'] = name;
    data['id'] = id;
    data['supervisor'] = supervisor;
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
