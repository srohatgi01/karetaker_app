import 'package:flutter/material.dart';
import 'package:karetaker/data/models/pills.dart';

class PillDetails extends StatelessWidget {
  final Pills pill;
  const PillDetails({Key? key, required this.pill}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Pill Details'),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${pill.pillName}'),
            Text('${pill.pillTime}'),
          ],
        ),
      ),
    );
  }
}
