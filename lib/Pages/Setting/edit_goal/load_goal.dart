import 'package:fitness_pose/Pages/Setting/edit_goal/edit_goals.dart';
import 'package:fitness_pose/Structures/goal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../../DB/db.dart';

class loading_goals extends StatefulWidget {
  const loading_goals({Key? key}) : super(key: key);

  @override
  _loading_goalsState createState() => _loading_goalsState();
}

class _loading_goalsState extends State<loading_goals> {
  late Goal_val goal_val;

  Future<void> innit() async {
    await DB.init();
    print('init in stat');
    //get bmi values from data base
    List<Map<String, dynamic>> _goals = await DB.query('goals');
    goal_val = _goals.map((item) => Goal_val.fromMap(item)).toList().last;
    Get.off(() => edit_goals(
          goal_val: goal_val,
        ));
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 200), () => innit());
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
