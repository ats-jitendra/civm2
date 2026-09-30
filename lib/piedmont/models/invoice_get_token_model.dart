class InvoiceGetTokenModel {
  List<FindAllIdByStatusClosedList>? findAllIdByStatusClosedList;

  InvoiceGetTokenModel({this.findAllIdByStatusClosedList});

  InvoiceGetTokenModel.fromJson(Map<String, dynamic> json) {
    if (json['findAllIdByStatusClosedList'] != null) {
      findAllIdByStatusClosedList = <FindAllIdByStatusClosedList>[];
      json['findAllIdByStatusClosedList'].forEach((v) {
        findAllIdByStatusClosedList!
            .add(FindAllIdByStatusClosedList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (findAllIdByStatusClosedList != null) {
      data['findAllIdByStatusClosedList'] =
          findAllIdByStatusClosedList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FindAllIdByStatusClosedList {
  int? id;

  FindAllIdByStatusClosedList({this.id});

  FindAllIdByStatusClosedList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    return data;
  }
}
