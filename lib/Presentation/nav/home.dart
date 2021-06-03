import 'package:flutter/material.dart';
import 'package:karetaker/constants/strings.dart';
import 'package:karetaker/data/models/googleuser.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            tooltip: 'Show Reports',
            icon: Icon(
              Icons.padding_outlined,
              size: 32,
            ),
            onPressed: () {},
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(
                Icons.bar_chart_rounded,
                size: 36,
              ),
              onPressed: () {},
            ),
          )
        ],
        title: Center(child: Text(APP_NAME)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),
              Text(
                'Welcome back ' +
                    Provider.of<GoogleUser>(context).firstName.toString() +
                    ',',
                style: TextStyle(fontSize: 26),
              ),
              Text('How are you feeling today?',
                  style: TextStyle(fontSize: 18, color: Colors.grey.shade700))
            ],
          ),
        ),
      ),
    );
  }
}
