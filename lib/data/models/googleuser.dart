import 'package:firebase_auth/firebase_auth.dart';

class GoogleUser {
  final String? firstName;
  final String? lastName;
  final String? emailAddress;
  final String? uuid;
  final String? photoUrl;

  GoogleUser(
      {this.firstName,
      this.lastName,
      this.emailAddress,
      this.uuid,
      this.photoUrl});

  factory GoogleUser.fromGoogle(User user) => GoogleUser(
      firstName: user.displayName!.split(" ")[0],
      lastName: user.displayName!.split(" ")[1],
      emailAddress: user.email,
      uuid: user.uid,
      photoUrl: user.photoURL);

  factory GoogleUser.fromLocal(
          String firstName, lastName, emailAddress, uuid, photoUrl) =>
      GoogleUser(
          firstName: firstName,
          lastName: lastName,
          emailAddress: emailAddress,
          photoUrl: photoUrl,
          uuid: uuid);
}
