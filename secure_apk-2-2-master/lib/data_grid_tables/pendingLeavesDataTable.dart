import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:secure_apk/leave_request.dart';
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
//     ]);
//   }

//   @override
//   // TODO: implement rows
//   List<DataGridRow> get rows => dataGridRows;

//   void buildDataGridRow() {
//     dataGridRows = productList.map<DataGridRow>((dataGridRows) {
//       return DataGridRow(cells: [
//         DataGridCell(columnName: 'Leave', value: count = count + 1),
//         DataGridCell(columnName: 'Leave', value: dataGridRows.LEAVE),
//         DataGridCell(
//             columnName: 'From date',
//             value: FromDate = DateFormat('dd-MMM-yyyy')
//                 .format(DateTime.parse(dataGridRows.FROM_DATE))),
//         DataGridCell(
//             columnName: 'To date',
//             value: toDate = DateFormat('dd-MMM-yyyy')
//                 .format(DateTime.parse(dataGridRows.TO_DATE))),
//         DataGridCell(columnName: 'No of days', value: dataGridRows.NO_OF_DAYS),
//         DataGridCell(
//             columnName: 'DATE_APPLIED',
//             value: applied_Date = DateFormat('dd-MMM-yyyy')
//                 .format(DateTime.parse(dataGridRows.DATE_APPLIED))),
//       ]);
//     }).toList(growable: false);
//   }
// }

// class PendingLeaveDataGrid extends StatefulWidget {
//   @override
//   State<PendingLeaveDataGrid> createState() => _DataTableState();
// }

// class _DataTableState extends State<PendingLeaveDataGrid> {
//   Future<ProductDataGridSource2> getProductDataSource() async {
//     var productList = await fetchData();

//     return ProductDataGridSource2(productList);
//   }

//   late List<PendingLeaveModel> productList;
//   Future<List<PendingLeaveModel>> fetchData() async {
//     List<PendingLeaveModel> users = [];

//     Response response = await post(
//         Uri.parse("http://172.16.15.129:8073/api/LeaveAPI/GetLeaveEmpQuery"),
//         body: {"cpfNo": "42914", "ouID": "94", "Flag": "PENDING_LEAVES"});
//     // print(response.body);
//     try {
//       var decode = json.decode(response.body);
//       var data = decode['Table'];
//       // print(data);

//       var decodeProduct = data.cast<Map<String, dynamic>>();
//       // print(decodeProduct);
//       productList = await decodeProduct
//           .map<PendingLeaveModel>((json) => PendingLeaveModel.fromJson(json))
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
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: SingleChildScrollView(
//         child: RefreshIndicator(
//           color: Color.fromRGBO(123, 34, 83, 1),
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
//                             color: Color.fromRGBO(123, 34, 83, 1),
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

class Pending_Leave_DataGrid extends StatefulWidget {
  const Pending_Leave_DataGrid({Key? key}) : super(key: key);

  @override
  State<Pending_Leave_DataGrid> createState() => _Pending_Leave_DataGridState();
}

int count = 0;

late List<PendingLeaveModel> emplist;
bool _isLoading = false;

class _Pending_Leave_DataGridState extends State<Pending_Leave_DataGrid> {
  late MyHttpClient myHttpClient = new MyHttpClient(context);
  late sessionExpired sessionexpired = new sessionExpired(context);
  Future<List<PendingLeaveModel>> fetchResults() async {
    count = 0;
    Map data = {
      "cpfNo": globalInt,
      "ouID": ouId.toString(),
      "Flag": "PENDING_LEAVES",
    };
    String _apiendpoint = "$ServerUrl/api/LeaveAPI/GetLeaveEmpQuery";
    Response? response = await myHttpClient.PostMethod(
        _apiendpoint, data, "Pending_leaves", true);
    // Response response = await post(
    //     Uri.parse("$ServerUrl/api/LeaveAPI/GetLeaveEmpQuery"),
    //     headers: {
    //       "MobileURL": "Pending_leaves",
    //       "CPF_NO": globalInt.toString(),
    //       "Authorization": "Bearer $JWT_Tokken"
    //     },
    //     body: {
    //       "cpfNo": globalInt,
    //       "ouID": ouId.toString(),
    //       "Flag": "PENDING_LEAVES"
    //     });

    try {
      var decode = json.decode(response!.body);
      if (decode.isNotEmpty) {
        var data = decode['Table'];

        var resultsJson = data.cast<Map<String, dynamic>>();
        emplist = await resultsJson
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
              'Error!  $e',
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      );
      print("error");
    }
    return emplist;
  }

  late bool hasInternet;
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
                    physics: AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics()),
                    scrollDirection: Axis.vertical,
                    child: DataTable(
                      showBottomBorder: true,
                      border: TableBorder.all(
                        width: 0.1,
                      ),
                      columns: const [
                        DataColumn(label: Text('#')),
                        DataColumn(label: Text('Action')),
                        DataColumn(label: Text('Type')),
                        DataColumn(label: Text('From Date')),
                        DataColumn(label: Text('To Date')),
                        DataColumn(label: Text('Days')),
                        DataColumn(label: Text('Applied Date')),
                      ],
                      rows: List.generate(
                        snapshot.data!.length,
                        (index) {
                          var emp = snapshot.data![index];
                          return DataRow(cells: [
                            DataCell(
                              Text((count = count + 1).toString()),
                              onTap: () => showCard(emp),
                            ),
                            DataCell(
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  showcasewidgetLeave(
                                                      //before using LeaveRequest
                                                      TYPE_OF_LEAVE:
                                                          emp.TYPE_OF_LEAVE!,
                                                      From_timeFor_edit:
                                                          emp.FROM_TIME!,
                                                      To_timeFor_edit:
                                                          emp.TO_TIME!,
                                                      reasonforedit:
                                                          emp.REASON ?? "",
                                                      edit: 1,
                                                      SerialNo: emp.SERIAL_NO!
                                                          .toInt(),
                                                      APPROVED: emp.APPROVED!,
                                                      FROM_1HALF_FLAGforedit:
                                                          emp.FROM_1HALF_FLAG!,
                                                      FROM_2HALF_FLAGforedit:
                                                          emp.FROM_2HALF_FLAG!,
                                                      To_1HALF_FLAGforedit:
                                                          emp.TO_1HALF_FLAG!,
                                                      To_2HALF_FLAGforedit:
                                                          emp.TO_2HALF_FLAG!,
                                                      fromdateforedit:
                                                          emp.FROM_DATE!,
                                                      leaveTypeforedit:
                                                          emp.LEAVE_ID ?? 0,
                                                      todateforedit:
                                                          emp.TO_DATE!,
                                                      totaldaysforedit:
                                                          emp.NO_OF_DAYS!)));
                                    },
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        var cpfNo = globalInt.toString();
                                        var serialNo = emp.SERIAL_NO!.toInt();
                                        // if (serialNo.contains(".")) {

                                        //   var data =
                                        //       serialNo.toString().split(".");
                                        //   print(data);
                                        // }

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
                                                      Navigator.pop(
                                                          context, false);
                                                      _openLoadingDialog(
                                                          context);
                                                      Map data = {
                                                        "cpfNo": globalInt,
                                                        "serialNo":
                                                            serialNo.toString(),
                                                      };
                                                      String _apiendpoint =
                                                          "$ServerUrl//api/LeaveAPI/DeleteLeave";
                                                      Response? response =
                                                          await myHttpClient
                                                              .PostMethod(
                                                                  _apiendpoint,
                                                                  data,
                                                                  "Pending_leaves",
                                                                  true);

                                                      // Response response =
                                                      //     await post(
                                                      //         Uri.parse(
                                                      //             "$ServerUrl//api/LeaveAPI/DeleteLeave"),
                                                      //         headers: {
                                                      //       "MobileURL":
                                                      //           "Pending_leaves",
                                                      //       "CPF_NO": globalInt
                                                      //           .toString(),
                                                      //       "Authorization":
                                                      //           "Bearer $JWT_Tokken"
                                                      //     },
                                                      //         body: {
                                                      //       "cpfNo": globalInt,
                                                      //       "serialNo": serialNo
                                                      //           .toString(),
                                                      //     });

                                                      var resopnseFromApi =
                                                          json.decode(
                                                              response!.body);
                                                      var status =
                                                          resopnseFromApi[
                                                              "status"];
                                                      var messege =
                                                          resopnseFromApi[
                                                              "message"];
                                                      Navigator.pop(
                                                          context, false);

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
                                                                '✓Leave deleted Successfuly',
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
                                                                    "Something Went Wrong ")));
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
                                      icon: Icon(Icons.delete))
                                ],
                              ),
                              onTap: () => showCard(emp),
                            ),
                            DataCell(
                              Text(emp.LEAVE.toString()),
                              onTap: () => showCard(emp),
                            ),
                            DataCell(
                              Text(
                                DateFormat('dd-MMM-yyyy')
                                    .format(DateTime.parse(emp.FROM_DATE!)),
                              ),
                              onTap: () => showCard(emp),
                            ),
                            DataCell(
                              Text(
                                DateFormat('dd-MMM-yyyy')
                                    .format(DateTime.parse(emp.TO_DATE!)),
                              ),
                              onTap: () => showCard(emp),
                            ),
                            DataCell(
                              Text(emp.NO_OF_DAYS.toString()),
                              onTap: () => showCard(emp),
                            ),
                            DataCell(
                              Text(
                                DateFormat('dd-MMM-yyyy')
                                    .format(DateTime.parse(emp.DATE_APPLIED!)),
                              ),
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
              //  borderRadius: BorderRadius.circular(20.0),
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
                        "Pending Leave",
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
                          emp.LEAVE.toString(),
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
                          "From Date:  ",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          DateFormat('dd-MMM-yyyy')
                              .format(DateTime.parse(emp.FROM_DATE!)),
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
                          "To Date:  ",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          DateFormat('dd-MMM-yyyy')
                              .format(DateTime.parse(emp.TO_DATE!)),
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
                          "Days:  ",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          emp.NO_OF_DAYS.toString(),
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
                          "Applied Date:  ",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          DateFormat('dd-MMM-yyyy')
                              .format(DateTime.parse(emp.DATE_APPLIED!)),
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
                                builder: (context) => showcasewidgetLeave(
                                    TYPE_OF_LEAVE: emp.TYPE_OF_LEAVE!,
                                    From_timeFor_edit: emp.FROM_TIME!,
                                    To_timeFor_edit: emp.TO_TIME!,
                                    reasonforedit: emp.REASON ?? "",
                                    edit: 1,
                                    SerialNo: emp.SERIAL_NO!.toInt(),
                                    APPROVED: emp.APPROVED!,
                                    FROM_1HALF_FLAGforedit:
                                        emp.FROM_1HALF_FLAG!,
                                    FROM_2HALF_FLAGforedit:
                                        emp.FROM_2HALF_FLAG!,
                                    To_1HALF_FLAGforedit: emp.TO_1HALF_FLAG!,
                                    To_2HALF_FLAGforedit: emp.TO_2HALF_FLAG!,
                                    fromdateforedit: emp.FROM_DATE!,
                                    leaveTypeforedit: emp.LEAVE_ID ?? 0,
                                    todateforedit: emp.TO_DATE!,
                                    totaldaysforedit: emp.NO_OF_DAYS!)));
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
                            var serialNo = emp.SERIAL_NO!.toInt();
                            // if (serialNo.contains(".")) {

                            //   var data =
                            //       serialNo.toString().split(".");
                            //   print(data);
                            // }

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
                                            "cpfNo": globalInt,
                                            "serialNo": serialNo.toString(),
                                          };
                                          String _apiendpoint =
                                              "$ServerUrl//api/LeaveAPI/DeleteLeave";
                                          Response? response =
                                              await myHttpClient.PostMethod(
                                                  _apiendpoint,
                                                  data,
                                                  "Pending_leaves",
                                                  true);
                                          // Response response = await post(
                                          //     Uri.parse(
                                          //         "$ServerUrl//api/LeaveAPI/DeleteLeave"),
                                          //     headers: {
                                          //       "MobileURL": "Pending_leaves",
                                          //       "CPF_NO": globalInt.toString(),
                                          //       "Authorization":
                                          //           "Bearer $JWT_Tokken"
                                          //     },
                                          //     body: {
                                          //       "cpfNo": globalInt,
                                          //       "serialNo": serialNo.toString(),
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
                                                    '✓Leave deleted Successfuly',
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
