import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:karetaker/Presentation/main_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'Presentation/google_auth.dart';
import 'constants/colors.dart';
import 'data/models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  tz.initializeTimeZones();

  await Firebase.initializeApp();

  bool? isSignedIn = false;

  SharedPreferences prefs = await SharedPreferences.getInstance();

  prefs.getBool('isSignedIn') == true ? isSignedIn = true : isSignedIn = false;

  String? emailAddress = prefs.getString('emailAddress') ?? 'Didn\'t get email';
  String? firstName = prefs.getString('first_name') ?? 'Didn\'t get First Name';
  String? lastName = prefs.getString('last_name') ?? 'Didn\'t get Last Name';
  String? uuid = prefs.getString('uuid') ?? 'Didn\'t get UUID';
  String? photoUrl = prefs.getString('photoUrl') ?? 'Didn\'t get Photo Url';
  String? gender = prefs.getString('gender') ?? 'Didn\'t get Photo Url';
  String? phoneNumber =
      prefs.getString('phoneNumber') ?? 'Didn\'t get Photo Url';

  User user = User.fromLocal(
    emailAddress: emailAddress,
    firstName: firstName,
    lastName: lastName,
    uuid: uuid,
    photoUrl: photoUrl,
    gender: gender,
    phoneNumber: phoneNumber,
  );

  runApp(
    MaterialApp(
      title: 'Karetaker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: primaryCustomColor),
      home: isSignedIn == false
          ? GoogleAuth()
          : Provider<User>(
              create: (context) => user,
              child: MainPage(),
            ),
    ),
  );
}
