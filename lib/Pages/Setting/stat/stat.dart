import 'package:fitness_pose/DB/db.dart';
import 'package:fitness_pose/Pages/Setting/stat/stat_body.dart';
import 'package:fitness_pose/Structures/progress.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class stat extends StatefulWidget {
  final List<Progress_val> progress;
  const stat({Key? key, required this.progress}) : super(key: key);

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
            child: Column(
              children: [
                stat_running(
                  progress: widget.progress,
                )
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.blueGrey,
    );
  }
}
