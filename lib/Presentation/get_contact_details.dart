import 'package:flutter/material.dart';
import 'package:karetaker/data/models/googleuser.dart';
import 'package:karetaker/data/models/user.dart';
import 'package:karetaker/data/repositories/authentication.dart';
import 'package:karetaker/presentation/main_page.dart';
import 'package:provider/provider.dart';

class GetContactDetails extends StatelessWidget {
  const GetContactDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var number;
    var gender;
    GoogleUser googleUser = Provider.of<GoogleUser>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Get User Details'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            child: Column(
              children: [
                TextFormField(
                  onChanged: (value) => {number = value},
                ),
                TextFormField(
                  onChanged: (value) => {gender = value},
                ),
                // DropdownButton(
                //   items: [
                //     DropdownMenuItem(
                //       child: Text('MALE'),
                //       value: Text('MALE'),
                //     ),
                //     DropdownMenuItem(
                //       child: Text('FEMALE'),
                //       value: Text('FEMALE'),
                //     ),
                //     DropdownMenuItem(
                //       child: Text('OTHERS'),
                //       value: Text('OTHERS'),
                //     ),
                //   ],
                // )
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: ElevatedButton(
              child: Text('Continue to the MainPage'),
              onPressed: () {
                GoogleUser goog = GoogleUser(
                    emailAddress: googleUser.emailAddress,
                    firstName: googleUser.firstName,
                    lastName: googleUser.lastName,
                    gender: gender,
                    phoneNumber: number,
                    photoUrl: googleUser.photoUrl,
                    uuid: googleUser.uuid);
                var user = Auth().createUserInDatabase(goog);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Provider(
                      create: (BuildContext context) => user,
                      child: MainPage(),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
