import 'package:flutter/material.dart';
import 'package:karetaker/data/models/googleuser.dart';
import 'package:karetaker/data/models/user.dart';
import 'package:karetaker/data/repositories/authentication.dart';
import 'package:provider/provider.dart';
import 'get_contact_details.dart';
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/icons/logo.png', height: 200),
            InkWell(
              onTap: () async {
                GoogleUser googleUser = await _auth.signIn();
                var isNewUser = await _auth.isNewUser(googleUser.emailAddress!);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => isNewUser == true
                        ? Provider<GoogleUser>(
                            create: (context) => googleUser,
                            child: GetContactDetails())
                        : Provider<User>(
                            create: (context) => isNewUser,
                            child: MainPage(),
                          ),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 6.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(50)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/google.png',
                      height: 30,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text('Sign In with Google', style: TextStyle(fontSize: 18))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
