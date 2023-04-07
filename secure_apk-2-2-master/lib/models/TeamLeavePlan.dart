import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class TeamLeavePlan {
  double CPF_NO;
  String EMP_NAME;
  late String LEAVE_TYPE;
  String FROM_DATE;
  String TO_DATE;
  double NO_OF_DAYS;
  String STATUS;

  TeamLeavePlan({
    required this.CPF_NO,
    required this.EMP_NAME,
    required this.LEAVE_TYPE,
    required this.FROM_DATE,
    required this.TO_DATE,
    required this.NO_OF_DAYS,
    required this.STATUS,
  });

  factory TeamLeavePlan.fromJson(Map<String, dynamic> json) {
    return TeamLeavePlan(
      CPF_NO: json["CPF_NO"],
      EMP_NAME: json["EMP_NAME"],
      LEAVE_TYPE: json["LEAVE_TYPE"],
      FROM_DATE: json["FROM_DATE"],
      TO_DATE: json["TO_DATE"],
      NO_OF_DAYS: json["NO_OF_DAYS"],
      STATUS: json["STATUS"],
    );
  }
}
