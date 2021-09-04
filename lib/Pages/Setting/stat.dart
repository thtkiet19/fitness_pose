import 'package:flutter/material.dart';

class stat extends StatelessWidget {
  const stat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Here is your stat'),
        backgroundColor: Colors.teal,
      ),
    );
  }
}
