class ManagerApprovalModel {
  late double CPF_NO;
  late String? EMP_NAME;
  late String? LEAVE;
  late String? REASON;
  late String? FROM_DATE;
  late String? TO_DATE;
  late double? DAYS;
  late String? APPLIED_DATE;
  late double? SERIAL_NO;
  late String? APPROVED;
  late String? FROM_TIME;
  late String? TO_TIME;
  late String? TOT_HOURS;
  late String? ADJ_DATE;
  late String? DATE_OF_ENTRY;

  ManagerApprovalModel(
      {required this.CPF_NO,
      required this.EMP_NAME,
      required this.LEAVE,
      required this.REASON,
      required this.FROM_DATE,
      required this.TO_DATE,
      required this.DAYS,
      required this.APPLIED_DATE,
      required this.APPROVED,
      required this.SERIAL_NO,
      required this.FROM_TIME,
      required this.ADJ_DATE,
      required this.DATE_OF_ENTRY,
      required this.TOT_HOURS,
      required this.TO_TIME});

  factory ManagerApprovalModel.fromJson(Map<String, dynamic> json) {
    return ManagerApprovalModel(
        CPF_NO: json["CPF_NO"],
        EMP_NAME: json["EMP_NAME"],
        LEAVE: json["LEAVE"],
        REASON: json["REASON"],
        FROM_DATE: json["FROM_DATE"],
        TO_DATE: json["TO_DATE"],
        DAYS: json["DAYS"],
        APPLIED_DATE: json["APPLIED_DATE"],
        SERIAL_NO: json["SERIAL_NO"],
        APPROVED: json["APPROVED"],
        FROM_TIME: json["FROM_TIME"],
        ADJ_DATE: json["ADJ_DATE"],
        DATE_OF_ENTRY: json["DATE_OF_ENTRY"],
        TOT_HOURS: json["TOT_HOURS"],
        TO_TIME: json["TO_TIME"]);
  }
}
