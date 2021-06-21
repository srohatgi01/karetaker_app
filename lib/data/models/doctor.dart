// To parse this JSON data, do
//
//     final doctor = doctorFromJson(jsonString);

import 'dart:convert';

class Doctor {
  Doctor({
    this.doctorId,
    this.firstName,
    this.lastName,
    this.specialityId,
    this.phoneNumber,
    this.practicingYears,
    this.emailAddress,
  });

  final String? doctorId;
  final String? firstName;
  final String? lastName;
  final int? specialityId;
  final String? phoneNumber;
  final int? practicingYears;
  final String? emailAddress;

  factory Doctor.fromRawJson(String str) => Doctor.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
        doctorId: json["doctor_id"] == null ? null : json["doctor_id"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        specialityId:
            json["speciality_id"] == null ? null : json["speciality_id"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        practicingYears:
            json["practicing_years"] == null ? null : json["practicing_years"],
        emailAddress:
            json["email_address"] == null ? null : json["email_address"],
      );

  Map<String, dynamic> toJson() => {
        "doctor_id": doctorId == null ? null : doctorId,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "speciality_id": specialityId == null ? null : specialityId,
        "phone_number": phoneNumber == null ? null : phoneNumber,
        "practicing_years": practicingYears == null ? null : practicingYears,
        "email_address": emailAddress == null ? null : emailAddress,
      };
}
