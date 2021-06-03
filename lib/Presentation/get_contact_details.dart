import 'package:flutter/material.dart';
import 'package:karetaker/data/models/googleuser.dart';
import 'package:karetaker/presentation/main_page.dart';
import 'package:provider/provider.dart';

class GetContactDetails extends StatelessWidget {
  const GetContactDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GoogleUser googleUser = Provider.of<GoogleUser>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Get User Details'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: ElevatedButton(
          child: Text('Continue to the MainPage'),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Provider(
                  create: (BuildContext context) => googleUser,
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
