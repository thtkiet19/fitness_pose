import 'package:camera/camera.dart';
import 'package:fitness_pose/loading.dart';
import 'package:get/get.dart';
// import 'package:fitness_pose/temp.dart';
import 'Excercises/LoadExcercise.dart';
import 'Excercises/Running/run_home.dart';
import 'homepage.dart';
import 'editBMI.dart';
import 'camera_ui.dart';
import 'package:flutter/material.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    logError(e.code, e.description);
  }
  runApp(Route());
}

class Route extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/loading',
      getPages: [
        GetPage(name: '/loading', page: () => loading()),
        GetPage(name: '/bmi', page: () => editBMI()),
        GetPage(name: '/exercises', page: () => HomePage()),
        GetPage(name: '/individual', page: () => LoadExcercise()),
        GetPage(name: '/running', page: () => RunningHomePage())
      ],
    );
  }
}
