import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';

import 'package:secure_apk/attendanceapproval.dart';
import 'package:secure_apk/globals.dart';

import 'package:secure_apk/models/managerApprovalModel.dart';

//import 'package:sweetalert/sweetalert.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'Face_Recognition_Authentication/widgets/app_button.dart';
import 'Face_Recognition_Authentication/widgets/app_text_field.dart';
import 'new_approval_page_TAB2.dart';
import 'reuseablewidgets.dart/Common.dart';
import 'reuseablewidgets.dart/colors.dart';
import 'reuseablewidgets.dart/loder.dart';
import 'reuseablewidgets.dart/sessionexpire.dart';

var actions = [
  'Approve',
  'Reject',
  'Delete',
];

final TextEditingController _rejectController = TextEditingController(text: '');
String manager_DropID = globalInt.toString();
bool isApiLoading = false;
TextEditingController Reason = TextEditingController();
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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
//String manager_DropID = "334";
// bool isApiLoading = false;
bool isApiLoading2 = true;
bool isApiLoading3 = false;
bool isPeerNotSelectedBool = true;
String managerCpfForPeerDropDown = globalInt.toString();

late List<ManagerApprovalModel> productList;

// Future<List<ManagerApprovalModel>> fetchData() async {
//   List<ManagerApprovalModel> users = [];
//   late List<DataGridRow> dataGridRows;
//   late List<ManagerApprovalModel> productList;
//   int count = 0;
//   var toDate;
//   var FromDate;
//   var applied_Date;
//   String? authority_ListId;
//   String dropdownvalue = 'Item 1';
//   late List<ManagerApprovalModel> emplist;

//   // List of items in our dropdown menu

//   bool showDropDownHint = true;

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
//         "$ServerUrl/api/TeamLeaveAPI/GetApproveUnapprovedLeave?ouId=94&cpfNo=$managerCpfForPeerDropDown&peerCpfNo=$peercpf&month=$month&filterType=$filterType"),
//     headers: {
//       "MobileURL": "Leaveapprovalpage",
//       "CPF_NO": globalInt.toString(),
//       "Authorization": "Bearer $JWT_Tokken"
//     },
//   );
//   if (response.statusCode == 401) {
//     var isunauth = response.reasonPhrase;
//     if (isunauth == "Unauthorized") {
// // logic for login the user out

//     }
//   }

//   try {
//     var decode = json.decode(response.body);
//     var data = decode['Table'];

//     var resultsJson = data.cast<Map<String, dynamic>>();
//     emplist = await resultsJson
//         .map<ManagerApprovalModel>(
//             (json) => ManagerApprovalModel.fromJson(json))
//         .toList();
//   } catch (e) {
//     print(e);
//   }
//   return emplist;
// }

class New_Approval_Page extends StatefulWidget {
  //const New_Approval_Page({Key? key}) : super(key: key);
  int selectedPage;

  New_Approval_Page(this.selectedPage);

  @override
  State<New_Approval_Page> createState() => _Approval_PageState();
}

class _Approval_PageState extends State<New_Approval_Page> {
  late sessionExpired sessionexpired = new sessionExpired(context);
  static GlobalKey<FormState> __KEY = new GlobalKey<FormState>();
  late MyHttpClient myHttpClient = new MyHttpClient(context);
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

  @override
  void dispose() {
    super.dispose();
  }

  Future<List<ManagerApprovalModel>> fetchData() async {
    List<ManagerApprovalModel> users = [];
    late List<DataGridRow> dataGridRows;
    late List<ManagerApprovalModel> productList;
    int count = 0;
    var toDate;
    var FromDate;
    var applied_Date;
    String? authority_ListId;
    String dropdownvalue = 'Item 1';
    late List<ManagerApprovalModel> emplist;

    // List of items in our dropdown menu

    bool showDropDownHint = true;

    var filterType = "A"; //All
    if (_value == 0) {
      filterType = "N"; //Approve
    } else if (_value == 1) {
      filterType = "Y";
    } else if (_value == 3) {
      filterType = "U";
    }
    var month = monthSelected == null ? 13 : double.parse(monthSelected);
    int intmonth = month.toInt();
    var peercpf = peerCpf == null ? managerCpfForPeerDropDown : peerCpf;
    final String apiEndpoint =
        "$ServerUrl/api/TeamLeaveAPI/GetApproveUnapprovedLeave?ouId=94&cpfNo=$managerCpfForPeerDropDown&peerCpfNo=$peercpf&month=$intmonth&filterType=$filterType";

    Response? response =
        await myHttpClient.GetMethod(apiEndpoint, "Leaveapprovalpage", true);
    // Response response = await get(
    //   Uri.parse(
    //       "$ServerUrl/api/TeamLeaveAPI/GetApproveUnapprovedLeave?ouId=94&cpfNo=$managerCpfForPeerDropDown&peerCpfNo=$peercpf&month=$intmonth&filterType=$filterType"),
    //   headers: {
    //     "MobileURL": "Leaveapprovalpage",
    //     "CPF_NO": globalInt.toString(),
    //     "Authorization": "Bearer $JWT_Tokken"
    //   },
    // );

    try {
      var decode = json.decode(response!.body);
      var data = decode['Table'];

      var resultsJson = data.cast<Map<String, dynamic>>();
      emplist = await resultsJson
          .map<ManagerApprovalModel>(
              (json) => ManagerApprovalModel.fromJson(json))
          .toList();
    } catch (e) {
      print(e);
    }

    return emplist;
  }

  Future _rejectLeave(bool flag_of_deny, var serial_no, var reason_text) async {
    //  Navigator.pop(context, true);
    // setState(() {
    //   isApiLoading = true;
    // });
    _openLoadingDialog(context);
    try {
      Map data = {
        "approveUnapprove": flag_of_deny.toString(),
        "serialNo": serial_no.toString(),
        "Reason": reason_text,
        "cpfNo": manager_DropID.toString()
      };
      String _apiendpoint = "$ServerUrl/api/TeamLeaveAPI/Leavedeny";
      Response? response = await myHttpClient.PostMethod(
          _apiendpoint, data, "Leaveapprovalpage", true);
      // Response response = await post(
      //     Uri.parse("$ServerUrl/api/TeamLeaveAPI/Leavedeny"),
      //     headers: {
      //       "MobileURL": "Leaveapprovalpage",
      //       "CPF_NO": globalInt.toString(),
      //       "Authorization": "Bearer $JWT_Tokken"
      //     },
      //     body: {
      //       "approveUnapprove": flag_of_deny.toString(),
      //       "serialNo": serial_no.toString(),
      //       "Reason": reason_text,
      //       "cpfNo": manager_DropID.toString()
      //     });
      // setState(() {
      //   isApiLoading = false;
      // });

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
      //   isApiLoading = true;
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
        Reason.clear();
      } else {
        // Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: MSG));
      }
      //  Navigator.pop(context, true);
    } catch (e) {
      Navigator.pop(context);
      print(e);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.red,
            content: Text(
              '$e',
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      );
    }
  }

  Future _approveLeave(var cpfNo, var SerialNo, bool flag_of_app) async {
    // setState(() {
    //   isApiLoading = true;
    // });
    _openLoadingDialog(context);
    try {
      Map data = {
        "cpfNo": cpfNo.toString(),
        "serialNo": SerialNo.toString(),
        "approveUnapprove": flag_of_app.toString()
      };
      String _apiendpoint =
          "$ServerUrl/api/TeamLeaveAPI/LeaveApproveUnapproved";
      Response? response = await myHttpClient.PostMethod(
          _apiendpoint, data, "Leaveapprovalpage", true);
      // Response response = await post(
      //     Uri.parse(
      //         "$ServerUrl/api/TeamLeaveAPI/LeaveApproveUnapproved"),
      //     headers: {
      //       "MobileURL": "Leaveapprovalpage",
      //       "CPF_NO": globalInt.toString(),
      //       "Authorization": "Bearer $JWT_Tokken"
      //     },
      //     body: {
      //       "cpfNo": cpfNo.toString(),
      //       "serialNo": SerialNo.toString(),
      //       "approveUnapprove": flag_of_app.toString()
      //     });

      var resopnseFromApi = json.decode(response!.body);
      var output = resopnseFromApi["Output"];
      var MSG = resopnseFromApi["MSG"];
      // setState(() {
      //   isApiLoading = false;
      // });

      if (response.statusCode != 200) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Internal server error")));
        return;
      }

      if (output == "SUCCESS") {
        Navigator.pop(context);

        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.green,
              content: Text(
                '✓Apporved,$MSG',
                style: TextStyle(color: Colors.white),
              ),
            );
          },
        );
        fetchData();
        rebuild();
      } else {
        Navigator.pop(context);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(MSG)));
      }
    } catch (e) {
      Navigator.pop(context);
      print(e);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.red,
            content: Text(
              '$e',
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      );
    }
  }

  Future _onDeleteDeniedLeave(var cpfNo, var SerialNo) async {
    setState(() {
      isApiLoading = true;
    });
    try {
      Map data = {
        "cpfNo": cpfNo.toString(),
        "serialNo": SerialNo.toString(),
      };
      String _apiendpoint = "$ServerUrl/api/TeamLeaveAPI/LeaveUndeny";
      Response? response = await myHttpClient.PostMethod(
          _apiendpoint, data, "Leaveapprovalpage", true);
      // Response response = await post(
      //     Uri.parse("$ServerUrl/api/TeamLeaveAPI/LeaveUndeny"),
      //     headers: {
      //       "MobileURL": "Leaveapprovalpage",
      //       "CPF_NO": globalInt.toString(),
      //       "Authorization": "Bearer $JWT_Tokken"
      //     },
      //     body: {
      //       "cpfNo": cpfNo.toString(),
      //       "serialNo": SerialNo.toString(),
      //     });
      setState(() {
        isApiLoading = false;
      });

      if (response!.statusCode != 200) {
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              backgroundColor: Colors.red,
              content: Text(
                'Internal Server Error !',
                style: TextStyle(color: Colors.white),
              ),
            );
          },
        );
        return;
      }
      var resopnseFromApi = json.decode(response.body);
      var output = resopnseFromApi["Output"];
      var MSG = resopnseFromApi["MSG"];
      if (output == "SUCCESS") {
        // SweetAlert.show(context,
        //     title: "Approved",
        //     subtitle: MSG,
        //     // onPress: Navigator.pop(context, false),
        //     style: SweetAlertStyle.success);
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.green,
              content: Text(
                MSG,
                style: TextStyle(color: Colors.white),
              ),
            );
          },
        );

        fetchData();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: MSG));
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.green,
            content: Text(
              "$e",
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      );
      print(e);
    }
  }

  Future _deleteLeve(var cpfNo, var serialNo) async {
    setState(() {
      isApiLoading = true;
    });
    try {
      Map data = {
        "cpfNo": cpfNo.toString(),
        "serialNo": serialNo.toString(),
        "ouId": ouId.toString(),
      };
      String _apiendpoint = "$ServerUrl/api/TeamLeaveAPI/DeleteRecorManager";
      Response? response = await myHttpClient.PostMethod(
          _apiendpoint, data, "Leaveapprovalpage", true);
      // Response response = await post(
      //     Uri.parse(
      //         "$ServerUrl/api/TeamLeaveAPI/DeleteRecorManager"),
      //     headers: {
      //       "MobileURL": "Leaveapprovalpage",
      //       "CPF_NO": globalInt.toString(),
      //       "Authorization": "Bearer $JWT_Tokken"
      //     },
      //     body: {
      //       "cpfNo": cpfNo.toString(),
      //       "serialNo": serialNo.toString(),
      //       "ouId": ouId.toString(),
      //     });

      if (response!.statusCode == 200) {
        var responseFromApi = json.decode(response.body);
        var status = responseFromApi['status'];
        var value = responseFromApi['value'];
        setState(() {
          isApiLoading = false;
        });
        if (status == 1) {
          showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                backgroundColor: Colors.green,
                content: Text(
                  '✓ Leave deleted successfully',
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
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.red,
              content: Text(
                'Error, ${response.statusCode}',
                style: TextStyle(color: Colors.white),
              ),
            );
          },
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.red,
            content: Text(
              'Error, $e',
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      );
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
        _getManagerDropDownList();
        _getMonthDropDownList();
        _getPEERDropDownList(managerCpfForPeerDropDown);
        fetchData();
      }
    });

    InternetConnectionChecker().onStatusChange.listen((event) {
      final hasInternet = event == InternetConnectionStatus.connected;
      if (!mounted) return;
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

  void rebuild() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: widget.selectedPage,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          shadowColor: Colors.white,
          elevation: 1,
          backgroundColor: Global_User_theme,
          title: Text(
            "Approval",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            // Container(
            //   margin: EdgeInsets.all(6.0),
            //   child: Image(
            //     image: AssetImage("images/bird.png"),
            //     alignment: Alignment.centerLeft,
            //   ),
            // ),
            circularBird()
          ],
          bottom: TabBar(
            // isScrollable: true,
            // unselectedLabelColor: Colors.red,
            // labelColor: Colors.black,

            indicatorColor: Colors.white,
            tabs: [
              Tab(text: "Leave"),
              Tab(
                text: "Hours reconciliation",
              ),
              Tab(text: "Attendance"),
            ],
          ),
        ),
        body: Form(child: tabBarItems()),
      ),
    );
  }

  Widget tabBarItems() {
    return TabBarView(
      children: [
        SingleChildScrollView(
          physics:
              AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
            child: Container(
              //  height: MediaQuery.of(context).size.height, //commented for keybord issue
              child: Header(),
            ),
          ),
        ),
        Container(child: NewApproval_TAB2()),
        Attendance_Approval()
      ],
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
                      //  mainAxisAlignment: MainAxisAlignment.center,
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
                              //  width: MediaQuery.of(context).size.width / 1.7, //commented for keybord issue
                              child: DropdownButtonHideUnderline(
                                child: ButtonTheme(
                                  alignedDropdown: false,
                                  child: DropdownButton<String>(
                                    hint: Text('Select'),

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
                            // SizedBox(
                            //   width: 30.w,
                            // ),
                            Container(
                              padding: EdgeInsets.all(3.w),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey)),
                              // width: MediaQuery.of(context).size.width / 2.7,//commented for keybord issue
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
                            margin: EdgeInsets.only(left: 6.w, right: 6.w),
                            padding: EdgeInsets.all(3.w),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)),
                            //   width: MediaQuery.of(context).size.width, //commented for keybord issue
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
                          ],
                        ),
                        // Divider(
                        //   thickness: 1,
                        // ),
                        Container(
                          height: MediaQuery.of(context).size.height /
                              2, //commented for keybord issue
                          child: RefreshIndicator(
                            onRefresh: fetchData,
                            child: FutureBuilder<List<ManagerApprovalModel>>(
                              initialData: const <ManagerApprovalModel>[],
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
                                  scrollDirection: Axis.vertical,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: DataTable(
                                      // headingRowHeight: 25,
                                      dividerThickness: 2,
                                      columnSpacing: 8,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                          borderRadius:
                                              BorderRadius.circular(5)),
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
                                        //   'Leave Type',
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
                                        //   'From',
                                        //   style: TextStyle(
                                        //       fontWeight: FontWeight.bold,
                                        //       fontSize: 15),
                                        // )),
                                        // DataColumn(
                                        //     label: Text(
                                        //   'To',
                                        //   style: TextStyle(
                                        //       fontWeight: FontWeight.bold,
                                        //       fontSize: 15),
                                        // )),
                                        // DataColumn(
                                        //     label: Text(
                                        //   'Days',
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
                                            cells: [
                                              DataCell(
                                                Text(
                                                  emp.APPROVED == "Y"
                                                      ? "Approved"
                                                      : emp.APPROVED == "N"
                                                          ? "Unapproved"
                                                          : "Denied",
                                                ),
                                                onTap: () => showCard(emp),

                                                //   GestureDetector(
                                                //   onTap: () {
                                                //     showDialog(
                                                //       context: context,
                                                //       builder:
                                                //           (dialogeeecontext) =>
                                                //               Center(
                                                //         child: Card(
                                                //           semanticContainer: true,
                                                //           clipBehavior: Clip
                                                //               .antiAliasWithSaveLayer,
                                                //           shape:
                                                //               RoundedRectangleBorder(
                                                //             borderRadius:
                                                //                 BorderRadius
                                                //                     .circular(
                                                //                         20.0),
                                                //           ),
                                                //           elevation: 5,
                                                //           margin:
                                                //               EdgeInsets.all(10),
                                                //           child: Container(
                                                //             height: MediaQuery.of(
                                                //                         context)
                                                //                     .size
                                                //                     .height /
                                                //                 2,
                                                //             color: Colors
                                                //                 .grey.shade200,
                                                //             child: Column(
                                                //               children: [
                                                //                 Padding(
                                                //                   padding:
                                                //                       const EdgeInsets
                                                //                               .all(
                                                //                           8.0),
                                                //                   child: Row(
                                                //                     mainAxisAlignment:
                                                //                         MainAxisAlignment
                                                //                             .center,
                                                //                     children: [
                                                //                       Text(
                                                //                           emp.APPROVED ==
                                                //                                   "Y"
                                                //                               ? "Approved"
                                                //                               : emp.APPROVED ==
                                                //                                       "N"
                                                //                                   ? "Unapproved"
                                                //                                   : "Denied",
                                                //                           style: TextStyle(
                                                //                               color:
                                                //                                   Colors.black,
                                                //                               fontWeight: FontWeight.bold))
                                                //                     ],
                                                //                   ),
                                                //                 ),
                                                //                 Padding(
                                                //                   padding:
                                                //                       const EdgeInsets
                                                //                               .all(
                                                //                           8.0),
                                                //                   child: Row(
                                                //                     // mainAxisAlignment:
                                                //                     //     MainAxisAlignment.center,
                                                //                     children: [
                                                //                       Text(
                                                //                         "Name:  ",
                                                //                         style: TextStyle(
                                                //                             color:
                                                //                                 Colors.black),
                                                //                       ),
                                                //                       Text(
                                                //                         emp.EMP_NAME
                                                //                             .toString(),
                                                //                         style: TextStyle(
                                                //                             color: Colors
                                                //                                 .black,
                                                //                             fontWeight:
                                                //                                 FontWeight.bold),
                                                //                       )
                                                //                     ],
                                                //                   ),
                                                //                 ),
                                                //                 // SizedBox(
                                                //                 //   height:
                                                //                 //       5,
                                                //                 // ),
                                                //                 Padding(
                                                //                   padding:
                                                //                       const EdgeInsets
                                                //                               .all(
                                                //                           8.0),
                                                //                   child: Row(
                                                //                     // mainAxisAlignment:
                                                //                     //     MainAxisAlignment.center,
                                                //                     children: [
                                                //                       Text(
                                                //                         "Employee Id:  ",
                                                //                         style: TextStyle(
                                                //                             color:
                                                //                                 Colors.black),
                                                //                       ),
                                                //                       Text(
                                                //                         emp.CPF_NO
                                                //                             .toInt()
                                                //                             .toString(),
                                                //                         style: TextStyle(
                                                //                             color: Colors
                                                //                                 .black,
                                                //                             fontWeight:
                                                //                                 FontWeight.bold),
                                                //                       )
                                                //                     ],
                                                //                   ),
                                                //                 ),
                                                //                 Padding(
                                                //                   padding:
                                                //                       const EdgeInsets
                                                //                               .all(
                                                //                           8.0),
                                                //                   child: Row(
                                                //                     // mainAxisAlignment:
                                                //                     //     MainAxisAlignment.center,
                                                //                     children: [
                                                //                       Text(
                                                //                         "Leave Type:  ",
                                                //                         style: TextStyle(
                                                //                             color:
                                                //                                 Colors.black),
                                                //                       ),
                                                //                       Text(
                                                //                         emp.LEAVE
                                                //                             .toString(),
                                                //                         style: TextStyle(
                                                //                             color: Colors
                                                //                                 .black,
                                                //                             fontWeight:
                                                //                                 FontWeight.bold),
                                                //                       )
                                                //                     ],
                                                //                   ),
                                                //                 ),
                                                //                 Padding(
                                                //                   padding:
                                                //                       const EdgeInsets
                                                //                               .all(
                                                //                           8.0),
                                                //                   child: Row(
                                                //                     // mainAxisAlignment:
                                                //                     //     MainAxisAlignment.center,
                                                //                     children: [
                                                //                       Text(
                                                //                         "Reason:  ",
                                                //                         style: TextStyle(
                                                //                             color:
                                                //                                 Colors.black),
                                                //                       ),
                                                //                       Text(
                                                //                         emp.REASON
                                                //                             .toString(),
                                                //                         style: TextStyle(
                                                //                             color: Colors
                                                //                                 .black,
                                                //                             fontWeight:
                                                //                                 FontWeight.bold),
                                                //                       )
                                                //                     ],
                                                //                   ),
                                                //                 ),
                                                //                 Padding(
                                                //                   padding:
                                                //                       const EdgeInsets
                                                //                               .all(
                                                //                           8.0),
                                                //                   child: Row(
                                                //                     // mainAxisAlignment:
                                                //                     //     MainAxisAlignment.center,
                                                //                     children: [
                                                //                       Text(
                                                //                         "From:  ",
                                                //                         style: TextStyle(
                                                //                             color:
                                                //                                 Colors.black),
                                                //                       ),
                                                //                       Text(
                                                //                         DateFormat(
                                                //                                 'dd-MMM-yyyy')
                                                //                             .format(
                                                //                                 DateTime.parse(emp.FROM_DATE!)),
                                                //                         style: TextStyle(
                                                //                             color: Colors
                                                //                                 .black,
                                                //                             fontWeight:
                                                //                                 FontWeight.bold),
                                                //                       )
                                                //                     ],
                                                //                   ),
                                                //                 ),
                                                //                 Padding(
                                                //                   padding:
                                                //                       const EdgeInsets
                                                //                               .all(
                                                //                           8.0),
                                                //                   child: Row(
                                                //                     // mainAxisAlignment:
                                                //                     //     MainAxisAlignment.center,
                                                //                     children: [
                                                //                       Text(
                                                //                         "To:  ",
                                                //                         style: TextStyle(
                                                //                             color:
                                                //                                 Colors.black),
                                                //                       ),
                                                //                       Text(
                                                //                         DateFormat(
                                                //                                 'dd-MMM-yyyy')
                                                //                             .format(
                                                //                                 DateTime.parse(emp.TO_DATE!)),
                                                //                         style: TextStyle(
                                                //                             color: Colors
                                                //                                 .black,
                                                //                             fontWeight:
                                                //                                 FontWeight.bold),
                                                //                       )
                                                //                     ],
                                                //                   ),
                                                //                 ),
                                                //                 Padding(
                                                //                   padding:
                                                //                       const EdgeInsets
                                                //                               .all(
                                                //                           8.0),
                                                //                   child: Row(
                                                //                     // mainAxisAlignment:
                                                //                     //     MainAxisAlignment.center,
                                                //                     children: [
                                                //                       Text(
                                                //                         "Days:  ",
                                                //                         style: TextStyle(
                                                //                             color:
                                                //                                 Colors.black),
                                                //                       ),
                                                //                       Text(
                                                //                         emp.DAYS
                                                //                             .toString(),
                                                //                         style: TextStyle(
                                                //                             color: Colors
                                                //                                 .black,
                                                //                             fontWeight:
                                                //                                 FontWeight.bold),
                                                //                       )
                                                //                     ],
                                                //                   ),
                                                //                 ),
                                                //                 Padding(
                                                //                   padding:
                                                //                       const EdgeInsets
                                                //                               .all(
                                                //                           15.0),
                                                //                   child: Row(
                                                //                     crossAxisAlignment:
                                                //                         CrossAxisAlignment
                                                //                             .center,
                                                //                     mainAxisAlignment:
                                                //                         MainAxisAlignment
                                                //                             .spaceEvenly,
                                                //                     children: [
                                                //                       ElevatedButton(
                                                //                           style: ElevatedButton.styleFrom(
                                                //                               primary: Color.fromRGBO(
                                                //                                   123,
                                                //                                   34,
                                                //                                   83,
                                                //                                   1)),
                                                //                           onPressed: emp.APPROVED ==
                                                //                                   "Y"
                                                //                               ? null
                                                //                               : () {
                                                //                                   if (emp.APPROVED == "Y") {
                                                //                                     return;
                                                //                                   }

                                                //                                   showDialog(
                                                //                                     context: context,
                                                //                                     builder: (dialogcontext) => new AlertDialog(
                                                //                                       title: Text("Are you  sure"),
                                                //                                       content: Text("Do you want to Approve ?"),
                                                //                                       actions: [
                                                //                                         TextButton(
                                                //                                             onPressed: () {
                                                //                                               Navigator.pop(context, false);
                                                //                                             },
                                                //                                             child: Text("No")),
                                                //                                         TextButton(
                                                //                                             onPressed: () async {
                                                //                                               if (emp.APPROVED == "Y") {
                                                //                                                 Navigator.pop(context, false);
                                                //                                                 return;
                                                //                                               }

                                                //                                               Navigator.pop(context, false);
                                                //                                               setState(() {
                                                //                                                 isApiLoading = true;
                                                //                                               });

                                                //                                               var SerialNo = emp.SERIAL_NO!.toInt();
                                                //                                               var cpfNo = manager_DropID;
                                                //                                               var peerCpfNo = emp.CPF_NO;
                                                //                                               var flag_of_app = true;
                                                //                                               if (emp.APPROVED == "Y") {
                                                //                                                 flag_of_app = false;
                                                //                                               }
                                                //                                               _approveLeave(cpfNo, SerialNo, flag_of_app);
                                                //                                               Navigator.pop(context, false);
                                                //                                             },
                                                //                                             child: Text("Yes")),
                                                //                                       ],
                                                //                                     ),
                                                //                                   );
                                                //                                 },
                                                //                           child:
                                                //                               Text(
                                                //                             "Approve",
                                                //                             style: TextStyle(
                                                //                                 color: Colors.white,
                                                //                                 fontWeight: FontWeight.bold),
                                                //                           )),
                                                //                       ElevatedButton(
                                                //                           style: ElevatedButton.styleFrom(
                                                //                               primary: Color.fromRGBO(
                                                //                                   123,
                                                //                                   34,
                                                //                                   83,
                                                //                                   1)),
                                                //                           onPressed: emp.APPROVED ==
                                                //                                   "N"
                                                //                               ? () {
                                                //                                   showDialog(
                                                //                                     context: context,
                                                //                                     builder: (dialogeecontext) => new AlertDialog(
                                                //                                       title: Text("Are you  sure"),
                                                //                                       content: Text("Do you want to reject?"),
                                                //                                       actions: [
                                                //                                         TextButton(
                                                //                                             onPressed: () {
                                                //                                               Navigator.pop(context, false);
                                                //                                             },
                                                //                                             child: Text("No")),
                                                //                                         TextButton(
                                                //                                             onPressed: () async {
                                                //                                               Navigator.pop(context, false);
                                                //                                               //  Navigator.pop(context, true);
                                                //                                               Navigator.pop(context, false);

                                                //                                               var SerialNo = emp.SERIAL_NO!.toInt();
                                                //                                               var cpfNo = manager_DropID;
                                                //                                               var peerCpfNo = emp.CPF_NO;
                                                //                                               if (emp.APPROVED == "N") {
                                                //                                                 _rejectController.clear();

                                                //                                                 showModalBottomSheet(
                                                //                                                     isScrollControlled: true,
                                                //                                                     shape: RoundedRectangleBorder(
                                                //                                                       // <-- SEE HERE
                                                //                                                       borderRadius: BorderRadius.vertical(
                                                //                                                         top: Radius.circular(25.0),
                                                //                                                       ),
                                                //                                                     ),
                                                //                                                     context: context,
                                                //                                                     builder: (context) {
                                                //                                                       return Padding(
                                                //                                                         padding: MediaQuery.of(context).viewInsets,
                                                //                                                         child: Container(
                                                //                                                           padding: EdgeInsets.all(30),
                                                //                                                           child: SizedBox(
                                                //                                                             height: 200,
                                                //                                                             child: Column(
                                                //                                                               mainAxisSize: MainAxisSize.min,
                                                //                                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                //                                                               children: <Widget>[
                                                //                                                                 Container(
                                                //                                                                   child: Column(
                                                //                                                                     children: [
                                                //                                                                       Container(
                                                //                                                                         child: Text(
                                                //                                                                           'Enter Reason',
                                                //                                                                           style: TextStyle(fontSize: 20),
                                                //                                                                         ),
                                                //                                                                       ),
                                                //                                                                       SizedBox(height: 20),
                                                //                                                                       AppTextField(
                                                //                                                                         //  key: __key,
                                                //                                                                         controller: _rejectController,
                                                //                                                                         labelText: "Enter here",
                                                //                                                                         isPassword: true,
                                                //                                                                       ),
                                                //                                                                       SizedBox(height: 10),
                                                //                                                                       AppButton(
                                                //                                                                         color: Color.fromRGBO(123, 34, 83, 1),
                                                //                                                                         text: 'reject',
                                                //                                                                         onPressed: () async {
                                                //                                                                           Navigator.pop(context, false);

                                                //                                                                           if (_rejectController.text == "") {
                                                //                                                                             ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter reason.")));
                                                //                                                                           } else {
                                                //                                                                             var serial_no = emp.SERIAL_NO!.toInt();
                                                //                                                                             var reason_text = _rejectController.text;
                                                //                                                                             var flag_of_deny = true;
                                                //                                                                             _rejectLeave(flag_of_deny, serial_no, reason_text);
                                                //                                                                           }
                                                //                                                                         },
                                                //                                                                         icon: Icon(
                                                //                                                                           Icons.check,
                                                //                                                                           color: Colors.white,
                                                //                                                                         ),
                                                //                                                                       )
                                                //                                                                     ],
                                                //                                                                   ),
                                                //                                                                 ),
                                                //                                                               ],
                                                //                                                             ),
                                                //                                                           ),
                                                //                                                         ),
                                                //                                                       );
                                                //                                                     });
                                                //                                               } else {
                                                //                                                 if (emp.APPROVED == "Y") {
                                                //                                                   //already approved
                                                //                                                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("You cannot deny approved leave. ")));
                                                //                                                   setState(() {
                                                //                                                     isApiLoading = false;
                                                //                                                   });
                                                //                                                 }
                                                //                                                 if (emp.APPROVED == "X") {
                                                //                                                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Already Denied ")));
                                                //                                                 }
                                                //                                               }
                                                //                                             },
                                                //                                             child: Text("Yes")),
                                                //                                       ],
                                                //                                     ),
                                                //                                   );
                                                //                                 }
                                                //                               : null,
                                                //                           child:
                                                //                               Text(
                                                //                             "Reject",
                                                //                             style: TextStyle(
                                                //                                 color: Colors.white,
                                                //                                 fontWeight: FontWeight.bold),
                                                //                           )),
                                                //                       ElevatedButton(
                                                //                           style: ElevatedButton.styleFrom(
                                                //                               primary: Color.fromRGBO(
                                                //                                   123,
                                                //                                   34,
                                                //                                   83,
                                                //                                   1)),
                                                //                           onPressed: emp.APPROVED !=
                                                //                                   "N"
                                                //                               ? null
                                                //                               : () {
                                                //                                   showDialog(
                                                //                                     context: context,
                                                //                                     builder: (dialogeeeecontext) => new AlertDialog(
                                                //                                       title: Text("Are you  sure"),
                                                //                                       content: Text("Do you want to delete?"),
                                                //                                       // backgroundColor: Colors.red.shade100,
                                                //                                       actions: [
                                                //                                         TextButton(
                                                //                                             onPressed: () {
                                                //                                               Navigator.pop(context, false);
                                                //                                             },
                                                //                                             child: Text("No")),
                                                //                                         TextButton(
                                                //                                             onPressed: () async {
                                                //                                               Navigator.pop(context, false);
                                                //                                               Navigator.pop(context, false);
                                                //                                               setState(() {
                                                //                                                 isApiLoading = true;
                                                //                                               });
                                                //                                               if (emp.APPROVED != "N") {
                                                //                                                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("You cannot delete approved/denied leave.")));
                                                //                                                 //  Navigator.pop(context, true);
                                                //                                                 //  return;
                                                //                                               } else {
                                                //                                                 var cpfNo = emp.CPF_NO.toInt();
                                                //                                                 var serialNo = emp.SERIAL_NO!.toInt();
                                                //                                                 _deleteLeve(cpfNo, serialNo);
                                                //                                               }
                                                //                                               //  Navigator.pop(context, true);
                                                //                                             },
                                                //                                             child: Text("Yes")),
                                                //                                       ],
                                                //                                     ),
                                                //                                   );
                                                //                                 },
                                                //                           child:
                                                //                               Text(
                                                //                             "Delete",
                                                //                             style: TextStyle(
                                                //                                 color: Colors.white,
                                                //                                 fontWeight: FontWeight.bold),
                                                //                           )),
                                                //                     ],
                                                //                   ),
                                                //                 )
                                                //               ],
                                                //             ),
                                                //           ),
                                                //         ),
                                                //       ),
                                                //     );
                                                //   },
                                                //   child: Text(
                                                //     emp.APPROVED == "Y"
                                                //         ? "Approved"
                                                //         : emp.APPROVED == "N"
                                                //             ? "Unapproved"
                                                //             : "Denied",
                                                //   ),
                                                // )
                                                // emp.APPROVED == "Y"
                                                //       ? Text("Approved")

                                                //       // Icon(
                                                //       //     Icons.check,
                                                //       //     color: Colors.green,
                                                //       //     //  size: 35,
                                                //       //   )
                                                //       : emp.APPROVED == "N"
                                                //           ? Text("Unapproved")
                                                //           // Icon(
                                                //           //     Icons.pending,
                                                //           //     color: Colors.red,
                                                //           //     //size: 35,
                                                //           //   )
                                                //           : Text("Denied")
                                                //  Icon(
                                                //     Icons.close,
                                                //     color: Colors.red,
                                                //   )
                                              ),
                                              // DataCell(
                                              //   StatefulBuilder(
                                              //     builder:
                                              //         (BuildContext context,
                                              //             setState) {
                                              //       return Container(
                                              //         margin: EdgeInsets.only(
                                              //             top: 9, bottom: 9),
                                              //         //  padding: EdgeInsets.all(0),
                                              //         decoration: BoxDecoration(
                                              //           // borderRadius:
                                              //           //     BorderRadius.circular(10),
                                              //           // border: Border.all(
                                              //           //     width: 1,
                                              //           //     color: Colors.black),
                                              //           color: Color.fromRGBO(
                                              //               123, 34, 83, 0.1),
                                              //         ),
                                              //         // width: MediaQuery.of(context).size.width,
                                              //         child: Padding(
                                              //           padding:
                                              //               const EdgeInsets
                                              //                   .only(left: 10),
                                              //           child: DropdownButton(
                                              //             // Initial Value
                                              //             // value: dropdownvalue,
                                              //             hint: FittedBox(
                                              //               child: Text(
                                              //                 'Action',
                                              //                 style: TextStyle(
                                              //                     color: Colors
                                              //                         .black),
                                              //               ),
                                              //             ),

                                              //             // Down Arrow Icon
                                              //             icon: const Icon(
                                              //               Icons
                                              //                   .keyboard_arrow_down,
                                              //               color: Colors.black,
                                              //             ),

                                              //             // Array list of items
                                              //             items: actions.map(
                                              //                 (String items) {
                                              //               return DropdownMenuItem(
                                              //                 value: items,
                                              //                 child:
                                              //                     Text(items),
                                              //               );
                                              //             }).toList(),
                                              //             dropdownColor:
                                              //                 Color.fromRGBO(
                                              //                     123,
                                              //                     34,
                                              //                     83,
                                              //                     1),
                                              //             //focusColor: Colors.white,
                                              //             style: TextStyle(
                                              //                 color:
                                              //                     Colors.white),
                                              //             autofocus: true,
                                              //             elevation: 10,
                                              //             underline: SizedBox(),

                                              //             // After selecting the desired option,it will
                                              //             // change button value to selected value
                                              //             onChanged: (String?
                                              //                 newValue) {
                                              //               if (newValue ==
                                              //                   "Approve") {
                                              //                 if (emp.APPROVED ==
                                              //                     "Y") {
                                              //                   return;
                                              //                 }

                                              //                 print("approve");
                                              //                 showDialog(
                                              //                   context:
                                              //                       context,
                                              //                   builder:
                                              //                       (dialogcontext) =>
                                              //                           new AlertDialog(
                                              //                     title: Text(
                                              //                         "are you  sure"),
                                              //                     content: Text(
                                              //                         "Do you want to Approve"),
                                              //                     actions: [
                                              //                       TextButton(
                                              //                           onPressed:
                                              //                               () async {
                                              //                             if (emp.APPROVED ==
                                              //                                 "Y") {
                                              //                               Navigator.pop(context,
                                              //                                   false);
                                              //                               return;
                                              //                             }

                                              //                             Navigator.pop(
                                              //                                 context,
                                              //                                 false);
                                              //                             setState(
                                              //                                 () {
                                              //                               isApiLoading =
                                              //                                   true;
                                              //                             });
                                              //                             // Navigator.of(context,
                                              //                             //         rootNavigator: true)
                                              //                             //     .pop();
                                              //                             var SerialNo = emp
                                              //                                 .SERIAL_NO!
                                              //                                 .toInt();
                                              //                             var cpfNo =
                                              //                                 manager_DropID;
                                              //                             var peerCpfNo =
                                              //                                 emp.CPF_NO;
                                              //                             var flag_of_app =
                                              //                                 true;
                                              //                             if (emp.APPROVED ==
                                              //                                 "Y") {
                                              //                               flag_of_app =
                                              //                                   false;
                                              //                             }
                                              //                             _approveLeave(
                                              //                                 cpfNo,
                                              //                                 SerialNo,
                                              //                                 flag_of_app);
                                              //                             // try {
                                              //                             //   Response
                                              //                             //       response =
                                              //                             //       await post(Uri.parse("http://172.16.15.129:8073/api/TeamLeaveAPI/LeaveApproveUnapproved"), headers: {
                                              //                             //     "MobileURL":
                                              //                             //         "Leaveapprovalpage",
                                              //                             //     "CPF_NO":
                                              //                             //         globalInt.toString()
                                              //                             //   }, body: {
                                              //                             //     "cpfNo":
                                              //                             //         cpfNo.toString(),
                                              //                             //     "serialNo":
                                              //                             //         SerialNo.toString(),
                                              //                             //     "approveUnapprove":
                                              //                             //         flag_of_app.toString()
                                              //                             //   });

                                              //                             //   var resopnseFromApi =
                                              //                             //       json.decode(response.body);
                                              //                             //   var output =
                                              //                             //       resopnseFromApi["Output"];
                                              //                             //   var MSG =
                                              //                             //       resopnseFromApi["MSG"];
                                              //                             //   setState(
                                              //                             //       () {
                                              //                             //     isApiLoading =
                                              //                             //         false;
                                              //                             //   });

                                              //                             //   if (response.statusCode !=
                                              //                             //       200) {
                                              //                             //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Internal server error")));
                                              //                             //     return;
                                              //                             //   }

                                              //                             //   if (output ==
                                              //                             //       "SUCCESS") {
                                              //                             //     // SweetAlert.show(
                                              //                             //     //     context,
                                              //                             //     //     title: "Approved",
                                              //                             //     //     subtitle: MSG,
                                              //                             //     //     // onPress: Navigator.pop(context, false),
                                              //                             //     //     style: SweetAlertStyle.success);
                                              //                             //     // AwesomeDialog(
                                              //                             //     //   context: context,
                                              //                             //     //   dialogType: DialogType.SUCCES,
                                              //                             //     //   animType: AnimType.BOTTOMSLIDE,
                                              //                             //     //   title: 'Apporved',
                                              //                             //     //   desc: MSG,
                                              //                             //     //   btnCancelOnPress: () {},
                                              //                             //     //   btnOkOnPress: () {},
                                              //                             //     // )..show();
                                              //                             //     showDialog(
                                              //                             //       context: context,
                                              //                             //       builder: (context) {
                                              //                             //         return AlertDialog(
                                              //                             //           backgroundColor: Colors.green,
                                              //                             //           content: Text(
                                              //                             //             '✓Apporved,$MSG',
                                              //                             //             style: TextStyle(color: Colors.white),
                                              //                             //           ),
                                              //                             //         );
                                              //                             //       },
                                              //                             //     );
                                              //                             //     fetchData();
                                              //                             //     rebuild();
                                              //                             //   } else {
                                              //                             //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(MSG)));
                                              //                             //   }
                                              //                             //   // Navigator.pop(context, false);

                                              //                             // } catch (e) {
                                              //                             //   print(
                                              //                             //       e);
                                              //                             //   showDialog(
                                              //                             //     context:
                                              //                             //         context,
                                              //                             //     builder:
                                              //                             //         (context) {
                                              //                             //       return AlertDialog(
                                              //                             //         backgroundColor: Colors.red,
                                              //                             //         content: Text(
                                              //                             //           '$e',
                                              //                             //           style: TextStyle(color: Colors.white),
                                              //                             //         ),
                                              //                             //       );
                                              //                             //     },
                                              //                             //   );
                                              //                             // }
                                              //                           },
                                              //                           child: Text(
                                              //                               "Yes")),
                                              //                       TextButton(
                                              //                           onPressed:
                                              //                               () {
                                              //                             Navigator.pop(
                                              //                                 context,
                                              //                                 false);
                                              //                           },
                                              //                           child: Text(
                                              //                               "No")),
                                              //                     ],
                                              //                   ),
                                              //                 );
                                              //               } else if (newValue ==
                                              //                   "Reject") {
                                              //                 print("reject");
                                              //                 showDialog(
                                              //                   context:
                                              //                       context,
                                              //                   builder:
                                              //                       (dialogeecontext) =>
                                              //                           new AlertDialog(
                                              //                     title: Text(
                                              //                         "Are you  sure"),
                                              //                     content: Text(
                                              //                         "Do you want to reject?"),
                                              //                     actions: [
                                              //                       TextButton(
                                              //                           onPressed:
                                              //                               () async {
                                              //                             Navigator.pop(
                                              //                                 context,
                                              //                                 false);
                                              //                             //  Navigator.pop(context, true);

                                              //                             var SerialNo = emp
                                              //                                 .SERIAL_NO!
                                              //                                 .toInt();
                                              //                             var cpfNo =
                                              //                                 manager_DropID;
                                              //                             var peerCpfNo =
                                              //                                 emp.CPF_NO;
                                              //                             if (emp.APPROVED ==
                                              //                                 "N") {
                                              //                               _rejectController.clear();
                                              //                               //   showSheet();
                                              //                               // showDialog(
                                              //                               //     context: context,
                                              //                               //     builder: (dialogeeecontext) => AlertDialog(
                                              //                               //           title: Text("Enter Reason"),
                                              //                               //           content: TextField(
                                              //                               //             key: __KEY,
                                              //                               //             controller: Reason,
                                              //                               //             decoration: InputDecoration(hintText: "Enter reason here"),
                                              //                               //           ),
                                              //                               //           actions: [
                                              //                               //             TextButton(

                                              //                               //                 //!<-------------function after reason for deny of leave and pressing ok---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->
                                              //                               //                 onPressed: () async {
                                              //                               //                   Navigator.pop(context, false);
                                              //                               //                   if (Reason.text == "") {
                                              //                               //                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter reason.")));
                                              //                               //                   } else {
                                              //                               //                     var serial_no = emp.SERIAL_NO;
                                              //                               //                     var reason_text = Reason.text;
                                              //                               //                     var flag_of_deny = true;
                                              //                               //                     _rejectLeave(flag_of_deny, serial_no, reason_text);
                                              //                               //                     // try {
                                              //                               //                     //   Response response = await post(Uri.parse("http://172.16.15.129:8073/api/TeamLeaveAPI/Leavedeny"), headers: {
                                              //                               //                     //     "MobileURL": "Leaveapprovalpage",
                                              //                               //                     //     "CPF_NO": globalInt.toString()
                                              //                               //                     //   }, body: {
                                              //                               //                     //     "approveUnapprove": flag_of_deny.toString(),
                                              //                               //                     //     "serialNo": serial_no.toString(),
                                              //                               //                     //     "Reason": reason_text,
                                              //                               //                     //     "cpfNo": manager_DropID.toString()
                                              //                               //                     //   });
                                              //                               //                     //   setState(() {
                                              //                               //                     //     isApiLoading = false;
                                              //                               //                     //   });
                                              //                               //                     //   print(response.body);
                                              //                               //                     //   var resopnseFromApi = json.decode(response.body);
                                              //                               //                     //   var output = resopnseFromApi["Output"];
                                              //                               //                     //   var MSG = resopnseFromApi["MSG"];
                                              //                               //                     //   if (output == "SUCCESS") {
                                              //                               //                     //     // SweetAlert.show(context,
                                              //                               //                     //     //     title: "Approved",
                                              //                               //                     //     //     subtitle: MSG,
                                              //                               //                     //     //     // onPress: Navigator.pop(context, false),
                                              //                               //                     //     //     style: SweetAlertStyle.success);
                                              //                               //                     //     AwesomeDialog(
                                              //                               //                     //       context: context,
                                              //                               //                     //       dialogType: DialogType.SUCCES,
                                              //                               //                     //       animType: AnimType.BOTTOMSLIDE,
                                              //                               //                     //       title: 'Approved',
                                              //                               //                     //       desc: MSG,
                                              //                               //                     //       btnCancelOnPress: () {},
                                              //                               //                     //       btnOkOnPress: () {},
                                              //                               //                     //     )..show();
                                              //                               //                     //     fetchData();
                                              //                               //                     //     rebuild();
                                              //                               //                     //     Reason.clear();
                                              //                               //                     //   } else {
                                              //                               //                     //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: MSG));
                                              //                               //                     //   }
                                              //                               //                     //   //  Navigator.pop(context, true);
                                              //                               //                     // } catch (e) {
                                              //                               //                     //   print(e);
                                              //                               //                     // }
                                              //                               //                   }
                                              //                               //                 },
                                              //                               //                 child: Text("Submit"))
                                              //                               //           ],
                                              //                               //         ));
                                              //                               showModalBottomSheet(
                                              //                                   isScrollControlled: true,
                                              //                                   shape: RoundedRectangleBorder(
                                              //                                     // <-- SEE HERE
                                              //                                     borderRadius: BorderRadius.vertical(
                                              //                                       top: Radius.circular(25.0),
                                              //                                     ),
                                              //                                   ),
                                              //                                   context: context,
                                              //                                   builder: (context) {
                                              //                                     return Padding(
                                              //                                       padding: MediaQuery.of(context).viewInsets,
                                              //                                       child: Container(
                                              //                                         padding: EdgeInsets.all(30),
                                              //                                         child: SizedBox(
                                              //                                           height: 200,
                                              //                                           child: Column(
                                              //                                             mainAxisSize: MainAxisSize.min,
                                              //                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              //                                             children: <Widget>[
                                              //                                               Container(
                                              //                                                 child: Column(
                                              //                                                   children: [
                                              //                                                     Container(
                                              //                                                       child: Text(
                                              //                                                         'Enter Reason',
                                              //                                                         style: TextStyle(fontSize: 20),
                                              //                                                       ),
                                              //                                                     ),
                                              //                                                     SizedBox(height: 20),
                                              //                                                     AppTextField(
                                              //                                                       //  key: __key,
                                              //                                                       controller: _rejectController,
                                              //                                                       labelText: "Enter here",
                                              //                                                       isPassword: true,
                                              //                                                     ),
                                              //                                                     SizedBox(height: 10),
                                              //                                                     AppButton(
                                              //                                                       color: Color.fromRGBO(123, 34, 83, 1),
                                              //                                                       text: 'reject',
                                              //                                                       onPressed: () async {
                                              //                                                         Navigator.pop(context, false);

                                              //                                                         if (_rejectController.text == "") {
                                              //                                                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter reason.")));
                                              //                                                         } else {
                                              //                                                           var serial_no = emp.SERIAL_NO!.toInt();
                                              //                                                           var reason_text = _rejectController.text;
                                              //                                                           var flag_of_deny = true;
                                              //                                                           _rejectLeave(flag_of_deny, serial_no, reason_text);
                                              //                                                         }
                                              //                                                       },
                                              //                                                       icon: Icon(
                                              //                                                         Icons.check,
                                              //                                                         color: Colors.white,
                                              //                                                       ),
                                              //                                                     )
                                              //                                                   ],
                                              //                                                 ),
                                              //                                               ),
                                              //                                             ],
                                              //                                           ),
                                              //                                         ),
                                              //                                       ),
                                              //                                     );
                                              //                                   });
                                              //                             } else {
                                              //                               if (emp.APPROVED ==
                                              //                                   "Y") {
                                              //                                 //already approved
                                              //                                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("You cannot deny approved leave. ")));
                                              //                                 setState(() {
                                              //                                   isApiLoading = false;
                                              //                                 });
                                              //                               }
                                              //                               if (emp.APPROVED ==
                                              //                                   "X") {
                                              //                                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Already Denied ")));

                                              //                                 // _onDeleteDeniedLeave(SerialNo,
                                              //                                 //     cpfNo);
                                              //                                 //already denied

                                              //                                 // try {
                                              //                                 //   Response response = await post(Uri.parse("http://172.16.15.129:8073/api/TeamLeaveAPI/LeaveUndeny"), headers: {
                                              //                                 //     "MobileURL": "Leaveapprovalpage",
                                              //                                 //     "CPF_NO": globalInt.toString()
                                              //                                 //   }, body: {
                                              //                                 //     "cpfNo": cpfNo.toString(),
                                              //                                 //     "serialNo": SerialNo.toString(),
                                              //                                 //   });
                                              //                                 //   setState(() {
                                              //                                 //     isApiLoading = false;
                                              //                                 //   });
                                              //                                 //   var resopnseFromApi = json.decode(response.body);
                                              //                                 //   var output = resopnseFromApi["Output"];
                                              //                                 //   var MSG = resopnseFromApi["MSG"];
                                              //                                 //   if (output == "SUCCESS") {
                                              //                                 //     // SweetAlert.show(context,
                                              //                                 //     //     title: "Approved",
                                              //                                 //     //     subtitle: MSG,
                                              //                                 //     //     // onPress: Navigator.pop(context, false),
                                              //                                 //     //     style: SweetAlertStyle.success);
                                              //                                 //     AwesomeDialog(
                                              //                                 //       context: context,
                                              //                                 //       dialogType: DialogType.SUCCES,
                                              //                                 //       animType: AnimType.BOTTOMSLIDE,
                                              //                                 //       title: 'Approved',
                                              //                                 //       desc: MSG,
                                              //                                 //       btnCancelOnPress: () {},
                                              //                                 //       btnOkOnPress: () {},
                                              //                                 //     )..show();

                                              //                                 //     fetchData();
                                              //                                 //   } else {
                                              //                                 //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: MSG));
                                              //                                 //   }
                                              //                                 // } catch (e) {
                                              //                                 //   print(e);
                                              //                                 // }
                                              //                               }
                                              //                             }
                                              //                           },
                                              //                           child: Text(
                                              //                               "Yes")),
                                              //                       TextButton(
                                              //                           onPressed:
                                              //                               () {
                                              //                             Navigator.pop(
                                              //                                 context,
                                              //                                 false);
                                              //                           },
                                              //                           child: Text(
                                              //                               "No")),
                                              //                     ],
                                              //                   ),
                                              //                 );
                                              //               } else if (newValue ==
                                              //                   "Delete") {
                                              //                 print("delete");
                                              //                 showDialog(
                                              //                   context:
                                              //                       context,
                                              //                   builder:
                                              //                       (dialogeeeecontext) =>
                                              //                           new AlertDialog(
                                              //                     title: Text(
                                              //                         "are you  sure"),
                                              //                     content: Text(
                                              //                         "Do you want to delete?"),
                                              //                     // backgroundColor: Colors.red.shade100,
                                              //                     actions: [
                                              //                       TextButton(
                                              //                           onPressed:
                                              //                               () async {
                                              //                             Navigator.pop(
                                              //                                 context,
                                              //                                 false);
                                              //                             setState(
                                              //                                 () {
                                              //                               isApiLoading =
                                              //                                   true;
                                              //                             });
                                              //                             if (emp.APPROVED !=
                                              //                                 "N") {
                                              //                               ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("You cannot delete approved/denied leave.")));
                                              //                               //  Navigator.pop(context, true);
                                              //                               //  return;
                                              //                             } else {
                                              //                               var cpfNo =
                                              //                                   emp.CPF_NO.toInt();
                                              //                               var serialNo =
                                              //                                   emp.SERIAL_NO!.toInt();
                                              //                               _deleteLeve(cpfNo,
                                              //                                   serialNo);

                                              //                               // try {
                                              //                               //   Response
                                              //                               //       response =
                                              //                               //       await post(Uri.parse("http://172.16.15.129:8073/api/TeamLeaveAPI/DeleteRecorManager"), headers: {
                                              //                               //     "MobileURL": "Leaveapprovalpage",
                                              //                               //     "CPF_NO": globalInt.toString()
                                              //                               //   }, body: {
                                              //                               //     "cpfNo": cpfNo.toString(),
                                              //                               //     "serialNo": serialNo.toString(),
                                              //                               //     "ouId": ouId.toString(),
                                              //                               //   });

                                              //                               //   print(response.body);
                                              //                               //   var responseFromApi =
                                              //                               //       json.decode(response.body);
                                              //                               //   var status =
                                              //                               //       responseFromApi['status'];
                                              //                               //   var value =
                                              //                               //       responseFromApi['value'];
                                              //                               //   setState(() {
                                              //                               //     isApiLoading = false;
                                              //                               //   });
                                              //                               //   if (status ==
                                              //                               //       1) {
                                              //                               //     // SweetAlert.show(context,
                                              //                               //     //     title: "Sucess",
                                              //                               //     //     subtitle: "Leave deleted successfully",
                                              //                               //     //     // onPress: Navigator.pop(context, false),
                                              //                               //     //     style: SweetAlertStyle.success);
                                              //                               //     // AwesomeDialog(
                                              //                               //     //   context: context,
                                              //                               //     //   dialogType: DialogType.SUCCES,
                                              //                               //     //   animType: AnimType.BOTTOMSLIDE,
                                              //                               //     //   title: "Sucess",
                                              //                               //     //   desc: "Leave deleted successfully",
                                              //                               //     //   btnCancelOnPress: () {},
                                              //                               //     //   btnOkOnPress: () {},
                                              //                               //     // )..show();
                                              //                               //     showDialog(
                                              //                               //       context: context,
                                              //                               //       builder: (context) {
                                              //                               //         return const AlertDialog(
                                              //                               //           backgroundColor: Colors.green,
                                              //                               //           content: Text(
                                              //                               //             'Leave deleted successfully',
                                              //                               //             style: TextStyle(color: Colors.white),
                                              //                               //           ),
                                              //                               //         );
                                              //                               //       },
                                              //                               //     );
                                              //                               //     fetchData();
                                              //                               //     rebuild();
                                              //                               //   } else {
                                              //                               //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error  ${value.toString()}.")));
                                              //                               //   }
                                              //                               // } catch (e) {
                                              //                               //   showDialog(
                                              //                               //     context: context,
                                              //                               //     builder: (context) {
                                              //                               //       return AlertDialog(
                                              //                               //         backgroundColor: Colors.red,
                                              //                               //         content: Text(
                                              //                               //           'Error, $e',
                                              //                               //           style: TextStyle(color: Colors.white),
                                              //                               //         ),
                                              //                               //       );
                                              //                               //     },
                                              //                               //   );
                                              //                               //   print(e);
                                              //                               // }
                                              //                             }
                                              //                             //  Navigator.pop(context, true);
                                              //                           },
                                              //                           child: Text(
                                              //                               "Yes")),
                                              //                       TextButton(
                                              //                           onPressed:
                                              //                               () {
                                              //                             Navigator.pop(
                                              //                                 context,
                                              //                                 false);
                                              //                           },
                                              //                           child: Text(
                                              //                               "No")),
                                              //                     ],
                                              //                   ),
                                              //                 );
                                              //               }
                                              //               setState(() {
                                              //                 dropdownvalue =
                                              //                     newValue!;
                                              //                 showDropDownHint =
                                              //                     false;
                                              //               });
                                              //             },
                                              //           ),
                                              //         ),
                                              //       );
                                              //     },
                                              //   ),
                                              // ),
                                              DataCell(
                                                Text(emp.CPF_NO
                                                    .toInt()
                                                    .toString()),
                                                onTap: () => showCard(emp),
                                              ),
                                              DataCell(
                                                Text(emp.EMP_NAME.toString()),
                                                onTap: () => showCard(emp),
                                              ),
                                              DataCell(TextButton(
                                                  onPressed: () {
                                                    showCard(emp);
                                                  },
                                                  child: Text(
                                                    "Click here",
                                                    style: TextStyle(
                                                        color:
                                                            Global_User_theme),
                                                  )))
                                              // DataCell(
                                              //   Text(emp.LEAVE!),
                                              //   onTap: () => showCard(emp),
                                              // ),
                                              // DataCell(
                                              //   Text(emp.REASON.toString()),
                                              //   onTap: () => showCard(emp),
                                              // ),
                                              // DataCell(
                                              //   Text(
                                              //     DateFormat('dd-MMM-yyyy')
                                              //         .format(DateTime.parse(
                                              //             emp.FROM_DATE!)),
                                              //   ),
                                              //   onTap: () => showCard(emp),
                                              // ),
                                              // DataCell(
                                              //   Text(
                                              //     DateFormat('dd-MMM-yyyy')
                                              //         .format(DateTime.parse(
                                              //             emp.TO_DATE!)),
                                              //   ),
                                              //   onTap: () => showCard(emp),
                                              // ),
                                              // DataCell(
                                              //   Text(emp.DAYS.toString()),
                                              //   onTap: () => showCard(emp),
                                              // ),
                                              // DataCell(
                                              //   Text(
                                              //     DateFormat('dd-MMM-yyyy')
                                              //         .format(DateTime.parse(
                                              //             emp.APPLIED_DATE!)),
                                              //   ),
                                              //   onTap: () {
                                              //     showCard(emp);
                                              //   },
                                              // ),
                                            ],
                                            // onSelectChanged: ((value) {
                                            //   print("pressed");
                                            // })
                                          );
                                        },
                                      ).toList(),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        //DataTablee()
                      ],
                    ),
                  );
  }

  showCard(ManagerApprovalModel emp) {
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
              //  height: MediaQuery.of(context).size.height / 2,
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
                          "Leave Type:  ",
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          emp.LEAVE.toString(),
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
                          emp.REASON.toString(),
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
                          "From:  ",
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          DateFormat('dd-MMM-yyyy')
                              .format(DateTime.parse(emp.FROM_DATE!)),
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
                          "To:  ",
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          DateFormat('dd-MMM-yyyy')
                              .format(DateTime.parse(emp.TO_DATE!)),
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
                          "Days:  ",
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          emp.DAYS.toString(),
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
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
                                                Navigator.pop(context, false);
                                                if (emp.APPROVED == "Y") {
                                                  return;
                                                }

                                                // setState(() {
                                                //   isApiLoading = true;
                                                // });

                                                var SerialNo =
                                                    emp.SERIAL_NO!.toInt();
                                                var cpfNo = manager_DropID;
                                                var peerCpfNo = emp.CPF_NO;
                                                var flag_of_app = true;
                                                if (emp.APPROVED == "Y") {
                                                  flag_of_app = false;
                                                }
                                                Navigator.pop(context, false);
                                                await _approveLeave(cpfNo,
                                                    SerialNo, flag_of_app);

                                                // Navigator.pop(context, false);
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
                            onPressed: emp.APPROVED == "N"
                                ? () {
                                    showDialog(
                                      context: context,
                                      builder: (dialogeecontext) =>
                                          new AlertDialog(
                                        title: Text("Are you  sure"),
                                        content: Text("Do you want to reject?"),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context, false);
                                              },
                                              child: Text("No")),
                                          TextButton(
                                              onPressed: () async {
                                                Navigator.pop(context, false);
                                                //  Navigator.pop(context, true);
                                                Navigator.pop(context, false);

                                                var SerialNo =
                                                    emp.SERIAL_NO!.toInt();
                                                var cpfNo = manager_DropID;
                                                var peerCpfNo = emp.CPF_NO;
                                                if (emp.APPROVED == "N") {
                                                  _rejectController.clear();

                                                  showModalBottomSheet(
                                                      isScrollControlled: true,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        // <-- SEE HERE
                                                        borderRadius:
                                                            BorderRadius
                                                                .vertical(
                                                          top: Radius.circular(
                                                              25.0),
                                                        ),
                                                      ),
                                                      context: context,
                                                      builder: (context) {
                                                        return Padding(
                                                          padding:
                                                              MediaQuery.of(
                                                                      context)
                                                                  .viewInsets,
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    30),
                                                            child: SizedBox(
                                                              height: 200,
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: <
                                                                    Widget>[
                                                                  Container(
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Container(
                                                                          child:
                                                                              Text(
                                                                            'Enter Reason',
                                                                            style:
                                                                                TextStyle(fontSize: 20),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                            height:
                                                                                20),
                                                                        AppTextField(
                                                                          //  key: __key,
                                                                          controller:
                                                                              _rejectController,
                                                                          labelText:
                                                                              "Enter here",
                                                                          isPassword:
                                                                              false,
                                                                        ),
                                                                        SizedBox(
                                                                            height:
                                                                                10),
                                                                        AppButton(
                                                                          color:
                                                                              Global_User_theme,
                                                                          text:
                                                                              'reject',
                                                                          onPressed:
                                                                              () async {
                                                                            Navigator.pop(context,
                                                                                false);

                                                                            if (_rejectController.text ==
                                                                                "") {
                                                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter reason.")));
                                                                            } else {
                                                                              var serial_no = emp.SERIAL_NO!.toInt();
                                                                              var reason_text = _rejectController.text;
                                                                              var flag_of_deny = true;
                                                                              await _rejectLeave(flag_of_deny, serial_no, reason_text);
                                                                            }
                                                                          },
                                                                          icon:
                                                                              Icon(
                                                                            Icons.check,
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      });
                                                } else {
                                                  if (emp.APPROVED == "Y") {
                                                    //already approved
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                            content: Text(
                                                                "You cannot deny approved leave. ")));
                                                    setState(() {
                                                      isApiLoading = false;
                                                    });
                                                  }
                                                  if (emp.APPROVED == "X") {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                            content: Text(
                                                                "Already Denied ")));
                                                  }
                                                }
                                              },
                                              child: Text("Yes")),
                                        ],
                                      ),
                                    );
                                  }
                                : null,
                            child: Text(
                              "Reject",
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
                                                setState(() {
                                                  isApiLoading = true;
                                                });
                                                if (emp.APPROVED != "N") {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          content: Text(
                                                              "You cannot delete approved/denied leave.")));
                                                  //  Navigator.pop(context, true);
                                                  //  return;
                                                } else {
                                                  var cpfNo =
                                                      emp.CPF_NO.toInt();
                                                  var serialNo =
                                                      emp.SERIAL_NO!.toInt();
                                                  _deleteLeve(cpfNo, serialNo);
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

  Future _getManagerDropDownList() async {
    setState(() {
      isApiLoading = true;
      NotificationCount = 0;
    });

    //isApiLoading = true;
    final String apiEndpoint =
        "$ServerUrl/api/TeamLeaveAPI/GETteamDet?cpfNo=$globalInt";

    Response? response =
        await myHttpClient.GetMethod(apiEndpoint, "Leaveapprovalpage", true);
    // Response response = await get(
    //   Uri.parse(
    //       "$ServerUrl/api/TeamLeaveAPI/GETteamDet?cpfNo=$globalInt"),

    //   // body: {"cpfNo": "42914"}
    //   headers: {
    //     "MobileURL": "Leaveapprovalpage",
    //     "CPF_NO": globalInt.toString(),
    //     "Authorization": "Bearer $JWT_Tokken"
    //   },
    // );

    try {
      var jsonBody = response!.body;

      // print(response.body);
      // print(jsonBody);

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
    } finally {
      setState(() {
        isApiLoading = false;
      });
    }
  }

  Future _getMonthDropDownList() async {
    setState(() {
      isApiLoading2 = true;
    });
    // isApiLoading = true;
    final String apiEndpoint =
        "$ServerUrl/api/TeamLeaveAPI/GetMonths?ouId=$ouId";

    Response? response =
        await myHttpClient.GetMethod(apiEndpoint, "Leaveapprovalpage", true);
    // Response response = await get(
    //   Uri.parse("$ServerUrl/api/TeamLeaveAPI/GetMonths?ouId=94"),
    //   headers: {
    //     "MobileURL": "Leaveapprovalpage",
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

    Response? response =
        await myHttpClient.GetMethod(apiEndpoint, "Leaveapprovalpage", true);
    // Response response = await get(
    //   Uri.parse(
    //       "$ServerUrl/api/TeamLeaveAPI/GETpeerDet?cpfNo=$cpfNo"),
    //   headers: {
    //     "MobileURL": "Leaveapprovalpage",
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
      setState(() => isAlertboxOpened = true); //
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

      Response? response =
          await myHttpClient.GetMethod(apiEndpoint, "Leaveapprovalpage", true);
      // Response response = await get(
      //   Uri.parse(
      //       "$ServerUrl/api/TeamLeaveAPI/GetApproveUnapprovedLeave?ouId=94&cpfNo=$managerCpfForPeerDropDown&peerCpfNo=$peercpf&month=$month&filterType=$filterType"),
      //   headers: {
      //     "MobileURL": "Leaveapprovalpage",
      //     "CPF_NO": globalInt.toString(),
      //     "Authorization": "Bearer $JWT_Tokken"
      //   },
      // );

      var jsonBody = response!.body;
    } catch (e) {
      print(e);
    }
  }
}
