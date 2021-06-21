// To parse this JSON data, do
//
//     final bloodPressure = bloodPressureFromJson(jsonString);

import 'dart:convert';

class BloodPressure {
  BloodPressure({
    this.readingId,
    this.userId,
    this.readingValue,
    this.timestamp,
  });

  final int? readingId;
  final String? userId;
  final String? readingValue;
  final DateTime? timestamp;

  factory BloodPressure.fromRawJson(String str) =>
      BloodPressure.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BloodPressure.fromJson(Map<String, dynamic> json) => BloodPressure(
        readingId: json["reading_id"] == null ? null : json["reading_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        readingValue:
            json["reading_value"] == null ? null : json["reading_value"],
        timestamp: json["timestamp"] == null
            ? null
            : DateTime.parse(json["timestamp"]),
      );

  Map<String, dynamic> toJson() => {
        "reading_id": readingId == null ? null : readingId,
        "user_id": userId == null ? null : userId,
        "reading_value": readingValue == null ? null : readingValue,
        "timestamp": timestamp == null ? null : timestamp!.toIso8601String(),
      };
}
