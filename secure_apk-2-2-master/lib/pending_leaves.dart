import 'package:flutter/material.dart';
import 'package:secure_apk/data_grid_tables/pendingLeavesDataTable.dart';

import 'reuseablewidgets.dart/colors.dart';

class PendingLeaves extends StatefulWidget {
  const PendingLeaves({Key? key}) : super(key: key);

  @override
  State<PendingLeaves> createState() => _PendingLeavesState();
}

class _PendingLeavesState extends State<PendingLeaves> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Color.fromRGBO(123, 34, 83, 1),
        appBar: AppBar(
          shadowColor: Colors.white,
          elevation: 1,
          backgroundColor: Global_User_theme,
          title: Text(
            "Pending leaves",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [circularBird()],
        ),
        body: Pending_Leave_DataGrid());
  }
}
