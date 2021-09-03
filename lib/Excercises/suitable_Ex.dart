import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class SuitableExcercises extends StatefulWidget {
  final double? bmi;
  const SuitableExcercises({Key? key, double? this.bmi}) : super(key: key);

  @override
  _SuitableExcercisesState createState() => _SuitableExcercisesState();
}

class _SuitableExcercisesState extends State<SuitableExcercises> {
  List<String> _excercises = [
    'Jogging',
    'Weight Training',
    'High Intensity Interval Training'
  ];

  List<String> _individual = ['Jog', 'Weight', 'HIIT'];
  List<String> trailingAnimation = [
    'https://ak.picdn.net/shutterstock/videos/1041284887/preview/stock-footage--d-rendering-a-running-shirtless-male-character-with-white-background.webm',
    'https://ak.picdn.net/shutterstock/videos/1067267848/preview/stock-footage--d-animation-k-video-showing-bodybuilding-exercise-at-gym-muscular-man-doing-one-arm-dumbbell.webm',
    'https://ak.picdn.net/shutterstock/videos/1065872560/preview/stock-footage-man-exercise-animation-d-model-on-white-background-in-blue-t-shirt-low-poly-style.webm'
  ];
  @override
  Widget build(BuildContext context) {
    print('${widget.bmi}');
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
                /*leading: CircleAvatar(
                backgroundImage:
                AssetImage('assets/' + _locations[index] + '.png'),
              ),*/
                hoverColor: Colors.grey[100],
                focusColor: Colors.lightBlue,
                trailing: CircularPercentIndicator(
                  radius: 40,
                  percent: 0.55,
                  progressColor: Colors.cyan,
                )),
            elevation: 3,
          ),
        );
      },
      scrollDirection: Axis.vertical,
    );
  }
}
