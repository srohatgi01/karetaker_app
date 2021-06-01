import 'package:flutter/material.dart';

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
        title: Center(child: Text('Karetaker')),
      ),
      body: Center(
        child: Text('Home Page'),
      ),
    );
  }
}
