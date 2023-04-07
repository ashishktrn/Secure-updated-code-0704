import 'package:flutter/material.dart';

import 'package:secure_apk/data_grid_tables/reconciliationHistoryDataTable.dart';

import 'reuseablewidgets.dart/colors.dart';

class ReconciliationHistory extends StatefulWidget {
  const ReconciliationHistory({Key? key}) : super(key: key);

  @override
  State<ReconciliationHistory> createState() => _ReconciliationPendingState();
}

class _ReconciliationPendingState extends State<ReconciliationHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.white,
          elevation: 1,
          backgroundColor: Global_User_theme,
          title: Text(
            "Reconciliation history",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [circularBird()],
        ),
        body: ReconciliationHistoryDataGrid());
  }

  // getData() async {
  //   try {
  //     Response response = await post(
  //         Uri.parse(
  //             "http://172.16.15.129:8073/api/LeaveAPI/GetAdjustmentHistory"),
  //         body: {"cpfNo": "42914", "ouID": "94", "Flag": "Y"});
  //     print(response.body);
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}
