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
    this.age,
    this.bodyHeight,
    this.bodyWeight,
    this.bloodGroup,
  });

  final String? emailAddress;
  final String? firstName;
  final String? lastName;
  final String? uuid;
  final String? phoneNumber;
  final String? gender;
  final String? photoUrl;
  final int? age;
  final double? bodyHeight;
  final double? bodyWeight;
  final String? bloodGroup;

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
        age: json["age"] == null ? null : json["age"],
        bodyHeight:
            json["body_height"] == null ? null : json["body_height"].toDouble(),
        bodyWeight:
            json["body_weight"] == null ? null : json["body_weight"].toDouble(),
        bloodGroup: json["blood_group"] == null ? null : json["blood_group"],
      );

  Map<String, dynamic> toJson() => {
        "email_address": emailAddress == null ? null : emailAddress,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "uuid": uuid == null ? null : uuid,
        "phone_number": phoneNumber == null ? null : phoneNumber,
        "gender": gender == null ? null : gender,
        "photo_url": photoUrl == null ? null : photoUrl,
        "age": age == null ? null : age,
        "body_height": bodyHeight == null ? null : bodyHeight,
        "body_weight": bodyWeight == null ? null : bodyWeight,
        "blood_group": bloodGroup == null ? null : bloodGroup,
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
