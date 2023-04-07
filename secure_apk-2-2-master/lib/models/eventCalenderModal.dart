import 'package:intl/intl.dart';

class EventCalenderModalForRH {
  late DateTime RH_DATE;
  String RH_NAME;

  EventCalenderModalForRH({
    required this.RH_DATE,
    required this.RH_NAME,
  });
  factory EventCalenderModalForRH.fromJson(Map<String, dynamic> json) {
    DateFormat format = DateFormat('dd-MMM-yyyy');
    return EventCalenderModalForRH(
        RH_DATE: format.parse(json['RH_DATE']), RH_NAME: json["RH_NAME"]);
  }
}

class EventCalenderModalForHolidayAndWeeklyOff {
  late DateTime DATES;
  String REASON;
  String REST_HOLIDAY;

  EventCalenderModalForHolidayAndWeeklyOff({
    required this.DATES,
    required this.REASON,
    required this.REST_HOLIDAY,
  });
  factory EventCalenderModalForHolidayAndWeeklyOff.fromJson(
      Map<String, dynamic> json) {
    DateFormat format = DateFormat('yyyy-MM-ddTHH:mm:ss');
    return EventCalenderModalForHolidayAndWeeklyOff(
      REASON: json["REASON"],
      REST_HOLIDAY: json["REST_HOLIDAY"],
      DATES: format.parse(json['DATES']),
    );
  }
}

class EventCalenderModalForPendingLeaves {
  String? REASON;
  String? LEAVE_NAME;
  String? LEAVE;
  double? NO_OF_DAYS;
  DateTime? FROM_DATE;
  DateTime? TO_DATE;
  EventCalenderModalForPendingLeaves(
      {required this.REASON,
      required this.LEAVE,
      required this.NO_OF_DAYS,
      required this.FROM_DATE,
      required this.TO_DATE,
      required this.LEAVE_NAME});
  factory EventCalenderModalForPendingLeaves.fromJson(
      Map<String, dynamic> json) {
    DateFormat format = DateFormat('yyyy-MM-ddTHH:mm:ss');
    return EventCalenderModalForPendingLeaves(
        REASON: json["REASON"],
        NO_OF_DAYS: json["NO_OF_DAYS"],
        FROM_DATE: format.parse(json['FROM_DATE']),
        TO_DATE: format.parse(json['TO_DATE']),
        LEAVE_NAME: json["LEAVE_NAME"],
        LEAVE: json["LEAVE"]);
  }
}
