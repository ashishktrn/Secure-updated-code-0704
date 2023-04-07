import 'package:flutter/material.dart';

import 'package:secure_apk/data_grid_tables/leave_historyDataTable.dart';

import 'reuseablewidgets.dart/colors.dart';

class LeaveHistory extends StatefulWidget {
  const LeaveHistory({Key? key}) : super(key: key);

  @override
  State<LeaveHistory> createState() => _LeaveHistoryState();
}

class _LeaveHistoryState extends State<LeaveHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.white,
          elevation: 1,
          backgroundColor: Global_User_theme,
          title: Text(
            "Leave History",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [circularBird()],
        ),
        body: LeaveHistoryDataGrid());
  }
}
