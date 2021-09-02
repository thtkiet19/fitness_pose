import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class loading extends StatefulWidget {
  const loading({Key? key}) : super(key: key);

  @override
  _loadingState createState() => _loadingState();
}

class _loadingState extends State<loading> {
  @override
  void initState() {
    super.initState();
    print('initing');
    // Get.toNamed("/excercises", arguments: {'meter': 1, 'centi': 60, 'kg': 55});
    print('sending info to homepage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SpinKitCubeGrid(
        color: Colors.blue[300],
        size: 100.0,
      ),
    ));
  }
}
