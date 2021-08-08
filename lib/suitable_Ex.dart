import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                Navigator.pushNamed(context, '/individual',
                    arguments: {'type': _individual[index], 'bmi': widget.bmi});
              },
              title: Text(_excercises[index]),
              /*leading: CircleAvatar(
                backgroundImage:
                AssetImage('assets/' + _locations[index] + '.png'),
              ),*/
              hoverColor: Colors.grey[100],
              focusColor: Colors.lightBlue,
            ),
            elevation: 3,
          ),
        );
      },
      scrollDirection: Axis.vertical,
    );
  }
}
