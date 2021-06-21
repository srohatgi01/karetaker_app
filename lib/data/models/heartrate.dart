// To parse this JSON data, do
//
//     final heartRate = heartRateFromJson(jsonString);

import 'dart:convert';

class HeartRate {
  HeartRate({
    this.readingId,
    this.userId,
    this.readingValue,
    this.timestamp,
  });

  final int? readingId;
  final String? userId;
  final String? readingValue;
  final DateTime? timestamp;

  factory HeartRate.fromRawJson(String str) =>
      HeartRate.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HeartRate.fromJson(Map<String, dynamic> json) => HeartRate(
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
