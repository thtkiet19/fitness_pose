import 'package:fitness_pose/Structures/bmi.dart';
import 'package:fitness_pose/Pages/homepage.dart';
import 'package:fitness_pose/Structures/progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../DB/db.dart';

class loading extends StatefulWidget {
  const loading({Key? key}) : super(key: key);

  @override
  _loadingState createState() => _loadingState();
}

class _loadingState extends State<loading> {
  late List<Bmi_val> _data;
  late List<Progress_val> _pro;

  void innitbmi() async {
    await DB.init();
    print('init');

    //get bmi values from data base
    List<Map<String, dynamic>> _results_bmi = await DB.query(Bmi_val.table);
    String today = DateFormat.yMMMMd('en_US').format(DateTime.now());
    List<Map<String, dynamic>> _progress = await DB.query('progress');
    if (_progress.isBlank == true) {
      DB.innnitProgressDate(today);
      List<Map<String, dynamic>> _progress = await DB.query('progress');
    }

    if (today != _progress.last['date']) {
      DB.innnitProgressDate(today);
    }
    DB.loadProgress(today);
    _progress = await DB.query('progress');
    print(_progress);
    // _progress.map((item) => Bmi_val.fromMap(item)).toList();
    print('$_results_bmi');

    //check if there are any bmi results yet
    if (_results_bmi.isBlank == true) {
      Get.offNamed('/bmi');
    } else {
      _data = _results_bmi.map((item) => Bmi_val.fromMap(item)).toList();
      _pro = _progress.map((item) => Progress_val.fromMap(item)).toList();
      Bmi_val init = _data[_data.length - 1];
      Get.off(() => HomePage(),
          arguments: {'bmi': init, 'progress': _pro[_pro.length - 1]});
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () => innitbmi());
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
