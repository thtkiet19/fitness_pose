import 'package:fitness_pose/Structures/bmi.dart';
import 'package:flutter/material.dart';
import '../../../Data Input/bmi_values.dart';

class editBMI extends StatefulWidget {
  final Bmi_val bmi;
  const editBMI({Key? key, required this.bmi}) : super(key: key);

  @override
  _editBMIState createState() => _editBMIState();
  static _editBMIState? of(BuildContext context) =>
      context.findAncestorStateOfType<_editBMIState>();
}

class _editBMIState extends State<editBMI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Welcome'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        color: Colors.blueGrey,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Enter your height and weight'),
                /*SizedBox(
                  height: MediaQuery.of(context).size.height / 8,
                ),*/
                Container(
                  height: MediaQuery.of(context).size.height / 1.2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BmiInput(
                          meter: widget.bmi.meter,
                          centi: widget.bmi.centi,
                          kg: widget.bmi.kg),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 35,
                        // color: Colors.blue,
                      ),
                    ],
                  ),
                  // color: Colors.purple,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
