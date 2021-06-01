import 'package:flutter/material.dart';
import 'package:karetaker/data/models/googleuser.dart';
import 'package:provider/provider.dart';
import '../data/Repositories/authentication.dart';
import 'main_page.dart';

class GoogleAuth extends StatefulWidget {
  @override
  _GoogleAuthState createState() => _GoogleAuthState();
}

class _GoogleAuthState extends State<GoogleAuth> {
  Auth _auth = Auth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: ElevatedButton(
          child: Text(
            'Google Sign In',
            style: TextStyle(fontSize: 20),
          ),
          onPressed: () async {
            GoogleUser googleUser = await _auth.signIn();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Provider<GoogleUser>(
                  create: (context) => googleUser,
                  child: MainPage(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
