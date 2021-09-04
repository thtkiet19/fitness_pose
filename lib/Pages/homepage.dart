import 'package:fitness_pose/Data%20Input/bmi.dart';
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

  @override
  Widget build(BuildContext context) {
    print('got to homepage');
    //print(Get.arguments);
    data = Get.arguments['bmi'];
    print('$data');
    // data = data.isEmpty ? {'meter': 1, 'centi': 60, 'kg': 55} : data;

    // data = {'meter': 1, 'centi': 60, 'kg': 55};
    print('passed data');
    /*double bmi = data['kg'] /
        ((data['meter'] + data['centi'] / 100) *
            (data['meter'] + data['centi'] / 100));*/
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
            ),
            // Text('$bmi')
          ]),
        ),
      ),
    );
  }
}
