// To parse this JSON data, do
//
//     final searchDoctor = searchDoctorFromJson(jsonString);

import 'dart:convert';
import 'specialities.dart';

class SearchDoctor {
  SearchDoctor({
    this.doctorId,
    this.firstName,
    this.lastName,
    this.practicingYears,
    this.specialities,
  });

  final String? doctorId;
  final String? firstName;
  final String? lastName;
  final int? practicingYears;
  final Specialities? specialities;

  factory SearchDoctor.fromRawJson(String str) =>
      SearchDoctor.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchDoctor.fromJson(Map<String, dynamic> json) => SearchDoctor(
        doctorId: json["doctor_id"] == null ? null : json["doctor_id"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        practicingYears:
            json["practicing_years"] == null ? null : json["practicing_years"],
        specialities: json["specialities"] == null
            ? null
            : Specialities.fromJson(json["specialities"]),
      );

  Map<String, dynamic> toJson() => {
        "doctor_id": doctorId == null ? null : doctorId,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "practicing_years": practicingYears == null ? null : practicingYears,
        "specialities": specialities == null ? null : specialities!.toJson(),
      };
}
