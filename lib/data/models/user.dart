// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

class User {
  User({
    this.emailAddress,
    this.firstName,
    this.lastName,
    this.uuid,
    this.phoneNumber,
    this.gender,
    this.photoUrl,
  });

  final String? emailAddress;
  final String? firstName;
  final String? lastName;
  final String? uuid;
  final String? phoneNumber;
  final String? gender;
  final String? photoUrl;

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        emailAddress:
            json["email_address"] == null ? null : json["email_address"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        uuid: json["uuid"] == null ? null : json["uuid"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        gender: json["gender"] == null ? null : json["gender"],
        photoUrl: json["photo_url"] == null ? null : json["photo_url"],
      );

  Map<String, dynamic> toJson() => {
        "email_address": emailAddress == null ? null : emailAddress,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "uuid": uuid == null ? null : uuid,
        "phone_number": phoneNumber == null ? null : phoneNumber,
        "gender": gender == null ? null : gender,
        "photo_url": photoUrl == null ? null : photoUrl,
      };

  factory User.fromLocal({
    firstName,
    lastName,
    emailAddress,
    uuid,
    photoUrl,
    gender,
    phoneNumber,
  }) =>
      User(
          firstName: firstName,
          lastName: lastName,
          emailAddress: emailAddress,
          photoUrl: photoUrl,
          uuid: uuid,
          gender: gender,
          phoneNumber: phoneNumber);
}
