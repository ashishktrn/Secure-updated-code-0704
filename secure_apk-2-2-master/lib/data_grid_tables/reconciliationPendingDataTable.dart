import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:secure_apk/models/pendingReconciliationModel.dart';
import '../globals.dart';
import '../hours_reconciliation.dart';
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
//       ]);
//     }).toList(growable: false);
//   }
// }

// class ReconciliationPendingDataGrid extends StatefulWidget {
//   @override
//   State<ReconciliationPendingDataGrid> createState() => _DataTableState();
// }

// class _DataTableState extends State<ReconciliationPendingDataGrid> {
//   Future<ProductDataGridSource2> getProductDataSource() async {
//     var productList = await fetchData();

//     return ProductDataGridSource2(productList);
//   }

//   late List<PendingReconciliationModel> productList;
//   Future<List<PendingReconciliationModel>> fetchData() async {
//     List<PendingLeaveModel> users = [];

//     Response response = await post(
//         Uri.parse(
//             "http://172.16.15.129:8073/api/LeaveAPI/GetAdjustmentHistory"),
//         headers: {
//           "MobileURL": "hoursReconciliationPending",
//           "CPF_NO": globalInt.toString()
//         },
//         body: {
//           "cpfNo": globalInt.toString(),
//           "ouID": "94",
//           "Flag": "N"
//         });
//     // print(response.body);
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
//                       color: Color.fromRGBO(123, 34, 83, 1),
//                       strokeWidth: 3,
//                     ),
//                   );
//           },
//         )),
//       ),
//     );
//   }
// }

class ReconciliationPendingDataGrid extends StatefulWidget {
  const ReconciliationPendingDataGrid({Key? key}) : super(key: key);

  @override
  State<ReconciliationPendingDataGrid> createState() =>
      _ReconciliationPendingDataGridState();
}

late List<PendingReconciliationModel> emplist;

int count = 0;

class _ReconciliationPendingDataGridState
    extends State<ReconciliationPendingDataGrid> {
  late MyHttpClient myHttpClient = new MyHttpClient(context);
  Future<List<PendingReconciliationModel>> fetchResults() async {
    count = 0;
    Map data = {
      "cpfNo": globalInt.toString(),
      "ouID": ouId.toString(),
      "Flag": "N"
    };
    String _apiendpoint = "$ServerUrl/api/LeaveAPI/GetAdjustmentHistory";
    Response? response = await myHttpClient.PostMethod(
        _apiendpoint, data, "hoursReconciliationPending", true);
    // Response response = await post(
    //     Uri.parse(
    //         "$ServerUrl/api/LeaveAPI/GetAdjustmentHistory"),
    //     headers: {
    //       "MobileURL": "hoursReconciliationPending",
    //       "CPF_NO": globalInt.toString(),
    //       "Authorization": "Bearer $JWT_Tokken"
    //     },
    //     body: {
    //       "cpfNo": globalInt.toString(),
    //       "ouID": ouId.toString(),
    //       "Flag": "N"
    //     });

    try {
      var decode = json.decode(response!.body);
      if (decode.isNotEmpty) {
        var data = decode['Table'];

        var resultsJson = data.cast<Map<String, dynamic>>();
        emplist = await resultsJson
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
                        DataColumn(label: Text('Action')),
                        DataColumn(label: Text('Adjustment Type')),
                        DataColumn(label: Text('Reason')),
                        DataColumn(label: Text('Date')),
                        DataColumn(label: Text('From Hours')),
                        DataColumn(label: Text('To Hours')),
                        DataColumn(label: Text('Total Hours')),
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
                              Row(
                                children: [
                                  IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () {
                                        // Hours_Reconciliation(
                                        //     adjusttmentforedit: emp.ADJUSTMENT,
                                        //     dateforedit: emp.DATE_OF_ENTRY,
                                        //     fromhourforedit: emp.FROM_TIME,
                                        //     reasonforedit: emp.REASON,
                                        //     tohourforedit: emp.TO_TIME,
                                        //     totalhourforedit: emp.TOT_HOURS);
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    showcasewidgetAdjustment(
                                                      APPROVED: emp.APPROVED,
                                                      SerialNo: emp.SL_NO,
                                                      dateforedit:
                                                          emp.DATE_OF_ENTRY,
                                                      adjusttmentforedit:
                                                          emp.ADJUSTMENTTYPE,
                                                      reasonforedit: emp.REASON,
                                                      fromhourforedit:
                                                          emp.FROM_TIME,
                                                      tohourforedit:
                                                          emp.TO_TIME,
                                                      totalhourforedit:
                                                          emp.TOT_HOURS,
                                                      edit: 1,
                                                    )));

                                        // Navigator.pushNamed(
                                        //     context, "hoursReconciliation");
                                      }),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        var cpfNo = globalInt.toString();
                                        var serialNo = emp.SL_NO;

                                        showDialog(
                                          context: context,
                                          builder: (dialogcontext) =>
                                              new AlertDialog(
                                            title: Text("Confirm"),
                                            content: Text(
                                                "Are you sure you want to delete this record?"),
                                            actions: [
                                              TextButton(
                                                  onPressed: () async {
                                                    try {
                                                      Map data = {
                                                        "cpfNo":
                                                            cpfNo.toString(),
                                                        "serialNo":
                                                            serialNo.toString(),
                                                        "ouId": ouId.toString()
                                                      };
                                                      Navigator.pop(
                                                          context, false);
                                                      _openLoadingDialog(
                                                          context);
                                                      String _apiendpoint =
                                                          "$ServerUrl/api/LeaveAPI/DeleteHoursAdj";
                                                      Response? response =
                                                          await myHttpClient
                                                              .PostMethod(
                                                                  _apiendpoint,
                                                                  data,
                                                                  "hoursReconciliationPending",
                                                                  true);
                                                      // Response response =
                                                      //     await post(
                                                      //         Uri.parse(
                                                      //             "$ServerUrl/api/LeaveAPI/DeleteHoursAdj"),
                                                      //         headers: {
                                                      //       "MobileURL":
                                                      //           "Pending_leaves",
                                                      //       "CPF_NO": globalInt
                                                      //           .toString(),
                                                      //       "Authorization":
                                                      //           "Bearer $JWT_Tokken"
                                                      //     },
                                                      //         body: {
                                                      //       "cpfNo": cpfNo
                                                      //           .toString(),
                                                      //       "serialNo": serialNo
                                                      //           .toString(),
                                                      //       "ouId":
                                                      //           ouId.toString()
                                                      //     });
                                                      Navigator.pop(
                                                          context, false);

                                                      var resopnseFromApi =
                                                          json.decode(
                                                              response!.body);
                                                      var status =
                                                          resopnseFromApi[
                                                              "status"];
                                                      var messege =
                                                          resopnseFromApi[
                                                              "message"];

                                                      if (status == 1) {
                                                        // Navigator.pop(
                                                        //     context, false);
                                                        // SweetAlert.show(context,
                                                        //     title: "Success",
                                                        //     subtitle:
                                                        //         "Leave deleted Successfuly",
                                                        //     // onPress: Navigator.pop(context, false),
                                                        //     style: SweetAlertStyle
                                                        //         .success);
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return AlertDialog(
                                                              backgroundColor:
                                                                  Colors.green,
                                                              content: Text(
                                                                'Adjustment deleted Successfuly',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                        setState(() {
                                                          fetchResults();
                                                        });
                                                      } else {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(SnackBar(
                                                                content: Text(
                                                                    messege)));
                                                      }
                                                    } catch (e) {
                                                      print(e);
                                                    }
                                                  },
                                                  child: Text("Yes")),
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(
                                                        context, false);
                                                  },
                                                  child: Text("No")),
                                            ],
                                          ),
                                        );
                                      },
                                      icon: Icon(Icons.delete)),
                                ],
                              ),
                              onTap: () => showCard(emp),
                            ),
                            DataCell(
                              Text(emp.ADJUSTMENT.toString()),
                              onTap: () => showCard(emp),
                            ),
                            DataCell(
                              Text(emp.REASON.toString()),
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

  void _openLoadingDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Container(
            width: 30,
            height: 110,
            child: Center(
              child: CustomLoader(
                dotColor: Global_User_theme,
              ),
            ),
          ),
        );
      },
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
                        "Pending Adjustment",
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
                          "Adjustment type:  ",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          emp.ADJUSTMENTTYPE.toString(),
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
                          "Reason:  ",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          emp.REASON.toString(),
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
                          "From hours:  ",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          emp.FROM_TIME,
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
                          "To hours:  ",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          emp.TO_TIME,
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
                        Text(
                          emp.TOT_HOURS,
                          // style: TextStyle(
                          //     color: Colors.black, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Center(
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => showcasewidgetAdjustment(
                                      APPROVED: emp.APPROVED,
                                      SerialNo: emp.SL_NO,
                                      dateforedit: emp.DATE_OF_ENTRY,
                                      adjusttmentforedit: emp.ADJUSTMENTTYPE,
                                      reasonforedit: emp.REASON,
                                      fromhourforedit: emp.FROM_TIME,
                                      tohourforedit: emp.TO_TIME,
                                      totalhourforedit: emp.TOT_HOURS,
                                      edit: 1,
                                    )));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 20,
                              //  margin: EdgeInsets.symmetric(horizontal: 100.w),
                              width: 60,
                              decoration: BoxDecoration(
                                color: Global_User_theme,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  "Edit",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            var cpfNo = globalInt.toString();
                            var serialNo = emp.SL_NO;

                            showDialog(
                              context: context,
                              builder: (dialogcontext) => new AlertDialog(
                                title: Text("Confirm"),
                                content: Text(
                                    "Are you sure you want to delete this record?"),
                                actions: [
                                  TextButton(
                                      onPressed: () async {
                                        try {
                                          Navigator.pop(context, false);
                                          Navigator.pop(context, false);
                                          _openLoadingDialog(context);
                                          Map data = {
                                            "cpfNo": cpfNo.toString(),
                                            "serialNo": serialNo.toString(),
                                            "ouId": ouId.toString()
                                          };

                                          String _apiendpoint =
                                              "$ServerUrl/api/LeaveAPI/DeleteHoursAdj";
                                          Response? response =
                                              await myHttpClient.PostMethod(
                                                  _apiendpoint,
                                                  data,
                                                  "hoursReconciliationPending",
                                                  true);
                                          // Response response = await post(
                                          //     Uri.parse(
                                          //         "$ServerUrl/api/LeaveAPI/DeleteHoursAdj"),
                                          //     headers: {
                                          //       "MobileURL": "Pending_leaves",
                                          //       "CPF_NO": globalInt.toString(),
                                          //       "Authorization":
                                          //           "Bearer $JWT_Tokken"
                                          //     },
                                          //     body: {
                                          //       "cpfNo": cpfNo.toString(),
                                          //       "serialNo": serialNo.toString(),
                                          //       "ouId": ouId.toString()
                                          //     });

                                          var resopnseFromApi =
                                              json.decode(response!.body);
                                          var status =
                                              resopnseFromApi["status"];
                                          var messege =
                                              resopnseFromApi["message"];
                                          Navigator.pop(context, false);

                                          if (status == 1) {
                                            // Navigator.pop(
                                            //     context, false);
                                            // SweetAlert.show(context,
                                            //     title: "Success",
                                            //     subtitle:
                                            //         "Leave deleted Successfuly",
                                            //     // onPress: Navigator.pop(context, false),
                                            //     style: SweetAlertStyle
                                            //         .success);
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  backgroundColor: Colors.green,
                                                  content: Text(
                                                    'Adjustment deleted Successfuly',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                );
                                              },
                                            );

                                            setState(() {
                                              fetchResults();
                                            });
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(messege)));
                                          }
                                        } catch (e) {
                                          print(e);
                                        }
                                      },
                                      child: Text("Yes")),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, false);
                                      },
                                      child: Text("No")),
                                ],
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 20,
                              //  margin: EdgeInsets.symmetric(horizontal: 100.w),
                              width: 60,
                              decoration: BoxDecoration(
                                color: Global_User_theme,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  "Delete",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
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
