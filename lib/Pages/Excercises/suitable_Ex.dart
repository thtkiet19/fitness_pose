import 'package:fitness_pose/Structures/goal.dart';
import 'package:fitness_pose/Structures/progress.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class SuitableExcercises extends StatefulWidget {
  final double? bmi;
  final Progress_val? progress_val;
  final Goal_val goal_val;

  const SuitableExcercises(
      {Key? key, double? this.bmi, this.progress_val, required this.goal_val})
      : super(key: key);

  @override
  _SuitableExcercisesState createState() => _SuitableExcercisesState();
}

class _SuitableExcercisesState extends State<SuitableExcercises> {
  List<String> _excercises = [
    'Jogging',
    'Weight Training',
    'High Intensity Interval Training'
  ];

  List<String> _individual = ['Jogging', 'Weight', 'HIIT'];
  List<String> _unit = ['meters', 'reps', 'reps'];
  List<String> trailingAnimation = [
    'https://ak.picdn.net/shutterstock/videos/1041284887/preview/stock-footage--d-rendering-a-running-shirtless-male-character-with-white-background.webm',
    'https://ak.picdn.net/shutterstock/videos/1067267848/preview/stock-footage--d-animation-k-video-showing-bodybuilding-exercise-at-gym-muscular-man-doing-one-arm-dumbbell.webm',
    'https://ak.picdn.net/shutterstock/videos/1065872560/preview/stock-footage-man-exercise-animation-d-model-on-white-background-in-blue-t-shirt-low-poly-style.webm'
  ];

  double percent(int progress, int goal) {
    double ans = progress / goal;
    if (ans > 1)
      return 1;
    else
      return ans;
  }

  @override
  Widget build(BuildContext context) {
    print('${widget.bmi}');
    int jogging = 0;
    if (widget.progress_val!.jogging != null)
      jogging = widget.progress_val!.jogging!.toInt();
    int weigh = 0;
    if (widget.progress_val!.weigh != null)
      weigh = widget.progress_val!.weigh!.toInt();
    int hiit = 0;
    if (widget.progress_val!.hiit != null)
      hiit = widget.progress_val!.hiit!.toInt();

    List<int> progress = [jogging, weigh, hiit];
    List<int> goal_val = [
      widget.goal_val.jogging_goal!.toInt(),
      widget.goal_val.weigh_goal!.toInt(),
      widget.goal_val.hiit_goal!.toInt()
    ];
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _excercises.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 3),
          child: Card(
            child: ListTile(
                onTap: () {
                  Get.toNamed('/individual', arguments: {
                    'type': _excercises[index],
                    'bmi': widget.bmi,
                    'video': trailingAnimation[index]
                  });
                },
                title: Text(_individual[index]),
                hoverColor: Colors.grey[100],
                focusColor: Colors.lightBlue,
                trailing: SizedBox(
                  width: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('${progress[index]} ${_unit[index]}'),
                      SizedBox(
                        width: 15,
                      ),
                      CircularPercentIndicator(
                        animation: true,
                        lineWidth: 6,
                        radius: 40,
                        percent: percent(progress[index], goal_val[index]),
                        progressColor: Colors.cyan,
                      ),
                    ],
                  ),
                )),
            elevation: 3,
          ),
        );
      },
      scrollDirection: Axis.vertical, /**/
    );
  }
}
