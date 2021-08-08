import 'package:flutter/material.dart';

class loading extends StatefulWidget {
  const loading({Key? key}) : super(key: key);

  @override
  _loadingState createState() => _loadingState();
}

class _loadingState extends State<loading> {
  void setUpBMI() async =>
      Navigator.pushReplacementNamed(context, '/excercises',
          arguments: {'kg': 60, 'meter': 1, 'centi': 60});

  @override
  void initState() {
    super.initState();
    setUpBMI();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('...'),
    );
  }
}
