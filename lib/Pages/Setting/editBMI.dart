import 'package:flutter/material.dart';
import '../../Data Input/bmi_values.dart';

class editBMI extends StatefulWidget {
  const editBMI({Key? key}) : super(key: key);

  @override
  _editBMIState createState() => _editBMIState();
  static _editBMIState? of(BuildContext context) =>
      context.findAncestorStateOfType<_editBMIState>();
}

class _editBMIState extends State<editBMI> {
  int? _meter;
  int? _centi;
  int? _kg;
  set meter(int value) => setState(() => _meter = value);
  set centi(int value) => setState(() => _centi = value);
  set kg(int value) => setState(() => _kg = value);

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
                      HeightInput(meter: _meter, centi: _centi, kg: _kg),
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
