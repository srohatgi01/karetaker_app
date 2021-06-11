import 'package:flutter/material.dart';

class GraphPage extends StatelessWidget {
  const GraphPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Graph Page'),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Text('Graph\'s Page'),
      ),
    );
  }
}
