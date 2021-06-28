// To parse this JSON data, do
//
//     final appointmentHistory = appointmentHistoryFromJson(jsonString);

import 'dart:convert';

class AppointmentHistory {
  AppointmentHistory({
    this.appointmentDate,
    this.status,
    this.slots,
    this.hospitals,
    this.doctors,
  });

  final DateTime? appointmentDate;
  final String? status;
  final SlotsHistory? slots;
  final HospitalsHistory? hospitals;
  final DoctorsHistory? doctors;

  factory AppointmentHistory.fromRawJson(String str) =>
      AppointmentHistory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AppointmentHistory.fromJson(Map<String, dynamic> json) =>
      AppointmentHistory(
        appointmentDate: json["appointment_date"] == null
            ? null
            : DateTime.parse(json["appointment_date"]),
        status: json["status"] == null ? null : json["status"],
        slots:
            json["slots"] == null ? null : SlotsHistory.fromJson(json["slots"]),
        hospitals: json["hospitals"] == null
            ? null
            : HospitalsHistory.fromJson(json["hospitals"]),
        doctors: json["doctors"] == null
            ? null
            : DoctorsHistory.fromJson(json["doctors"]),
      );

  Map<String, dynamic> toJson() => {
        "appointment_date":
            appointmentDate == null ? null : appointmentDate!.toIso8601String(),
        "status": status == null ? null : status,
        "slots": slots == null ? null : slots!.toJson(),
        "hospitals": hospitals == null ? null : hospitals!.toJson(),
        "doctors": doctors == null ? null : doctors!.toJson(),
      };
}

class DoctorsHistory {
  DoctorsHistory({
    this.firstName,
    this.lastName,
  });

  final String? firstName;
  final String? lastName;

  factory DoctorsHistory.fromRawJson(String str) =>
      DoctorsHistory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DoctorsHistory.fromJson(Map<String, dynamic> json) => DoctorsHistory(
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
      };
}

class HospitalsHistory {
  HospitalsHistory({
    this.hospitalName,
    this.hospitalAddress,
  });

  final String? hospitalName;
  final String? hospitalAddress;

  factory HospitalsHistory.fromRawJson(String str) =>
      HospitalsHistory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HospitalsHistory.fromJson(Map<String, dynamic> json) =>
      HospitalsHistory(
        hospitalName:
            json["hospital_name"] == null ? null : json["hospital_name"],
        hospitalAddress:
            json["hospital_address"] == null ? null : json["hospital_address"],
      );

  Map<String, dynamic> toJson() => {
        "hospital_name": hospitalName == null ? null : hospitalName,
        "hospital_address": hospitalAddress == null ? null : hospitalAddress,
      };
}

class SlotsHistory {
  SlotsHistory({
    this.startTime,
  });

  final String? startTime;

  factory SlotsHistory.fromRawJson(String str) =>
      SlotsHistory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SlotsHistory.fromJson(Map<String, dynamic> json) => SlotsHistory(
        startTime: json["start_time"] == null ? null : json["start_time"],
      );

  Map<String, dynamic> toJson() => {
        "start_time": startTime == null ? null : startTime,
      };
}
