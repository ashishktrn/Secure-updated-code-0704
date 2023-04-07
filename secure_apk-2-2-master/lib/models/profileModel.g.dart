part of 'profileModel.dart';

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) {
  return ProfileModel(
      location_id: json["location_id"],
      ou_id: json["ou_id"],
      date_of_joining: json["date_of_joining"],
      emp_name: json['emp_name'],
      CPF_NO: json['CPF_NO'],
      designation_name: json['designation_name'] as String,
      securelevel: json['securelevel'],
      organization_name: json['organization_name'] as String,
      ou_name: json['ou_name'] as String,
      location_code: json["location_code"],
      role_title: json["role_title"],
      cpf_image: json["cpf_image"],
      email: json["email"],
      emp_name_cpf_no: json["emp_name_cpf_no"]);
}

//  empno: json['empno'] as String,
//     about: json['about'] as String,
//     name: json['name'] as String,
//     profession: json['profession'] as String,
//     titleline: json['titleline'] as String,
//     username: json['username'] as String,

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'emp_name': instance.emp_name,
      'empno': instance.CPF_NO,
      'designation_name': instance.designation_name,
      'securelevel': instance.securelevel,
      'organization_name': instance.organization_name,
      'ou_name': instance.ou_name,
      'location_code': instance.location_code,
      'role_title': instance.role_title,
      'cpf_image': instance.cpf_image,
      'email': instance.email,
      'emp_name_cpf_no': instance.emp_name_cpf_no
    };
