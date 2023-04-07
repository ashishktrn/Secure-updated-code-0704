import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class AttendanceInformationModel {
  int CPF_NO;
  int MAF;
  late String DATE_OF_ENTRY;
  late String ENTRY_TIME;
  late String IO_CODE;
  late String LONGITUDE;
  late String LATITUDE;
  late String ADDRESS;
  double? DISTANCE_FROM_OFFICE;
  int ROW_ID;
  late String IMAGE;
  String EMP_NAME;

  late int CREATED_BY;
  late String CREATED_DATE;
  AttendanceInformationModel(
      {required this.CPF_NO,
      required this.DISTANCE_FROM_OFFICE,
      required this.IMAGE,
      required this.DATE_OF_ENTRY,
      required this.ENTRY_TIME,
      required this.IO_CODE,
      required this.LONGITUDE,
      required this.LATITUDE,
      required this.ADDRESS,
      required this.MAF,
      required this.CREATED_BY,
      required this.CREATED_DATE,
      required this.ROW_ID,
      required this.EMP_NAME});

  factory AttendanceInformationModel.fromJson(Map<String, dynamic> json) {
    return AttendanceInformationModel(
        IMAGE: json["IMAGE"],
        DISTANCE_FROM_OFFICE: json["DISTANCE_FROM_OFFICE"],
        CPF_NO: json["CPF_NO"],
        DATE_OF_ENTRY: json["DATE_OF_ENTRY"],
        ENTRY_TIME: json["ENTRY_TIME"],
        IO_CODE: json["IO_CODE"],
        LONGITUDE: json["LONGITUDE"],
        LATITUDE: json["LATITUDE"],
        ADDRESS: json["ADDRESS"],
        MAF: json["MAF"],
        CREATED_BY: json["CREATED_BY"],
        CREATED_DATE: json["CREATED_DATE"],
        ROW_ID: json["ROW_ID"],
        EMP_NAME: json["EMP_NAME"]);
  }

  tomap() => {
        "CPF_NO": CPF_NO,
        "DATE_OF_ENTRY": DATE_OF_ENTRY,
        "ENTRY_TIME": ENTRY_TIME,
        "IO_CODE": IO_CODE,
        "LONGITUDE": LONGITUDE,
        "LATITUDE": LATITUDE,
        "ADDRESS": ADDRESS,
        "MAF": MAF,
        "CREATED_BY": CREATED_BY,
        "CREATED_DATE": CREATED_DATE,
        "ROW_ID": ROW_ID
      };
}
