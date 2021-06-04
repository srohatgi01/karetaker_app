import 'package:flutter/material.dart';
import 'package:karetaker/data/models/googleuser.dart';
import 'package:karetaker/data/models/user.dart';
import 'package:karetaker/data/repositories/authentication.dart';
import 'package:provider/provider.dart';
import '../google_auth.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // User user = Provider.of<User>(context);
    GoogleUser googleUser = Provider.of<GoogleUser>(context);
    Auth _auth = Auth();

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Profile Page')),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.only(top: 100)),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(180),
                child: Image.network(
                  googleUser.photoUrl!,
                  height: 150,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Name - ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        googleUser.firstName! + ' ' + googleUser.lastName!,
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Email ID - ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        googleUser.emailAddress!,
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "UUID - ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        googleUser.uuid!,
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                //     mainAxisSize: MainAxisSize.min,
                //     children: [
                //       Text(
                //         "Number - ",
                //         style: TextStyle(
                //             fontWeight: FontWeight.bold, fontSize: 18),
                //       ),
                //       Text(
                //         user.phoneNumber!,
                //         style: TextStyle(fontSize: 18),
                //       ),
                //     ],
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                //     mainAxisSize: MainAxisSize.min,
                //     children: [
                //       Text(
                //         "Gender - ",
                //         style: TextStyle(
                //             fontWeight: FontWeight.bold, fontSize: 18),
                //       ),
                //       Text(
                //         user.gender!,
                //         style: TextStyle(fontSize: 18),
                //       ),
                //     ],
                //   ),
                // )
              ],
            )),
            Expanded(
              child: Container(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  child: Text(
                    'Sign Out',
                    style: TextStyle(fontSize: 18),
                  ),
                  onPressed: () async {
                    await _auth.signOut();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => GoogleAuth()));
                  },
                ),
              ),
            ),
            SizedBox(height: 100)
          ],
        ),
      ),
    );
  }
}
