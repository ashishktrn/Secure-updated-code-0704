import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class PendingLeaveModel {
  double? SERIAL_NO;
  String? FROM_TIME;
  String? TO_TIME;
  late String? REASON;
  String? FROM_DATE;
  String? TO_DATE;
  late String? TYPE_OF_LEAVE;
  double? NO_OF_DAYS;
  String? LEAVE;
  String? DATE_APPLIED;
  String? LEAVE_NAME;
  String? APPROVED;
  String? FROM_1HALF_FLAG;
  String? FROM_2HALF_FLAG;
  String? TO_1HALF_FLAG;
  String? TO_2HALF_FLAG;
  double? LEAVE_ID;

  PendingLeaveModel(
      {required this.SERIAL_NO,
      required this.TO_TIME,
      required this.REASON,
      required this.FROM_DATE,
      required this.TO_DATE,
      required this.TYPE_OF_LEAVE,
      required this.NO_OF_DAYS,
      required this.FROM_TIME,
      required this.LEAVE,
      required this.DATE_APPLIED,
      required this.APPROVED,
      required this.LEAVE_NAME,
      required this.FROM_1HALF_FLAG,
      required this.FROM_2HALF_FLAG,
      required this.TO_1HALF_FLAG,
      required this.TO_2HALF_FLAG,
      required this.LEAVE_ID});

  factory PendingLeaveModel.fromJson(Map<String, dynamic> json) {
    return PendingLeaveModel(
        LEAVE_ID: json["LEAVE_ID"],
        SERIAL_NO: json["SERIAL_NO"],
        TO_TIME: json["TO_TIME"],
        REASON: json["REASON"],
        FROM_DATE: json["FROM_DATE"],
        TO_DATE: json["TO_DATE"],
        TYPE_OF_LEAVE: json["TYPE_OF_LEAVE"],
        NO_OF_DAYS: json["NO_OF_DAYS"],
        FROM_TIME: json["FROM_TIME"],
        LEAVE: json["LEAVE"],
        DATE_APPLIED: json["DATE_APPLIED"],
        LEAVE_NAME: json["LEAVE_NAME"],
        APPROVED: json["APPROVED"],
        FROM_1HALF_FLAG: json["FROM_1HALF_FLAG"],
        FROM_2HALF_FLAG: json["FROM_2HALF_FLAG"],
        TO_1HALF_FLAG: json["TO_1HALF_FLAG"],
        TO_2HALF_FLAG: json["TO_2HALF_FLAG"]);
  }

  tomap() => {
        "SERIAL_NO": SERIAL_NO,
        "TO_TIME": TO_TIME,
        "REASON": REASON,
        "FROM_DATE": FROM_DATE,
        "TYPE_OF_LEAVE": TYPE_OF_LEAVE,
        "TO_DATE": TO_DATE,
        "NO_OF_DAYS": NO_OF_DAYS,
        "FROM_TIME": FROM_TIME,
        "LEAVE": LEAVE,
        "DATE_APPLIED": DATE_APPLIED,
        "APPROVED": APPROVED,
        "LEAVE_NAME": LEAVE_NAME
      };
}
