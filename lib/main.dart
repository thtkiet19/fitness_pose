import 'package:camera/camera.dart';
import 'package:fitness_pose/Pages/loading.dart';
import 'package:fitness_pose/Pages/Setting/setting.dart';
import 'package:get/get.dart';
// import 'package:fitness_pose/temp.dart';
import '../Pages/Excercises/LoadExcercise.dart';
import '../Pages/Excercises/Running/run_home.dart';
import 'Pages/homepage.dart';
import 'Pages/Setting/editBMI.dart';
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
        GetPage(name: '/setting', page: () => setting()),
        GetPage(name: '/bmi', page: () => editBMI()),
        GetPage(name: '/exercises', page: () => HomePage()),
        GetPage(name: '/individual', page: () => LoadExcercise()),
        GetPage(name: '/running', page: () => RunningHomePage())
      ],
    );
  }
}
