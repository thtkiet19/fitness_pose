import 'package:fitness_pose/Structures/bmi.dart';
import 'package:fitness_pose/Pages/homepage.dart';
import 'package:fitness_pose/Structures/entry.dart';
import 'package:fitness_pose/Structures/goal.dart';
import 'package:fitness_pose/Structures/progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../DB/db.dart';

class loading extends StatefulWidget {
  const loading({Key? key}) : super(key: key);

  @override
  _loadingState createState() => _loadingState();
}

class _loadingState extends State<loading> {
  late List<Bmi_val> _data;
  late List<Progress_val> _pro;
  late Goal_val goal_val;

  void innitdata() async {
    await DB.init();
    print('init');

    //get bmi values from data base
    List<Map<String, dynamic>> _results_bmi = await DB.query(Bmi_val.table);
    String today = DateFormat.yMMMMd('en_US').format(DateTime.now());
    List<Map<String, dynamic>> _progress = await DB.query('progress');
    if (_progress.isBlank == true) {
      DB.innnitProgressDate(today);
      _progress = await DB.query('progress');
    }

    if (today != _progress.last['date']) {
      DB.innnitProgressDate(today);
    }
    List<Map<String, dynamic>> _results = await DB.query(Entry.table);
    List<Entry> _temp = _results.map((item) => Entry.fromMap(item)).toList();
    if (_temp.isBlank == false) {
      DB.loadProgress(today);
      _progress = await DB.query('progress');
    }
    print(_progress);
    // _progress.map((item) => Bmi_val.fromMap(item)).toList();
    print('$_results_bmi');
    List<Map<String, dynamic>> _goals = await DB.query('goals');
    if (_goals.isBlank == true) {
      DB.insertGoal(
          'goals',
          Goal_val(
              date: today, jogging_goal: 2000, weigh_goal: 10, hiit_goal: 5));
      _goals = await DB.query('goals');
    } else {
      goal_val = _goals.map((item) => Goal_val.fromMap(item)).toList().last;
      print('${goal_val.jogging_goal}');
    }
    //check if there are any bmi results yet
    if (_results_bmi.isBlank == true) {
      Get.offNamed('/bmi');
    } else {
      _data = _results_bmi.map((item) => Bmi_val.fromMap(item)).toList();
      _pro = _progress.map((item) => Progress_val.fromMap(item)).toList();
      Bmi_val init = _data[_data.length - 1];
      Get.off(() => HomePage(), arguments: {
        'bmi': init,
        'progress': _pro[_pro.length - 1],
        'goal': goal_val
      });
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () => innitdata());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SpinKitDualRing(
        color: Color.fromARGB(255, 13, 248, 192),
        size: 100.0,
      ),
    ));
  }
}
