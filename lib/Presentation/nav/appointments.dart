import 'package:flutter/material.dart';

class AppointmentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // User user = Provider.of<User>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment Page'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Text('List all appointments'),
      ),
    );
  }
}
