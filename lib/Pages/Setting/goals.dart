import 'package:flutter/material.dart';

class goals extends StatelessWidget {
  const goals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set your own goal'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        child: Column(
          children: [
            Row(
              children: [Text('Enter your running')],
            )
          ],
        ),
      ),
    );
  }
}
