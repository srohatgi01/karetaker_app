import 'package:flutter/material.dart';
import 'package:karetaker/data/models/pills.dart';
import 'package:karetaker/data/models/user.dart';
import 'package:karetaker/data/repositories/pills_repo.dart';
import 'package:provider/provider.dart';

class AddPill extends StatefulWidget {
  const AddPill({Key? key}) : super(key: key);

  @override
  _AddPillState createState() => _AddPillState();
}

class _AddPillState extends State<AddPill> {
  var pillName, pillTime;

  @override
  Widget build(BuildContext context) {
    String email = Provider.of<User>(context).emailAddress.toString();
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('Add new Pill Reminder'),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            pillNameTextField(),
            SizedBox(height: 40),
            pillTimeTextField(),
            SizedBox(height: 100),
            Hero(
              tag: 'addPill',
              child: ElevatedButton(
                onPressed: () {
                  print('On Pressed Clicked');
                  Pills pill = Pills(
                    pillName: pillName,
                    pillTime: pillTime,
                    userId: email,
                  );
                  print('Pill Model Created - ' + pill.toString());

                  PillsRepository().createNewPill(pill: pill);
                  Navigator.pop(context);
                },
                child: Text(
                  'Add new Pill Reminder',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ));
  }

  Widget pillNameTextField() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: TextFormField(
          autofocus: false,
          textAlign: TextAlign.center,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: new InputDecoration(
            labelText: "Enter Pill Name",
            fillColor: Colors.white,
            border: new OutlineInputBorder(),
          ),
          keyboardType: TextInputType.name,
          style: new TextStyle(
            fontSize: 16,
            fontFamily: "Poppins",
          ),
          validator: (val) {
            if (val!.length == 0) {
              return "Pill name cannot be empty";
            } else {
              return null;
            }
          },
          onChanged: (value) {
            pillName = value;
            print('Pill Name - $pillName');
          },
        ),
      );

  Widget pillTimeTextField() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: TextFormField(
          autofocus: false,
          textAlign: TextAlign.center,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: new InputDecoration(
            labelText: "Enter Pill Time",
            fillColor: Colors.white,
            border: new OutlineInputBorder(),
          ),
          keyboardType: TextInputType.datetime,
          style: new TextStyle(
            fontSize: 16,
            fontFamily: "Poppins",
          ),
          validator: (val) {
            if (val!.length == 0) {
              return "Pill Time cannot be empty";
            } else {
              return null;
            }
          },
          onChanged: (value) {
            pillTime = value;
            print('Pill Time - $pillTime');
          },
        ),
      );
}
