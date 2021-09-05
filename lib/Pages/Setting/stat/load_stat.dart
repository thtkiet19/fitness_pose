import 'package:fitness_pose/Pages/Setting/stat/stat.dart';
import 'package:fitness_pose/Structures/bmi.dart';
import 'package:fitness_pose/Structures/goal.dart';
import 'package:fitness_pose/Structures/progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../../DB/db.dart';

class loading_stat extends StatefulWidget {
  const loading_stat({Key? key}) : super(key: key);

  @override
  _loading_statState createState() => _loading_statState();
}

class _loading_statState extends State<loading_stat> {
  late final List<Progress_val> _progress;
  late final List<Bmi_val> _bmi;
  late Goal_val goal_val;

  Future<void> innitdb() async {
    await DB.init();
    print('init in stat');
    List<Map<String, dynamic>> _pro =
        await DB.selectWeek('progress', 'date DESC');
    _progress = _pro.map((item) => Progress_val.fromMap(item)).toList();

    List<Map<String, dynamic>> _weekbmi = await DB.selectWeek('bmi', 'id DESC');
    _bmi = _weekbmi.map((item) => Bmi_val.fromMap(item)).toList();

    List<Map<String, dynamic>> _goals = await DB.query('goals');
    goal_val = _goals.map((item) => Goal_val.fromMap(item)).toList().last;
    Get.off(() => stat(
          progress: _progress,
          goal_val: goal_val,
          bmi: _bmi,
        ));
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 200), () => innitdb());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SpinKitCircle(
        color: Colors.blue[300],
        size: 100.0,
      ),
    ));
  }
}
