// To parse this JSON data, do
//
//     final appointment = appointmentFromJson(jsonString);

import 'dart:convert';

class Appointment {
  Appointment({
    this.appointmentId,
    this.appointmentDate,
    this.userId,
    this.doctorId,
    this.hospitalId,
    this.slotId,
    this.remarks,
    this.status,
    this.timestamp,
  });

  final int? appointmentId;
  final String? appointmentDate;
  final String? userId;
  final String? doctorId;
  final int? hospitalId;
  final int? slotId;
  final String? remarks;
  final String? status;
  final DateTime? timestamp;

  factory Appointment.fromRawJson(String str) =>
      Appointment.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
        appointmentId:
            json["appointment_id"] == null ? null : json["appointment_id"],
        // appointmentDate: json["appointment_date"] == null
        //     ? null
        //     : DateTime.parse(json["appointment_date"]),
        userId: json["user_id"] == null ? null : json["user_id"],
        doctorId: json["doctor_id"] == null ? null : json["doctor_id"],
        hospitalId: json["hospital_id"] == null ? null : json["hospital_id"],
        slotId: json["slot_id"] == null ? null : json["slot_id"],
        remarks: json["remarks"] == null ? null : json["remarks"],
        status: json["status"] == null ? null : json["status"],
        timestamp: json["timestamp"] == null
            ? null
            : DateTime.parse(json["timestamp"]),
      );

  Map<String, dynamic> toJson() => {
        "appointment_id": appointmentId == null ? null : appointmentId,
        "appointment_date": appointmentDate == null ? null : appointmentDate,
        "user_id": userId == null ? null : userId,
        "doctor_id": doctorId == null ? null : doctorId,
        "hospital_id": hospitalId == null ? null : hospitalId,
        "slot_id": slotId == null ? null : slotId,
        "remarks": remarks == null ? null : remarks,
        "status": status == null ? null : status,
        "timestamp": timestamp == null ? null : timestamp!.toIso8601String(),
      };
}
