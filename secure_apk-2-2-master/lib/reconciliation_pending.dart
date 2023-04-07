import 'package:flutter/material.dart';

import 'package:secure_apk/data_grid_tables/reconciliationPendingDataTable.dart';

import 'reuseablewidgets.dart/colors.dart';

class ReconciliationPending extends StatefulWidget {
  const ReconciliationPending({Key? key}) : super(key: key);

  @override
  State<ReconciliationPending> createState() => _ReconciliationPendingState();
}

class _ReconciliationPendingState extends State<ReconciliationPending> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.white,
          elevation: 1,
          backgroundColor: Global_User_theme,
          title: Text(
            "Pending reconciliation",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [circularBird()],
        ),
        body: ReconciliationPendingDataGrid());
  }

  // getData() async {
  //   try {
  //     Response response = await post(
  //         Uri.parse(
  //             "http://172.16.15.129:8073/api/LeaveAPI/GetAdjustmentHistory"),
  //         body: {"cpfNo": "42914", "ouID": "94", "Flag": "N"});
  //     print(response.body);
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}
