import 'package:flutter/material.dart';

import 'package:secure_apk/leave__balaceUi.dart';
import 'package:secure_apk/models/leaveBalanceModel.dart';

import 'reuseablewidgets.dart/colors.dart';

class LeaveBalance extends StatefulWidget {
  const LeaveBalance({Key? key}) : super(key: key);

  @override
  State<LeaveBalance> createState() => _LeaveBalanceState();
}

class _LeaveBalanceState extends State<LeaveBalance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.white,
          elevation: 1,
          backgroundColor: Global_User_theme,
          title: Text(
            "Leave Balance",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [circularBird()],
        ),
        body: LeaveBalanceDataGrid());
  }

  List<LeaveBalanceModel> dataModel = [];
  late List productList;
  // getData() async {
  //   Response response;
  //   response = await post(
  //       Uri.parse("http://172.16.15.129:8073/api/LeaveAPI/GetLeaveBalance"),
  //       body: {
  //         "cpfNo": "42914",
  //         "ouID": "94",
  //       });
  //   try {
  //     var map = jsonDecode(response.body);

  //     List<dynamic> newData = map[0]["LeaveBalanceList"];
  //     print("newData: $newData");

  //     var decodeProduct = newData.cast<Map<String, dynamic>>();
  //     // print(decodeProduct);
  //     productList = await decodeProduct
  //         .map<LeaveBalanceModel>((json) => LeaveBalanceModel.fromJson(json))
  //         .toList();

  //   } catch (e) {
  //     print(e);
  //   }
  // }
}
