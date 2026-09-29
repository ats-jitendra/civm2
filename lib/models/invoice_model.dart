class InvoiceModel {
  List<FindInvoiceByTokenNo>? findInvoiceByTokenNo;

  InvoiceModel({this.findInvoiceByTokenNo});

  InvoiceModel.fromJson(Map<String, dynamic> json) {
    if (json['findInvoiceByTokenNo'] != null) {
      findInvoiceByTokenNo = <FindInvoiceByTokenNo>[];
      json['findInvoiceByTokenNo'].forEach((v) {
        findInvoiceByTokenNo!.add(FindInvoiceByTokenNo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (findInvoiceByTokenNo != null) {
      data['findInvoiceByTokenNo'] =
          findInvoiceByTokenNo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FindInvoiceByTokenNo {
  double? workingHrs;
  String? empType;
  int? tokenNo;
  double? hrlyRate;
  String? invoiceDate;
  double? invoiceTotal;
  String? vmaMaintTimeSheetId;
  String? empName;
  double? laborCost;
  double? laborTotal;
  int? invoiceNo;
  String? workOrderNo;
  String? createDate;

  FindInvoiceByTokenNo(
      {this.workingHrs,
      this.empType,
      this.tokenNo,
      this.hrlyRate,
      this.invoiceDate,
      this.invoiceTotal,
      this.vmaMaintTimeSheetId,
      this.empName,
      this.laborCost,
      this.laborTotal,
      this.invoiceNo,
      this.workOrderNo,
      this.createDate});

  FindInvoiceByTokenNo.fromJson(Map<String, dynamic> json) {
    workingHrs = json['workingHrs'];
    empType = json['empType'];
    tokenNo = json['tokenNo'];
    hrlyRate = json['hrlyRate'];
    invoiceDate = json['invoiceDate'];
    invoiceTotal = json['invoiceTotal'];
    vmaMaintTimeSheetId = json['vmaMaintTimeSheetId'];
    empName = json['empName'];
    laborCost = json['laborCost'];
    laborTotal = json['laborTotal'];
    invoiceNo = json['invoiceNo'];
    workOrderNo = json['workOrderNo'];
    createDate = json['createDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['workingHrs'] = workingHrs;
    data['empType'] = empType;
    data['tokenNo'] = tokenNo;
    data['hrlyRate'] = hrlyRate;
    data['invoiceDate'] = invoiceDate;
    data['invoiceTotal'] = invoiceTotal;
    data['vmaMaintTimeSheetId'] = vmaMaintTimeSheetId;
    data['empName'] = empName;
    data['laborCost'] = laborCost;
    data['laborTotal'] = laborTotal;
    data['invoiceNo'] = invoiceNo;
    data['workOrderNo'] = workOrderNo;
    data['createDate'] = createDate;
    return data;
  }
}
