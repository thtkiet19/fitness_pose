import 'package:fitness_pose/Pages/Setting/stat/stat_height.dart';
import 'package:fitness_pose/Pages/Setting/stat/stat_weight.dart';
import 'package:fitness_pose/Pages/Setting/stat/stat_running.dart';
import 'package:fitness_pose/Structures/bmi.dart';
import 'package:fitness_pose/Structures/goal.dart';
import 'package:fitness_pose/Structures/progress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class stat extends StatefulWidget {
  final List<Progress_val> progress;
  final List<Bmi_val> bmi;

  final Goal_val goal_val;
  const stat(
      {Key? key,
      required this.progress,
      required this.goal_val,
      required this.bmi})
      : super(key: key);

  @override
  _statState createState() => _statState();
}

class _statState extends State<stat> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 100), () {});
    return Scaffold(
      appBar: AppBar(
        title: Text('Your statistic'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 30, 8.0, 0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                stat_running(
                  progress: widget.progress,
                  goal_val: widget.goal_val,
                ),
                stat_weight(bmi: widget.bmi),
                stat_height(bmi: widget.bmi)
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.blueGrey,
    );
  }
}
