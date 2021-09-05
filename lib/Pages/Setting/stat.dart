import 'package:fitness_pose/DB/db.dart';
import 'package:fitness_pose/Pages/Setting/stat_body.dart';
import 'package:fitness_pose/Structures/progress.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class stat extends StatefulWidget {
  const stat({Key? key}) : super(key: key);

  @override
  _statState createState() => _statState();
}

class _statState extends State<stat> {
  late final List<Progress_val> _progress;

  Future<void> innitdb() async {
    await DB.init();
    print('init in stat');
    //get bmi values from data base
    List<Map<String, dynamic>> _pro = await DB.selectWeekRun();
    _progress = _pro.map((item) => Progress_val.fromMap(item)).toList();
    print('${_progress[0].date}');
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () => innitdb());
  }

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
                stat_body(
                  progress: _progress,
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
