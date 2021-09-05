import 'package:fitness_pose/Pages/Setting/stat/stat.dart';
import 'package:fitness_pose/Structures/bmi.dart';
import 'package:fitness_pose/Pages/homepage.dart';
import 'package:fitness_pose/Structures/progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../DB/db.dart';

class loading_stat extends StatefulWidget {
  const loading_stat({Key? key}) : super(key: key);

  @override
  _loading_statState createState() => _loading_statState();
}

class _loading_statState extends State<loading_stat> {
  late final List<Progress_val> _progress;

  Future<void> innitdb() async {
    await DB.init();
    print('init in stat');
    //get bmi values from data base
    List<Map<String, dynamic>> _pro = await DB.selectWeekRun();
    _progress = _pro.map((item) => Progress_val.fromMap(item)).toList();
    Get.off(() => stat(
          progress: _progress,
        ));
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 200), () => innitdb());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SpinKitCircle(
        color: Colors.blue[300],
        size: 100.0,
      ),
    ));
  }
}
