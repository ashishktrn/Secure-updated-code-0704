import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'globals.dart';
import 'reuseablewidgets.dart/Common.dart';
import 'reuseablewidgets.dart/colors.dart';
import 'reuseablewidgets.dart/loder.dart';

class LeaveBalanceDataGrid extends StatefulWidget {
  const LeaveBalanceDataGrid({Key? key}) : super(key: key);

  @override
  State<LeaveBalanceDataGrid> createState() => _LeaveBalanceDataGridState();
}

class _LeaveBalanceDataGridState extends State<LeaveBalanceDataGrid> {
  @override
  late bool hasInternet;
  late MyHttpClient myHttpClient = new MyHttpClient(context);
  void initState() {
    // TODO: implement initState

    super.initState();
    Future.delayed(Duration.zero, () async {
      final connected = await InternetConnectionChecker().hasConnection;
      if (connected) {
        fetchdata();
      }
    });

    InternetConnectionChecker().onStatusChange.listen((event) {
      final hasInternet = event == InternetConnectionStatus.connected;
      if (!mounted) return;
      setState(() => this.hasInternet = hasInternet);
      if (!this.hasInternet) {
      } else {
        fetchdata();
      }
    });
  }

  // void design() {
  //   try {
  //     if (LeaveBlanceList.isNotEmpty) {
  //       for (var item in LeaveBlanceList) {
  //         newData = item["LeaveBalanceList"];
  //       }
  //     }
  //   } catch (e) {
  //     showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           backgroundColor: Colors.red,
  //           content: Text(
  //             'Error! $e',
  //             style: TextStyle(color: Colors.white),
  //           ),
  //         );
  //       },
  //     );
  //   }
  // }

  bool _isLoading = false;
  bool _showPaidLeave = false;
  bool _showearned_leave = false;
  bool _showmedical_leave = false;
  bool _showcalusal_leave = false;
  bool _showshort_leave = false;
  bool _showsick_leave = false;
  late List newData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                color: Global_User_theme,
                strokeWidth: 3,
              ))
            : SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()),
                child: Column(
                  children: [
                    _showPaidLeave
                        ? _showLeaveBalanceCard(
                            "Paid Leave",
                            LeaveBlanceList[0]["pl_bal"],
                            LeaveBlanceList[0]["pl_cnt"],
                            LeaveBlanceList[0]["pl_bal_tot"],
                          )
                        : SizedBox.shrink(),
                    _showcalusal_leave
                        ? _showLeaveBalanceCard(
                            "Casual leave",
                            LeaveBlanceList[0]["cl_bal"],
                            LeaveBlanceList[0]["cl_cnt"],
                            LeaveBlanceList[0]["cl_bal_tot"],
                          )
                        : SizedBox.shrink(),
                    _showearned_leave
                        ? _showLeaveBalanceCard(
                            "Earnd leave",
                            LeaveBlanceList[0]["el_bal"],
                            LeaveBlanceList[0]["el_cnt"],
                            LeaveBlanceList[0]["el_bal_tot"],
                          )
                        : SizedBox.shrink(),
                    _showmedical_leave
                        ? _showLeaveBalanceCard(
                            "Medical leave",
                            LeaveBlanceList[0]["ml_bal"],
                            LeaveBlanceList[0]["ml_cnt"],
                            LeaveBlanceList[0]["ml_bal_tot"],
                          )
                        : SizedBox.shrink(),
                    _showshort_leave
                        ? Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(9.0),
                                child: Card(
                                  shadowColor: Colors.grey,
                                  elevation: 8,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24)),
                                  // color: Colors.grey.shade200,
                                  child: Container(
                                    height: MediaQuery.of(context).size.height /
                                        5.3,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Colors.white38,
                                        width: 5.0,
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                      // borderRadius: BorderRadius.circular(40),
                                      gradient: LinearGradient(
                                          colors: [
                                            Colors.white,
                                            Colors.white,
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                            child: Icon(
                                          Icons.calendar_month,
                                          size: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              6.2,
                                          color: Global_User_theme,
                                        )),
                                        Center(
                                          child: SingleChildScrollView(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                FittedBox(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          top: 1, left: 0),
                                                      child: AutoSizeText(
                                                        "Short Leave",
                                                        style: TextStyle(
                                                            fontSize: 18.w,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black),
                                                        maxLines: 1,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "Count: ${LeaveBlanceList[0]['sl_cnt']}",
                                                  style: TextStyle(
                                                      fontSize: 15.w,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        : SizedBox.shrink(),
                    // _showsick_leave
                    //     ? _showLeaveBalanceCard(
                    //         "sick leave",
                    //         LeaveBlanceList[0]["skl_bal"],
                    //         LeaveBlanceList[0]["skl_cnt"],
                    //         LeaveBlanceList[0]["skl_bal_tot"])
                    //     : SizedBox.shrink(),
                  ],
                ),
              )

        //  SingleChildScrollView(
        //     physics: AlwaysScrollableScrollPhysics(
        //         parent: BouncingScrollPhysics()),
        //     child: Column(
        //       children: [
        //         Padding(
        //           padding: const EdgeInsets.all(12.0),
        //           child: Card(
        //             shadowColor: Colors.grey,
        //             elevation: 8,
        //             shape: RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.circular(24)),
        //             // color: Colors.grey.shade200,
        //             child: Container(
        //               height: MediaQuery.of(context).size.height / 3.3,
        //               decoration: BoxDecoration(
        //                 borderRadius: BorderRadius.circular(20),
        //                 gradient: LinearGradient(
        //                     colors: [
        //                       Global_User_theme,
        //                       Global_User_theme,
        //                     ],
        //                     begin: Alignment.topCenter,
        //                     end: Alignment.bottomCenter),
        //               ),
        //               child: Row(
        //                 children: [
        //                   Container(
        //                       child: Icon(
        //                     Icons.date_range,
        //                     size: MediaQuery.of(context).size.height / 5,
        //                     color: Colors.white,
        //                   )),
        //                   Center(
        //                     child: SingleChildScrollView(
        //                       child: Column(
        //                         crossAxisAlignment: CrossAxisAlignment.start,
        //                         children: [
        //                           FittedBox(
        //                             child: Padding(
        //                               padding: const EdgeInsets.all(0.0),
        //                               child: Container(
        //                                 margin:
        //                                     EdgeInsets.only(top: 1, left: 0),
        //                                 child: AutoSizeText(
        //                                   LeaveBlanceList[0]["pl_bal"],
        //                                   style: TextStyle(
        //                                       fontSize: 15.w,
        //                                       fontWeight: FontWeight.bold,
        //                                       color: Colors.white),
        //                                   maxLines: 1,
        //                                 ),
        //                               ),
        //                             ),
        //                           ),
        //                           SizedBox(
        //                             height: 20,
        //                           ),
        //                         ],
        //                       ),
        //                     ),
        //                   )
        //                 ],
        //               ),
        //             ),
        //           ),
        //         )
        //         // for (var item in LeaveBlanceList) ...[
        //         //   ...[

        //         //     Padding(
        //         //       padding: const EdgeInsets.all(12.0),
        //         //       child: Card(
        //         //         shadowColor: Colors.grey,
        //         //         elevation: 8,
        //         //         shape: RoundedRectangleBorder(
        //         //             borderRadius: BorderRadius.circular(24)),
        //         //         // color: Colors.grey.shade200,
        //         //         child: Container(
        //         //           height: MediaQuery.of(context).size.height / 3.3,
        //         //           decoration: BoxDecoration(
        //         //             borderRadius: BorderRadius.circular(20),
        //         //             gradient: LinearGradient(
        //         //                 colors: [
        //         //                   Global_User_theme,
        //         //                   Global_User_theme,
        //         //                 ],
        //         //                 begin: Alignment.topCenter,
        //         //                 end: Alignment.bottomCenter),
        //         //           ),
        //         //           child: Row(
        //         //             children: [
        //         //               Container(
        //         //                   // color: Colors.red,
        //         //                   child: Icon(
        //         //                 Icons.date_range,
        //         //                 size: MediaQuery.of(context).size.height / 5,
        //         //                 color: Colors.white,
        //         //               )),
        //         //               Center(
        //         //                 child: SingleChildScrollView(
        //         //                   child: Column(
        //         //                     crossAxisAlignment:
        //         //                         CrossAxisAlignment.start,
        //         //                     children: [
        //         //                       FittedBox(
        //         //                         child: Padding(
        //         //                           padding: const EdgeInsets.all(0.0),
        //         //                           child: Container(

        //         //                               //color: Colors.red,
        //         //                               margin: EdgeInsets.only(
        //         //                                   top: 1, left: 0),
        //         //                               child: Card(
        //         //                                 color: Global_User_theme,
        //         //                                 child: Align(
        //         //                                   alignment:
        //         //                                       Alignment.topCenter,
        //         //                                   child: Container(
        //         //                                     margin: EdgeInsets.all(5),
        //         //                                     child: AutoSizeText(
        //         //                                       item["LeaveName"],
        //         //                                       style: TextStyle(
        //         //                                           fontSize: 15.w,
        //         //                                           fontWeight:
        //         //                                               FontWeight.bold,
        //         //                                           color:
        //         //                                               Colors.white),
        //         //                                       maxLines: 1,
        //         //                                     ),
        //         //                                   ),
        //         //                                 ),
        //         //                               )),
        //         //                         ),
        //         //                       ),
        //         //                       SizedBox(
        //         //                         height: 20,
        //         //                       ),
        //         //                       for (var data
        //         //                           in item["LeaveBalanceList"]) ...[
        //         //                         Card(
        //         //                           color: Global_User_theme,
        //         //                           child: Container(
        //         //                             // decoration: BoxDecoration(
        //         //                             //     shape: BoxShape.rectangle,
        //         //                             //     border: Border.all()),
        //         //                             margin: EdgeInsets.only(left: 0),
        //         //                             child: Row(
        //         //                               children: [
        //         //                                 Container(
        //         //                                   margin: EdgeInsets.all(5),
        //         //                                   child: Text(
        //         //                                     data["LTYPE"] + " : ",
        //         //                                     style: TextStyle(
        //         //                                         fontSize: 10.w,
        //         //                                         fontWeight:
        //         //                                             FontWeight.w300,
        //         //                                         color: Color.fromARGB(
        //         //                                             255,
        //         //                                             255,
        //         //                                             255,
        //         //                                             255)),
        //         //                                   ),
        //         //                                 ),
        //         //                                 SizedBox(
        //         //                                   width: 20,
        //         //                                 ),
        //         //                                 data["LeaveBalanceValue"]
        //         //                                         .toString()
        //         //                                         .contains('.0')
        //         //                                     ? Container(
        //         //                                         margin:
        //         //                                             EdgeInsets.all(5),
        //         //                                         child: Text(
        //         //                                           double.parse(data[
        //         //                                                       "LeaveBalanceValue"]
        //         //                                                   .toString())
        //         //                                               .round()
        //         //                                               .toString(),
        //         //                                           style: TextStyle(
        //         //                                               fontSize: 16,
        //         //                                               fontWeight:
        //         //                                                   FontWeight
        //         //                                                       .w300,
        //         //                                               color: Color
        //         //                                                   .fromARGB(
        //         //                                                       255,
        //         //                                                       248,
        //         //                                                       244,
        //         //                                                       244)),
        //         //                                         ),
        //         //                                       )
        //         //                                     : Container(
        //         //                                         margin:
        //         //                                             EdgeInsets.all(5),
        //         //                                         child: Text(
        //         //                                           data["LeaveBalanceValue"]
        //         //                                               .toString(),
        //         //                                           style: TextStyle(
        //         //                                               fontSize: 16,
        //         //                                               fontWeight:
        //         //                                                   FontWeight
        //         //                                                       .w300,
        //         //                                               color: Color
        //         //                                                   .fromARGB(
        //         //                                                       255,
        //         //                                                       247,
        //         //                                                       245,
        //         //                                                       245)),
        //         //                                         ),
        //         //                                       )
        //         //                               ],
        //         //                             ),
        //         //                           ),
        //         //                         )
        //         //                       ],
        //         //                     ],
        //         //                   ),
        //         //                 ),
        //         //               )
        //         //             ],
        //         //           ),
        //         //         ),
        //         //       ),
        //         //     )

        //         //   ],

        //         // ]
        //       ],
        //     ),
        //   ),
        );
  }

  List LeaveBlanceList = [];
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

  Widget _showLeaveBalanceCard(String Leave_name, String leave_balance,
      String count, String leave_avalid) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(9.0),
          child: Card(
            shadowColor: Colors.grey,
            elevation: 8,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            // color: Colors.grey.shade200,
            child: Container(
              height: MediaQuery.of(context).size.height / 5.3,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.white,
                  width: 5.0,
                ),
                borderRadius: BorderRadius.circular(10.0),
                // borderRadius: BorderRadius.circular(40),
                gradient: LinearGradient(colors: [
                  Colors.white,
                  Colors.white,
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      child: Icon(
                    Icons.calendar_month,
                    size: MediaQuery.of(context).size.height / 6.3,
                    color: Global_User_theme,
                  )),
                  Center(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Container(
                                margin: EdgeInsets.only(top: 1, left: 0),
                                child: AutoSizeText(
                                  Leave_name,
                                  style: TextStyle(
                                      fontSize: 18.w,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Balance: $leave_balance",
                            style: TextStyle(
                                fontSize: 15.w,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Count: $count",
                            style: TextStyle(
                                fontSize: 15.w,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Leave Availed: $leave_avalid",
                            style: TextStyle(
                                fontSize: 15.w,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Future fetchdata() async {
    _openLoadingDialog(context);
    // setState(() {
    //   _isLoading = true;
    // });
    Map data = {
      "cpfNo": globalInt.toString(),
      "ouID": ouId.toString(),
    };

    String _apiendpoint = "$ServerUrl/api/LeaveAPI/GetLeaveBalance";
    Response? response = await myHttpClient.PostMethod(
        _apiendpoint, data, "Leave_Balance", true);
    // Response response;
    // response = await post(
    //     Uri.parse("$ServerUrl/api/LeaveAPI/GetLeaveBalance"),
    //     headers: {
    //       "MobileURL": "Leave_Balance",
    //       "CPF_NO": globalInt.toString(),
    //       "Authorization": "Bearer $JWT_Tokken"
    //     },
    //     body: {
    //       "cpfNo": globalInt.toString(),
    //       "ouID": ouId.toString(),
    //     });
    try {
      var decode = json.decode(response!.body);
      if (decode.isNotEmpty) {
        print(decode);

        setState(() {
          LeaveBlanceList = decode.toList();
        });

        print(LeaveBlanceList[0]["pl_bal"]);
        if (LeaveBlanceList[0]["pl_bal"] != "-99") {
          setState(() {
            _showPaidLeave = true;
          });
        }
        if (LeaveBlanceList[0]["el_bal"] != "-99") {
          print(LeaveBlanceList[0]["el_bal"]);
          setState(() {
            _showearned_leave = true;
          });
        }
        if (LeaveBlanceList[0]["ml_bal"] != "-99") {
          setState(() {
            _showmedical_leave = true;
          });
        }
        if (LeaveBlanceList[0]["cl_bal"] != "-99") {
          setState(() {
            _showcalusal_leave = true;
          });
        }
        if (LeaveBlanceList[0]["sl_bal"] != "-99") {
          setState(() {
            _showshort_leave = true;
          });
        }
        // if (LeaveBlanceList[0]["skl_bal"] != "-99") {
        //   setState(() {
        //     _showsick_leave = true;
        //   });
        // }
        Navigator.pop(context);
      } else {
        Navigator.pop(context);
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
      Navigator.pop(context);
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
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
