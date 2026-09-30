class MixingInventoryModel {
  List<GetChemicalQuantity>? getChemicalQuantity;
  List<GetAllChemicalDescriptions>? getAllChemicalDescriptions;
  List<GetMixingInventoryFormDataOfChemicalQntityByOrderNo>?
      getMixingInventoryFormDataOfChemicalQntityByOrderNo;

  MixingInventoryModel(
      {this.getChemicalQuantity,
      this.getAllChemicalDescriptions,
      this.getMixingInventoryFormDataOfChemicalQntityByOrderNo});

  MixingInventoryModel.fromJson(Map<String, dynamic> json) {
    if (json['getChemicalQuantity'] != null) {
      getChemicalQuantity = <GetChemicalQuantity>[];
      json['getChemicalQuantity'].forEach((v) {
        getChemicalQuantity!.add(GetChemicalQuantity.fromJson(v));
      });
    }
    if (json['getAllChemicalDescriptions'] != null) {
      getAllChemicalDescriptions = <GetAllChemicalDescriptions>[];
      json['getAllChemicalDescriptions'].forEach((v) {
        getAllChemicalDescriptions!
            .add(GetAllChemicalDescriptions.fromJson(v));
      });
    }
    if (json['getMixingInventoryFormDataOfChemicalQntityByOrderNo'] != null) {
      getMixingInventoryFormDataOfChemicalQntityByOrderNo =
          <GetMixingInventoryFormDataOfChemicalQntityByOrderNo>[];
      json['getMixingInventoryFormDataOfChemicalQntityByOrderNo'].forEach((v) {
        getMixingInventoryFormDataOfChemicalQntityByOrderNo!.add(
            GetMixingInventoryFormDataOfChemicalQntityByOrderNo.fromJson(
                v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getChemicalQuantity != null) {
      data['getChemicalQuantity'] =
          getChemicalQuantity!.map((v) => v.toJson()).toList();
    }
    if (getAllChemicalDescriptions != null) {
      data['getAllChemicalDescriptions'] =
          getAllChemicalDescriptions!.map((v) => v.toJson()).toList();
    }
    if (getMixingInventoryFormDataOfChemicalQntityByOrderNo != null) {
      data['getMixingInventoryFormDataOfChemicalQntityByOrderNo'] = getMixingInventoryFormDataOfChemicalQntityByOrderNo!
          .map((v) => v.toJson())
          .toList();
    }
    return data;
  }
}

class GetChemicalQuantity {
  String? date;
  String? weekStartDate;
  String? utility;
  int? id;
  String? workOrderNo;
  String? forMan;
  String? weekEndDate;
  String? status;

  GetChemicalQuantity(
      {this.date,
      this.weekStartDate,
      this.utility,
      this.id,
      this.workOrderNo,
      this.forMan,
      this.weekEndDate,
      this.status});

  GetChemicalQuantity.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    weekStartDate = json['weekStartDate'];
    utility = json['utility'];
    id = json['id'];
    workOrderNo = json['workOrderNo'];
    forMan = json['forMan'];
    weekEndDate = json['weekEndDate'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['weekStartDate'] = weekStartDate;
    data['utility'] = utility;
    data['id'] = id;
    data['workOrderNo'] = workOrderNo;
    data['forMan'] = forMan;
    data['weekEndDate'] = weekEndDate;
    data['status'] = status;
    return data;
  }
}

class GetAllChemicalDescriptions {
  String? formId;
  String? date;
  String? batch;
  List<GetChemicalNameAmtList>? getChemicalNameAmtList;
  int? id;
  String? time;
  String? water;
  String? waterAmt;

  GetAllChemicalDescriptions(
      {this.formId,
      this.date,
      this.batch,
      this.getChemicalNameAmtList,
      this.id,
      this.time,
      this.water,
      this.waterAmt});

  GetAllChemicalDescriptions.fromJson(Map<String, dynamic> json) {
    formId = json['formId'];
    date = json['date'];
    batch = json['batch'];
    if (json['getChemicalNameAmtList'] != null) {
      getChemicalNameAmtList = <GetChemicalNameAmtList>[];
      json['getChemicalNameAmtList'].forEach((v) {
        getChemicalNameAmtList!.add(GetChemicalNameAmtList.fromJson(v));
      });
    }
    id = json['id'];
    time = json['time'];
    water = json['water'];
    waterAmt = json['waterAmt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['formId'] = formId;
    data['date'] = date;
    data['batch'] = batch;
    if (getChemicalNameAmtList != null) {
      data['getChemicalNameAmtList'] =
          getChemicalNameAmtList!.map((v) => v.toJson()).toList();
    }
    data['id'] = id;
    data['time'] = time;
    data['water'] = water;
    data['waterAmt'] = waterAmt;
    return data;
  }
}

class GetChemicalNameAmtList {
  String? amount;
  String? name;

  GetChemicalNameAmtList({this.amount, this.name});

  GetChemicalNameAmtList.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['name'] = name;
    return data;
  }
}

class GetMixingInventoryFormDataOfChemicalQntityByOrderNo {
  String? formId;
  String? endWeekAmt;
  String? name;
  String? start;
  String? end;
  int? id;
  String? startWeekAmt;

  GetMixingInventoryFormDataOfChemicalQntityByOrderNo(
      {this.formId,
      this.endWeekAmt,
      this.name,
      this.start,
      this.end,
      this.id,
      this.startWeekAmt});

  GetMixingInventoryFormDataOfChemicalQntityByOrderNo.fromJson(
      Map<String, dynamic> json) {
    formId = json['formId'];
    endWeekAmt = json['endWeekAmt'];
    name = json['name'];
    start = json['start'];
    end = json['end'];
    id = json['id'];
    startWeekAmt = json['startWeekAmt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['formId'] = formId;
    data['endWeekAmt'] = endWeekAmt;
    data['name'] = name;
    data['start'] = start;
    data['end'] = end;
    data['id'] = id;
    data['startWeekAmt'] = startWeekAmt;
    return data;
  }
}
