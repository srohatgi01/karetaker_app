// To parse this JSON data, do
//
//     final sugar = sugarFromJson(jsonString);

import 'dart:convert';

class Sugar {
  Sugar({
    this.readingId,
    this.userId,
    this.value,
    this.type,
    this.timestamp,
  });

  final int? readingId;
  final String? userId;
  final String? value;
  final String? type;
  final DateTime? timestamp;

  factory Sugar.fromRawJson(String str) => Sugar.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Sugar.fromJson(Map<String, dynamic> json) => Sugar(
        readingId: json["reading_id"] == null ? null : json["reading_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        value: json["value"] == null ? null : json["value"],
        type: json["type"] == null ? null : json["type"],
        timestamp: json["timestamp"] == null
            ? null
            : DateTime.parse(json["timestamp"]),
      );

  Map<String, dynamic> toJson() => {
        "reading_id": readingId == null ? null : readingId,
        "user_id": userId == null ? null : userId,
        "value": value == null ? null : value,
        "type": type == null ? null : type,
        "timestamp": timestamp == null ? null : timestamp!.toIso8601String(),
      };
}
