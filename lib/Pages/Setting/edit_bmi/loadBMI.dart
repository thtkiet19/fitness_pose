import 'package:fitness_pose/Pages/Setting/edit_bmi/editBMI.dart';
import 'package:fitness_pose/Structures/bmi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../../DB/db.dart';

class load_bmi extends StatefulWidget {
  const load_bmi({Key? key}) : super(key: key);

  @override
  _load_bmiState createState() => _load_bmiState();
}

class _load_bmiState extends State<load_bmi> {
  late final Bmi_val bmi_val;

  Future<void> innitdb() async {
    await DB.init();

    List<Map<String, dynamic>> _bmi = await DB.query('bmi');
    bmi_val = _bmi.map((item) => Bmi_val.fromMap(item)).toList().last;
    Get.off(() => editBMI(bmi: bmi_val));
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
