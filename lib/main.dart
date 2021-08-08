import 'package:camera/camera.dart';
import 'package:fitness_pose/loading.dart';
// import 'package:fitness_pose/temp.dart';
import 'Excercises/LoadExcercise.dart';
import 'homepage.dart';
import 'wellcome.dart';
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
    return MaterialApp(
      initialRoute: '/excercises',
      routes: {
        '/loading': (context) => loading(),
        '/bmi': (context) => editBMI(),
        '/excercises': (context) => HomePage(),
        '/individual': (context) => LoadExcercise()
      },
    );
  }
}
