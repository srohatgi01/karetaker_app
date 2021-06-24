// To parse this JSON data, do
//
//     final slots = slotsFromJson(jsonString);

import 'dart:convert';

class Slots {
  Slots({
    this.startTime,
    this.slotId,
  });

  final String? startTime;
  final int? slotId;

  factory Slots.fromRawJson(String str) => Slots.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Slots.fromJson(Map<String, dynamic> json) => Slots(
        startTime: json["start_time"] == null ? null : json["start_time"],
        slotId: json["slot_id"] == null ? null : json["slot_id"],
      );

  Map<String, dynamic> toJson() => {
        "start_time": startTime == null ? null : startTime,
        "slot_id": slotId == null ? null : slotId,
      };
}
