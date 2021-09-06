import 'package:fitness_pose/Pages/Setting/edit_bmi/loadBMI.dart';
import 'package:fitness_pose/Pages/loading.dart';
import 'package:fitness_pose/Pages/Setting/setting.dart';
import 'package:get/get.dart';
import '../Pages/Excercises/LoadExcercise.dart';
import '../Pages/Excercises/Running/run_home.dart';
import 'Pages/homepage.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  runApp(Route());
}

class Route extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/loading',
      getPages: [
        GetPage(name: '/loading', page: () => loading()),
        GetPage(name: '/setting', page: () => setting()),
        GetPage(name: '/bmi', page: () => load_bmi()),
        GetPage(name: '/exercises', page: () => HomePage()),
        GetPage(name: '/individual', page: () => LoadExcercise()),
        GetPage(name: '/running', page: () => RunningHomePage())
      ],
    );
  }
}
