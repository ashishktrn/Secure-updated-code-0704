import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:secure_apk/globals.dart';
import 'dart:convert';
import '../models/attendanceinformation_model.dart';
import '../reuseablewidgets.dart/Common.dart';
import '../reuseablewidgets.dart/colors.dart';
import '../reuseablewidgets.dart/loder.dart';
import '../reuseablewidgets.dart/sessionexpire.dart';

// class ProductDataGridSource2 extends DataGridSource {
//   ProductDataGridSource2(this.productList) {
//     buildDataGridRow();
//   }

//   late List<DataGridRow> dataGridRows;
//   late List<AttendanceInformationModel> productList;
//   int count = 0;
//   var date_Of_Entry;
//   var entry_Time;
//   var created_Date;

//   @override
//   DataGridRowAdapter? buildRow(DataGridRow row) {
//     return DataGridRowAdapter(cells: [
//       Container(
//         color: Colors.grey.shade200,
//         // color: Colors.red,
//         child: Align(
//           alignment: Alignment.center,
//           child: Text(
//             row.getCells()[0].value.toString(),
//             //overflow: TextOverflow.ellipsis,
//           ),
//         ),
//         alignment: Alignment.centerLeft,
//         //padding: EdgeInsets.all(8.0),
//       ),
//       Container(
//         color: Color.fromRGBO(238, 238, 238, 1),
//         child: Align(
//           alignment: Alignment.center,
//           child: Text(
//             row.getCells()[1].value.toString(),
//             // overflow: TextOverflow.ellipsis,
//           ),
//         ),
//         alignment: Alignment.centerLeft,
//         // padding: EdgeInsets.all(8.0),
//       ),
//       Container(
//         color: Colors.grey.shade200,
//         child: Align(
//           alignment: Alignment.center,
//           child: Text(
//             row.getCells()[2].value.toString(),
//             //overflow: TextOverflow.ellipsis,
//           ),
//         ),
//         alignment: Alignment.centerLeft,
//         //padding: EdgeInsets.all(8.0),
//       ),
//       Container(
//         color: Colors.grey.shade200,
//         child: Text(
//           row.getCells()[3].value.toString(),
//           //overflow: TextOverflow.ellipsis,
//         ),
//         alignment: Alignment.centerLeft,
//         //padding: EdgeInsets.all(8.0),
//       ),
//       Container(
//         color: Colors.grey.shade200,
//         child: Text(
//           row.getCells()[4].value.toString(),
//           //overflow: TextOverflow.ellipsis,
//         ),
//         alignment: Alignment.centerLeft,
//         //padding: EdgeInsets.all(8.0),
//       ),
//       // Container(
//       //   color: Colors.grey.shade200,
//       //   child: Text(
//       //     row.getCells()[5].value.toString(),
//       //     //overflow: TextOverflow.ellipsis,
//       //   ),
//       //   alignment: Alignment.center,
//       //   //padding: EdgeInsets.all(8.0),
//       // ),
//       // Container(
//       //   color: Colors.grey.shade200,
//       //   child: Text(
//       //     row.getCells()[6].value.toString(),
//       //     //overflow: TextOverflow.ellipsis,
//       //   ),
//       //   alignment: Alignment.center,
//       //   //padding: EdgeInsets.all(8.0),
//       // ),
//       Container(
//         color: Colors.grey.shade200,
//         child: Text(
//           row.getCells()[7].value.toString(),
//           //overflow: TextOverflow.ellipsis,
//         ),
//         alignment: Alignment.center,
//         //padding: EdgeInsets.all(8.0),
//       ),
//       // Container(
//       //   color: Colors.grey.shade200,
//       //   child: Text(
//       //     row.getCells()[8].value.toString(),
//       //     //overflow: TextOverflow.ellipsis,
//       //   ),
//       //   alignment: Alignment.center,
//       //   //padding: EdgeInsets.all(8.0),
//       // ),
//       Container(
//         color: Colors.grey.shade200,
//         child: Align(
//           alignment: Alignment.center,
//           child: Text(
//             row.getCells()[9].value.toString(),
//             //overflow: TextOverflow.ellipsis,
//           ),
//         ),
//         alignment: Alignment.centerLeft,
//         //padding: EdgeInsets.all(8.0),
//       ),
//       Container(
//         color: Colors.grey.shade200,
//         child: Align(
//           alignment: Alignment.center,
//           child: Text(
//             row.getCells()[10].value.toString(),
//             //overflow: TextOverflow.ellipsis,
//           ),
//         ),
//         alignment: Alignment.centerLeft,
//         //padding: EdgeInsets.all(8.0),
//       ),
//     ]);
//   }

//   @override
//   // TODO: implement rows
//   List<DataGridRow> get rows => dataGridRows;
//   void buildDataGridRow() {
//     dataGridRows = productList.map<DataGridRow>((dataGridRows) {
//       return DataGridRow(cells: [
//         DataGridCell(columnName: 'count', value: count = count + 1),
//         DataGridCell(columnName: 'CPF_NO', value: dataGridRows.CPF_NO),
//         DataGridCell(
//             columnName: 'IO_CODE',
//             value: dataGridRows.IO_CODE == "I" ? "In" : "Out"),
//         DataGridCell(
//             columnName: 'DATE_OF_ENTRY',
//             value: date_Of_Entry = DateFormat('dd-MMM-yyyy')
//                 .format(DateTime.parse(dataGridRows.DATE_OF_ENTRY))),
//         DataGridCell(
//             columnName: 'ENTRY_TIME',
//             value: entry_Time = DateFormat('hh:mm:a')
//                 .format(DateTime.parse(dataGridRows.ENTRY_TIME))),
//         DataGridCell(columnName: 'LONGITUDE', value: dataGridRows.LONGITUDE),
//         DataGridCell(columnName: 'LATITUDE', value: dataGridRows.LATITUDE),
//         DataGridCell(columnName: 'ADDRESS', value: dataGridRows.ADDRESS),
//         DataGridCell(columnName: 'created by', value: dataGridRows.CREATED_BY),
//         DataGridCell(
//             columnName: 'created date',
//             value: created_Date = DateFormat('dd-MMM-yyyy')
//                 .format(DateTime.parse(dataGridRows.CREATED_DATE))),
//         DataGridCell(
//             columnName: 'MAF',
//             value: dataGridRows.MAF == 0 ? "Unapproved" : "Approved"),
//       ]);
//     }).toList(growable: false);
//   }
// }

// class DataTablee2 extends StatefulWidget {
//   @override
//   State<DataTablee2> createState() => _DataTableState();
// }

// class _DataTableState extends State<DataTablee2> {
//   Future<ProductDataGridSource2> getProductDataSource() async {
//     var productList = await fetchData();
//     return ProductDataGridSource2(productList);
//   }

//   // isValiddate(testdate) {
//   //   var splt = testdate.toString().split("-");
//   //   var year = int.parse(splt[0]);
//   //   var month = getMonthNumber(splt[1]);
//   //   var day = int.parse(splt[2]);

//   //   var d = new DateTime(year, month, day);
//   //   if (d.year == year && d.month == month && d.day == day) {
//   //     return true;
//   //   }
//   //   return false;
//   // }

//   // getMonthNumber(month) {
//   //   if (month == "jan" || month == "Jan") {
//   //     return 1;
//   //   } else if (month == "feb" || month == "Feb") {
//   //     return 2;
//   //   } else if (month == "Mar" || month == "mar") {
//   //     return 3;
//   //   } else if (month == "Apr" || month == "apr") {
//   //     return 4;
//   //   } else if (month == "May" || month == "may") {
//   //     return 5;
//   //   } else if (month == "jun" || month == "Jun") {
//   //     return 6;
//   //   } else if (month == "Jul" || month == "jul") {
//   //     return 7;
//   //   } else if (month == "Aug" || month == "aug") {
//   //     return 8;
//   //   } else if (month == "Sep" || month == "sep") {
//   //     return 9;
//   //   } else if (month == "Oct" || month == "oct") {
//   //     return 10;
//   //   } else if (month == "Nov" || month == "nov") {
//   //     return 11;
//   //   } else if (month == "Dec" || month == "dec") {
//   //     return 12;
//   //   }
//   // }

//   late List<AttendanceInformationModel> productList;
//   late sessionExpired sessionexpired = new sessionExpired(context);
//   Future<List<AttendanceInformationModel>> fetchData() async {
//     DateTime now = new DateTime.now();

//     String formattedDate = DateFormat('yyyy-MM-dd').format(now);

//     print(formattedDate);
//     //isValiddate(formattedDate);

//     List<AttendanceInformationModel> users = [];

//     //final String apiEndpoint = "http://localhost:57891/api/LoginAD/getempdata";
//     // final String apiEndpoint =
//     //     "http://172.16.15.129:8026/api/MarkAttendance/GetUserInfo?CPF_NO=$globalInt&ENTRY_DATE=$formattedDate&flag=0&radioFlag=2";
//     final String apiEndpoint =
//         "$ServerUrl/api/MobileAPI/GetUserInfo?CPF_NO=$globalInt&ENTRY_DATE=$formattedDate&flag=0&radioFlag=2";

//     final Uri url = Uri.parse(apiEndpoint);
//     final response = await http.get(
//       url,
//       headers: {
//         "MobileURL": "hoursReconciliation",
//         "CPF_NO": globalInt.toString(),
//         "Authorization": "Bearer $JWT_Tokken"
//       },
//     );
//     print(response.body);
//     if (response.statusCode == 401) {
//       var isunauth = response.reasonPhrase;
//       if (isunauth == "Unauthorized") {
// // logic for login the user out
//         sessionexpired.LogoutUser();
//       }
//     }

//     try {
//       var decodeProduct =
//           json.decode(response.body).cast<Map<String, dynamic>>();
//       productList = await decodeProduct
//           .map<AttendanceInformationModel>(
//               (json) => AttendanceInformationModel.fromJson(json))
//           .toList();
//     } catch (e) {
//       print(e);
//     }

//     return productList;
//   }

//   List<GridColumn> getcolumns() {
//     return <GridColumn>[
//       GridTextColumn(
//           columnName: "#",
//           width: 40,
//           label: Container(
//             decoration: BoxDecoration(
//               color: Colors.grey.shade300,
//             ),
//             padding: EdgeInsets.all(8),
//             alignment: Alignment.center,
//             child: Text(
//               '#',
//               // overflow: TextOverflow.clip,
//               // softWrap: true,
//             ),
//           )),
//       GridTextColumn(
//           columnName: "Cpf No",
//           width: 70,
//           label: Container(
//             decoration: BoxDecoration(
//               color: Colors.grey.shade300,
//             ),
//             padding: EdgeInsets.all(8),
//             alignment: Alignment.center,
//             child: Text(
//               'Cpf No',
//               // overflow: TextOverflow.clip,
//               // softWrap: true,
//             ),
//           )),
//       GridTextColumn(
//           columnName: "IO",
//           width: 70,
//           label: Container(
//             color: Colors.grey.shade300,
//             padding: EdgeInsets.all(8),
//             alignment: Alignment.center,
//             child: Text(
//               'IO code',
//               // overflow: TextOverflow.clip,
//               // softWrap: true,
//             ),
//           )),
//       GridTextColumn(
//           columnName: "Date of entry",
//           width: 150,
//           label: Container(
//             color: Colors.grey.shade300,
//             padding: EdgeInsets.all(8),
//             alignment: Alignment.centerLeft,
//             child: Text(
//               'Date of entry',
//               // overflow: TextOverflow.clip,
//               // softWrap: true,
//             ),
//           )),
//       GridTextColumn(
//           columnName: "Entry time",
//           width: 100,
//           label: Container(
//             color: Colors.grey.shade300,
//             padding: EdgeInsets.all(8),
//             alignment: Alignment.centerLeft,
//             child: Text(
//               'Entry time',
//               // overflow: TextOverflow.clip,
//               // softWrap: true,
//             ),
//           )),
//       // GridTextColumn(
//       //     columnName: "Longitude",
//       //     width: 90,
//       //     label: Container(
//       //       color: Colors.grey.shade300,
//       //       padding: EdgeInsets.all(8),
//       //       alignment: Alignment.center,
//       //       child: Text(
//       //         'Longitude',
//       //         // overflow: TextOverflow.clip,
//       //         // softWrap: true,
//       //       ),
//       //     )),
//       // GridTextColumn(
//       //     columnName: "Latitude",
//       //     width: 100,
//       //     label: Container(
//       //       color: Colors.grey.shade300,
//       //       padding: EdgeInsets.all(8),
//       //       alignment: Alignment.centerLeft,
//       //       child: Text(
//       //         'Latitude',
//       //         // overflow: TextOverflow.clip,
//       //         // softWrap: true,
//       //       ),
//       //     )),
//       GridTextColumn(
//           columnName: "adress",
//           width: 150,
//           label: Container(
//             color: Colors.grey.shade300,
//             padding: EdgeInsets.all(8),
//             alignment: Alignment.centerLeft,
//             child: Text(
//               'Adress',
//               // overflow: TextOverflow.clip,
//               // softWrap: true,
//             ),
//           )),
//       // GridTextColumn(
//       //     columnName: "CREATED_BY",
//       //     width: 90,
//       //     label: Container(
//       //       color: Colors.grey.shade300,
//       //       padding: EdgeInsets.all(8),
//       //       alignment: Alignment.center,
//       //       child: Text(
//       //         'Created by',
//       //         // overflow: TextOverflow.clip,
//       //         // softWrap: true,
//       //       ),
//       //     )),
//       GridTextColumn(
//           columnName: "CREATED_DATE",
//           width: 110,
//           label: Container(
//             color: Colors.grey.shade300,
//             padding: EdgeInsets.all(8),
//             alignment: Alignment.centerLeft,
//             child: Text(
//               'Created date',
//               // overflow: TextOverflow.clip,
//               // softWrap: true,
//             ),
//           )),
//       GridTextColumn(
//           columnName: "Status",
//           width: 100,
//           label: Container(
//             color: Colors.grey.shade300,
//             padding: EdgeInsets.all(8),
//             alignment: Alignment.center,
//             child: Text(
//               'Status',
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
//                 ? SfDataGrid(source: snapshot.data, columns: getcolumns())
//                 : Center(
//                     child: CircularProgressIndicator(
//                       color: securePurpleColor,
//                       strokeWidth: 3,
//                     ),
//                   );
//           },
//         )),
//       ),
//     );
//   }
// }
class DataTablee2 extends StatefulWidget {
  const DataTablee2({Key? key}) : super(key: key);

  @override
  State<DataTablee2> createState() => _DataTablee2State();
}

late List<AttendanceInformationModel> emplist;

int count = 0;

class _DataTablee2State extends State<DataTablee2> {
  late MyHttpClient myHttpClient = new MyHttpClient(context);
  Future<List<AttendanceInformationModel>> fetchResults() async {
    DateTime now = new DateTime.now();

    String formattedDate = DateFormat('yyyy-MM-dd').format(now);

    count = 0;
    final String apiEndpoint =
        "$ServerUrl/api/MobileAPI/GetUserInfo?CPF_NO=$globalInt&ENTRY_DATE=$formattedDate&flag=0&radioFlag=2&PeerCpf=0";

    Response? response =
        await myHttpClient.GetMethod(apiEndpoint, "hoursReconciliation", true);

    // final Uri url = Uri.parse(apiEndpoint);
    // final response = await get(
    //   url,
    //   headers: {
    //     "MobileURL": "hoursReconciliation",
    //     "CPF_NO": globalInt.toString(),
    //     "Authorization": "Bearer $JWT_Tokken"
    //   },
    // );
    if (response!.statusCode == 200) {
      try {
        var decode = json.decode(response.body);

        //if (decode.isNotEmpty) {
        var decodeProduct =
            json.decode(response.body).cast<Map<String, dynamic>>();
        emplist = await decodeProduct
            .map<AttendanceInformationModel>(
                (json) => AttendanceInformationModel.fromJson(json))
            .toList();
        // } else {
        //   showDialog(
        //     context: context,
        //     builder: (context) {
        //       return AlertDialog(
        //         backgroundColor: Colors.yellow,
        //         content: Text(
        //           'No Data',
        //           style: TextStyle(color: Colors.white),
        //         ),
        //       );
        //     },
        //   );
        // }
      } catch (e) {
        print(e);
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.red,
              content: Text(
                'Error!',
                style: TextStyle(color: Colors.white),
              ),
            );
          },
        );
      }
    }

    return emplist;
  }

  late bool hasInternet;
  late sessionExpired sessionexpired = new sessionExpired(context);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {
      final connected = await InternetConnectionChecker().hasConnection;
      if (connected) {
        count = 0;
        fetchResults();
      }
    });

    InternetConnectionChecker().onStatusChange.listen((event) {
      final hasInternet = event == InternetConnectionStatus.connected;
      if (!mounted) return;
      setState(() => this.hasInternet = hasInternet);
      if (!this.hasInternet) {
      } else {
        count = 0;
        fetchResults();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        child: Column(
          children: [
            FutureBuilder<List<AttendanceInformationModel>>(
              initialData: const <AttendanceInformationModel>[],
              future: fetchResults(),
              builder: (context, snapshot) {
                if (snapshot.hasError ||
                    snapshot.data == null ||
                    snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CustomLoader(
                      dotColor: Global_User_theme,
                    ),
                  );
                  ;
                }

                return SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics()),
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: DataTable(
                      showBottomBorder: true,
                      border: TableBorder.all(
                        width: 0.1,
                      ),
                      columns: const [
                        DataColumn(label: Text('#')),
                        DataColumn(label: Text('Cpf No')),
                        DataColumn(label: Text('In/Out')),
                        DataColumn(label: Text('Date')),
                        DataColumn(label: Text('Entry Time')),
                        DataColumn(label: Text('Adress')),
                        DataColumn(label: Text('Status')),
                      ],
                      rows: List.generate(
                        snapshot.data!.length,
                        (index) {
                          var emp = snapshot.data![index];
                          return DataRow(cells: [
                            DataCell(
                              Text(
                                (count = count + 1).toString(),
                              ),
                              onTap: () => showCard(emp),
                            ),
                            DataCell(
                              Text(emp.CPF_NO.toString()),
                              onTap: () => showCard(emp),
                            ),
                            DataCell(
                              Text(emp.IO_CODE == 'I' ? 'In' : 'Out'),
                              onTap: () => showCard(emp),
                            ),
                            DataCell(
                              Text(
                                DateFormat('dd-MMM-yyyy')
                                    .format(DateTime.parse(emp.DATE_OF_ENTRY)),
                              ),
                              onTap: () => showCard(emp),
                            ),
                            DataCell(
                              Text(DateFormat('hh:mm a')
                                  .format(DateTime.parse(emp.ENTRY_TIME))),
                              onTap: () => showCard(emp),
                            ),
                            DataCell(
                              Text(emp.ADDRESS),
                              onTap: () => showCard(emp),
                            ),
                            DataCell(
                              Text(emp.MAF == 0 ? "Unapproved" : "Approved"),
                              onTap: () => showCard(emp),
                            ),
                          ]);
                        },
                      ).toList(),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  showCard(AttendanceInformationModel emp) {
    showDialog(
      context: context,
      builder: (dialogeeecontext) => Center(
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
              // borderRadius: BorderRadius.circular(1.0),
              ),
          elevation: 5,
          margin: EdgeInsets.all(10),
          child: SingleChildScrollView(
            physics:
                AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            child: Container(
              //  height: MediaQuery.of(context).size.height / 2,
              color: Colors.grey.shade200,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,

                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Pipo History",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      // mainAxisAlignment:
                      //     MainAxisAlignment.center,
                      children: [
                        Text(
                          "Employee Name:  ",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          emp.EMP_NAME.toString(),
                          // style: TextStyle(
                          //     color: Colors.black, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      // mainAxisAlignment:
                      //     MainAxisAlignment.center,
                      children: [
                        Text(
                          "Employee No:  ",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          emp.CPF_NO.toString(),
                          // style: TextStyle(
                          //     color: Colors.black, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  // SizedBox(
                  //   height:
                  //       5,
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      // mainAxisAlignment:
                      //     MainAxisAlignment.center,
                      children: [
                        Text(
                          "In/Out:  ",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          emp.IO_CODE == 'I' ? 'In' : 'Out',
                          // style: TextStyle(
                          //     color: Colors.black, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      // mainAxisAlignment:
                      //     MainAxisAlignment.center,
                      children: [
                        Text(
                          "DATE:  ",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          DateFormat('dd-MMM-yyyy')
                              .format(DateTime.parse(emp.DATE_OF_ENTRY)),
                          // style: TextStyle(
                          //     color: Colors.black, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      // mainAxisAlignment:
                      //     MainAxisAlignment.center,
                      children: [
                        Text(
                          "Entry Time:  ",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          DateFormat('hh:mm a')
                              .format(DateTime.parse(emp.ENTRY_TIME)),
                          // style: TextStyle(
                          //     color: Colors.black, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      // mainAxisAlignment:
                      //     MainAxisAlignment.center,
                      children: [
                        Text(
                          "Adress:  ",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          emp.ADDRESS,
                          // style: TextStyle(
                          //     color: Colors.black, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      // mainAxisAlignment:
                      //     MainAxisAlignment.center,
                      children: [
                        Text(
                          "Status:  ",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          emp.MAF == 0 ? "Unapproved" : "Approved",
                          // style: TextStyle(
                          //     color: Colors.black, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    return Container();
  }
}
