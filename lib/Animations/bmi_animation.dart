import 'package:fitness_pose/Animations/arrow_indicator.dart';
import 'package:fitness_pose/Animations/rive_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class BmiAnimation extends StatefulWidget {
  final double? bmi;
  BmiAnimation({Key? key, required this.bmi}) : super(key: key);
  List<String> _bmiCharactor = [
    'You are Skinny',
    'Your body type is normal',
    'You are over weight',
    'You are serve obesity',
    'You are morbid obesity',
    'You are supper obesity'
  ];
  @override
  _AnimatedImageState createState() => _AnimatedImageState();
}

class _AnimatedImageState extends State<BmiAnimation> {
  @override
  Widget build(BuildContext context) {
    double percent = ((widget.bmi! - 13) / 37);
    percent = (percent > 1) ? percent = 1 : percent = percent;
    int _bmiIndex = 0;
    if (widget.bmi! > 40)
      _bmiIndex = 5;
    else if (widget.bmi! > 35)
      _bmiIndex = 4;
    else if (widget.bmi! > 30)
      _bmiIndex = 3;
    else if (widget.bmi! > 25)
      _bmiIndex = 2;
    else if (widget.bmi! > 18.5)
      _bmiIndex = 1;
    else
      _bmiIndex = 0;

    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 1.5,
          height: MediaQuery.of(context).size.height / 3.5,
          child: BodyAnimation(),
        ),
        Text(
          widget._bmiCharactor[_bmiIndex],
          style: TextStyle(
              color: Color.fromRGBO(0, 0, 0, 1.0),
              fontSize: 22,
              fontWeight: FontWeight.w400),
        ),
        Text(
          'BMI = ${(widget.bmi! * 2).floorToDouble() / 2}',
          style: GoogleFonts.openSans(
            color: Color.fromRGBO(0, 35, 26, 1.0),
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 2,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: StepProgressIndicator(
            totalSteps: 37,
            size: 20,
            roundedEdges: Radius.circular(10),
            gradientColor: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xff2dd3fc),
                Color(0xff09ff00),
                Color(0xfffffc40),
                Color(0xffffa640),
                Color(0xffff5640),
                Color(0xffc90e0e)
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 1, 0, 1),
          child: ArrowIndicator(
            percent: percent,
            animation: true,
            backgroundColor: Colors.white,
          ),
        )
      ],
    );
  }
}
