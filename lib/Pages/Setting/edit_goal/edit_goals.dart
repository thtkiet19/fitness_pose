import 'package:fitness_pose/Structures/goal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';
import '../../../DB/db.dart';

class edit_goals extends StatefulWidget {
  final Goal_val goal_val;
  const edit_goals({Key? key, required this.goal_val}) : super(key: key);

  @override
  _edit_goalsState createState() => _edit_goalsState();
}

class _edit_goalsState extends State<edit_goals> {
  /* Future<void> innitvalues() async {
    DB.init();
    List<Map<String, dynamic>> _goals = await DB.query('goals');
    widget.goal_val = _goals.map((item) => Goal_val.fromMap(item)).toList().last;
    print('${goal_val.jogging_goal}');
  }

  @override
  void initState() {
    super.initState();
    innitvalues();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Set your own goal',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text('Daily running distance in meter'),
                  NumberPicker(
                      axis: Axis.horizontal,
                      textStyle: TextStyle(color: Colors.white),
                      value: widget.goal_val.jogging_goal!.toInt(),
                      selectedTextStyle:
                          TextStyle(color: Colors.teal, fontSize: 30),
                      minValue: 0,
                      maxValue: 20000,
                      decoration: BoxDecoration(
                        border: Border(left: BorderSide(), right: BorderSide()),
                      ),
                      step: 500,
                      haptics: false,
                      onChanged: (value) {
                        setState(() =>
                            widget.goal_val.jogging_goal = value.toDouble());
                        //Welcome.of(context)!.meter = value;
                      }
                      //setState(() => widget.meter = value),
                      ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 18,
              ),
              Column(
                children: [
                  Text('Daily Weightlifting Reps'),
                  NumberPicker(
                    axis: Axis.horizontal,
                    textStyle: TextStyle(color: Colors.white),
                    value: widget.goal_val.weigh_goal!.toInt(),
                    selectedTextStyle:
                        TextStyle(color: Colors.teal, fontSize: 30),
                    minValue: 0,
                    maxValue: 20,
                    decoration: BoxDecoration(
                      border: Border(left: BorderSide(), right: BorderSide()),
                    ),
                    step: 1,
                    haptics: false,
                    onChanged: (value) {
                      setState(
                          () => widget.goal_val.weigh_goal = value.toDouble());
                    },
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 18,
              ),
              Column(
                children: [
                  Text('Daily hiit reps'),
                  NumberPicker(
                    axis: Axis.horizontal,
                    textStyle: TextStyle(color: Colors.white),
                    value: widget.goal_val.hiit_goal!.toInt(),
                    selectedTextStyle:
                        TextStyle(color: Colors.teal, fontSize: 30),
                    minValue: 0,
                    maxValue: 20,
                    decoration: BoxDecoration(
                      border: Border(left: BorderSide(), right: BorderSide()),
                    ),
                    step: 1,
                    haptics: false,
                    onChanged: (value) => setState(
                        () => widget.goal_val.hiit_goal = value.toDouble()),
                  ),
                ],
              ),
              ElevatedButton(
                  onPressed: () async {
                    DB.insertGoal(
                        'goals',
                        Goal_val(
                            date: DateFormat.yMMMMd('en_US')
                                .format(DateTime.now()),
                            jogging_goal: widget.goal_val.jogging_goal,
                            weigh_goal: widget.goal_val.weigh_goal,
                            hiit_goal: widget.goal_val.hiit_goal));
                    List<Map<String, dynamic>> _results =
                        await DB.query(Goal_val.table);
                    print('$_results');
                    Get.offAllNamed('/loading');
                  },
                  child: Icon(Icons.add)),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.blueGrey,
    );
  }
}
