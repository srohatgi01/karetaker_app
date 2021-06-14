import 'package:flutter/material.dart';

class BlogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.search),
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Search here',
          ),
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: Center(child: Text('Blogs Page')),
    );
  }
}
