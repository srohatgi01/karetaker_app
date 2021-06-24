import 'dart:convert';

class Hospitals {
  Hospitals({
    this.hospitalId,
    this.hospitalName,
    this.emailAddress,
    this.phoneNumber,
    this.hospitalAddress,
  });

  final int? hospitalId;
  final String? hospitalName;
  final String? emailAddress;
  final String? phoneNumber;
  final String? hospitalAddress;

  factory Hospitals.fromRawJson(String str) =>
      Hospitals.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Hospitals.fromJson(Map<String, dynamic> json) => Hospitals(
        hospitalId: json["hospital_id"] == null ? null : json["hospital_id"],
        hospitalName:
            json["hospital_name"] == null ? null : json["hospital_name"],
        emailAddress:
            json["email_address"] == null ? null : json["email_address"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        hospitalAddress:
            json["hospital_address"] == null ? null : json["hospital_address"],
      );

  Map<String, dynamic> toJson() => {
        "hospital_id": hospitalId == null ? null : hospitalId,
        "hospital_name": hospitalName == null ? null : hospitalName,
        "email_address": emailAddress == null ? null : emailAddress,
        "phone_number": phoneNumber == null ? null : phoneNumber,
        "hospital_address": hospitalAddress == null ? null : hospitalAddress,
      };
}
