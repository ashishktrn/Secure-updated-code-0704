import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:secure_apk/reuseablewidgets.dart/sessionexpire.dart';
import 'globals.dart';
import 'models/attenanceResponse_Model.dart';
import 'models/attendanceinformation_model.dart';
import 'reuseablewidgets.dart/Common.dart';
import 'reuseablewidgets.dart/colors.dart';
import 'reuseablewidgets.dart/loder.dart';

class Attendance_Approval extends StatefulWidget {
  const Attendance_Approval({Key? key}) : super(key: key);

  @override
  State<Attendance_Approval> createState() => _Attendance_ApprovalState();
}

bool _isApiLoading = false;
int _value = 2;
var emptyList = [];
late AttendanceResponse attendanceResponse;
late List<AttendanceInformationModel> productList;
late List<AttendanceInformationModel> emplist;

// Future<List<AttendanceInformationModel>> fetchResults() async {
//   List<AttendanceInformationModel> users = [];

//   DateTime now = new DateTime.now();

//   String formattedDate = DateFormat('yyyy-MM-dd').format(now);

//   print(formattedDate);

//   Response response = await get(
//     //   Uri.parse(
//     //       "http://172.16.15.129:8026/api/MarkAttendance/GetUserInfo?CPF_NO=$globalInt&ENTRY_DATE=1-JUN-22&flag=1&radioFlag=$_value"),
//     // );
//     Uri.parse(
//         "$ServerUrl/api/MobileAPI/GetUserInfo?CPF_NO=$globalInt&ENTRY_DATE=1-JUN-22&flag=1&radioFlag=$_value"),
//     headers: {
//       "MobileURL": "hoursReconciliation",
//       "CPF_NO": globalInt.toString(),
//       "Authorization": "Bearer $JWT_Tokken"
//     },
//   );
//   if (response.statusCode == 401) {
//     var isunauth = response.reasonPhrase;
//     if (isunauth == "Unauthorized") {
// // logic for login the user out
//       sessionexpired.LogoutUser();
//     }
//   }

//   try {
//     var decode = json.decode(response.body);

//     //  var data = decode['Table'];
//     var decodeProduct = json.decode(response.body).cast<Map<String, dynamic>>();
//     productList = await decodeProduct
//         .map<AttendanceInformationModel>(
//             (json) => AttendanceInformationModel.fromJson(json))
//         .toList();
//     //print(productList);
//   } catch (e) {
//     print(e);
//   }
//   return productList;
// }

class _Attendance_ApprovalState extends State<Attendance_Approval> {
  late MyHttpClient myHttpClient = new MyHttpClient(context);
  late sessionExpired sessionexpired = new sessionExpired(context);
  List? PeerDropDownList;
  late String PeerDropDownListID;
  bool isPeerNotSelectedBool = true;
  var peerCpf;

  Future _getPEERDropDownList(cpfNo) async {
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
      } else {
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
    } catch (e) {
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
    } finally {}
  }

  Future<List<AttendanceInformationModel>> fetchResults() async {
    List<AttendanceInformationModel> users = [];

    DateTime now = new DateTime.now();

    String formattedDate = DateFormat('yyyy-MM-dd').format(now);

    print(formattedDate);
    var peercpf = peerCpf == null ? globalInt : peerCpf;
    final String apiEndpoint =
        "$ServerUrl/api/MobileAPI/GetUserInfo?CPF_NO=$globalInt&ENTRY_DATE=1-JUN-22&flag=1&radioFlag=$_value&PeerCpf=$peercpf";

    Response? response =
        await myHttpClient.GetMethod(apiEndpoint, "hoursReconciliation", true);

    try {
      var decode = json.decode(response!.body);

      //  var data = decode['Table'];
      var decodeProduct =
          json.decode(response.body).cast<Map<String, dynamic>>();
      productList = await decodeProduct
          .map<AttendanceInformationModel>(
              (json) => AttendanceInformationModel.fromJson(json))
          .toList();
      //print(productList);
    } catch (e) {
      print(e);
    }
    return productList;
  }

  @override
  late bool hasInternet;

  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {
      final connected = await InternetConnectionChecker().hasConnection;
      if (connected) {
        _value = 2;
        fetchResults();
        _getPEERDropDownList(globalInt);
      }
    });
    InternetConnectionChecker().onStatusChange.listen((event) {
      final hasInternet = event == InternetConnectionStatus.connected;
      if (!mounted) return;
      setState(() => this.hasInternet = hasInternet);
      if (!this.hasInternet) {
      } else {
        _value = 2;
        _getPEERDropDownList(globalInt);
        fetchResults();
      }
    });
  }

  Future rebuild() async {
    fetchResults();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(8.w),
      child: Form(child: tabBarItems()),
    ));
  }

  Widget tabBarItems() {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: AttendanceTable(),
    );
  }

  Widget AttendanceTable() {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      child: Column(
        children: [
          SizedBox(
            height: 50,
            width: double.infinity,
            child: Container(
              margin: EdgeInsets.only(left: 6.w, right: 6.w),
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                color: Colors.grey.shade300,
              ),
              //   width: MediaQuery.of(context).size.width, //commented for keybord issue
              child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                  alignedDropdown: false,
                  child: isPeerNotSelectedBool
                      ? DropdownButton<String>(
                          menuMaxHeight: MediaQuery.of(context).size.height / 2,
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
                              PeerDropDownListID = newValue.toString();
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
                          menuMaxHeight: MediaQuery.of(context).size.height / 2,
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
                              PeerDropDownListID = newValue.toString();
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
            height: 10,
          ),
          Container(
            color: Colors.grey.shade300,
            child: Padding(
              padding: EdgeInsets.only(left: 30.w, top: 20.h),
              child: Row(
                children: [
                  Radio(
                    activeColor: Global_User_theme,
                    value: 1,
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
                  Text("All"),
                  SizedBox(
                    width: 5,
                  ),
                  Radio(
                    activeColor: Global_User_theme,
                    value: 2,
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
                    value: 3,
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
                  Text("Approved"),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            //   height: MediaQuery.of(context).size.height / 1,
            child: FutureBuilder<List<AttendanceInformationModel>>(
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
                }

                return SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics()),
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: DataTable(
                      columnSpacing: 8,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(5)),
                      //  sortAscending: true,
                      columns: const [
                        DataColumn(label: Text('Image')),
                        DataColumn(label: Text('Status')),
                        DataColumn(label: Text('ACTION')),
                        DataColumn(label: Text('Cpf No')),
                        DataColumn(label: Text('IO')),
                        DataColumn(label: Text('Date of entry')),
                        DataColumn(label: Text('Entry time')),
                        DataColumn(label: Text('Address')),
                      ],
                      rows: List.generate(
                        snapshot.data!.length,
                        (index) {
                          var emp = snapshot.data![index];
                          return DataRow(cells: [
                            DataCell(
                                // CircleAvatar(
                                //   backgroundColor: Colors.white,
                                //   backgroundImage:
                                //       MemoryImage(base64Decode(emp.IMAGE)),
                                //   //radius: 45.r,
                                // ),
                                TextButton(
                              style: TextButton.styleFrom(
                                  primary: Global_User_theme),
                              onPressed: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ShowPhotoFullScreen(emp.IMAGE))),
                              //  CircleAvatar(
                              //   backgroundColor: Colors.white,
                              //   backgroundImage:
                              //       MemoryImage(base64Decode(emp.IMAGE)),
                              //   //radius: 45.r,
                              // ),
                              child: Text("View Image"),
                            )),
                            DataCell(
                              emp.MAF == 0
                                  ? Text("Unapproved")
                                  : Text("Approved"),
                              onTap: () => showCardAttendance(emp),
                            ),
                            DataCell(
                              Container(
                                  height: 25,
                                  width: 60,
                                  child: emp.MAF == 0
                                      ? ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: Global_User_theme),
                                          onPressed: () {
                                            _isApiLoading
                                                ? Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: Color.fromRGBO(
                                                          123, 34, 83, 1),
                                                      strokeWidth: 2,
                                                      backgroundColor:
                                                          Colors.green.shade50,
                                                    ),
                                                  )
                                                : showDialog(
                                                    context: context,
                                                    builder: (dialogcontext) =>
                                                        new AlertDialog(
                                                      title:
                                                          Text("Are You  Sure"),
                                                      content: Text(
                                                          "Do you want to Approve ?"),
                                                      actions: [
                                                        TextButton(
                                                            onPressed:
                                                                () async {
                                                              Navigator.pop(
                                                                  context,
                                                                  false);
                                                              print(emp.ROW_ID);

                                                              try {
                                                                // setState(() {
                                                                //   _isApiLoading =
                                                                //       true;
                                                                // });
                                                                _openLoadingDialog(
                                                                    context);
                                                                final String
                                                                    apiEndpoint =
                                                                    "$ServerUrl/api/MobileAPI/approveAttendance?ROW_ID=${emp.ROW_ID}";

                                                                Response?
                                                                    response =
                                                                    await myHttpClient.GetMethod(
                                                                        apiEndpoint,
                                                                        "hoursReconciliation",
                                                                        true);

                                                                // Response
                                                                //     response =
                                                                //     await get(
                                                                //   //   Uri.parse(
                                                                //   //       "http://172.16.15.129:8026/api/MarkAttendance/approveAttendance?ROW_ID=${emp.ROW_ID}"),
                                                                //   // );
                                                                //   Uri.parse(
                                                                //       "$ServerUrl/api/MobileAPI/approveAttendance?ROW_ID=${emp.ROW_ID}"),
                                                                //   headers: {
                                                                //     "MobileURL":
                                                                //         "hoursReconciliation",
                                                                //     "CPF_NO":
                                                                //         globalInt
                                                                //             .toString(),
                                                                //     "Authorization":
                                                                //         "Bearer $JWT_Tokken"
                                                                //   },
                                                                // );

                                                                final decodedData =
                                                                    jsonDecode(
                                                                        response!
                                                                            .body);
                                                                if (response
                                                                        .statusCode ==
                                                                    200) {
                                                                  List<AttendanceResponse>
                                                                      list =
                                                                      List.from(
                                                                              decodedData)
                                                                          .map<
                                                                              AttendanceResponse>(
                                                                            (item) =>
                                                                                AttendanceResponse.fromJson(item),
                                                                          )
                                                                          .toList();
                                                                  attendanceResponse =
                                                                      list.first;
                                                                  if (attendanceResponse
                                                                          .RET_VALUE ==
                                                                      1) {
                                                                    // Navigator.pop(
                                                                    //     context,
                                                                    //     false);
                                                                    // SweetAlert.show(
                                                                    //     context,
                                                                    //     title: attendanceResponse
                                                                    //         .RET_MESSAGE,
                                                                    //     subtitle:
                                                                    //         "Thank you",
                                                                    //     style: SweetAlertStyle
                                                                    //         .success);
                                                                    Navigator.pop(
                                                                        context);
                                                                    showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return AlertDialog(
                                                                          backgroundColor:
                                                                              Colors.green,
                                                                          content:
                                                                              Text(
                                                                            'Attendance approved successfully ✓',
                                                                            style:
                                                                                TextStyle(color: Colors.white),
                                                                          ),
                                                                        );
                                                                      },
                                                                    );
                                                                  }
                                                                }

                                                                // setState(() {
                                                                //   _isApiLoading =
                                                                //       false;
                                                                // });
                                                                // Navigator.pop(
                                                                //     context, false);
                                                                rebuild();
                                                              } catch (e) {
                                                                Navigator.pop(
                                                                    context);
                                                                print(e);
                                                              }
                                                            },
                                                            child: Text("Yes")),
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context,
                                                                  false);
                                                            },
                                                            child: Text("No")),
                                                      ],
                                                    ),
                                                  );
                                          },
                                          child:
                                              FittedBox(child: Text("Approve")))
                                      : Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Icon(Icons.check),
                                        )),
                              onTap: () => showCardAttendance(emp),
                            ),
                            DataCell(
                              Text(emp.CPF_NO.toString()),
                              onTap: () => showCardAttendance(emp),
                            ),
                            DataCell(
                              Text(emp.IO_CODE.toString()),
                              onTap: () => showCardAttendance(emp),
                            ),
                            DataCell(
                              Text(
                                DateFormat('dd-MMM-yyyy')
                                    .format(DateTime.parse(emp.DATE_OF_ENTRY)),
                              ),
                              onTap: () => showCardAttendance(emp),
                            ),
                            DataCell(
                              Text(DateFormat('hh:mm:a')
                                  .format(DateTime.parse(emp.ENTRY_TIME))),
                              onTap: () => showCardAttendance(emp),
                            ),
                            DataCell(
                              Text(emp.ADDRESS.toString()),
                              onTap: () => showCardAttendance(emp),
                            ),
                          ]);
                        },
                      ).toList(),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
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

  showCardAttendance(AttendanceInformationModel emp) {
    showDialog(
        context: context,
        builder: (dialogecontext) => Center(
              child: Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 5,
                margin: EdgeInsets.all(10),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics()),
                  child: Container(
                    // height: MediaQuery.of(context).size.height / 2,
                    color: Colors.grey.shade200,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(emp.MAF == 0 ? "Unapproved" : "Approve",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Image(
                                fit: BoxFit.contain,
                                image: MemoryImage(base64Decode(emp.IMAGE)),
                                height: 200,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,

                                    // mainAxisAlignment:
                                    //     MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Employee Name:  ",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      Text(
                                        emp.EMP_NAME.toString(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    // mainAxisAlignment:
                                    //     MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "In/Out:  ",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      Text(
                                        emp.IO_CODE == "I" ? "In" : "Out",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
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
                                        "Date of entry:  ",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      Text(
                                        DateFormat('dd-MMM-yyyy').format(
                                            DateTime.parse(emp.DATE_OF_ENTRY)),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
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
                                        "Entry time:  ",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      Text(
                                        DateFormat('hh:mm:a').format(
                                            DateTime.parse(emp.ENTRY_TIME)),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
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
                                      FittedBox(
                                        child: Text(
                                          "Address: ",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      Text(
                                        emp.ADDRESS,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
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
                                      FittedBox(
                                        child: Text(
                                          "Distance from office: ",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      Text(
                                        emp.DISTANCE_FROM_OFFICE == null
                                            ? 0.toString()
                                            : emp.DISTANCE_FROM_OFFICE
                                                .toString(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Global_User_theme),
                                  onPressed: emp.MAF == 1
                                      ? null
                                      : () {
                                          showDialog(
                                            context: context,
                                            builder: (dialogcontext) =>
                                                new AlertDialog(
                                              title: Text("Are you  sure"),
                                              content: Text(
                                                  "Do you want to Approve ?"),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context, false);
                                                    },
                                                    child: Text("No")),
                                                TextButton(
                                                    onPressed: () async {
                                                      Navigator.pop(
                                                          context, false);
                                                      Navigator.pop(
                                                          context, false);

                                                      try {
                                                        _openLoadingDialog(
                                                            context);
                                                        // setState(() {
                                                        //   _isApiLoading = true;
                                                        // });
                                                        final String
                                                            apiEndpoint =
                                                            "$ServerUrl/api/MobileAPI/approveAttendance?ROW_ID=${emp.ROW_ID}";

                                                        Response? response =
                                                            await myHttpClient
                                                                .GetMethod(
                                                                    apiEndpoint,
                                                                    "hoursReconciliation",
                                                                    true);

                                                        // Response response =
                                                        //     await get(
                                                        //   Uri.parse(
                                                        //       "$ServerUrl/api/MobileAPI/approveAttendance?ROW_ID=${emp.ROW_ID}"),
                                                        //   headers: {
                                                        //     "MobileURL":
                                                        //         "hoursReconciliation",
                                                        //     "CPF_NO": globalInt
                                                        //         .toString(),
                                                        //     "Authorization":
                                                        //         "Bearer $JWT_Tokken"
                                                        //   },
                                                        // );

                                                        final decodedData =
                                                            jsonDecode(
                                                                response!.body);

                                                        if (response
                                                                .statusCode ==
                                                            200) {
                                                          List<AttendanceResponse>
                                                              list = List.from(
                                                                      decodedData)
                                                                  .map<
                                                                      AttendanceResponse>(
                                                                    (item) => AttendanceResponse
                                                                        .fromJson(
                                                                            item),
                                                                  )
                                                                  .toList();
                                                          attendanceResponse =
                                                              list.first;
                                                          Navigator.pop(
                                                              context);
                                                          if (attendanceResponse
                                                                  .RET_VALUE ==
                                                              1) {
                                                            // Navigator.pop(
                                                            //     context,
                                                            //     false);
                                                            // SweetAlert.show(
                                                            //     context,
                                                            //     title: attendanceResponse
                                                            //         .RET_MESSAGE,
                                                            //     subtitle:
                                                            //         "Thank you",
                                                            //     style: SweetAlertStyle
                                                            //         .success);
                                                            showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return AlertDialog(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .green,
                                                                  content: Text(
                                                                    'Attendance approved successfully ✓',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                );
                                                              },
                                                            );
                                                          }
                                                        }
                                                        // setState(() {
                                                        //   _isApiLoading = false;
                                                        // });
                                                        // Navigator.pop(
                                                        //     context, false);
                                                        rebuild();
                                                      } catch (e) {
                                                        Navigator.pop(context);
                                                        print(e);
                                                      }
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
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}

class ShowPhotoFullScreen extends StatelessWidget {
  late String imageUrl;
  ShowPhotoFullScreen(this.imageUrl);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Global_User_theme,
        actions: [circularBird()],
      ),
      body: Hero(
        tag: "a",
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Image(
            fit: BoxFit.contain,
            image: MemoryImage(base64Decode(imageUrl)),
            height: 200,
          ),
        ),
      ),
    );
  }
}
