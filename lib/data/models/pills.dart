// To parse this JSON data, do
//
//     final pills = pillsFromJson(jsonString);

import 'dart:convert';

class Pills {
  Pills({
    this.pillsId,
    this.pillName,
    this.pillTime,
    this.userId,
  });

  final int? pillsId;
  final String? pillName;
  final String? pillTime;
  final String? userId;

  String toRawJson() => json.encode(toJson());

  factory Pills.fromJson(Map<String, dynamic> json) => Pills(
        pillsId: json["pills_id"] == null ? null : json["pills_id"],
        pillName: json["pill_name"] == null ? null : json["pill_name"],
        pillTime: json["pill_time"] == null ? null : json["pill_time"],
        userId: json["user_id"] == null ? null : json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        // "pills_id": pillsId == null ? null : pillsId,
        "pill_name": pillName == null ? null : pillName,
        "pill_time": pillTime == null ? null : pillTime,
        "user_id": userId == null ? null : userId,
      };
}
