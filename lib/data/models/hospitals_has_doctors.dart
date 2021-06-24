import 'dart:convert';
import './hospitals.dart';

class HospitalsHasDoctor {
  HospitalsHasDoctor({
    this.doctorId,
    this.hospitalId,
    this.doctorStatus,
    this.fee,
    this.hospitals,
  });

  final String? doctorId;
  final int? hospitalId;
  final String? doctorStatus;
  final String? fee;
  final Hospitals? hospitals;

  factory HospitalsHasDoctor.fromRawJson(String str) =>
      HospitalsHasDoctor.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HospitalsHasDoctor.fromJson(Map<String, dynamic> json) =>
      HospitalsHasDoctor(
        doctorId: json["doctor_id"] == null ? null : json["doctor_id"],
        hospitalId: json["hospital_id"] == null ? null : json["hospital_id"],
        doctorStatus:
            json["doctor_status"] == null ? null : json["doctor_status"],
        fee: json["fee"] == null ? null : json["fee"],
        hospitals: json["hospitals"] == null
            ? null
            : Hospitals.fromJson(json["hospitals"]),
      );

  Map<String, dynamic> toJson() => {
        "doctor_id": doctorId == null ? null : doctorId,
        "hospital_id": hospitalId == null ? null : hospitalId,
        "doctor_status": doctorStatus == null ? null : doctorStatus,
        "fee": fee == null ? null : fee,
        "hospitals": hospitals == null ? null : hospitals!.toJson(),
      };
}
