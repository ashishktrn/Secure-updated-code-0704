import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:secure_apk/reuseablewidgets.dart/sessionexpire.dart';

import 'globals.dart';
import 'models/adjustmentApprovalmodel.dart';
import 'reuseablewidgets.dart/Common.dart';
import 'reuseablewidgets.dart/colors.dart';
import 'reuseablewidgets.dart/loder.dart';

int _value = 2;
TextEditingController dropDownController = TextEditingController();
TextEditingController dropDownController2 = TextEditingController();
List? PeerDropDownList;
late String PeerDropDownListID;
List? month_List;
String? authority_ListId;
String? month_ListId = "13.0";
bool ApprovedToggle = false;
bool unapprovedToggle = false;
bool AllTogle = false;
bool upcommingToggle = false;
var monthSelected;
var peerCpf;

List? managerDrpDownList;
String manager_DropID = globalInt.toString();
bool isApiLoading = false;
bool isApiLoading2 = false;
bool isApiLoading3 = true;
bool isPeerNotSelectedBool = true;
String managerCpfForPeerDropDown = globalInt.toString();
late List<AdjustmentApprovalModel> productList;
late List<AdjustmentApprovalModel> emplist;
var items = [
  'Approve',
  'Delete',
];
var emptyList = [];
int count = 0;
var toDate;
var FromDate;
var applied_Date;

String dropdownvalue = 'Item 1';

bool showDropDownHint = true;

// Future<List<AdjustmentApprovalModel>> fetchData() async {
//   List<AdjustmentApprovalModel> users = [];

//   var filterType = "A"; //All
//   if (_value == 0) {
//     filterType = "N"; //Approve
//   } else if (_value == 1) {
//     filterType = "Y";
//   } else if (_value == 3) {
//     filterType = "U";
//   }
//   var month = monthSelected == null ? 13 : monthSelected;
//   var peercpf = peerCpf == null ? managerCpfForPeerDropDown : peerCpf;

//   Response response = await get(
//     Uri.parse(
//         "http://172.16.15.129:8073/api/TeamLeaveAPI/GetApproveUnapprovedHrAdjustment?ouId=94&cpfNo=$managerCpfForPeerDropDown&peerCpfNo=$peercpf&month=$month&filterType=$filterType"),
//     headers: {
//       //"MobileURL": "Leaveapprovalpage",
//       "MobileURL": "Adjustmentapprovalpage",
//       "CPF_NO": globalInt.toString()
//     },
//   );

//   try {
//     var decode = json.decode(response.body);
//     var data = decode['Table'];

//     var resultsJson = data.cast<Map<String, dynamic>>();
//     emplist = await resultsJson
//         .map<AdjustmentApprovalModel>(
//             (json) => AdjustmentApprovalModel.fromJson(json))
//         .toList();

//     //      var decode = json.decode(response.body);
//     // var data = decode['Table'];

//     // var decodeProduct = data.cast<Map<String, dynamic>>();

//     // productList = await decodeProduct
//     //     .map<AdjustmentApprovalModel>(
//     //         (json) => AdjustmentApprovalModel.fromJson(json))
//     //     .toList();

//   } catch (e) {
//     print(e);
//   }
//   return emplist;
// }

class NewApproval_TAB2 extends StatefulWidget {
  const NewApproval_TAB2({Key? key}) : super(key: key);

  @override
  State<NewApproval_TAB2> createState() => _TabState();
}

class _TabState extends State<NewApproval_TAB2> {
  late MyHttpClient myHttpClient = new MyHttpClient(context);
  late sessionExpired sessionexpired = new sessionExpired(context);
  Future<List<AdjustmentApprovalModel>> fetchData() async {
    List<AdjustmentApprovalModel> users = [];

    var filterType = "A"; //All
    if (_value == 0) {
      filterType = "N"; //Approve
    } else if (_value == 1) {
      filterType = "Y";
    } else if (_value == 3) {
      filterType = "U";
    }
    var month = monthSelected == null ? 13 : monthSelected;
    var peercpf = peerCpf == null ? managerCpfForPeerDropDown : peerCpf;
    final String apiEndpoint =
        "$ServerUrl/api/TeamLeaveAPI/GetApproveUnapprovedHrAdjustment?ouId=94&cpfNo=$managerCpfForPeerDropDown&peerCpfNo=$peercpf&month=$month&filterType=$filterType";

    Response? response = await myHttpClient.GetMethod(
        apiEndpoint, "Adjustmentapprovalpage", true);
    // Response response = await get(
    //   Uri.parse(
    //       "$ServerUrl/api/TeamLeaveAPI/GetApproveUnapprovedHrAdjustment?ouId=94&cpfNo=$managerCpfForPeerDropDown&peerCpfNo=$peercpf&month=$month&filterType=$filterType"),
    //   headers: {
    //     //"MobileURL": "Leaveapprovalpage",
    //     "MobileURL": "Adjustmentapprovalpage",
    //     "CPF_NO": globalInt.toString(),
    //     "Authorization": "Bearer $JWT_Tokken"
    //   },
    // );

    try {
      var decode = json.decode(response!.body);
      var data = decode['Table'];

      var resultsJson = data.cast<Map<String, dynamic>>();
      emplist = await resultsJson
          .map<AdjustmentApprovalModel>(
              (json) => AdjustmentApprovalModel.fromJson(json))
          .toList();

      //      var decode = json.decode(response.body);
      // var data = decode['Table'];

      // var decodeProduct = data.cast<Map<String, dynamic>>();

      // productList = await decodeProduct
      //     .map<AdjustmentApprovalModel>(
      //         (json) => AdjustmentApprovalModel.fromJson(json))
      //     .toList();
    } catch (e) {
      print(e);
    }
    return emplist;
  }

  approvedToggleOnChange(bool newValue2) {
    setState(() {
      ApprovedToggle = newValue2;
    });
  }

  unapprovedToggleOnChange(bool newValue2) {
    setState(() {
      unapprovedToggle = newValue2;
    });
  }

  allToggleOnChangee(bool newValue2) {
    setState(() {
      AllTogle = newValue2;
    });
  }

  upcommingToggleOnChange(bool newValue2) {
    setState(() {
      upcommingToggle = newValue2;
    });
  }

  Future _deleteAdjustment(var cpfNo, var globalcpfNo, var serialNo) async {
    // setState(() {
    //   isApiLoading = true;
    // });
    try {
      Map data = {
        "cpfNo": cpfNo.toString(),
        "globalcpfNo": globalcpfNo.toString(),
        "serialNo": serialNo.toString(),
        "ouId": ouId.toString()
      };
      String _apiendpoint =
          "$ServerUrl/api/TeamLeaveAPI/DeleteAdjustmentRecorManager";
      Response? response = await myHttpClient.PostMethod(
          _apiendpoint, data, "Adjustmentapprovalpage", true);
      // Response response = await post(
      //     Uri.parse(
      //         "$ServerUrl/api/TeamLeaveAPI/DeleteAdjustmentRecorManager"),
      //     headers: {
      //       "MobileURL": "Adjustmentapprovalpage",
      //       "CPF_NO": globalInt.toString(),
      //       "Authorization": "Bearer $JWT_Tokken"
      //     },
      //     body: {
      //       "cpfNo": cpfNo.toString(),
      //       "globalcpfNo": globalcpfNo.toString(),
      //       "serialNo": serialNo.toString(),
      //       "ouId": ouId.toString()
      //     });

      var responseFromApi = json.decode(response!.body);
      var status = responseFromApi['status'];
      var value = responseFromApi['value'];
      // setState(() {
      //   isApiLoading = false;
      // });
      if (response.statusCode != 200) {
        Navigator.pop(context, false);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Internal server error")));
        return;
      }
      if (status == 1) {
        Navigator.pop(context, false);
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.green,
              content: Text(
                '✓Adjustment deleted successfully',
                style: TextStyle(color: Colors.white),
              ),
            );
          },
        );
        fetchData();
        rebuild();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error  ${value.toString()}.")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(duration: new Duration(seconds: 5), content: Text("Error")));
      print(e);
    }
  }

  Future _approveAdjustment(
      var peerCpfNo, var cpfNo, var SerialNo, bool flag_of_app) async {
    try {
      // setState(() {
      //   isApiLoading = true;
      // });
      Map data = {
        "cpfNo": peerCpfNo.toString(),
        "globalcpfNo": cpfNo.toString(),
        "serialNo": SerialNo.toString(),
        "approveUnapprove": flag_of_app.toString()
      };
      String _apiendpoint =
          "$ServerUrl/api/TeamLeaveAPI/AdjustmentApproveUnapproved";
      Response? response = await myHttpClient.PostMethod(
          _apiendpoint, data, "Adjustmentapprovalpage", true);
      // Response response = await post(
      //     Uri.parse(
      //         "$ServerUrl/api/TeamLeaveAPI/AdjustmentApproveUnapproved"),
      //     headers: {
      //       "MobileURL": "Adjustmentapprovalpage",
      //       "CPF_NO": globalInt.toString(),
      //       "Authorization": "Bearer $JWT_Tokken"
      //     },
      //     body: {
      //       "cpfNo": peerCpfNo.toString(),
      //       "globalcpfNo": cpfNo.toString(),
      //       "serialNo": SerialNo.toString(),
      //       "approveUnapprove": flag_of_app.toString()
      //     });

      if (response!.statusCode != 200) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Internal server error")));
        return;
      }
      var resopnseFromApi = json.decode(response.body);
      var output = resopnseFromApi["Output"];
      var MSG = resopnseFromApi["MSG"];
      // setState(() {
      //   isApiLoading = false;
      // });

      if (output == "SUCCESS") {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.green,
              content: Text(
                '✓Success, $MSG',
                style: TextStyle(color: Colors.white),
              ),
            );
          },
        );

        fetchData();
        rebuild();
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(MSG)));
        fetchData();
        rebuild();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(duration: new Duration(seconds: 5), content: Text("Error")));
      print(e);
    }
  }

  bool isAlertboxOpened = false;
  late bool hasInternet;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {
      final connected = await InternetConnectionChecker().hasConnection;
      if (connected) {
        isAlertboxOpened = false;
        _getManagerDropDownList();

        _getMonthDropDownList();
        _getPEERDropDownList(managerCpfForPeerDropDown);
        fetchData();
      }
    });
    InternetConnectionChecker().onStatusChange.listen((event) {
      if (!mounted) return;
      final hasInternet = event == InternetConnectionStatus.connected;
      setState(() => this.hasInternet = hasInternet);
      if (!this.hasInternet) {
      } else {
        isAlertboxOpened = false;
        _getManagerDropDownList();

        _getMonthDropDownList();
        _getPEERDropDownList(managerCpfForPeerDropDown);
        fetchData();
      }
    });
  }

  Future rebuild() async {
    fetchData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(child: tabBarItems()),
    );
  }

  Widget tabBarItems() {
    return Container(
      //height: MediaQuery.of(context).size.height,
      child: Header(),
    );
  }

  Widget Header() {
    return isApiLoading
        ? Center(
            child: CircularProgressIndicator(color: Global_User_theme),
          )
        : isApiLoading2
            ? Center(
                child: CircularProgressIndicator(color: Global_User_theme),
              )
            : isApiLoading3
                ? Center(
                    child: CircularProgressIndicator(color: Global_User_theme),
                  )
                : SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics()),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Container(
                                child: Text(
                                  "Select manager",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                child: Text(
                                  "Month",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              padding: EdgeInsets.all(3.w),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey)),
                              //  width: MediaQuery.of(context).size.width / 1.7,
                              child: DropdownButtonHideUnderline(
                                child: ButtonTheme(
                                  alignedDropdown: false,
                                  child: DropdownButton<String>(
                                    hint: Text('Select leave'),

                                    value: manager_DropID,

                                    iconSize: 30.h,
                                    icon: (null),
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 16.sm,
                                    ),
                                    // hint: Text('Select leave'),
                                    onChanged: (newValue) {
                                      setState(() {
                                        manager_DropID = newValue.toString();
                                      });
                                    },
                                    items: managerDrpDownList?.map((item) {
                                      return new DropdownMenuItem(
                                        child: new Text(item['Name']),
                                        value: item['EmpNo'].toString(),
                                        onTap: () async {
                                          setState(() {
                                            managerCpfForPeerDropDown =
                                                item['EmpNo'];
                                            PeerDropDownListID = item['EmpNo'];
                                            isPeerNotSelectedBool = true;
                                            peerCpf = null;
                                          });

                                          _getPEERDropDownList(
                                              managerCpfForPeerDropDown);
                                        },
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(3.w),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey)),
                              // width: MediaQuery.of(context).size.width / 2.7,
                              child: DropdownButtonHideUnderline(
                                child: ButtonTheme(
                                  alignedDropdown: false,
                                  child: DropdownButton<String>(
                                    hint: Text('Select month'),

                                    value: month_ListId,

                                    iconSize: 30.h,
                                    icon: (null),
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 16.sm,
                                    ),
                                    // hint: Text('Select leave'),
                                    onChanged: (newValue) {
                                      setState(() {
                                        month_ListId = newValue.toString();
                                      });
                                    },
                                    items: month_List?.map((item) {
                                      return new DropdownMenuItem(
                                        child: new Text(item['MONTH_NAME']),
                                        value: item['MONTH_NO'].toString(),
                                        onTap: () async {
                                          monthSelected =
                                              item['MONTH_NO'].toString();
                                          print(monthSelected);
                                        },
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Container(
                            margin: EdgeInsets.only(left: 10.w, right: 10.w),
                            padding: EdgeInsets.all(3.w),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)),
                            // width: MediaQuery.of(context).size.width,
                            child: DropdownButtonHideUnderline(
                              child: ButtonTheme(
                                alignedDropdown: false,
                                child: isPeerNotSelectedBool
                                    ? DropdownButton<String>(
                                        hint: Text('Select employee'),

                                        // value: PeerDropDownListID,

                                        iconSize: 30.h,
                                        icon: (null),
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 16.sm,
                                        ),
                                        // hint: Text('Select leave'),
                                        onChanged: (newValue) {
                                          setState(() {
                                            PeerDropDownListID =
                                                newValue.toString();
                                          });
                                        },
                                        items: PeerDropDownList?.map((item) {
                                          return new DropdownMenuItem(
                                            child: new Text(item['Name']),
                                            value: item['ID'].toString(),
                                            onTap: () async {
                                              isPeerNotSelectedBool = false;
                                              peerCpf = item['EmpNo'];
                                            },
                                          );
                                        }).toList(),
                                      )
                                    : DropdownButton<String>(
                                        hint: Text('Select emplyee'),

                                        value: PeerDropDownListID,

                                        iconSize: 30.h,
                                        icon: (null),
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 16.sm,
                                        ),
                                        // hint: Text('Select leave'),
                                        onChanged: (newValue) {
                                          setState(() {
                                            PeerDropDownListID =
                                                newValue.toString();
                                          });
                                        },
                                        items: PeerDropDownList?.map((item) {
                                          return new DropdownMenuItem(
                                            child: new Text(item['Name']),
                                            value: item['ID'].toString(),
                                            onTap: () async {
                                              peerCpf = item['EmpNo'];
                                            },
                                          );
                                        }).toList(),
                                      ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Row(
                          children: [
                            Radio(
                              activeColor: Global_User_theme,
                              value: 0,
                              groupValue: _value,
                              onChanged: (value) {
                                print("pressed1");
                                setState(() {
                                  _value = value as int;
                                });
                              },
                            ),
                            // SizedBox(
                            //   width: 5,
                            // ),
                            Text("Approved"),
                            SizedBox(
                              width: 5,
                            ),
                            Radio(
                              activeColor: Global_User_theme,
                              value: 1,
                              groupValue: _value,
                              onChanged: (value) {
                                print("pressed2");
                                setState(() {
                                  _value = value as int;
                                });
                              },
                            ),
                            // SizedBox(
                            //   width: 5,
                            // ),
                            Text("Unapproved"),
                            SizedBox(
                              width: 5,
                            ),
                            Radio(
                              activeColor: Global_User_theme,
                              value: 2,
                              groupValue: _value,
                              onChanged: (value) {
                                print("pressed3");
                                setState(() {
                                  _value = value as int;
                                });
                              },
                            ),
                            // SizedBox(
                            //   width: ,
                            // ),
                            Text("All"),
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Row(
                          children: [
                            Radio(
                              activeColor: Global_User_theme,
                              value: 3,
                              groupValue: _value,
                              onChanged: (value) {
                                print("pressed4");
                                setState(() {
                                  _value = value as int;
                                });
                              },
                            ),

                            // SizedBox(
                            //   width: 5,
                            // ),
                            Text("Upcoming"),
                            // ElevatedButton(
                            //     onPressed: () {
                            //       rebuild();
                            //     },
                            //     child: Text("Press")),
                            // Divider(
                            //   thickness: 1,
                            // ),
                          ],
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height /
                              2, //uncomment to make the datatable scroable in its container only
                          child: FutureBuilder<List<AdjustmentApprovalModel>>(
                            initialData: const <AdjustmentApprovalModel>[],
                            future: fetchData(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError ||
                                  snapshot.data == null ||
                                  snapshot.connectionState ==
                                      ConnectionState.waiting) {
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
                                  child: RefreshIndicator(
                                    onRefresh: fetchData,
                                    child: DataTable(
                                      columnSpacing: 20,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      //  sortAscending: true,
                                      columns: const [
                                        DataColumn(
                                          label: Text(
                                            'Status',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ),
                                        // DataColumn(
                                        //     label: Text(
                                        //   'Action',
                                        //   style: TextStyle(
                                        //       fontWeight: FontWeight.bold,
                                        //       fontSize: 15),
                                        // )),
                                        DataColumn(
                                            label: Text(
                                          'Emp Id',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        )),
                                        DataColumn(
                                            label: Text(
                                          'Name',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        )),
                                        DataColumn(
                                            label: Text(
                                          'Details',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        )),
                                        // DataColumn(
                                        //     label: Text(
                                        //   'Date',
                                        //   style: TextStyle(
                                        //       fontWeight: FontWeight.bold,
                                        //       fontSize: 15),
                                        // )),
                                        // DataColumn(
                                        //     label: Text(
                                        //   'From Time',
                                        //   style: TextStyle(
                                        //       fontWeight: FontWeight.bold,
                                        //       fontSize: 15),
                                        // )),
                                        // DataColumn(
                                        //     label: Text(
                                        //   'To Time',
                                        //   style: TextStyle(
                                        //       fontWeight: FontWeight.bold,
                                        //       fontSize: 15),
                                        // )),
                                        // DataColumn(
                                        //     label: Text(
                                        //   'Total Hours',
                                        //   style: TextStyle(
                                        //       fontWeight: FontWeight.bold,
                                        //       fontSize: 15),
                                        // )),
                                        // DataColumn(
                                        //     label: Text(
                                        //   'Reason',
                                        //   style: TextStyle(
                                        //       fontWeight: FontWeight.bold,
                                        //       fontSize: 15),
                                        // )),
                                        // DataColumn(
                                        //     label: Text(
                                        //   'Req On',
                                        //   style: TextStyle(
                                        //       fontWeight: FontWeight.bold,
                                        //       fontSize: 15),
                                        // )),
                                      ],
                                      rows: List.generate(
                                        snapshot.data!.length,
                                        (index) {
                                          var emp = snapshot.data![index];
                                          return DataRow(
                                              selected: false,
                                              cells: [
                                                DataCell(
                                                  emp.APPROVED == "Y"
                                                      ? Text("Approved")

                                                      // Icon(
                                                      //     Icons.check,
                                                      //     color: Colors.green,
                                                      //     //  size: 35,
                                                      //   )
                                                      : emp.APPROVED == "N"
                                                          ? Text("Unapproved")
                                                          // Icon(
                                                          //     Icons.pending,
                                                          //     color: Colors.red,
                                                          //     //size: 35,
                                                          //   )
                                                          : Text("denied"),
                                                  onTap: () =>
                                                      showCardAdjustment(emp),

                                                  //  Icon(
                                                  //     Icons.close,
                                                  //     color: Colors.red,
                                                  //   )
                                                ),
                                                // DataCell(
                                                //   emp.APPROVED == "Y"
                                                //       ? StatefulBuilder(
                                                //           builder: (BuildContext
                                                //                   context,
                                                //               setState) {
                                                //             return Container(
                                                //               margin: EdgeInsets
                                                //                   .only(
                                                //                       bottom: 9,
                                                //                       top: 9),
                                                //               //  padding: EdgeInsets.all(0),
                                                //               decoration:
                                                //                   BoxDecoration(
                                                //                 borderRadius:
                                                //                     BorderRadius
                                                //                         .circular(
                                                //                             0),
                                                //                 // border: Border.all(
                                                //                 //     width: 1,
                                                //                 //     color:
                                                //                 //         Colors.black),
                                                //                 color: Color
                                                //                     .fromRGBO(
                                                //                         123,
                                                //                         34,
                                                //                         83,
                                                //                         0.1),
                                                //               ),
                                                //               // width: MediaQuery.of(context).size.width,
                                                //               child: Padding(
                                                //                   padding: const EdgeInsets
                                                //                           .only(
                                                //                       left: 10),
                                                //                   child: DropdownButton(
                                                //                       // Initial Value
                                                //                       // value: dropdownvalue,
                                                //                       hint: FittedBox(
                                                //                         child:
                                                //                             Text(
                                                //                           'Done',
                                                //                           style:
                                                //                               TextStyle(color: Colors.black),
                                                //                         ),
                                                //                       ),

                                                //                       // Down Arrow Icon
                                                //                       icon: const Icon(
                                                //                         Icons
                                                //                             .check_box,
                                                //                         color: Colors
                                                //                             .green,
                                                //                       ),

                                                //                       // Array list of items
                                                //                       items: items.map((String items) {
                                                //                         return DropdownMenuItem(
                                                //                           value:
                                                //                               emptyList,
                                                //                           child:
                                                //                               Text(items),
                                                //                         );
                                                //                       }).toList(),
                                                //                       style: TextStyle(color: Colors.white),
                                                //                       autofocus: true,
                                                //                       elevation: 10,
                                                //                       underline: SizedBox(),
                                                //                       onChanged: null)),
                                                //             );
                                                //           },
                                                //         )
                                                //       : StatefulBuilder(
                                                //           builder: (BuildContext
                                                //                   context,
                                                //               setState) {
                                                //             return Container(
                                                //               margin: EdgeInsets
                                                //                   .only(
                                                //                       bottom: 9,
                                                //                       top: 9),
                                                //               //  padding: EdgeInsets.all(0),
                                                //               decoration:
                                                //                   BoxDecoration(
                                                //                 borderRadius:
                                                //                     BorderRadius
                                                //                         .circular(
                                                //                             0),
                                                //                 // border: Border.all(
                                                //                 //     width: 1,
                                                //                 //     color:
                                                //                 //         Colors.black),
                                                //                 color: Color
                                                //                     .fromRGBO(
                                                //                         123,
                                                //                         34,
                                                //                         83,
                                                //                         0.1),
                                                //               ),
                                                //               // width: MediaQuery.of(context).size.width,
                                                //               child: Padding(
                                                //                 padding:
                                                //                     const EdgeInsets
                                                //                             .only(
                                                //                         left:
                                                //                             10),
                                                //                 child:
                                                //                     DropdownButton(
                                                //                   // Initial Value
                                                //                   // value: dropdownvalue,
                                                //                   hint:
                                                //                       FittedBox(
                                                //                     child: Text(
                                                //                       'Action',
                                                //                       style: TextStyle(
                                                //                           color:
                                                //                               Colors.black),
                                                //                     ),
                                                //                   ),

                                                //                   // Down Arrow Icon
                                                //                   icon:
                                                //                       const Icon(
                                                //                     Icons
                                                //                         .keyboard_arrow_down,
                                                //                     color: Colors
                                                //                         .black,
                                                //                   ),

                                                //                   // Array list of items
                                                //                   items: items
                                                //                       .map((String
                                                //                           items) {
                                                //                     return DropdownMenuItem(
                                                //                       value:
                                                //                           items,
                                                //                       child: Text(
                                                //                           items),
                                                //                     );
                                                //                   }).toList(),
                                                //                   dropdownColor:
                                                //                       Color.fromRGBO(
                                                //                           123,
                                                //                           34,
                                                //                           83,
                                                //                           1),
                                                //                   //focusColor: Colors.white,
                                                //                   style: TextStyle(
                                                //                       color: Colors
                                                //                           .white),
                                                //                   autofocus:
                                                //                       true,
                                                //                   elevation: 10,
                                                //                   underline:
                                                //                       SizedBox(),

                                                //                   // After selecting the desired option,it will
                                                //                   // change button value to selected value
                                                //                   onChanged:
                                                //                       (String?
                                                //                           newValue) {
                                                //                     if (newValue ==
                                                //                         "Approve") {
                                                //                       print(
                                                //                           "approve");
                                                //                       showDialog(
                                                //                         context:
                                                //                             context,
                                                //                         builder:
                                                //                             (dialogcontext) =>
                                                //                                 new AlertDialog(
                                                //                           title:
                                                //                               Text("are you  sure"),
                                                //                           content:
                                                //                               Text("Do you want to Approve"),
                                                //                           actions: [
                                                //                             TextButton(
                                                //                                 onPressed: () async {
                                                //                                   Navigator.pop(context, false);
                                                //                                   var SerialNo = emp.SL_NO;
                                                //                                   var cpfNo = manager_DropID;
                                                //                                   var peerCpfNo = emp.CPF_NO;
                                                //                                   var flag_of_app = true;
                                                //                                   if (emp.APPROVED == "Y") {
                                                //                                     flag_of_app = false;
                                                //                                   }
                                                //                                   _approveAdjustment(peerCpfNo, cpfNo, SerialNo, flag_of_app);
                                                //                                   // try {
                                                //                                   //   Response response = await post(Uri.parse("http://172.16.15.129:8073/api/TeamLeaveAPI/AdjustmentApproveUnapproved"), headers: {
                                                //                                   //     "MobileURL": "Adjustmentapprovalpage",
                                                //                                   //     "CPF_NO": globalInt.toString()
                                                //                                   //   }, body: {
                                                //                                   //     "cpfNo": peerCpfNo.toString(),
                                                //                                   //     "globalcpfNo": cpfNo.toString(),
                                                //                                   //     "serialNo": SerialNo.toString(),
                                                //                                   //     "approveUnapprove": flag_of_app.toString()
                                                //                                   //   });
                                                //                                   //   var resopnseFromApi = json.decode(response.body);
                                                //                                   //   var output = resopnseFromApi["Output"];
                                                //                                   //   var MSG = resopnseFromApi["MSG"];
                                                //                                   //   if (output == "SUCCESS") {
                                                //                                   //     // SweetAlert.show(context,
                                                //                                   //     //     title: "Approved",
                                                //                                   //     //     subtitle: MSG,
                                                //                                   //     //     // onPress: Navigator.pop(context, false),
                                                //                                   //     //     style: SweetAlertStyle.success);
                                                //                                   //     // AwesomeDialog(
                                                //                                   //     //   context: context,
                                                //                                   //     //   dialogType: DialogType.SUCCES,
                                                //                                   //     //   animType: AnimType.BOTTOMSLIDE,
                                                //                                   //     //   title: 'Approved',
                                                //                                   //     //   desc: MSG,
                                                //                                   //     //   btnCancelOnPress: () {},
                                                //                                   //     //   btnOkOnPress: () {},
                                                //                                   //     // )..show();
                                                //                                   //     showDialog(
                                                //                                   //       context: context,
                                                //                                   //       builder: (context) {
                                                //                                   //         return AlertDialog(
                                                //                                   //           backgroundColor: Colors.green,
                                                //                                   //           content: Text(
                                                //                                   //             '✓Success, $MSG',
                                                //                                   //             style: TextStyle(color: Colors.white),
                                                //                                   //           ),
                                                //                                   //         );
                                                //                                   //       },
                                                //                                   //     );

                                                //                                   //     fetchData();
                                                //                                   //     rebuild();
                                                //                                   //   } else {
                                                //                                   //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(MSG)));
                                                //                                   //     fetchData();
                                                //                                   //     rebuild();
                                                //                                   //   }
                                                //                                   // } catch (e) {
                                                //                                   //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: new Duration(seconds: 5), content: Text("Error")));
                                                //                                   //   print(e);
                                                //                                   // }
                                                //                                 },
                                                //                                 child: Text("Yes")),
                                                //                             TextButton(
                                                //                                 onPressed: () {
                                                //                                   Navigator.pop(context, false);
                                                //                                 },
                                                //                                 child: Text("No")),
                                                //                           ],
                                                //                         ),
                                                //                       );
                                                //                     } else if (newValue ==
                                                //                         "Delete") {
                                                //                       print(
                                                //                           "delete");
                                                //                       showDialog(
                                                //                         context:
                                                //                             context,
                                                //                         builder:
                                                //                             (dialogeeeecontext) =>
                                                //                                 new AlertDialog(
                                                //                           title:
                                                //                               Text("are you  sure"),
                                                //                           content:
                                                //                               Text("Do you want to delete?"),
                                                //                           // backgroundColor: Colors.red.shade100,
                                                //                           actions: [
                                                //                             TextButton(
                                                //                                 onPressed: () async {
                                                //                                   Navigator.pop(context, false);

                                                //                                   if (emp.APPROVED == "Y") {
                                                //                                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("You cannot delete approved hours adjustment entries.")));
                                                //                                   } else {
                                                //                                     var cpfNo = emp.CPF_NO;
                                                //                                     var globalcpfNo = manager_DropID;
                                                //                                     var serialNo = emp.SL_NO;
                                                //                                     var ouIdd = ouId;
                                                //                                     _deleteAdjustment(cpfNo, globalcpfNo, serialNo);
                                                //                                     // try {
                                                //                                     //   Response response = await post(Uri.parse("http://172.16.15.129:8073/api/TeamLeaveAPI/DeleteAdjustmentRecorManager"), headers: {
                                                //                                     //     "MobileURL": "Adjustmentapprovalpage",
                                                //                                     //     "CPF_NO": globalInt.toString()
                                                //                                     //   }, body: {
                                                //                                     //     "cpfNo": cpfNo.toString(),
                                                //                                     //     "globalcpfNo": globalcpfNo.toString(),
                                                //                                     //     "serialNo": serialNo.toString(),
                                                //                                     //     "ouId": ouId.toString()
                                                //                                     //   });
                                                //                                     //   var responseFromApi = json.decode(response.body);
                                                //                                     //   var status = responseFromApi['status'];
                                                //                                     //   var value = responseFromApi['value'];
                                                //                                     //   setState(() {
                                                //                                     //     isApiLoading = false;
                                                //                                     //   });
                                                //                                     //   if (status == 1) {
                                                //                                     //     // SweetAlert.show(context,
                                                //                                     //     //     title: "Sucess",
                                                //                                     //     //     subtitle: "Adjustment deleted successfully",
                                                //                                     //     //     // onPress: Navigator.pop(context, false),
                                                //                                     //     //     style: SweetAlertStyle.success);
                                                //                                     //     // AwesomeDialog(
                                                //                                     //     //   context: context,
                                                //                                     //     //   dialogType: DialogType.SUCCES,
                                                //                                     //     //   animType: AnimType.BOTTOMSLIDE,
                                                //                                     //     //   title: 'Sucess',
                                                //                                     //     //   desc: "Adjustment deleted successfully",
                                                //                                     //     //   btnCancelOnPress: () {},
                                                //                                     //     //   btnOkOnPress: () {},
                                                //                                     //     // )..show();
                                                //                                     //     showDialog(
                                                //                                     //       context: context,
                                                //                                     //       builder: (context) {
                                                //                                     //         return AlertDialog(
                                                //                                     //           backgroundColor: Colors.green,
                                                //                                     //           content: Text(
                                                //                                     //             '✓Success,Adjustment deleted successfully',
                                                //                                     //             style: TextStyle(color: Colors.white),
                                                //                                     //           ),
                                                //                                     //         );
                                                //                                     //       },
                                                //                                     //     );
                                                //                                     //     fetchData();
                                                //                                     //     rebuild();
                                                //                                     //   } else {
                                                //                                     //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error  ${value.toString()}.")));
                                                //                                     //   }
                                                //                                     // } catch (e) {
                                                //                                     //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: new Duration(seconds: 5), content: Text("Error")));
                                                //                                     //   print(e);
                                                //                                     // }
                                                //                                   }

                                                //                                   //  Navigator.pop(context, true);
                                                //                                 },
                                                //                                 child: Text("Yes")),
                                                //                             TextButton(
                                                //                                 onPressed: () {
                                                //                                   Navigator.pop(context, false);
                                                //                                 },
                                                //                                 child: Text("No")),
                                                //                           ],
                                                //                         ),
                                                //                       );
                                                //                     }
                                                //                     setState(
                                                //                         () {
                                                //                       dropdownvalue =
                                                //                           newValue!;
                                                //                       showDropDownHint =
                                                //                           false;
                                                //                     });
                                                //                   },
                                                //                 ),
                                                //               ),
                                                //             );
                                                //           },
                                                //         ),
                                                // ),
                                                DataCell(
                                                  Text(emp.CPF_NO.toString()),
                                                  onTap: () {
                                                    showCardAdjustment(emp);
                                                  },
                                                ),
                                                DataCell(
                                                  Text(emp.EMP_NAME.toString()),
                                                  onTap: () =>
                                                      showCardAdjustment(emp),
                                                ),
                                                DataCell(
                                                  TextButton(
                                                      onPressed: () {
                                                        showCardAdjustment(emp);
                                                      },
                                                      child: Text(
                                                        "Click here",
                                                        style: TextStyle(
                                                            color:
                                                                Global_User_theme),
                                                      )),
                                                  onTap: () =>
                                                      showCardAdjustment(emp),
                                                ),
                                                // DataCell(
                                                //   Text(
                                                //     DateFormat('dd-MMM-yyyy')
                                                //         .format(DateTime.parse(
                                                //             emp.ADJ_DATE)),
                                                //   ),
                                                //   onTap: () =>
                                                //       showCardAdjustment(emp),
                                                // ),
                                                // DataCell(
                                                //   Text(DateFormat('hh:mm:a')
                                                //       .format(DateTime.parse(
                                                //           emp.FROM_TIME))),
                                                //   onTap: () =>
                                                //       showCardAdjustment(emp),
                                                // ),
                                                // DataCell(
                                                //   Text(DateFormat('hh:mm:a')
                                                //       .format(DateTime.parse(
                                                //           emp.TO_TIME))),
                                                //   onTap: () =>
                                                //       showCardAdjustment(emp),
                                                // ),
                                                // DataCell(
                                                //   Text(emp.TOT_HOURS),
                                                // ),
                                                // DataCell(
                                                //   Text(emp.REASON),
                                                //   onTap: () =>
                                                //       showCardAdjustment(emp),
                                                // ),
                                                // DataCell(
                                                //   Text(
                                                //     DateFormat('dd-MMM-yyyy')
                                                //         .format(
                                                //       DateTime.parse(
                                                //           emp.DATE_OF_ENTRY),
                                                //     ),
                                                //   ),
                                                //   onTap: () =>
                                                //       showCardAdjustment(emp),
                                                // ),
                                              ]);
                                        },
                                      ).toList(),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        // ElevatedButton(
                        //     onPressed: () {
                        //     setState(() {
                        //       fetchData();
                        //     });
                        //     },
                        //     child: Text("Press")),
                        // Divider(
                        //   thickness: 1,
                        // ),

                        //DataTablee()
                      ],
                    ),
                  );
  }

  showCardAdjustment(AdjustmentApprovalModel emp) {
    showDialog(
      context: context,
      builder: (dialogeeecontext) => Center(
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 5,
          margin: EdgeInsets.all(10),
          child: SingleChildScrollView(
            physics:
                AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            child: Container(
              // height: MediaQuery.of(context).size.height / 2,
              color: Colors.grey.shade200,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,

                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            emp.APPROVED == "Y"
                                ? "Approved"
                                : emp.APPROVED == "N"
                                    ? "Unapproved"
                                    : "Denied",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold))
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
                          "Name:  ",
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          emp.EMP_NAME.toString(),
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
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
                          "Employee Id:  ",
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          emp.CPF_NO.toInt().toString(),
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
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
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          DateFormat('dd-MMM-yyyy')
                              .format(DateTime.parse(emp.ADJ_DATE)),
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
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
                          "From Time:  ",
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          DateFormat('hh:mm:a')
                              .format(DateTime.parse(emp.FROM_TIME)),
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
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
                          "To Time:  ",
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          DateFormat('hh:mm:a')
                              .format(DateTime.parse(emp.TO_TIME)),
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
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
                          "Toal Hours:  ",
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          emp.TOT_HOURS,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
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
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          emp.REASON,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
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
                          "Requested On:  ",
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          DateFormat('dd-MMM-yyyy')
                              .format(DateTime.parse(emp.DATE_OF_ENTRY)),
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Global_User_theme),
                            onPressed: emp.APPROVED == "Y"
                                ? null
                                : () {
                                    if (emp.APPROVED == "Y") {
                                      return;
                                    }

                                    showDialog(
                                      context: context,
                                      builder: (dialogcontext) =>
                                          new AlertDialog(
                                        title: Text("Are you  sure"),
                                        content:
                                            Text("Do you want to Approve ?"),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context, false);
                                              },
                                              child: Text("No")),
                                          TextButton(
                                              onPressed: () async {
                                                if (emp.APPROVED == "Y") {
                                                  Navigator.pop(context, false);
                                                  return;
                                                }

                                                Navigator.pop(context, false);
                                                Navigator.pop(context, false);
                                                // setState(() {
                                                //   isApiLoading = true;
                                                // });
                                                _openLoadingDialog(context);

                                                // var SerialNo =
                                                //     emp.SERIAL_NO!.toInt();
                                                var SerialNo = emp.SL_NO;
                                                var cpfNo = manager_DropID;
                                                var peerCpfNo = emp.CPF_NO;
                                                var flag_of_app = true;
                                                if (emp.APPROVED == "Y") {
                                                  flag_of_app = false;
                                                }
                                                await _approveAdjustment(
                                                    peerCpfNo,
                                                    cpfNo,
                                                    SerialNo,
                                                    flag_of_app);
                                                Navigator.pop(context, false);
                                              },
                                              child: Text("Yes")),
                                        ],
                                      ),
                                    );
                                  },
                            child: Text(
                              "Approve",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Global_User_theme),
                            onPressed: emp.APPROVED != "N"
                                ? null
                                : () {
                                    showDialog(
                                      context: context,
                                      builder: (dialogeeeecontext) =>
                                          new AlertDialog(
                                        title: Text("Are you  sure"),
                                        content: Text("Do you want to delete?"),
                                        // backgroundColor: Colors.red.shade100,
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context, false);
                                              },
                                              child: Text("No")),
                                          TextButton(
                                              onPressed: () async {
                                                Navigator.pop(context, false);
                                                Navigator.pop(context, false);
                                                // setState(() {
                                                //   isApiLoading = true;
                                                // });
                                                if (emp.APPROVED != "N") {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          content: Text(
                                                              "You cannot delete approved/denied leave.")));

                                                  //  Navigator.pop(context, true);
                                                  //  return;
                                                } else {
                                                  _openLoadingDialog(context);
                                                  var cpfNo = emp.CPF_NO;
                                                  var globalcpfNo =
                                                      manager_DropID;
                                                  var serialNo = emp.SL_NO;
                                                  var ouIdd = ouId;
                                                  await _deleteAdjustment(cpfNo,
                                                      globalcpfNo, serialNo);
                                                }
                                                //  Navigator.pop(context, true);
                                              },
                                              child: Text("Yes")),
                                        ],
                                      ),
                                    );
                                  },
                            child: Text(
                              "Delete",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
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

  Future _getManagerDropDownList() async {
    setState(() {
      isApiLoading = true;
    });
    //isApiLoading = true;
    final String apiEndpoint =
        "$ServerUrl/api/TeamLeaveAPI/GETteamDet?cpfNo=$globalInt";

    Response? response = await myHttpClient.GetMethod(
        apiEndpoint, "Adjustmentapprovalpage", true);
    // Response response = await get(
    //   Uri.parse(
    //       "$ServerUrl/api/TeamLeaveAPI/GETteamDet?cpfNo=$globalInt"),
    //   headers: {
    //     //"MobileURL": "Leaveapprovalpage",
    //     "MobileURL": "Adjustmentapprovalpage",
    //     "CPF_NO": globalInt.toString(),
    //     "Authorization": "Bearer $JWT_Tokken"
    //   },

    //   // body: {"cpfNo": "42914"}
    // );

    try {
      var jsonBody = response!.body;

      if (jsonBody.isNotEmpty) {
        var jsonData = json.decode(jsonBody);
        setState(() {
          managerDrpDownList = jsonData;
          // _leaveListCircularBool = false;
          // rhLeaveCircularbool = false;
        });
        print(managerDrpDownList);
        setState(() {
          isApiLoading = false;
        });
      } else {
        if (!isAlertboxOpened) {
          showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                backgroundColor: Colors.red,
                content: Text(
                  'Error! No response from server',
                  style: TextStyle(color: Colors.white),
                ),
              );
            },
          );
        }
        setState(() => isAlertboxOpened = true); //
      }

      // isApiLoading = false;
    } catch (e) {
      if (!isAlertboxOpened) {
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              backgroundColor: Colors.red,
              content: Text(
                'Error! No response from server',
                style: TextStyle(color: Colors.white),
              ),
            );
          },
        );
      }
      setState(() => isAlertboxOpened = true); //
      // ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(duration: new Duration(seconds: 5), content: Text("Error")));
      print(e);
    } finally {
      setState(() {
        isApiLoading = false;
      });
    }
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

  Future _getMonthDropDownList() async {
    setState(() {
      isApiLoading2 = true;
    });
    // isApiLoading = true;
    final String apiEndpoint =
        "$ServerUrl/api/TeamLeaveAPI/GetMonths?ouId=$ouId";

    Response? response = await myHttpClient.GetMethod(
        apiEndpoint, "Adjustmentapprovalpage", true);
    // Response response = await get(
    //   Uri.parse(
    //       "$ServerUrl/api/TeamLeaveAPI/GetMonths?ouId=$ouId"),
    //   headers: {
    //     //"MobileURL": "Leaveapprovalpage",
    //     "MobileURL": "Adjustmentapprovalpage",
    //     "CPF_NO": globalInt.toString(),

    //     "Authorization": "Bearer $JWT_Tokken"
    //   },
    // );
    try {
      var jsonBody = response!.body;

      if (jsonBody.isNotEmpty) {
        var jsonData = json.decode(jsonBody);
        setState(() {
          month_List = jsonData['Table'];
        });
        print(month_List);
        //isApiLoading = false;
        setState(() {
          isApiLoading2 = false;
        });
      } else {
        if (!isAlertboxOpened) {
          showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                backgroundColor: Colors.red,
                content: Text(
                  'Error! No response from server',
                  style: TextStyle(color: Colors.white),
                ),
              );
            },
          );
        }
        setState(() => isAlertboxOpened = true); //
      }
    } catch (e) {
      if (!isAlertboxOpened) {
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              backgroundColor: Colors.red,
              content: Text(
                'Error! No response from server',
                style: TextStyle(color: Colors.white),
              ),
            );
          },
        );
      }
      setState(() => isAlertboxOpened = true); //
      // ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(duration: new Duration(seconds: 5), content: Text("Error")));
      print(e);
    } finally {
      setState(() {
        isApiLoading2 = false;
      });
    }
  }

  Future _getPEERDropDownList(cpfNo) async {
    setState(() {
      isApiLoading3 = true;
    });
    // isApiLoading = true;
    final String apiEndpoint =
        "$ServerUrl/api/TeamLeaveAPI/GETpeerDet?cpfNo=$cpfNo";

    Response? response = await myHttpClient.GetMethod(
        apiEndpoint, "Adjustmentapprovalpage", true);
    // Response response = await get(
    //   Uri.parse(
    //       "$ServerUrl/api/TeamLeaveAPI/GETpeerDet?cpfNo=$cpfNo"),
    //   headers: {
    //     // "MobileURL": "Leaveapprovalpage",
    //     "MobileURL": "Adjustmentapprovalpage",
    //     "CPF_NO": globalInt.toString(),

    //     "Authorization": "Bearer $JWT_Tokken"
    //   },
    // );

    try {
      var jsonBody = response!.body;

      if (jsonBody.isNotEmpty) {
        var jsonData = json.decode(jsonBody);
        setState(() {
          PeerDropDownList = jsonData;
        });
        print(PeerDropDownList);
        //isApiLoading = false;
        setState(() {
          isApiLoading3 = false;
        });
      } else {
        if (!isAlertboxOpened) {
          showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                backgroundColor: Colors.red,
                content: Text(
                  'Error! No response from server',
                  style: TextStyle(color: Colors.white),
                ),
              );
            },
          );
        }
        setState(() => isAlertboxOpened = true); //
      }
    } catch (e) {
      if (!isAlertboxOpened) {
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              backgroundColor: Colors.red,
              content: Text(
                'Error! No response from server',
                style: TextStyle(color: Colors.white),
              ),
            );
          },
        );
      }
      setState(() => isAlertboxOpened = true);
      // ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(duration: new Duration(seconds: 5), content: Text("Error")));
      print(e);
    } finally {
      setState(() {
        isApiLoading3 = false;
      });
    }
  }

  Future getApprovedUnapprovedList() async {
    var filterType = "A"; //All
    if (_value == 0) {
      filterType = "N"; //Approve
    } else if (_value == 1) {
      filterType = "Y";
    } else if (_value == 3) {
      filterType = "U";
    }
    var month = monthSelected == null ? 13 : monthSelected;
    var peercpf = peerCpf == null ? managerCpfForPeerDropDown : peerCpf;

    try {
      final String apiEndpoint =
          "$ServerUrl/api/TeamLeaveAPI/GetApproveUnapprovedLeave?ouId=94&cpfNo=$managerCpfForPeerDropDown&peerCpfNo=$peercpf&month=$month&filterType=$filterType";

      Response? response = await myHttpClient.GetMethod(
          apiEndpoint, "Adjustmentapprovalpage", true);
      // Response response = await get(
      //   Uri.parse(
      //       "$ServerUrl/api/TeamLeaveAPI/GetApproveUnapprovedLeave?ouId=94&cpfNo=$managerCpfForPeerDropDown&peerCpfNo=$peercpf&month=$month&filterType=$filterType"),
      //   headers: {
      //     "MobileURL": "Adjustmentapprovalpage",
      //     "CPF_NO": globalInt.toString(),
      //     "Authorization": "Bearer $JWT_Tokken"
      //   },
      // );

      var jsonBody = response!.body;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(duration: new Duration(seconds: 5), content: Text("Error")));
      print(e);
    }
  }
}
