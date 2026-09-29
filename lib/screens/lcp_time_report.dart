import 'package:flutter/material.dart';

class LCPTimeReport extends StatefulWidget {
  const LCPTimeReport({Key? key}) : super(key: key);

  @override
  State<LCPTimeReport> createState() => _LCPTimeReportState();
}

class _LCPTimeReportState extends State<LCPTimeReport> {
  final contractor = ['Robert Dean'];
  String? value;

  final equipment_type = [
    'Pickup',
    'Crew Truck',
    'Aerial Truck',
    'Chipper',
    'Chip Truck',
    'Other',
    'SAW #1',
    'SAW #2'
  ];
  String? value1;

  final Remarks = [
    'Weather Delay',
    'Permission Issues',
  ];
  String? value2;

  //TimeOfDay _applicationStartTime = TimeOfDay(hour: 00, minute: 00);
  //TimeOfDay _applicationEndTime = TimeOfDay(hour: 00, minute: 00);
  //TimeOfDay _breakStartTime = TimeOfDay(hour: 00, minute: 00);
  //TimeOfDay _breakEndTime = TimeOfDay(hour: 00, minute: 00);
  //TimeOfDay _Time = TimeOfDay(hour: 00, minute: 00);

  //var isLoaded = false;
  //final controller = TestController();

  @override
  Widget build(BuildContext context) {
    Color hexToColor(String code) {
      return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('LCP Time Report',
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

                              // getCurrentDate1(),
                              //enabled: false,
                              //obscureText: false,
                              //decoration: InputDecoration(
                              //  border: OutlineInputBorder(),
                              //labelText: getCurrentDate(),
                              //labelText: 'Contractor'), items: const [],
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
                child: const Row(
                  children: [
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              "Crew Number : ",
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
                          // getCurrentDate1(),
                          //enabled: false,
                          obscureText: false,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              //labelText: getCurrentDate(),
                              labelText: 'Crew Number '),
                        ),
                      ),
                    ))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: const Row(
                  children: [
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              "Job Number : ",
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
                          // getCurrentDate1(),
                          //enabled: false,
                          obscureText: false,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              //labelText: getCurrentDate(),
                              labelText: 'Job Number '),
                        ),
                      ),
                    ))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: const Row(
                  children: [
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              "Week End Date : ",
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
                          //onTap: _selectDate(context),
                          // getCurrentDate1(),
                          //enabled: false,
                          obscureText: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            //labelText: getCurrentDate(),
                            labelText: 'Select Date',
                          ),
                        ),
                      ),
                    ))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: const Row(
                  children: [
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              "General Foreman : ",
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
                          // getCurrentDate1(),
                          //enabled: false,
                          obscureText: false,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              //labelText: getCurrentDate(),
                              labelText: 'General Foreman '),
                        ),
                      ),
                    ))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: const Row(
                  children: [
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              "Foreman's Digital Signature : ",
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
                          // getCurrentDate1(),
                          //enabled: false,
                          obscureText: false,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              //labelText: getCurrentDate(),
                              labelText: "Foreman's Digital Signature"),
                        ),
                      ),
                    ))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: const Row(
                  children: [
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              "Contract_Type : ",
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
                          // getCurrentDate1(),
                          //enabled: false,
                          obscureText: false,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              //labelText: getCurrentDate(),
                              labelText: 'Contract_Type'),
                        ),
                      ),
                    ))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: const Row(
                  children: [
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              "Pesticide LIC Number : ",
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
                          // getCurrentDate1(),
                          //enabled: false,
                          obscureText: false,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              //labelText: getCurrentDate(),
                              labelText: 'Pesticide LIC Number '),
                        ),
                      ),
                    ))
                  ],
                ),
              ),
              Container(
                color: Colors.blue,
                padding: const EdgeInsets.all(4),
                height: 40,
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: const Row(children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Text(
                          "Employees ",
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
              Container(
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: const Row(
                  children: [
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              "Employee Number : ",
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
                            // getCurrentDate1(),
                            //enabled: false,
                            obscureText: false,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                //labelText: getCurrentDate(),
                                labelText: 'Employee Number '),
                            keyboardType: TextInputType.number),
                      ),
                    ))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: const Row(
                  children: [
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              "Employee Name : ",
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
                          // getCurrentDate1(),
                          //enabled: false,
                          obscureText: false,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              //labelText: getCurrentDate(),
                              labelText: 'Employee Name '),
                        ),
                      ),
                    ))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: const Row(
                  children: [
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              "Class Code : ",
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
                          // getCurrentDate1(),
                          //enabled: false,
                          obscureText: false,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              //labelText: getCurrentDate(),
                              labelText: 'Class Code '),
                        ),
                      ),
                    ))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: const Row(
                  children: [
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              "Sunday - Number of Hours : ",
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
                            // getCurrentDate1(),
                            //enabled: false,
                            obscureText: false,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                //labelText: getCurrentDate(),
                                labelText: 'Sunday - Number of Hours '),
                            keyboardType: TextInputType.number),
                      ),
                    ))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: const Row(
                  children: [
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              "Monday - Number of Hours : ",
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
                            // getCurrentDate1(),
                            //enabled: false,
                            obscureText: false,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                //labelText: getCurrentDate(),
                                labelText: 'Monday - Number of Hours '),
                            keyboardType: TextInputType.number),
                      ),
                    ))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: const Row(
                  children: [
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              "Tuesday - Number of Hours : ",
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
                            // getCurrentDate1(),
                            //enabled: false,
                            obscureText: false,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                //labelText: getCurrentDate(),
                                labelText: 'Tuesday - Number of Hours '),
                            keyboardType: TextInputType.number),
                      ),
                    ))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: const Row(
                  children: [
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              "Wednesday - Number of Hours : ",
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
                            // getCurrentDate1(),
                            //enabled: false,
                            obscureText: false,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                //labelText: getCurrentDate(),
                                labelText: 'Wednesday - Number of Hours '),
                            keyboardType: TextInputType.number),
                      ),
                    ))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: const Row(
                  children: [
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              "Thursday - Number of Hours : ",
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
                            // getCurrentDate1(),
                            //enabled: false,
                            obscureText: false,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                //labelText: getCurrentDate(),
                                labelText: 'Thursday - Number of Hours '),
                            keyboardType: TextInputType.number),
                      ),
                    ))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: const Row(
                  children: [
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              "Friday - Number of Hours : ",
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
                            // getCurrentDate1(),
                            //enabled: false,
                            obscureText: false,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                //labelText: getCurrentDate(),
                                labelText: 'Friday - Number of Hours '),
                            keyboardType: TextInputType.number),
                      ),
                    ))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: const Row(
                  children: [
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              "Saturday - Number of Hours : ",
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
                            // getCurrentDate1(),
                            //enabled: false,
                            obscureText: false,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                //labelText: getCurrentDate(),
                                labelText: 'Saturday - Number of Hours '),
                            keyboardType: TextInputType.number),
                      ),
                    ))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: const Row(
                  children: [
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              "Total Hours : ",
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
                          // getCurrentDate1(),
                          //enabled: false,
                          enabled: false,
                          obscureText: false,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              //labelText: getCurrentDate(),
                              labelText: ' '),
                        ),
                      ),
                    ))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: const Row(
                  children: [
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              "Other Crew : ",
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
                          // getCurrentDate1(),
                          //enabled: false,
                          obscureText: false,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              //labelText: getCurrentDate(),
                              labelText: 'Other Crew '),
                        ),
                      ),
                    ))
                  ],
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.only(
                          left: 40, right: 40, top: 10.0, bottom: 10.0),
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
                            colors: [
                              Color.fromARGB(255, 148, 207, 255),
                              Colors.blue
                            ],
                          )),
                      child: const Row(children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Add another Employee",
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
              Container(
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: const Row(
                  children: [
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              "Total Crew Hours : ",
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
                          // getCurrentDate1(),
                          //enabled: false,
                          obscureText: false,
                          enabled: false,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              //labelText: getCurrentDate(),
                              labelText: ' '),
                        ),
                      ),
                    ))
                  ],
                ),
              ),
              Container(
                color: Colors.blue,
                padding: const EdgeInsets.all(4),
                height: 40,
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: const Row(children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Text(
                          "Equipment ",
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
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
                              "Equipment Type : ",
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
                              hint: const Text('Select Equipment'),
                              value: value1,
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black,
                              ),
                              isExpanded: true,
                              items: equipment_type.map(buildMenuItem).toList(),
                              onChanged: (value1) =>
                                  setState(() => this.value1 = value1),
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
                child: const Row(
                  children: [
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              "Equipment Number : ",
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
                          // getCurrentDate1(),
                          //enabled: false,
                          obscureText: false,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              //labelText: getCurrentDate(),
                              labelText: 'Equipment Number '),
                        ),
                      ),
                    ))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: const Row(
                  children: [
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              "Code : ",
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
                          // getCurrentDate1(),
                          //enabled: false,
                          obscureText: false,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              //labelText: getCurrentDate(),
                              labelText: 'Code '),
                        ),
                      ),
                    ))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: const Row(
                  children: [
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              "Monday - Number of Hours : ",
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
                            // getCurrentDate1(),
                            //enabled: false,
                            obscureText: false,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                //labelText: getCurrentDate(),
                                labelText: 'Monday - Number of Hours '),
                            keyboardType: TextInputType.number),
                      ),
                    ))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: const Row(
                  children: [
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              "Tuesday - Number of Hours : ",
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
                            // getCurrentDate1(),
                            //enabled: false,
                            obscureText: false,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                //labelText: getCurrentDate(),
                                labelText: 'Tuesday - Number of Hours '),
                            keyboardType: TextInputType.number),
                      ),
                    ))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: const Row(
                  children: [
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              "Wednesday - Number of Hours : ",
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
                            // getCurrentDate1(),
                            //enabled: false,
                            obscureText: false,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                //labelText: getCurrentDate(),
                                labelText: 'Wednesday - Number of Hours '),
                            keyboardType: TextInputType.number),
                      ),
                    ))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: const Row(
                  children: [
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              "Thursday - Number of Hours : ",
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
                            // getCurrentDate1(),
                            //enabled: false,
                            obscureText: false,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                //labelText: getCurrentDate(),
                                labelText: 'Thursday - Number of Hours '),
                            keyboardType: TextInputType.number),
                      ),
                    ))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: const Row(
                  children: [
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              "Friday - Number of Hours : ",
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
                            // getCurrentDate1(),
                            //enabled: false,
                            obscureText: false,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                //labelText: getCurrentDate(),
                                labelText: 'Friday - Number of Hours '),
                            keyboardType: TextInputType.number),
                      ),
                    ))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: const Row(
                  children: [
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              "Saturday - Number of Hours : ",
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
                            // getCurrentDate1(),
                            //enabled: false,
                            obscureText: false,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                //labelText: getCurrentDate(),
                                labelText: 'Saturday - Number of Hours '),
                            keyboardType: TextInputType.number),
                      ),
                    ))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: const Row(
                  children: [
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              "Total Hours :",
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
                            // getCurrentDate1(),
                            //enabled: false,
                            obscureText: false,
                            enabled: false,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                //labelText: getCurrentDate(),
                                labelText: ' '),
                            keyboardType: TextInputType.number),
                      ),
                    ))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: const Row(
                  children: [
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              "Other Crew : ",
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
                            // getCurrentDate1(),
                            //enabled: false,
                            obscureText: false,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                //labelText: getCurrentDate(),
                                labelText: 'Other Crew '),
                            keyboardType: TextInputType.number),
                      ),
                    ))
                  ],
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.only(
                          left: 40, right: 40, top: 10.0, bottom: 10.0),
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
                            colors: [
                              Color.fromARGB(255, 148, 207, 255),
                              Colors.blue
                            ],
                          )),
                      child: const Row(children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Add another Equipment",
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
              Container(
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: const Row(
                  children: [
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              "Total Equipment Hours :",
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
                            // getCurrentDate1(),
                            //enabled: false,
                            obscureText: false,
                            enabled: false,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                //labelText: getCurrentDate(),
                                labelText: ' '),
                            keyboardType: TextInputType.number),
                      ),
                    ))
                  ],
                ),
              ),
              Container(
                color: Colors.blue,
                padding: const EdgeInsets.all(4),
                height: 40,
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: const Row(children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Text(
                          "Activities ",
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
              Container(
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: const Row(
                  children: [
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              "Day of Week : ",
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
                          // getCurrentDate1(),
                          //enabled: false,
                          obscureText: false,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              //labelText: getCurrentDate(),
                              labelText: 'Day of Week'),
                        ),
                      ),
                    ))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: const Row(
                  children: [
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              "Substraction ID : ",
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
                            // getCurrentDate1(),
                            //enabled: false,
                            obscureText: false,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                //labelText: getCurrentDate(),
                                labelText: 'Substraction ID '),
                            keyboardType: TextInputType.number),
                      ),
                    ))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: const Row(
                  children: [
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              "Feeder ID : ",
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
                            // getCurrentDate1(),
                            //enabled: false,
                            obscureText: false,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                //labelText: getCurrentDate(),
                                labelText: 'Feeder ID '),
                            keyboardType: TextInputType.number),
                      ),
                    ))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: const Row(
                  children: [
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              "Work Type : ",
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
                          // getCurrentDate1(),
                          //enabled: false,
                          obscureText: false,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              //labelText: getCurrentDate(),
                              labelText: 'SWork Tye '),
                        ),
                      ),
                    ))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: const Row(
                  children: [
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              "Account/WO Number : ",
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
                          // getCurrentDate1(),
                          //enabled: false,
                          obscureText: false,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              //labelText: getCurrentDate(),
                              labelText: 'Account/WO Number '),
                        ),
                      ),
                    ))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: const Row(
                  children: [
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              "Map Number : ",
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
                          // getCurrentDate1(),
                          //enabled: false,
                          obscureText: false,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              //labelText: getCurrentDate(),
                              labelText: 'Map Number '),
                        ),
                      ),
                    ))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: const Row(
                  children: [
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              "Section Address : ",
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
                          // getCurrentDate1(),
                          //enabled: false,
                          obscureText: false,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              //labelText: getCurrentDate(),
                              labelText: 'Section Address '),
                        ),
                      ),
                    ))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: const Row(
                  children: [
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              "Pole Number : ",
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
                          // getCurrentDate1(),
                          //enabled: false,
                          obscureText: false,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              //labelText: getCurrentDate(),
                              labelText: 'Pole Number'),
                        ),
                      ),
                    ))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: const Row(
                  children: [
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              "NotesActivity Code : ",
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
                          // getCurrentDate1(),
                          //enabled: false,
                          obscureText: false,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              //labelText: getCurrentDate(),
                              labelText: 'NotesActivity Code '),
                        ),
                      ),
                    ))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: const Row(
                  children: [
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              "Man Hours : ",
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
                            // getCurrentDate1(),
                            //enabled: false,
                            obscureText: false,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                //labelText: getCurrentDate(),
                                labelText: 'Man Hours '),
                            keyboardType: TextInputType.number),
                      ),
                    ))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: const Row(
                  children: [
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              "Spans : ",
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
                            // getCurrentDate1(),
                            //enabled: false,
                            obscureText: false,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                //labelText: getCurrentDate(),
                                labelText: 'Spans '),
                            keyboardType: TextInputType.number),
                      ),
                    ))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: const Row(
                  children: [
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              "Length : ",
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
                            // getCurrentDate1(),
                            //enabled: false,
                            obscureText: false,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                //labelText: getCurrentDate(),
                                labelText: 'Length '),
                            keyboardType: TextInputType.number),
                      ),
                    ))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: const Row(
                  children: [
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              "Width : ",
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
                            // getCurrentDate1(),
                            //enabled: false,
                            obscureText: false,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                //labelText: getCurrentDate(),
                                labelText: 'Width '),
                            keyboardType: TextInputType.number),
                      ),
                    ))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: const Row(
                  children: [
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              "Chemical Code : ",
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
                          // getCurrentDate1(),
                          //enabled: false,
                          obscureText: false,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              //labelText: getCurrentDate(),
                              labelText: 'Chemical Code '),
                        ),
                      ),
                    ))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                child: const Row(
                  children: [
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              "Chemical Quantity : ",
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
                            // getCurrentDate1(),
                            //enabled: false,
                            obscureText: false,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                //labelText: getCurrentDate(),
                                labelText: 'Chemical Quantity '),
                            keyboardType: TextInputType.number),
                      ),
                    ))
                  ],
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.only(
                          left: 40, right: 40, top: 10.0, bottom: 10.0),
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
                            colors: [
                              Color.fromARGB(255, 148, 207, 255),
                              Colors.blue
                            ],
                          )),
                      child: const Row(children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Add another Activity",
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
                              "Remarks : ",
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
                              hint: const Text('Remarks'),
                              value: value2,
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black,
                              ),
                              isExpanded: true,
                              items: Remarks.map(buildMenuItem).toList(),
                              onChanged: (value2) =>
                                  setState(() => this.value2 = value2),
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
                child: const Row(
                  children: [
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Text(
                              "Foreman Digital Signature : ",
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
                          // getCurrentDate1(),
                          //enabled: false,
                          obscureText: false,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              //labelText: getCurrentDate(),
                              labelText: 'Foreman Digital Signature '),
                        ),
                      ),
                    ))
                  ],
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.only(
                          left: 40, right: 40, top: 10.0, bottom: 10.0),
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
                            colors: [
                              Color.fromARGB(255, 148, 207, 255),
                              Colors.blue
                            ],
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
            fontSize: 15,
          )));

// _selectDate(BuildContext context) async {
//     final DateTime? selected = await showDatePicker(
//       context: context,
//       initialDate: selectedDate,
//       firstDate: DateTime(2010),
//       lastDate: DateTime(2025),
//     );
//     if (selected != null && selected != selectedDate)
//       setState(() {
//         selectedDate = selected;
//         date=selectedDate.toString();
//       });
//   }

  getCurrentDate() {
    var date = DateTime.now().toString();

    var dateParse = DateTime.parse(date);

    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
    return formattedDate.toString();
  }
}
