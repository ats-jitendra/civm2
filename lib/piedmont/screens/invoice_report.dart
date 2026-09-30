import 'package:flutter/material.dart';

class InvoiceReport extends StatefulWidget {
  const InvoiceReport({Key? key}) : super(key: key);

  @override
  State<InvoiceReport> createState() => _InvoiceReportState();
}

class _InvoiceReportState extends State<InvoiceReport> {
  final contractor = ['Robert Dean'];
  String? value;

  @override
  Widget build(BuildContext context) {
    Color hexToColor(String code) {
      return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      // drawer: DrawerClass(),
      appBar: AppBar(iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Invoice Report',
            style: TextStyle(color: Colors.white),),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: Row(
                  children: [
                    const Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              "Contractor : ",
                              style:
                                  TextStyle(fontSize: 18.0, color: Colors.blue),
                            ),
                          )),
                    ),
                    Expanded(
                        child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.5),
                            border: Border.all(
                                color: const Color.fromARGB(255, 136, 130, 130)),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              hint: const Text('Select Contractor'),
                              value: value,
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black,
                              ),
                              isExpanded: true,
                              items: contractor.map(buildMenuItem).toList(),
                              onChanged: (value) =>
                                  setState(() => this.value = value),
                            ),
                          ),
                        ),
                      ),
                    ))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: Row(children: [
                  const Expanded(
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Text(
                            "Date : ",
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.blue),
                          ),
                        )),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: TextField(
                          // getCurrentDate1(),
                          enabled: false,
                          obscureText: false,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: getCurrentDate(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
              Container(
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: const Row(children: [
                  Expanded(
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Text(
                            "Draw ID : ",
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.blue),
                          ),
                        )),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.all(2.0),
                        child: TextField(
                          obscureText: false,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Draw ID ',
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
              Container(
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: const Row(children: [
                  Expanded(
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Text(
                            "Invoive ID : ",
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.blue),
                          ),
                        )),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.all(2.0),
                        child: TextField(
                          obscureText: false,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Invoice ID ',
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
              Container(
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: const Row(children: [
                  Expanded(
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Text(
                            "Contract ID : ",
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.blue),
                          ),
                        )),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.all(2.0),
                        child: TextField(
                          obscureText: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Contract ID ',
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
              Container(
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: const Row(children: [
                  Expanded(
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Text(
                            "Location : ",
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.blue),
                          ),
                        )),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.all(2.0),
                        child: TextField(
                          obscureText: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Location ',
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
              Container(
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: const Row(children: [
                  Expanded(
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Text(
                            "Item ID : ",
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.blue),
                          ),
                        )),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.all(2.0),
                        child: TextField(
                          obscureText: false,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Item ID ',
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
              Container(
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: const Row(children: [
                  Expanded(
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Text(
                            "Item Description : ",
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.blue),
                          ),
                        )),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.all(2.0),
                        child: TextField(
                          obscureText: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Item Description ',
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
              Container(
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: const Row(children: [
                  Expanded(
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Text(
                            "Contract amount : ",
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.blue),
                          ),
                        )),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.all(2.0),
                        child: TextField(
                          obscureText: false,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Contract amount ',
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
              Container(
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: const Row(children: [
                  Expanded(
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Text(
                            "Completed to Date : ",
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.blue),
                          ),
                        )),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.all(2.0),
                        child: TextField(
                          obscureText: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Completed to Date ',
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
              Container(
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: const Row(children: [
                  Expanded(
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Text(
                            "Retainage : ",
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.blue),
                          ),
                        )),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.all(2.0),
                        child: TextField(
                          obscureText: false,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Retainage ',
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
              Container(
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: const Row(children: [
                  Expanded(
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Text(
                            "Less Previous Billings : ",
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.blue),
                          ),
                        )),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.all(2.0),
                        child: TextField(
                          obscureText: false,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Less Previous Billings ',
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
              Container(
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: const Row(children: [
                  Expanded(
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Text(
                            "Total this invoice lsee retainage : ",
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.blue),
                          ),
                        )),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.all(2.0),
                        child: TextField(
                          obscureText: false,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Total this invoice lsee retainage ',
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
              Container(
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: const Row(children: [
                  Expanded(
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Text(
                            "Amount Sub Total : ",
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.blue),
                          ),
                        )),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.all(2.0),
                        child: TextField(
                          obscureText: false,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Amount Sub Total ',
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
              Container(
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: const Row(children: [
                  Expanded(
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Text(
                            "Amount Due this invoice : ",
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.blue),
                          ),
                        )),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.all(2.0),
                        child: TextField(
                          obscureText: false,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Amount Due this invoice ',
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
              Container(
                  margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                  child: InkWell(
                    onTap: () {
                      _showSubmitDataDialog();
                    },
                    child: Container(
                      margin: const EdgeInsets.only(
                          left: 40, right: 40, bottom: 10.0),
                      padding: const EdgeInsets.all(8),
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      decoration: BoxDecoration(
                          // shape: BoxShape.circle,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.blue,
                                blurRadius: 5,
                                offset: Offset(2.0, 5.0))
                          ],
                          color: Colors.blue,
                          gradient: const LinearGradient(
                            colors: [Colors.blue, Colors.blue],
                          )),
                      child: const Row(children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Submit",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(item,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 20,
          )));

  String getCurrentDate() {
    var date = DateTime.now().toString();

    var dateParse = DateTime.parse(date);

    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
    return formattedDate.toString();
  }

  void _showSubmitDataDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return Container(
            child: AlertDialog(
              title: const Text('Are you sure to submit?'),
              // content: Text("Are you sure to submit?"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("NO")),
                TextButton(
                    onPressed: () {
                      // sendData();
                      Navigator.pop(context);
                    },
                    child: const Text("Yes")),
              ],
            ),
          );
        });
  }
}
