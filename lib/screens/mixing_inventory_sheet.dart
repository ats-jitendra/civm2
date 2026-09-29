// import 'package:CIVM/models/foreman.dart';
// import 'package:flutter/material.dart';

// class MixingInventorySheet extends StatefulWidget {
//   const MixingInventorySheet({Key? key}) : super(key: key);

//   @override
//   State<MixingInventorySheet> createState() => _MixingInventorySheetState();
// }

// class _MixingInventorySheetState extends State<MixingInventorySheet> {
//   static const List<Foreman> _foremanOptions = <Foreman>[
//     Foreman(name: 'Jack', id: 'jack@example.com'),
//     Foreman(name: 'John', id: 'john@example.com'),
//     Foreman(name: 'Thomas', id: 'thomas123@gmail.com'),
//   ];

//   static String _displayStringForOption(Foreman option) => option.name;
//   @override
//   Widget build(BuildContext context) {
//     Color hexToColor(String code) {
//       return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
//     }

//     return Scaffold(
//       backgroundColor: Colors.white,
//       // drawer: DrawerClass(),
//       appBar: AppBar(iconTheme: const IconThemeData(color: Colors.white),
//         title: const Text('Mixing Inventory Sheet',
//             style: TextStyle(color: Colors.white),),
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Container(
//                 margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
//                 child: Row(
//                   children: [
//                     const Expanded(
//                       child: Align(
//                           alignment: Alignment.centerLeft,
//                           child: Padding(
//                             padding: EdgeInsets.all(2.0),
//                             child: Text(
//                               "Foreman Name : ",
//                               style:
//                                   TextStyle(fontSize: 18.0, color: Colors.blue),
//                             ),
//                           )),
//                     ),
//                     Expanded(
//                         child: Align(
//                       alignment: Alignment.centerRight,
//                       child: Padding(
//                         padding: const EdgeInsets.all(2.0),
//                         child: Container(
//                           padding:
//                               const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(4.5),
//                             border: Border.all(
//                                 color: const Color.fromARGB(255, 136, 130, 130)),
//                           ),
//                           child: DropdownButtonHideUnderline(
//                             child: Autocomplete<Foreman>(
//                               displayStringForOption: _displayStringForOption,
//                               optionsBuilder:
//                                   (TextEditingValue textEditingValue) {
//                                 if (textEditingValue.text == '') {
//                                   return const Iterable<Foreman>.empty();
//                                 }
//                                 return _foremanOptions.where((Foreman option) {
//                                   return option.toString().contains(
//                                       textEditingValue.text.toLowerCase());
//                                 });
//                               },
//                               onSelected: (Foreman selection) {
//                                 debugPrint(
//                                     'You just selected ${_displayStringForOption(selection)}');
//                               },
//                             ),
//                           ),
//                         ),
//                       ),
//                     ))
//                   ],
//                 ),
//               ),
//               Container(
//                 margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
//                 child: Row(children: [
//                   const Expanded(
//                     child: Align(
//                         alignment: Alignment.centerLeft,
//                         child: Padding(
//                           padding: EdgeInsets.all(2.0),
//                           child: Text(
//                             "Date : ",
//                             style:
//                                 TextStyle(fontSize: 18.0, color: Colors.blue),
//                           ),
//                         )),
//                   ),
//                   Expanded(
//                     child: Align(
//                       alignment: Alignment.centerRight,
//                       child: Padding(
//                         padding: const EdgeInsets.all(2.0),
//                         child: TextField(
//                           // getCurrentDate1(),
//                           enabled: false,
//                           obscureText: false,
//                           decoration: InputDecoration(
//                             border: const OutlineInputBorder(),
//                             labelText: getCurrentDate(),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ]),
//               ),
//               Container(
//                 margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
//                 child: const Row(children: [
//                   Expanded(
//                     child: Align(
//                         alignment: Alignment.centerLeft,
//                         child: Padding(
//                           padding: EdgeInsets.all(2.0),
//                           child: Text(
//                             "Batch Number : ",
//                             style:
//                                 TextStyle(fontSize: 18.0, color: Colors.blue),
//                           ),
//                         )),
//                   ),
//                   Expanded(
//                     child: Align(
//                       alignment: Alignment.centerRight,
//                       child: Padding(
//                         padding: EdgeInsets.all(2.0),
//                         child: TextField(
//                           obscureText: false,
//                           keyboardType: TextInputType.number,
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             labelText: 'Batch Number ',
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ]),
//               ),
//               Container(
//                 margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
//                 child: const Row(children: [
//                   Expanded(
//                     child: Align(
//                         alignment: Alignment.centerLeft,
//                         child: Padding(
//                           padding: EdgeInsets.all(2.0),
//                           child: Text(
//                             "Chemical Name : ",
//                             style:
//                                 TextStyle(fontSize: 18.0, color: Colors.blue),
//                           ),
//                         )),
//                   ),
//                   Expanded(
//                     child: Align(
//                       alignment: Alignment.centerRight,
//                       child: Padding(
//                         padding: EdgeInsets.all(2.0),
//                         child: TextField(
//                           obscureText: false,
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             labelText: 'Chemical Name ',
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ]),
//               ),
//               Container(
//                 margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
//                 child: const Row(children: [
//                   Expanded(
//                     child: Align(
//                         alignment: Alignment.centerLeft,
//                         child: Padding(
//                           padding: EdgeInsets.all(2.0),
//                           child: Text(
//                             "Chemical Amount : ",
//                             style:
//                                 TextStyle(fontSize: 18.0, color: Colors.blue),
//                           ),
//                         )),
//                   ),
//                   Expanded(
//                     child: Align(
//                       alignment: Alignment.centerRight,
//                       child: Padding(
//                         padding: EdgeInsets.all(2.0),
//                         child: TextField(
//                           obscureText: false,
//                           keyboardType: TextInputType.number,
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             labelText: 'Chemical Amount ',
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ]),
//               ),
//               Container(
//                 margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
//                 child: const Row(children: [
//                   Expanded(
//                     child: Align(
//                         alignment: Alignment.centerLeft,
//                         child: Padding(
//                           padding: EdgeInsets.all(2.0),
//                           child: Text(
//                             "Water Amount : ",
//                             style:
//                                 TextStyle(fontSize: 18.0, color: Colors.blue),
//                           ),
//                         )),
//                   ),
//                   Expanded(
//                     child: Align(
//                       alignment: Alignment.centerRight,
//                       child: Padding(
//                         padding: EdgeInsets.all(2.0),
//                         child: TextField(
//                           obscureText: false,
//                           keyboardType: TextInputType.number,
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             labelText: 'Water Amount ',
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ]),
//               ),
//               Container(
//                   margin: const EdgeInsets.only(left: 6, right: 6, top: 8.0),
//                   child: InkWell(
//                     onTap: () {
//                       _showSubmitDataDialog();
//                     },
//                     child: Container(
//                       margin: const EdgeInsets.only(
//                           left: 40, right: 40, bottom: 10.0),
//                       padding: const EdgeInsets.all(8),
//                       alignment: Alignment.center,
//                       width: MediaQuery.of(context).size.width,
//                       height: 40,
//                       decoration: BoxDecoration(
//                           // shape: BoxShape.circle,
//                           borderRadius: BorderRadius.circular(10),
//                           boxShadow: const [
//                             BoxShadow(
//                                 color: Colors.blue,
//                                 blurRadius: 5,
//                                 offset: Offset(2.0, 5.0))
//                           ],
//                           color: Colors.blue,
//                           gradient: const LinearGradient(
//                             colors: [Colors.blue, Colors.blue],
//                           )),
//                       child: const Row(children: [
//                         Expanded(
//                           child: Align(
//                             alignment: Alignment.center,
//                             child: Text(
//                               "Submit",
//                               textAlign: TextAlign.left,
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 20,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ]),
//                     ),
//                   )),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _showSubmitDataDialog() {
//     showDialog(
//         context: context,
//         builder: (context) {
//           return Container(
//             child: AlertDialog(
//               title: const Text('Are you sure to submit?'),
//               // content: Text("Are you sure to submit?"),
//               actions: [
//                 TextButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     child: const Text("NO")),
//                 TextButton(
//                     onPressed: () {
//                       // sendData();
//                       Navigator.pop(context);
//                     },
//                     child: const Text("Yes")),
//               ],
//             ),
//           );
//         });
//   }

//   String getCurrentDate() {
//     var date = DateTime.now().toString();

//     var dateParse = DateTime.parse(date);

//     var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
//     return formattedDate.toString();
//   }
// }
