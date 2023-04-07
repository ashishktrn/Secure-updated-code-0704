import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class PendingReconciliationModel {
  String ADJUSTMENT;
  String DATE_OF_ENTRY;
  late String REASON;
  String FROM_TIME;
  String TO_TIME;
  int SL_NO;
  int ADJUSTMENTTYPE;

  late String TOT_HOURS;
  String APPROVED;

  PendingReconciliationModel(
      {required this.ADJUSTMENT,
      required this.SL_NO,
      required this.TO_TIME,
      required this.REASON,
      required this.DATE_OF_ENTRY,
      required this.TOT_HOURS,
      required this.FROM_TIME,
      required this.APPROVED,
      required this.ADJUSTMENTTYPE});

  factory PendingReconciliationModel.fromJson(Map<String, dynamic> json) {
    return PendingReconciliationModel(
        ADJUSTMENTTYPE: json["ADJUSTMENTTYPE"],
        SL_NO: json["SL_NO"],
        ADJUSTMENT: json["ADJUSTMENT"],
        TO_TIME: json["TO_TIME"],
        REASON: json["REASON"],
        DATE_OF_ENTRY: json["DATE_OF_ENTRY"],
        TOT_HOURS: json["TOT_HOURS"],
        FROM_TIME: json["FROM_TIME"],
        APPROVED: json["APPROVED"]);
  }

  // tomap() => {
  //       "SERIAL_NO": SERIAL_NO,
  //       "TO_TIME": TO_TIME,
  //       "REASON": REASON,
  //       "FROM_DATE": FROM_DATE,
  //       "TYPE_OF_LEAVE": TYPE_OF_LEAVE,
  //       "TO_DATE": TO_DATE,
  //       "NO_OF_DAYS": NO_OF_DAYS,
  //       "FROM_TIME": FROM_TIME,
  //       "LEAVE": LEAVE,
  //       "DATE_APPLIED": DATE_APPLIED,
  //       "APPROVED": APPROVED,
  //       "LEAVE_NAME": LEAVE_NAME
  //     };
}
