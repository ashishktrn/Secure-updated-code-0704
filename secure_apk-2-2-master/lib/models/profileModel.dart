import 'package:json_annotation/json_annotation.dart';

part 'profileModel.g.dart';

@JsonSerializable()
class ProfileModel {
  String emp_name;
  late int CPF_NO;
  late String role_title;
  late String designation_name;
  late String securelevel;
  late String organization_name;
  late String ou_name;
  late String location_code;
  late String cpf_image;
  late String email;
  late String emp_name_cpf_no;
  late String date_of_joining;
  late String ou_id;
  late int location_id;
  ProfileModel(
      {required this.emp_name,
      required this.CPF_NO,
      required this.designation_name,
      required this.securelevel,
      required this.ou_name,
      required this.organization_name,
      required this.location_code,
      required this.role_title,
      required this.cpf_image,
      required this.email,
      required this.emp_name_cpf_no,
      required this.date_of_joining,
      required this.ou_id,
      required this.location_id});

  // factory ProfileModel.fromJson(Map<String, dynamic> json) =>
  //     _$ProfileModelFromJson(json);
  // Map<String, dynamic> toJson() => _$ProfileModelToJson(this);

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
        location_id: json["location_id"],
        emp_name: json["emp_name"],
        CPF_NO: json["CPF_NO"],
        designation_name: json["designation_name"],
        securelevel: json["securelevel"],
        ou_name: json["ou_name"],
        organization_name: json["organization_name"],
        location_code: json["location_code"],
        role_title: json["role_title"],
        cpf_image: json["cpf_image"],
        email: json["email"],
        emp_name_cpf_no: json["emp_name_cpf_no"],
        date_of_joining: json["date_of_joining"],
        ou_id: json["ou_id"]);
  }

  tomap() => {
        "EMP_NAME": emp_name,
        "CPF_NO": CPF_NO,
        "designation_name": designation_name,
        "securelevel": securelevel,
        "ou_name": ou_name,
        "organization_name": organization_name,
        "location_code": location_code,
        "role_title": role_title,
        "cpf_image": cpf_image,
        "email": email,
        "emp_name_cpf_no": emp_name_cpf_no
      };

  // ProfileModel.fromJson(Map<String, dynamic> json)
  //     : name = json['name'],
  //       empno = json["empno"],
  //       designation = json["designation"],
  //       level = json["level"],
  //       operating = json["operating"],
  //       organisation = json["organisation"];
}
