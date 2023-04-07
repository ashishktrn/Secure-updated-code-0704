import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class PipoEntryDetails {
  String SHIFT_CD;
  String IN_OUT;
  late String DATETIME;

  PipoEntryDetails({
    required this.SHIFT_CD,
    required this.IN_OUT,
    required this.DATETIME,
  });

  factory PipoEntryDetails.fromJson(Map<String, dynamic> json) {
    return PipoEntryDetails(
      SHIFT_CD: json["SHIFT_CD"],
      IN_OUT: json["IN_OUT"],
      DATETIME: json["DATETIME"],
    );
  }
}
