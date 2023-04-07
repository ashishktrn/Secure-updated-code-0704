class AttendanceResponse {
  late String RET_MESSAGE;
  late int RET_VALUE;
  // late String CPF_NO;
  // late String ENTRY_DATE;
  // late String ENTRY_TIME;
  // late String IO_CODE;
  // late String IMAGE;
  // late String LONGITUDE;
  // late String LATITUDE;
  // late String ADDRESS;
  // late int MAF;

  AttendanceResponse({
    required this.RET_MESSAGE,
    required this.RET_VALUE,
    // required this.CPF_NO,
    // required this.ADDRESS,
    // required this.ENTRY_DATE,
    // required this.ENTRY_TIME,
    // required this.IMAGE,
    // required this.IO_CODE,
    // required this.LATITUDE,
    // required this.LONGITUDE,
    // required this.MAF
  });

  factory AttendanceResponse.fromJson(Map<String, dynamic> json) {
    return AttendanceResponse(
      RET_MESSAGE: json["RET_MESSAGE"],
      RET_VALUE: json["RET_VALUE"],
      // CPF_NO: json["CPF_NO"],
      // ADDRESS: json["ADDRESS"],
      // ENTRY_DATE: json["ENTRY_DATE"],
      // ENTRY_TIME: json["ENTRY_TIME"],
      // IMAGE: json["IMAGE"],
      // IO_CODE: json["IO_CODE"],
      // LATITUDE: json["LATITUDE"],
      // LONGITUDE: json["LONGITUDE"],
      // MAF: json["MAF"],
    );
  }

  tomap() => {
        "RET_MESSAGE": RET_MESSAGE,
        "RET_VALUE": RET_VALUE,
      };
}

class Settings {
  late final bool attendanceSuccess;
  late final bool attendanceSuccess2;
  Settings({required this.attendanceSuccess, required this.attendanceSuccess2});
}
