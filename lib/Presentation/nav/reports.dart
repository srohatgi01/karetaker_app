import 'package:flutter/material.dart';
import 'package:karetaker/data/models/user.dart';
import 'package:provider/provider.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Medical Records'),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Text('Reports Page'),
      ),
    );
  }
}
