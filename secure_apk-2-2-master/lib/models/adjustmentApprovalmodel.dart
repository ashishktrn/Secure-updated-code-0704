class AdjustmentApprovalModel {
  late int CPF_NO;
  late String EMP_NAME;

  late String REASON;

  late String APPROVED;
  late String FROM_TIME;
  late String TO_TIME;
  late String TOT_HOURS;
  late String ADJ_DATE;
  late String DATE_OF_ENTRY;
  late int SL_NO;

  AdjustmentApprovalModel(
      {required this.CPF_NO,
      required this.EMP_NAME,
      required this.REASON,
      required this.APPROVED,
      required this.FROM_TIME,
      required this.ADJ_DATE,
      required this.DATE_OF_ENTRY,
      required this.TOT_HOURS,
      required this.TO_TIME,
      required this.SL_NO});

  factory AdjustmentApprovalModel.fromJson(Map<String, dynamic> json) {
    return AdjustmentApprovalModel(
        CPF_NO: json["CPF_NO"],
        EMP_NAME: json["EMP_NAME"],
        REASON: json["REASON"],
        APPROVED: json["APPROVED"],
        FROM_TIME: json["FROM_TIME"],
        ADJ_DATE: json["ADJ_DATE"],
        DATE_OF_ENTRY: json["DATE_OF_ENTRY"],
        TOT_HOURS: json["TOT_HOURS"],
        TO_TIME: json["TO_TIME"],
        SL_NO: json["SL_NO"]);
  }
}
