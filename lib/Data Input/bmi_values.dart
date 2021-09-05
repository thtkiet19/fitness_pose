import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';
import '../../DB/db.dart';
import '../Structures/bmi.dart';

class BmiInput extends StatefulWidget {
  late final int meter;
  late final int centi;
  late final int kg;
  BmiInput(
      {Key? key, required this.meter, required this.centi, required this.kg})
      : super(key: key);

  @override
  _BmiInputState createState() => _BmiInputState();
}

class _BmiInputState extends State<BmiInput> {
  int meter = 1;
  int centi = 60;
  int kg = 60;

  innit() {
    meter = widget.meter;
    centi = widget.centi;
    kg = widget.kg;
  }

  @override
  void initState() {
    super.initState();
    innit();
  }

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
                      value: meter,
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
                        setState(() => meter = value);
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
                    value: centi,
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
                      setState(() => centi = value);
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
                value: kg,
                selectedTextStyle: TextStyle(color: Colors.teal, fontSize: 30),
                minValue: 10,
                maxValue: 299,
                decoration: BoxDecoration(
                  border: Border(left: BorderSide(), right: BorderSide()),
                ),
                step: 1,
                haptics: false,
                onChanged: (value) => setState(() => kg = value),
              ),
            ],
          ),
          ElevatedButton(
              onPressed: () async {
                DB.insertBmi(
                    Bmi_val.table,
                    Bmi_val(
                        date: DateFormat.yMMMMd('en_US').format(DateTime.now()),
                        meter: meter,
                        centi: centi,
                        kg: kg));
                List<Map<String, dynamic>> _results =
                    await DB.query(Bmi_val.table);
                print('$_results');
                Get.offAllNamed('/loading');
              },
              child: Icon(Icons.alt_route)),
        ],
      ),
    );
  }
}
