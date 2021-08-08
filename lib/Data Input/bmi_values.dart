import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class HeightInput extends StatefulWidget {
  HeightInput({Key? key, int? meter, int? centi, int? kg}) : super(key: key);
  int meter = 1;
  int centi = 60;
  int kg = 60;
  @override
  _HeightInputState createState() => _HeightInputState();
}

class _HeightInputState extends State<HeightInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text('Meter'),
                  NumberPicker(
                      axis: Axis.vertical,
                      textStyle: TextStyle(color: Colors.white),
                      value: widget.meter,
                      selectedTextStyle:
                          TextStyle(color: Colors.teal, fontSize: 30),
                      minValue: 0,
                      maxValue: 2,
                      decoration: BoxDecoration(
                        border: Border(top: BorderSide(), bottom: BorderSide()),
                      ),
                      step: 1,
                      haptics: false,
                      onChanged: (value) {
                        setState(() => widget.meter = value);
                        //Welcome.of(context)!.meter = value;
                      }
                      //setState(() => widget.meter = value),
                      ),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 18,
              ),
              Column(
                children: [
                  Text('Centimeter'),
                  NumberPicker(
                    axis: Axis.vertical,
                    textStyle: TextStyle(color: Colors.white),
                    value: widget.centi,
                    selectedTextStyle:
                        TextStyle(color: Colors.teal, fontSize: 30),
                    minValue: 0,
                    maxValue: 99,
                    decoration: BoxDecoration(
                      border: Border(top: BorderSide(), bottom: BorderSide()),
                    ),
                    step: 1,
                    haptics: false,
                    onChanged: (value) {
                      setState(() => widget.centi = value);
                    },
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              Text('Kilogram'),
              NumberPicker(
                axis: Axis.horizontal,
                textStyle: TextStyle(color: Colors.white),
                value: widget.kg,
                selectedTextStyle: TextStyle(color: Colors.teal, fontSize: 30),
                minValue: 10,
                maxValue: 299,
                decoration: BoxDecoration(
                  border: Border(left: BorderSide(), right: BorderSide()),
                ),
                step: 1,
                haptics: false,
                onChanged: (value) => setState(() => widget.kg = value),
              ),
            ],
          ),
          ElevatedButton(
              onPressed: () {
                print(widget.kg);
                Navigator.pushReplacementNamed(context, '/excercises',
                    arguments: {
                      'meter': widget.meter,
                      'centi': widget.centi,
                      'kg': widget.kg
                    });
              },
              child: Icon(Icons.alt_route)),
        ],
      ),
    );
  }
}
