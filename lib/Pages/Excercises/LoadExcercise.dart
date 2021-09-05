import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'Running/run_home.dart';

class LoadExcercise extends StatefulWidget {
  const LoadExcercise({Key? key}) : super(key: key);

  @override
  _LoadExcerciseState createState() => _LoadExcerciseState();
}

class _LoadExcerciseState extends State<LoadExcercise> {
  Map data = {};

  late VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
    data = data.isEmpty ? Get.arguments as Map : data;
    if (data['type'] == "Jogging") {
      Future.delayed(const Duration(milliseconds: 500),
          () => Get.offAll(() => RunningHomePage()));
    }
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
