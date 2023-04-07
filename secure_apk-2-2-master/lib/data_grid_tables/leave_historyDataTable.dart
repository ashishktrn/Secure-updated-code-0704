import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:secure_apk/models/pending_leaveModel.dart';
import '../globals.dart';
import '../reuseablewidgets.dart/Common.dart';
import '../reuseablewidgets.dart/colors.dart';
import '../reuseablewidgets.dart/loder.dart';
import '../reuseablewidgets.dart/sessionexpire.dart';

// class PendingLeaveDataGrid extends StatefulWidget {
//   const PendingLeaveDataGrid({ Key? key }) : super(key: key);

//   @override
//   State<PendingLeaveDataGrid> createState() => _PendingLeaveDataGridState();
// }

// class _PendingLeaveDataGridState extends State<PendingLeaveDataGrid> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(

//     );
//   }
// }

// class ProductDataGridSource2 extends DataGridSource {
//   ProductDataGridSource2(this.productList) {
//     buildDataGridRow();
//   }

//   late List<DataGridRow> dataGridRows;
//   late List<PendingLeaveModel> productList;
//   int count = 0;
//   var toDate;
//   var FromDate;
//   var applied_Date;
//   final HomePage home = new HomePage();

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
//         color: Colors.grey.shade200,
//         child: Text(
//           row.getCells()[1].value.toString(),
//           // overflow: TextOverflow.ellipsis,
//         ),
//         alignment: Alignment.centerLeft,
//         // padding: EdgeInsets.all(8.0),
//       ),
//       Container(
//         color: Colors.grey.shade200,
//         child: Text(
//           row.getCells()[2].value.toString(),
//           //overflow: TextOverflow.ellipsis,
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

//         child: Align(
//           alignment: Alignment.center,
//           child: Text(
//             row.getCells()[4].value.toString(),
//             //overflow: TextOverflow.ellipsis,
//           ),
//         ),
//         alignment: Alignment.centerLeft,
//         //padding: EdgeInsets.all(8.0),
//       ),
//       Container(
//         color: Colors.grey.shade200,
//         child: Text(
//           row.getCells()[5].value.toString(),
//           //overflow: TextOverflow.ellipsis,
//         ),
//         alignment: Alignment.centerLeft,
//         //padding: EdgeInsets.all(8.0),
//       ),
//       Container(
//         color: Colors.grey.shade200,
//         child: Text(
//           row.getCells()[6].value.toString(),
//           //overflow: TextOverflow.ellipsis,
//         ),
//         alignment: Alignment.center,
//         //padding: EdgeInsets.all(8.0),
//       ),
//       Container(
//         color: Colors.grey.shade200,
//         child: Text(
//           row.getCells()[7].value.toString(),
//           //overflow: TextOverflow.ellipsis,
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
//         DataGridCell(columnName: 'Leave', value: count = count + 1),
//         DataGridCell(columnName: 'Leave', value: dataGridRows.LEAVE_NAME),
//         DataGridCell(
//             columnName: 'From date',
//             value: dataGridRows.FROM_DATE == null
//                 ? null
//                 : dataGridRows.FROM_DATE = DateFormat('dd-MMM-yyyy')
//                     .format(DateTime.parse(dataGridRows.FROM_DATE!))),
//         DataGridCell(
//             columnName: 'To date',
//             value: dataGridRows.TO_DATE == null
//                 ? null
//                 : dataGridRows.TO_DATE = DateFormat('dd-MMM-yyyy')
//                     .format(DateTime.parse(dataGridRows.TO_DATE!))),
//         DataGridCell(columnName: 'No of days', value: dataGridRows.NO_OF_DAYS),
//         DataGridCell(
//             columnName: 'DATE_APPLIED',
//             value: dataGridRows.DATE_APPLIED == null
//                 ? null
//                 : dataGridRows.DATE_APPLIED = DateFormat('dd-MMM-yyyy')
//                     .format(DateTime.parse(dataGridRows.DATE_APPLIED!))),
//         DataGridCell(columnName: 'Leave', value: dataGridRows.REASON),
//         DataGridCell(columnName: 'Leave', value: dataGridRows.APPROVED),
//       ]);
//     }).toList(growable: false);
//   }
// }

// class LeaveHistoryDataGrid extends StatefulWidget {
//   @override
//   State<LeaveHistoryDataGrid> createState() => _DataTableState();
// }

// class _DataTableState extends State<LeaveHistoryDataGrid> {
//   late sessionExpired sessionexpired = new sessionExpired(context);
//   Future<ProductDataGridSource2> getProductDataSource() async {
//     var productList = await fetchData();

//     return ProductDataGridSource2(productList);
//   }

//   late List<PendingLeaveModel> productList;
//   Future<List<PendingLeaveModel>> fetchData() async {
//     List<PendingLeaveModel> users = [];

//     Response response = await post(
//         Uri.parse("$ServerUrl/api/LeaveAPI/GetLeaveEmpQuery"),
//         headers: {
//           "MobileURL": "Leave_history",
//           "CPF_NO": globalInt.toString(),
//           "Authorization": "Bearer $JWT_Tokken"
//         },
//         body: {
//           "cpfNo": "42914",
//           "ouID": ouId.toString(),
//           "Flag": "LEAVE_HISTORY"
//         });
//     if (response.statusCode == 401) {
//       var isunauth = response.reasonPhrase;
//       if (isunauth == "Unauthorized") {
// // logic for login the user out
//         sessionexpired.LogoutUser();
//       }
//     }

//     // print(response.body);
//     try {
//       if (response.body != "" || response.body.isNotEmpty) {
//         var decode = json.decode(response.body);
//         var data = decode['Table'];
//         // print(data);

//         var decodeProduct = data.cast<Map<String, dynamic>>();
//         // print(decodeProduct);
//         productList = await decodeProduct
//             .map<PendingLeaveModel>((json) => PendingLeaveModel.fromJson(json))
//             .toList();

//         print(productList[1]);
//       } else {
//         showDialog(
//           context: context,
//           builder: (context) {
//             return const AlertDialog(
//               backgroundColor: Colors.red,
//               content: Text(
//                 'Error! No response from server',
//                 style: TextStyle(color: Colors.white),
//               ),
//             );
//           },
//         );
//       }
//     } catch (e) {
//       showDialog(
//         context: context,
//         builder: (context) {
//           return const AlertDialog(
//             backgroundColor: Colors.red,
//             content: Text(
//               'Error! No response from server',
//               style: TextStyle(color: Colors.white),
//             ),
//           );
//         },
//       );
//       print(e);
//     }
//     print(productList);
//     return productList;
//   }

//   List<GridColumn> getcolumns() {
//     return <GridColumn>[
//       GridTextColumn(
//           columnName: "#",
//           width: 40,
//           label: Container(
//             decoration: BoxDecoration(color: Colors.grey.shade300),
//             padding: EdgeInsets.all(8),
//             alignment: Alignment.center,
//             child: Text(
//               '#',

//               // overflow: TextOverflow.clip,
//               // softWrap: true,
//             ),
//           )),
//       GridTextColumn(
//           columnName: "Type",
//           width: 100,
//           label: Container(
//             decoration: BoxDecoration(color: Colors.grey.shade300),
//             padding: EdgeInsets.all(8),
//             alignment: Alignment.centerLeft,
//             child: Text(
//               'Type',

//               // overflow: TextOverflow.clip,
//               // softWrap: true,
//             ),
//           )),
//       GridTextColumn(
//           columnName: "From date",
//           width: 90,
//           label: Container(
//             color: Colors.grey.shade300,
//             padding: EdgeInsets.all(0),
//             alignment: Alignment.centerLeft,
//             child: Text(
//               'From date',
//               // overflow: TextOverflow.clip,
//               // softWrap: true,
//             ),
//           )),
//       GridTextColumn(
//           columnName: "To date",
//           width: 90,
//           label: Container(
//             color: Colors.grey.shade300,
//             padding: EdgeInsets.all(8),
//             alignment: Alignment.centerLeft,
//             child: Text(
//               'To date',
//               // overflow: TextOverflow.clip,
//               // softWrap: true,
//             ),
//           )),
//       GridTextColumn(
//           columnName: "Days",
//           width: 70,
//           label: Container(
//             color: Colors.grey.shade300,
//             padding: EdgeInsets.all(8),
//             alignment: Alignment.center,
//             child: Text(
//               'Days',
//               // overflow: TextOverflow.clip,
//               // softWrap: true,
//             ),
//           )),
//       GridTextColumn(
//           columnName: "Applied Date",
//           width: 90,
//           label: Container(
//             color: Colors.grey.shade300,
//             padding: EdgeInsets.all(0),
//             alignment: Alignment.centerLeft,
//             child: Text(
//               'Applied Date',
//               overflow: TextOverflow.clip,
//               // softWrap: true,
//             ),
//           )),
//       GridTextColumn(
//           columnName: "Reason",
//           width: 90,
//           label: Container(
//             color: Colors.grey.shade300,
//             padding: EdgeInsets.all(0),
//             alignment: Alignment.center,
//             child: Text(
//               'Reason',
//               overflow: TextOverflow.clip,
//               // softWrap: true,
//             ),
//           )),
//       GridTextColumn(
//           columnName: "Approved/Rejected",
//           width: 90,
//           label: Container(
//             color: Colors.grey.shade300,
//             padding: EdgeInsets.all(0),
//             alignment: Alignment.centerLeft,
//             child: Text(
//               'Approved/Rejected',
//               overflow: TextOverflow.clip,
//               // softWrap: true,
//             ),
//           )),
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: SingleChildScrollView(
//         child: RefreshIndicator(
//           color: securePurpleColor,
//           onRefresh: fetchData,
//           child: Container(
//               height: MediaQuery.of(context).size.height,
//               //color: Color.fromA
//               //RGB(255, 253, 49, 49),
//               child: FutureBuilder(
//                 future: getProductDataSource(),
//                 builder:
//                     (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//                   return snapshot.hasData
//                       ? SfDataGrid(source: snapshot.data, columns: getcolumns())
//                       : Center(
//                           child: CircularProgressIndicator(
//                             color: securePurpleColor,
//                             strokeWidth: 3,
//                           ),
//                         );
//                 },
//               )),
//         ),
//       ),
//     );
//   }
// }
class LeaveHistoryDataGrid extends StatefulWidget {
  const LeaveHistoryDataGrid({Key? key}) : super(key: key);

  @override
  State<LeaveHistoryDataGrid> createState() => _LeaveHistoryDataGridState();
}

late List<PendingLeaveModel> emplist;

int count = 0;

class _LeaveHistoryDataGridState extends State<LeaveHistoryDataGrid> {
  late MyHttpClient myHttpClient = new MyHttpClient(context);
  Future<List<PendingLeaveModel>> fetchResults() async {
    DateTime now = new DateTime.now();
    Map data = {
      "cpfNo": globalInt,
      "ouID": ouId.toString(),
      "Flag": "LEAVE_HISTORY"
    };

    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    count = 0;
    String _apiendpoint = "$ServerUrl/api/LeaveAPI/GetLeaveEmpQuery";
    Response? response = await myHttpClient.PostMethod(
        _apiendpoint, data, "Leave_history", true);
    // Response response = await post(
    //     Uri.parse("$ServerUrl/api/LeaveAPI/GetLeaveEmpQuery"),
    //     headers: {
    //       "MobileURL": "Leave_history",
    //       "CPF_NO": globalInt.toString(),
    //       "Authorization": "Bearer $JWT_Tokken"
    //     },
    //     body: {
    //       "cpfNo": globalInt,
    //       "ouID": ouId.toString(),
    //       "Flag": "LEAVE_HISTORY"
    //     });

    try {
      var decode = json.decode(response!.body);
      if (decode.isNotEmpty) {
        var decode = json.decode(response.body);
        var data = decode['Table'];
        // print(data);

        var decodeProduct = data.cast<Map<String, dynamic>>();
        // print(decodeProduct);
        emplist = await decodeProduct
            .map<PendingLeaveModel>((json) => PendingLeaveModel.fromJson(json))
            .toList();
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.red,
              content: Text(
                'Error! No response from server',
                style: TextStyle(color: Colors.white),
              ),
            );
          },
        );
      }
    } catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.red,
            content: Text(
              'Error! $e',
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      );
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
            FutureBuilder<List<PendingLeaveModel>>(
              initialData: const <PendingLeaveModel>[],
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
                        DataColumn(label: Text('Type')),
                        DataColumn(label: Text('From Date')),
                        DataColumn(label: Text('To Date')),
                        DataColumn(label: Text('Days')),
                        DataColumn(label: Text('Applied Date')),
                        DataColumn(label: Text('Reason')),
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
                              Text(emp.LEAVE_NAME.toString()),
                              onTap: () => showCard(emp),
                            ),
                            DataCell(
                              Text(emp.FROM_DATE == null
                                  ? "null"
                                  : emp.FROM_DATE = DateFormat('dd-MMM-yyyy')
                                      .format(DateTime.parse(emp.FROM_DATE!))),
                              onTap: () => showCard(emp),
                            ),
                            DataCell(
                              Text(emp.TO_DATE == null
                                  ? "null"
                                  : emp.TO_DATE = DateFormat('dd-MMM-yyyy')
                                      .format(DateTime.parse(emp.TO_DATE!))),
                              onTap: () => showCard(emp),
                            ),
                            DataCell(
                              Text(emp.NO_OF_DAYS.toString()),
                              onTap: () => showCard(emp),
                            ),
                            DataCell(
                              Text(emp.DATE_APPLIED == null
                                  ? "null"
                                  : emp.DATE_APPLIED = DateFormat('dd-MMM-yyyy')
                                      .format(
                                          DateTime.parse(emp.DATE_APPLIED!))),
                              onTap: () => showCard(emp),
                            ),
                            DataCell(
                              Text(emp.REASON == null ? "" : emp.REASON!),
                              onTap: () => showCard(emp),
                            ),
                            DataCell(
                              Text(emp.APPROVED!),
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

  showCard(PendingLeaveModel emp) {
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
                        "Leave history",
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
                          "Type:  ",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          emp.LEAVE_NAME.toString(),
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
                          "From Date:  ",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Text(emp.FROM_DATE!),
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
                          "To Date:  ",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Text(emp.TO_DATE!),
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
                          "Days:  ",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Text(emp.NO_OF_DAYS.toString()
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
                          "Applied Date:  ",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Text(emp.DATE_APPLIED == null ? "" : emp.DATE_APPLIED!),
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
                          "Reason:  ",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          emp.REASON == null ? "" : emp.REASON!,
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
                        Text(emp.APPROVED!),
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
