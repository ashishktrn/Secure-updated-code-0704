// import 'package:flutter/material.dart';
// import 'package:secure_apk/globals.dart';
// import 'package:secure_apk/models/profileModel.dart';
// import 'package:provider/provider.dart';
// import 'package:snippet_coder_utils/FormHelper.dart';
// import 'package:syncfusion_flutter_datagrid/datagrid.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'dart:io' as Io;

// import '../reuseablewidgets.dart/colors.dart';

// class ProductDataGridSource extends DataGridSource {
//   ProductDataGridSource(this.productList) {
//     buildDataGridRow();
//   }

//   late List<DataGridRow> dataGridRows;
//   late List<ProfileModel> productList;
//   List<dynamic> authority_List = [];
//   String? authority_ListId;
//   String dropdownvalue = 'Item 1';

//   // List of items in our dropdown menu
//   var items = [
//     'Approve',
//     'Reject',
//     'Delete',
//   ];
//   bool showDropDownHint = true;

//   @override
//   DataGridRowAdapter? buildRow(DataGridRow row) {
//     return DataGridRowAdapter(cells: [
//       Container(
//         // color: Colors.red,
//         child: Text(
//           row.getCells()[0].value.toString(),
//           //overflow: TextOverflow.ellipsis,
//         ),
//         alignment: Alignment.centerLeft,
//         //padding: EdgeInsets.all(8.0),
//       ),
//       Container(
//         child: Text(
//           row.getCells()[1].value.toString(),
//           // overflow: TextOverflow.ellipsis,
//         ),
//         alignment: Alignment.centerLeft,
//         // padding: EdgeInsets.all(8.0),
//       ),
//       Container(
//         child: Text(
//           row.getCells()[2].value.toString(),
//           //overflow: TextOverflow.ellipsis,
//         ),
//         alignment: Alignment.centerLeft,
//         //padding: EdgeInsets.all(8.0),
//       ),
//       Container(
//         child: Text(
//           row.getCells()[3].value.toString(),
//           //overflow: TextOverflow.ellipsis,
//         ),
//         alignment: Alignment.centerLeft,
//         //padding: EdgeInsets.all(8.0),
//       ),
//       Container(
//         child: Text(
//           row.getCells()[4].value.toString(),
//           //overflow: TextOverflow.ellipsis,
//         ),
//         alignment: Alignment.centerLeft,
//         //padding: EdgeInsets.all(8.0),
//       ),
//       Container(
//         child: Text(
//           row.getCells()[5].value.toString(),
//           //overflow: TextOverflow.ellipsis,
//         ),
//         alignment: Alignment.centerLeft,
//         //padding: EdgeInsets.all(8.0),
//       ),
//       Container(
//         child: Text(
//           row.getCells()[6].value.toString(),
//           //overflow: TextOverflow.ellipsis,
//         ),
//         alignment: Alignment.centerLeft,
//         //padding: EdgeInsets.all(8.0),
//       ),
//       Container(
//         child: Text(
//           row.getCells()[7].value.toString(),
//           //overflow: TextOverflow.ellipsis,
//         ),
//         alignment: Alignment.centerLeft,
//         //padding: EdgeInsets.all(8.0),
//       ),
//       StatefulBuilder(
//         builder: (BuildContext context, setState) {
//           return showDropDownHint
//               ? Container(
//                   // color: Colors.red,
//                   child: Padding(
//                     padding: const EdgeInsets.all(0.0),
//                     child: Container(
//                       margin: EdgeInsets.all(5),
//                       //  padding: EdgeInsets.all(0),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         border: Border.all(width: 1, color: Colors.black),
//                         color: Global_User_theme,
//                       ),
//                       // width: MediaQuery.of(context).size.width,
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 20),
//                         child: DropdownButton(
//                           // Initial Value
//                           // value: dropdownvalue,
//                           hint: Text(
//                             'Action',
//                             style: TextStyle(color: Colors.white),
//                           ),

//                           // Down Arrow Icon
//                           icon: const Icon(
//                             Icons.keyboard_arrow_down,
//                             color: Colors.white,
//                           ),

//                           // Array list of items
//                           items: items.map((String items) {
//                             return DropdownMenuItem(
//                               value: items,
//                               child: Text(items),
//                             );
//                           }).toList(),
//                           dropdownColor: Colors.black,
//                           //focusColor: Colors.white,
//                           style: TextStyle(color: Colors.white),
//                           autofocus: true,
//                           elevation: 10,
//                           underline: Container(),

//                           // After selecting the desired option,it will
//                           // change button value to selected value
//                           onChanged: (String? newValue) {
//                             if (newValue == "Approve") {
//                               print("approve");
//                               showDialog(
//                                 context: context,
//                                 builder: (context) => new AlertDialog(
//                                   title: Text("are you  sure"),
//                                   content: Text("Do you want to Approve"),
//                                   actions: [
//                                     TextButton(
//                                         onPressed: () {
//                                           //  Navigator.pop(context, true);
//                                         },
//                                         child: Text("Yes")),
//                                     TextButton(
//                                         onPressed: () {
//                                           Navigator.pop(context, false);
//                                         },
//                                         child: Text("No")),
//                                   ],
//                                 ),
//                               );
//                             } else if (newValue == "Reject") {
//                               print("reject");
//                               showDialog(
//                                 context: context,
//                                 builder: (context) => new AlertDialog(
//                                   title: Text("are you  sure"),
//                                   content: Text("Do you want to Reject?"),
//                                   actions: [
//                                     TextButton(
//                                         onPressed: () {
//                                           //  Navigator.pop(context, true);
//                                         },
//                                         child: Text("Yes")),
//                                     TextButton(
//                                         onPressed: () {
//                                           Navigator.pop(context, false);
//                                         },
//                                         child: Text("No")),
//                                   ],
//                                 ),
//                               );
//                             } else if (newValue == "Delete") {
//                               print("delete");
//                               showDialog(
//                                 context: context,
//                                 builder: (context) => new AlertDialog(
//                                   title: Text("are you  sure"),
//                                   content: Text("Do you want to delete?"),
//                                   // backgroundColor: Colors.red.shade100,
//                                   actions: [
//                                     TextButton(
//                                         onPressed: () {
//                                           //  Navigator.pop(context, true);
//                                         },
//                                         child: Text("Yes")),
//                                     TextButton(
//                                         onPressed: () {
//                                           Navigator.pop(context, false);
//                                         },
//                                         child: Text("No")),
//                                   ],
//                                 ),
//                               );
//                             }
//                             setState(() {
//                               dropdownvalue = newValue!;
//                               showDropDownHint = false;
//                             });
//                           },
//                         ),
//                       ),
//                     ),
//                   ),
//                 )
//               : Container(
//                   // color: Colors.red,
//                   child: Padding(
//                     padding: const EdgeInsets.all(0.0),
//                     child: Container(
//                       margin: EdgeInsets.all(5),
//                       //  padding: EdgeInsets.all(0),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         border: Border.all(width: 1, color: Colors.black),
//                         color: Global_User_theme,
//                       ),
//                       // width: MediaQuery.of(context).size.width,
//                       child: FittedBox(
//                         child: DropdownButton(
//                           // Initial Value
//                           value: dropdownvalue,
//                           hint: Text(
//                             'Action',
//                             style: TextStyle(color: Colors.white),
//                           ),

//                           underline: Container(),
//                           // Down Arrow Icon
//                           icon: const Icon(
//                             Icons.keyboard_arrow_down,
//                             color: Colors.white,
//                           ),

//                           // Array list of items
//                           items: items.map((String items) {
//                             return DropdownMenuItem(
//                               value: items,
//                               child: Text(
//                                 items,
//                               ),
//                             );
//                           }).toList(),
//                           focusColor: Colors.white,
//                           style: TextStyle(color: Colors.white),
//                           dropdownColor: Colors.black,
//                           // After selecting the desired option,it will
//                           // change button value to selected value
//                           onChanged: (String? newValue) {
//                             if (newValue == "Approve") {
//                               showDialog(
//                                 context: context,
//                                 builder: (context) => new AlertDialog(
//                                   title: Text("are you  sure"),
//                                   content: Text("Do you want to approve?"),
//                                   actions: [
//                                     TextButton(
//                                         onPressed: () {
//                                           //  Navigator.pop(context, true);
//                                         },
//                                         child: Text("Yes")),
//                                     TextButton(
//                                         onPressed: () {
//                                           Navigator.pop(context, false);
//                                         },
//                                         child: Text("No")),
//                                   ],
//                                 ),
//                               );
//                               print("approve");
//                             } else if (newValue == "Reject") {
//                               showDialog(
//                                 context: context,
//                                 builder: (context) => new AlertDialog(
//                                   title: Text("are you  sure"),
//                                   content: Text("Do you want to Reject?"),
//                                   actions: [
//                                     TextButton(
//                                         onPressed: () {
//                                           //  Navigator.pop(context, true);
//                                         },
//                                         child: Text("Yes")),
//                                     TextButton(
//                                         onPressed: () {
//                                           Navigator.pop(context, false);
//                                         },
//                                         child: Text("No")),
//                                   ],
//                                 ),
//                               );
//                               print("reject");
//                             } else if (newValue == "Delete") {
//                               showDialog(
//                                 context: context,
//                                 builder: (context) => new AlertDialog(
//                                   title: Text("are you  sure"),
//                                   content: Text("Do you want to delete?"),
//                                   actions: [
//                                     TextButton(
//                                         onPressed: () {
//                                           //  Navigator.pop(context, true);
//                                         },
//                                         child: Text("Yes")),
//                                     TextButton(
//                                         onPressed: () {
//                                           Navigator.pop(context, false);
//                                         },
//                                         child: Text("No")),
//                                   ],
//                                 ),
//                               );
//                               print("delete");
//                             }
//                             setState(() {
//                               dropdownvalue = newValue!;
//                             });
//                           },
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//         },
//       ),

//       // Text(
//       //   row.getCells()[7].value.toString(),
//       //   //overflow: TextOverflow.ellipsis,
//       // ),
//       //alignment: Alignment.centerLeft,
//       //padding: EdgeInsets.all(8.0),
//     ]);
//   }

//   @override
//   // TODO: implement rows
//   List<DataGridRow> get rows => dataGridRows;

//   void buildDataGridRow() {
//     dataGridRows = productList.map<DataGridRow>((dataGridRows) {
//       return DataGridRow(cells: [
//         DataGridCell(
//           columnName: 'Name',
//           value: dataGridRows.emp_name,
//         ),
//         DataGridCell(
//             columnName: 'designation', value: dataGridRows.designation_name),
//         DataGridCell(columnName: 'CPF', value: dataGridRows.CPF_NO),
//         DataGridCell(columnName: 'email', value: dataGridRows.email),
//         DataGridCell(
//             columnName: 'securelevel', value: dataGridRows.securelevel),
//         DataGridCell(columnName: 'role title', value: dataGridRows.role_title),
//         DataGridCell(
//             columnName: 'emp_name_cpf_no', value: dataGridRows.emp_name_cpf_no),
//         DataGridCell(columnName: 'ou_name', value: dataGridRows.ou_name),
//       ]);
//     }).toList(growable: false);
//   }
// }

// class DataTablee extends StatefulWidget {
//   @override
//   State<DataTablee> createState() => _DataTableState();
// }

// class _DataTableState extends State<DataTablee> {
//   Future<ProductDataGridSource> getProductDataSource() async {
//     var productList = await datato();
//     return ProductDataGridSource(productList);
//   }

//   Future<List<ProfileModel>> datato() async {
//     List<ProfileModel> users = [];

//     //final String apiEndpoint = "http://localhost:57891/api/LoginAD/getempdata";
//     final String apiEndpoint =
//         "http://172.16.15.129:8022/Employee/api/MobileAPI/GetUserInfo?CPF_NO=$globalInt";

//     final Uri url = Uri.parse(apiEndpoint);
//     final response = await http.get(url);
//     print(response.body);
//     var decodeProduct = json.decode(response.body).cast<Map<String, dynamic>>();
//     List<ProfileModel> productList = await decodeProduct
//         .map<ProfileModel>((json) => ProfileModel.fromJson(json))
//         .toList();
//     print(decodeProduct);
//     print(productList);
//     return productList;
//   }

//   List<GridColumn> getcolumns() {
//     return <GridColumn>[
//       GridTextColumn(
//           columnName: "Name",
//           width: 70,
//           label: Container(
//             decoration: BoxDecoration(),
//             padding: EdgeInsets.all(8),
//             alignment: Alignment.centerLeft,
//             child: Text(
//               'Name',
//               // overflow: TextOverflow.clip,
//               // softWrap: true,
//             ),
//           )),
//       GridTextColumn(
//           columnName: "designation",
//           width: 70,
//           label: Container(
//             padding: EdgeInsets.all(8),
//             alignment: Alignment.centerLeft,
//             child: Text(
//               'designation',
//               // overflow: TextOverflow.clip,
//               // softWrap: true,
//             ),
//           )),
//       GridTextColumn(
//           columnName: "CPF",
//           width: 70,
//           label: Container(
//             padding: EdgeInsets.all(8),
//             alignment: Alignment.centerLeft,
//             child: Text(
//               'CPF',
//               // overflow: TextOverflow.clip,
//               // softWrap: true,
//             ),
//           )),
//       GridTextColumn(
//           columnName: "email",
//           width: 70,
//           label: Container(
//             padding: EdgeInsets.all(8),
//             alignment: Alignment.centerLeft,
//             child: Text(
//               'email',
//               // overflow: TextOverflow.clip,
//               // softWrap: true,
//             ),
//           )),
//       GridTextColumn(
//           columnName: "securelevel",
//           width: 70,
//           label: Container(
//             padding: EdgeInsets.all(8),
//             alignment: Alignment.centerLeft,
//             child: Text(
//               'securelevel',
//               // overflow: TextOverflow.clip,
//               // softWrap: true,
//             ),
//           )),
//       GridTextColumn(
//           columnName: "role title",
//           width: 70,
//           label: Container(
//             padding: EdgeInsets.all(8),
//             alignment: Alignment.centerLeft,
//             child: Text(
//               'role title',
//               // overflow: TextOverflow.clip,
//               // softWrap: true,
//             ),
//           )),
//       GridTextColumn(
//           columnName: "emp_name_cpf_no",
//           width: 70,
//           label: Container(
//             padding: EdgeInsets.all(8),
//             alignment: Alignment.centerLeft,
//             child: Text(
//               'emp_name_cpf_no',
//               // overflow: TextOverflow.clip,
//               // softWrap: true,
//             ),
//           )),
//       GridTextColumn(
//           columnName: "ou_name",
//           width: 70,
//           label: Container(
//             padding: EdgeInsets.all(8),
//             alignment: Alignment.centerLeft,
//             child: Text(
//               'ou_name',
//               // overflow: TextOverflow.clip,
//               // softWrap: true,
//             ),
//           )),
//       GridTextColumn(
//           columnName: "Action",
//           width: 120,
//           label: Container(
//             padding: EdgeInsets.all(8),
//             alignment: Alignment.centerLeft,
//             child: Text(
//               'Action',
//               // overflow: TextOverflow.clip,
//               // softWrap: true,
//             ),
//           )),
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: SingleChildScrollView(
//         child: Container(
//             //color: Color.fromA
//             //RGB(255, 253, 49, 49),
//             child: FutureBuilder(
//           future: getProductDataSource(),
//           builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//             return snapshot.hasData
//                 ? SfDataGrid(
//                     source: snapshot.data,
//                     columns: getcolumns(),
//                   )
//                 : Center(
//                     child: CircularProgressIndicator(
//                       strokeWidth: 3,
//                     ),
//                   );
//           },
//         )),
//       ),
//     );
//   }
// }
