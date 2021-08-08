import 'package:flutter/material.dart';

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
    data['kg'] = 60;
    data['meter'] = 1;
    data['centi'] = 60;
    data =
        data.isEmpty ? ModalRoute.of(context)!.settings.arguments as Map : data;
    double bmi = data['kg'] /
        ((data['meter'] + data['centi'] / 100) *
            (data['meter'] + data['centi'] / 100));
    double getbmi() => bmi;
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
                  Navigator.pushNamed(context, '/bmi');
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
