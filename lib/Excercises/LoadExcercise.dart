import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class LoadExcercise extends StatefulWidget {
  const LoadExcercise({Key? key}) : super(key: key);

  @override
  _LoadExcerciseState createState() => _LoadExcerciseState();
}

//TODO: load indiviual excercises
class _LoadExcerciseState extends State<LoadExcercise> {
  Map data = {};
  @override
  Widget build(BuildContext context) {
    data =
        data.isEmpty ? ModalRoute.of(context)!.settings.arguments as Map : data;
    return Scaffold(
        appBar: AppBar(
          title: Text(data['type']),
          centerTitle: true,
          backgroundColor: Colors.teal,
        ),
        body: Center(
            child: SizedBox(
                height: 200,
                width: 200,
                child: LiquidCircularProgressIndicator(
                  center: Text('${data['bmi']}'),
                  value: data['bmi'] / 45,
                ))));
  }
}
