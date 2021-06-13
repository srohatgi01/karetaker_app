import 'package:flutter/material.dart';
import 'package:karetaker/constants/strings.dart';
import 'package:karetaker/data/models/googleuser.dart';
import 'package:karetaker/data/models/user.dart';
import 'package:karetaker/data/repositories/authentication.dart';
import 'package:karetaker/presentation/main_page.dart';
import 'package:provider/provider.dart';

class GetContactDetails extends StatefulWidget {
  const GetContactDetails({Key? key}) : super(key: key);

  @override
  _GetContactDetailsState createState() => _GetContactDetailsState();
}

var gender;
var number;

class _GetContactDetailsState extends State<GetContactDetails> {
  @override
  Widget build(BuildContext context) {
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 40, 20),
                  child: TextFormField(
                    autofocus: false,
                    textAlign: TextAlign.center,
                    maxLength: 10,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: new InputDecoration(
                      labelText: "Enter Phone Number",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                    style: new TextStyle(
                      fontSize: 16,
                      fontFamily: "Poppins",
                    ),
                    validator: (val) {
                      if (val!.length == 0) {
                        return "Phone Number cannot be empty";
                      } else if (val.length != 10) {
                        return "Phone number must be 10 digits";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) => {print(number), number = value},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 20, 40, 40),
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Select Gender',
                      border: const OutlineInputBorder(),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: Text(
                          'Select Gender',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Poppins",
                          ),
                        ),
                        isExpanded: true,
                        isDense:
                            true, // Reduces the dropdowns height by +/- 50%
                        icon: Icon(Icons.keyboard_arrow_down),
                        value: gender,
                        items: [
                          DropdownMenuItem(
                            child: Text('${GENDER_SELECT[0]}'),
                            value: GENDER_SELECT_VALUES[0],
                          ),
                          DropdownMenuItem(
                            child: Text('${GENDER_SELECT[1]}'),
                            value: GENDER_SELECT_VALUES[1],
                          ),
                          DropdownMenuItem(
                            child: Text('${GENDER_SELECT[2]}'),
                            value: GENDER_SELECT_VALUES[2],
                          )
                        ],
                        onChanged: (value) => {
                          print(value),
                          setState(() => {gender = value})
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 100),
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              child: Text('SUBMIT',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
              onPressed: () async {
                String newUser = User(
                        emailAddress: googleUser.emailAddress,
                        firstName: googleUser.firstName,
                        lastName: googleUser.lastName,
                        uuid: googleUser.uuid,
                        gender: gender,
                        phoneNumber: number,
                        photoUrl: googleUser.photoUrl)
                    .toRawJson();

                // we are giving raw json to the UserApi().createNewUser
                var returnedUser = await Auth().createUserInDatabase(newUser);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Provider<User>(
                      create: (context) => returnedUser,
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
