import 'package:fitness_pose/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class loading extends StatefulWidget {
  const loading({Key? key}) : super(key: key);

  @override
  _loadingState createState() => _loadingState();
}

class _loadingState extends State<loading> {
  void innitbmi() async {
    Get.off(() => HomePage(), arguments: {'meter': 1, 'centi': 60, 'kg': 55});
  }

  @override
  void initState() {
    super.initState();
    print('initing');
    Future.delayed(const Duration(milliseconds: 500), () => innitbmi());
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
