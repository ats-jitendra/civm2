class InvoiceFormModel {
  int? id;
  String? contractorName;
  String? date;
  String? drawId;
  String? invoiceId;
  String? contractId;
  String? location;
  String? itemId;
  String? itemDescription;
  String? contractAmount;
  String? completedToDate;
  String? retaInAge;
  String? lessPreviousBillings;
  String? totalThisInvoceLseeRetaInAge;
  String? amountSubTotal;
  String? amountDueThisInvoice;

  InvoiceFormModel(
      {this.id,
      this.contractorName,
      this.date,
      this.drawId,
      this.invoiceId,
      this.contractId,
      this.location,
      this.itemId,
      this.itemDescription,
      this.contractAmount,
      this.completedToDate,
      this.retaInAge,
      this.lessPreviousBillings,
      this.totalThisInvoceLseeRetaInAge,
      this.amountSubTotal,
      this.amountDueThisInvoice});

  InvoiceFormModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    contractorName = json['contractorName'];
    date = json['date'];
    drawId = json['drawId'];
    invoiceId = json['invoiceId'];
    contractId = json['contractId'];
    location = json['location'];
    itemId = json['itemId'];
    itemDescription = json['itemDescription'];
    contractAmount = json['contractAmount'];
    completedToDate = json['completedToDate'];
    retaInAge = json['retaInAge'];
    lessPreviousBillings = json['lessPreviousBillings'];
    totalThisInvoceLseeRetaInAge = json['totalThisInvoceLseeRetaInAge'];
    amountSubTotal = json['amountSubTotal'];
    amountDueThisInvoice = json['amountDueThisInvoice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['contractorName'] = contractorName;
    data['date'] = date;
    data['drawId'] = drawId;
    data['invoiceId'] = invoiceId;
    data['contractId'] = contractId;
    data['location'] = location;
    data['itemId'] = itemId;
    data['itemDescription'] = itemDescription;
    data['contractAmount'] = contractAmount;
    data['completedToDate'] = completedToDate;
    data['retaInAge'] = retaInAge;
    data['lessPreviousBillings'] = lessPreviousBillings;
    data['totalThisInvoceLseeRetaInAge'] = totalThisInvoceLseeRetaInAge;
    data['amountSubTotal'] = amountSubTotal;
    data['amountDueThisInvoice'] = amountDueThisInvoice;
    return data;
  }
}
