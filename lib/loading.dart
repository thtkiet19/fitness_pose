import 'package:fitness_pose/Data%20Input/bmi.dart';
import 'package:fitness_pose/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../DB/db.dart';

class loading extends StatefulWidget {
  const loading({Key? key}) : super(key: key);

  @override
  _loadingState createState() => _loadingState();
}

class _loadingState extends State<loading> {
  late List<Bmi_val> _data;

  void innitbmi() async {
    List<Map<String, dynamic>> _results = await DB.query(Bmi_val.table);
    print('$_results');
    _data = _results.map((item) => Bmi_val.fromMap(item)).toList();
    Bmi_val init = _data[_data.length - 1];
    Get.off(() => HomePage(), arguments: {'bmi': init});
  }

  @override
  void initState() {
    super.initState();
    DB.init();
    print('init');
    Future.delayed(const Duration(milliseconds: 500), () => innitbmi());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SpinKitCubeGrid(
        color: Colors.blue[300],
        size: 100.0,
      ),
    ));
  }
}
