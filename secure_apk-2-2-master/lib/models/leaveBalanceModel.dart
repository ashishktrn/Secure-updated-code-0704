// To parse this JSON data, do
//
//     final leaveBalanceModel = leaveBalanceModelFromJson(jsonString);

import 'dart:convert';

List<LeaveBalanceModel> leaveBalanceModelFromJson(String str) =>
    List<LeaveBalanceModel>.from(
        json.decode(str).map((x) => LeaveBalanceModel.fromJson(x)));

String leaveBalanceModelToJson(List<LeaveBalanceModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LeaveBalanceModel {
  LeaveBalanceModel({
    required this.leaveCode,
    required this.leaveName,
    required this.ltype,
    required this.leaveBalanceValue,
    required this.shortLeaveBalance,
    required this.leaveBalanceList,
  });

  String leaveCode;
  String leaveName;
  String ltype;
  double leaveBalanceValue;
  double shortLeaveBalance;
  List<dynamic> leaveBalanceList;

  factory LeaveBalanceModel.fromJson(Map<String, dynamic> json) =>
      LeaveBalanceModel(
        leaveCode: json["LeaveCode"] == null ? null : json["LeaveCode"],
        leaveName: json["LeaveName"],
        ltype: json["LTYPE"] == null ? null : json["LTYPE"],
        leaveBalanceValue: json["LeaveBalanceValue"],
        shortLeaveBalance: json["ShortLeaveBalance"],
        leaveBalanceList: json["LeaveBalanceList"],
      );

  Map<String, dynamic> toJson() => {
        "LeaveCode": leaveCode == null ? null : leaveCode,
        "LeaveName": leaveName,
        "LTYPE": ltype == null ? null : ltype,
        "LeaveBalanceValue": leaveBalanceValue,
        "ShortLeaveBalance": shortLeaveBalance,
        "LeaveBalanceList": leaveBalanceList == null
            ? null
            : List<dynamic>.from(leaveBalanceList.map((x) => x.toJson())),
      };
}
