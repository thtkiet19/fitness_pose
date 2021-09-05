import 'package:fitness_pose/Structures/bmi.dart';
import 'package:fitness_pose/Structures/goal.dart';
import 'package:fitness_pose/Structures/progress.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Animations/bmi_animation.dart';
import '../../Pages/Excercises/suitable_Ex.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Bmi_val data;
  late Progress_val pro;
  late Goal_val goal;

  @override
  Widget build(BuildContext context) {
    print('got to homepage');
    //print(Get.arguments);
    data = Get.arguments['bmi'];
    pro = Get.arguments['progress'];
    goal = Get.arguments['goal'];
    print('${pro.jogging}');
    double bmi = data.kg /
        ((data.meter + data.centi / 100) * (data.meter + data.centi / 100));
    String date = data.date;
    return Scaffold(
      appBar: AppBar(
          title: Text('iWorkOut'),
          centerTitle: true,
          backgroundColor: Colors.teal,
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.settings),
                tooltip: 'Edit BMI',
                onPressed: () {
                  Get.toNamed('/setting');
                }),
          ]),
      body: Container(
        color: Colors.blueGrey,
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            BmiAnimation(bmi: bmi),
            Text(date),
            SizedBox(
              height: 15,
            ),
            SuitableExcercises(
              bmi: bmi,
              progress_val: pro,
              goal_val: goal,
            ),
            // Text('$bmi')
          ]),
        ),
      ),
    );
  }
}
