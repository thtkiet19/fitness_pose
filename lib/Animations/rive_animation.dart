import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class BodyAnimation extends StatelessWidget {
  const BodyAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RiveAnimation.asset(
        'assets/RiveAnimation/runner_boy.riv',
        fit: BoxFit.fitHeight,
      ),
    );
  }
}
