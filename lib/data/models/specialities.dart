import 'dart:convert';

class Specialities {
  Specialities({
    this.specialityId,
    this.specialityName,
  });

  final int? specialityId;
  final String? specialityName;

  factory Specialities.fromRawJson(String str) =>
      Specialities.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Specialities.fromJson(Map<String, dynamic> json) => Specialities(
        specialityId:
            json["speciality_id"] == null ? null : json["speciality_id"],
        specialityName:
            json["speciality_name"] == null ? null : json["speciality_name"],
      );

  Map<String, dynamic> toJson() => {
        "speciality_id": specialityId == null ? null : specialityId,
        "speciality_name": specialityName == null ? null : specialityName,
      };
}
