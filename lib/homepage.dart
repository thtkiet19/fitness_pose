import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Animations/bmi_animation.dart';
import 'suitable_Ex.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    print('got to homepage');
    print(Get.arguments);
    // data = data.isEmpty ? Get.arguments as Map : data;
    data = {'meter': 1, 'centi': 60, 'kg': 55};
    print('passed data');
    double bmi = data['kg'] /
        ((data['meter'] + data['centi'] / 100) *
            (data['meter'] + data['centi'] / 100));
    return Scaffold(
      appBar: AppBar(
          title: Text('BMI'),
          centerTitle: true,
          backgroundColor: Colors.teal,
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.edit),
                tooltip: 'Edit BMI',
                onPressed: () {
                  Get.toNamed('/bmi');
                }),
          ]),
      body: Container(
        color: Colors.blueGrey,
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            BmiAnimation(bmi: bmi),
            SizedBox(
              height: 15,
            ),
            SuitableExcercises(
              bmi: bmi,
            ),
            // Text('$bmi')
          ]),
        ),
      ),
    );
  }
}
