import 'package:fitness_pose/Animations/arrow_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

// import 'arrow_indicator.dart';

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

class _AnimatedImageState extends State<BmiAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 3),
  )..repeat(reverse: true);

  late final Animation<Offset> _animation = Tween<Offset>(
    begin: Offset.zero,
    end: Offset(0.0, 0.08),
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double percent = ((widget.bmi! - 13) / 37);
    percent = (percent > 1) ? percent = 1 : percent = percent;
    int _bmiIndex = 0;
    double _bmi = widget.bmi!;
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
        Text(widget._bmiCharactor[_bmiIndex]),
        Text('Your BMI = ${widget.bmi!.toDouble()}'),
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
        /* Padding(
            padding: const EdgeInsets.fromLTRB(8, 1, 8, 1),
            child: StepProgressIndicator(
              totalSteps: 37,
              currentStep: (widget.bmi!.toInt() - 13),
              selectedColor: Colors.pink,
              unselectedColor: Colors.amber,
            )),*/
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
