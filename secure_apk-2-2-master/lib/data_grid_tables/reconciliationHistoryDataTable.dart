import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:secure_apk/models/pendingReconciliationModel.dart';
import '../globals.dart';
import '../reuseablewidgets.dart/Common.dart';
import '../reuseablewidgets.dart/colors.dart';
import '../reuseablewidgets.dart/loder.dart';
import '../reuseablewidgets.dart/sessionexpire.dart';

// class ProductDataGridSource2 extends DataGridSource {
//   ProductDataGridSource2(this.productList) {
//     buildDataGridRow();
//   }

//   late List<DataGridRow> dataGridRows;
//   late List<PendingReconciliationModel> productList;
//   int count = 0;
//   var toDate;
//   var FromDate;
//   var applied_Date;

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
//         alignment: Alignment.center,
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
//         DataGridCell(columnName: 'Leave', value: dataGridRows.ADJUSTMENT),
//         DataGridCell(columnName: 'Leave', value: dataGridRows.REASON),
//         DataGridCell(
//             columnName: 'From date',
//             value: dataGridRows.DATE_OF_ENTRY == null
//                 ? null
//                 : dataGridRows.DATE_OF_ENTRY = DateFormat('dd-MMM-yyyy')
//                     .format(DateTime.parse(dataGridRows.DATE_OF_ENTRY))),
//         DataGridCell(columnName: 'No of days', value: dataGridRows.FROM_TIME),
//         DataGridCell(columnName: 'Leave', value: dataGridRows.TO_TIME),
//         DataGridCell(columnName: 'Leave', value: dataGridRows.TOT_HOURS),
//         DataGridCell(
//             columnName: 'Leave',
//             value:
//                 dataGridRows.APPROVED.contains("Y") ? "Approved" : "Pending"),
//       ]);
//     }).toList(growable: false);
//   }
// }

// class ReconciliationHistoryDataGrid extends StatefulWidget {
//   @override
//   State<ReconciliationHistoryDataGrid> createState() => _DataTableState();
// }

// class _DataTableState extends State<ReconciliationHistoryDataGrid> {
//   Future<ProductDataGridSource2> getProductDataSource() async {
//     var productList = await fetchData();

//     return ProductDataGridSource2(productList);
//   }

//   late List<PendingReconciliationModel> productList;
//   Future<List<PendingReconciliationModel>> fetchData() async {
//     late sessionExpired sessionexpired = new sessionExpired(context);
//     List<PendingLeaveModel> users = [];

//     Response response = await post(
//         Uri.parse(
//             "$ServerUrl/api/LeaveAPI/GetAdjustmentHistory"),
//         headers: {
//           "MobileURL": "hoursReconciliationHistory",
//           "CPF_NO": globalInt.toString(),
//           "Authorization": "Bearer $JWT_Tokken"
//         },
//         body: {
//           "cpfNo": globalInt.toString(),
//           "ouID": ouId.toString(),
//           "Flag": "Y"
//         });
//     // print(response.body);

//     if (response.statusCode == 401) {
//       var isunauth = response.reasonPhrase;
//       if (isunauth == "Unauthorized") {
//         sessionexpired.LogoutUser();
// // logic for login the user out

//       }
//     }

//     try {
//       var decode = json.decode(response.body);
//       var data = decode['Table'];
//       // print(data);

//       var decodeProduct = data.cast<Map<String, dynamic>>();
//       // print(decodeProduct);
//       productList = await decodeProduct
//           .map<PendingReconciliationModel>(
//               (json) => PendingReconciliationModel.fromJson(json))
//           .toList();

//       print(productList[1]);
//     } catch (e) {
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
//           columnName: "Adjustment type",
//           width: 100,
//           label: Container(
//             decoration: BoxDecoration(color: Colors.grey.shade300),
//             padding: EdgeInsets.all(8),
//             alignment: Alignment.centerLeft,
//             child: Text(
//               'Adjustment type',

//               // overflow: TextOverflow.clip,
//               // softWrap: true,
//             ),
//           )),
//       GridTextColumn(
//           columnName: "Reason",
//           width: 90,
//           label: Container(
//             color: Colors.grey.shade300,
//             padding: EdgeInsets.all(0),
//             alignment: Alignment.centerLeft,
//             child: Text(
//               'Reason',
//               // overflow: TextOverflow.clip,
//               // softWrap: true,
//             ),
//           )),
//       GridTextColumn(
//           columnName: "Date",
//           width: 90,
//           label: Container(
//             color: Colors.grey.shade300,
//             padding: EdgeInsets.all(8),
//             alignment: Alignment.centerLeft,
//             child: Text(
//               'Date',
//               // overflow: TextOverflow.clip,
//               // softWrap: true,
//             ),
//           )),
//       GridTextColumn(
//           columnName: "From Hour",
//           width: 90,
//           label: Container(
//             color: Colors.grey.shade300,
//             padding: EdgeInsets.all(8),
//             alignment: Alignment.center,
//             child: Text(
//               'From Hour',
//               // overflow: TextOverflow.clip,
//               // softWrap: true,
//             ),
//           )),
//       GridTextColumn(
//           columnName: "To Hour",
//           width: 90,
//           label: Container(
//             color: Colors.grey.shade300,
//             padding: EdgeInsets.all(0),
//             alignment: Alignment.centerLeft,
//             child: Text(
//               'To Hour',
//               overflow: TextOverflow.clip,
//               // softWrap: true,
//             ),
//           )),
//       GridTextColumn(
//           columnName: "Total Hours",
//           width: 90,
//           label: Container(
//             color: Colors.grey.shade300,
//             padding: EdgeInsets.all(0),
//             alignment: Alignment.center,
//             child: Text(
//               'Total Hours',
//               overflow: TextOverflow.clip,
//               // softWrap: true,
//             ),
//           )),
//       GridTextColumn(
//           columnName: "Status",
//           width: 90,
//           label: Container(
//             color: Colors.grey.shade300,
//             padding: EdgeInsets.all(0),
//             alignment: Alignment.center,
//             child: Text(
//               'Status',
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
//         child: Container(
//             height: MediaQuery.of(context).size.height,
//             //color: Color.fromA
//             //RGB(255, 253, 49, 49),
//             child: FutureBuilder(
//               future: getProductDataSource(),
//               builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//                 return snapshot.hasData
//                     ? SfDataGrid(source: snapshot.data, columns: getcolumns())
//                     : Center(
//                         child: CircularProgressIndicator(
//                           color: securePurpleColor,
//                           strokeWidth: 3,
//                         ),
//                       );
//               },
//             )),
//       ),
//     );
//   }
// }
class ReconciliationHistoryDataGrid extends StatefulWidget {
  const ReconciliationHistoryDataGrid({Key? key}) : super(key: key);

  @override
  State<ReconciliationHistoryDataGrid> createState() =>
      _ReconciliationHistoryDataGridState();
}

late List<PendingReconciliationModel> emplist;

int count = 0;

class _ReconciliationHistoryDataGridState
    extends State<ReconciliationHistoryDataGrid> {
  late MyHttpClient myHttpClient = new MyHttpClient(context);
  Future<List<PendingReconciliationModel>> fetchResults() async {
    DateTime now = new DateTime.now();

    String formattedDate = DateFormat('yyyy-MM-dd').format(now);

    count = 0;
    Map data = {
      "cpfNo": globalInt.toString(),
      "ouID": ouId.toString(),
      "Flag": "Y"
    };
    String _apiendpoint = "$ServerUrl/api/LeaveAPI/GetAdjustmentHistory";
    Response? response = await myHttpClient.PostMethod(
        _apiendpoint, data, "hoursReconciliationHistory", true);
    // Response response = await post(
    //     Uri.parse(
    //         "$ServerUrl/api/LeaveAPI/GetAdjustmentHistory"),
    //     headers: {
    //       "MobileURL": "hoursReconciliationHistory",
    //       "CPF_NO": globalInt.toString(),
    //       "Authorization": "Bearer $JWT_Tokken"
    //     },
    //     body: {
    //       "cpfNo": globalInt.toString(),
    //       "ouID": ouId.toString(),
    //       "Flag": "Y"
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
            .map<PendingReconciliationModel>(
                (json) => PendingReconciliationModel.fromJson(json))
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
            FutureBuilder<List<PendingReconciliationModel>>(
              initialData: const <PendingReconciliationModel>[],
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
                        DataColumn(label: Text('Adjustment Type')),
                        DataColumn(label: Text('Date')),
                        DataColumn(label: Text('From Hour')),
                        DataColumn(label: Text('To Hour')),
                        DataColumn(label: Text('Total Hours')),
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
                              Text(emp.ADJUSTMENT.toString()),
                              onTap: () => showCard(emp),
                            ),
                            DataCell(
                              Text(emp.DATE_OF_ENTRY == null
                                  ? "null"
                                  : emp.DATE_OF_ENTRY =
                                      DateFormat('dd-MMM-yyyy').format(
                                          DateTime.parse(emp.DATE_OF_ENTRY))),
                              onTap: () => showCard(emp),
                            ),
                            DataCell(
                              Text(emp.FROM_TIME),
                              onTap: () => showCard(emp),
                            ),
                            DataCell(
                              Text(emp.TO_TIME),
                              onTap: () => showCard(emp),
                            ),
                            DataCell(
                              Text(emp.TOT_HOURS),
                              onTap: () => showCard(emp),
                            ),
                            DataCell(
                              Text(emp.REASON),
                              onTap: () => showCard(emp),
                            ),
                            DataCell(
                              Text(emp.APPROVED.contains("Y")
                                  ? "Approved"
                                  : "Pending"),
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

  showCard(PendingReconciliationModel emp) {
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
                        "Reconciliation history",
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
                          "Adjustment Type:  ",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          emp.ADJUSTMENT.toString(),
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
                          "Date:  ",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Text(emp.DATE_OF_ENTRY),
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
                          "From Hours:  ",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Text(emp.FROM_TIME
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
                          "To Hours:  ",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Text(emp.TO_TIME
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
                          "Total hours:  ",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Text(emp.TOT_HOURS
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
                          "Reason:  ",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          emp.REASON,
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
                        Text(emp.APPROVED.contains("Y")
                            ? "Approved"
                            : "Pending"),
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
