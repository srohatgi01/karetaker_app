import 'package:flutter/material.dart';

class BlogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blogs Page'),
      ),
      body: ListView.builder(
        itemBuilder: (context, position) =>
            Card(child: Text(something[position])),
        itemCount: something.length,
      ),
    );
  }

  final List<String> something = [
    'one',
    'two',
    'three',
    'four',
    'five',
    'six',
    'seven'
  ];
}
