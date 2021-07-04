// To parse this JSON data, do
//
//     final reports = reportsFromJson(jsonString);

import 'dart:convert';

class Reports {
  Reports({
    this.reportId,
    this.userId,
    this.nameOfReport,
    this.dateOfReport,
    this.doctorWhoCreatedReport,
    this.showStatus,
    this.timestamp,
  });

  final int? reportId;
  final String? userId;
  final String? nameOfReport;
  final String? dateOfReport;
  final String? doctorWhoCreatedReport;
  final String? showStatus;
  final DateTime? timestamp;

  factory Reports.fromRawJson(String str) => Reports.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Reports.fromJson(Map<String, dynamic> json) => Reports(
        reportId: json["report_id"] == null ? null : json["report_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        nameOfReport:
            json["name_of_report"] == null ? null : json["name_of_report"],
        dateOfReport:
            json["date_of_report"] == null ? null : json["date_of_report"],
        doctorWhoCreatedReport: json["doctor_who_created_report"] == null
            ? null
            : json["doctor_who_created_report"],
        showStatus: json["show_status"] == null ? null : json["show_status"],
        timestamp: json["timestamp"] == null
            ? null
            : DateTime.parse(json["timestamp"]),
      );

  Map<String, dynamic> toJson() => {
        "report_id": reportId == null ? null : reportId,
        "user_id": userId == null ? null : userId,
        "name_of_report": nameOfReport == null ? null : nameOfReport,
        "date_of_report": dateOfReport == null ? null : dateOfReport,
        "doctor_who_created_report":
            doctorWhoCreatedReport == null ? null : doctorWhoCreatedReport,
        "show_status": showStatus == null ? null : showStatus,
      };
}
