import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'entry.dart';
import 'package:get/get.dart';

class MapPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Set<Polyline> polyline = {};
  Location _location = Location();
  late GoogleMapController _mapController;
  bool started = false;

  // LatLng _center = const LatLng(15.394813, 108.811698);
  LatLng _center = LatLng(Get.arguments['lat'], Get.arguments['long']);
  List<LatLng> route = [];

  double _dist = 0;
  late String _displayTime;
  late int _time;
  late int _lastTime;
  double _speed = 0;
  double _avgSpeed = 0;
  int _speedCounter = 0;
  String mapJson = Get.arguments['MapJson'];
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();

  @override
  void initState() {
    super.initState();
    print('$mapJson');
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  Future<String> getJsonFile(String path) async {
    return await rootBundle.loadString(path);
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    _mapController = controller;
    print(getJsonFile("assets/MapJson/$mapJson.json"));
    String json = await getJsonFile("assets/MapJson/$mapJson.json");
    // print('JSON PRINTING \n $json');
    _mapController.setMapStyle(json);
    double appendDist;
    _location.onLocationChanged.listen((LocationData currentLocation) {
      LatLng loc =
          LatLng(currentLocation.latitude!, currentLocation.longitude!);
      print("$currentLocation");
      _mapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: loc, zoom: 17)));

      if (route.length > 0) {
        appendDist = Geolocator.distanceBetween(route.last.latitude,
            route.last.longitude, loc.latitude, loc.longitude);
        int timeDuration = (_time - _lastTime);
        if (timeDuration != 0) _dist = _dist + appendDist;

        if (timeDuration != 0) {
          _speed = (appendDist / (timeDuration / 100)) * 3.6;
          if (_speed != 0) {
            _avgSpeed = _avgSpeed + _speed;
            _speedCounter++;
          }
        }
      }
      _lastTime = _time;
      route.add(loc);
      if (started == true)
        polyline.add(Polyline(
            polylineId: PolylineId(currentLocation.toString()),
            visible: true,
            points: route,
            width: 5,
            startCap: Cap.roundCap,
            endCap: Cap.roundCap,
            color: Colors.deepOrange));

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Container(
          child: GoogleMap(
        polylines: polyline,
        zoomControlsEnabled: false,
        onMapCreated: _onMapCreated,
        myLocationEnabled: true,
        initialCameraPosition: CameraPosition(target: _center, zoom: 15),
      )),
      Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(10, 0, 10, 40),
            height: 140,
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text("SPEED (KM/H)",
                            style: GoogleFonts.montserrat(
                                fontSize: 10, fontWeight: FontWeight.w300)),
                        Text(_speed.toStringAsFixed(2),
                            style: GoogleFonts.montserrat(
                                fontSize: 30, fontWeight: FontWeight.w300))
                      ],
                    ),
                    Column(
                      children: [
                        Text("TIME",
                            style: GoogleFonts.montserrat(
                                fontSize: 10, fontWeight: FontWeight.w300)),
                        StreamBuilder<int>(
                          stream: _stopWatchTimer.rawTime,
                          initialData: 0,
                          builder: (context, snap) {
                            _time = snap.data!;
                            _displayTime =
                                StopWatchTimer.getDisplayTimeHours(_time) +
                                    ":" +
                                    StopWatchTimer.getDisplayTimeMinute(_time) +
                                    ":" +
                                    StopWatchTimer.getDisplayTimeSecond(_time);
                            return Text(_displayTime,
                                style: GoogleFonts.montserrat(
                                    fontSize: 30, fontWeight: FontWeight.w300));
                          },
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text("DISTANCE (KM)",
                            style: GoogleFonts.montserrat(
                                fontSize: 10, fontWeight: FontWeight.w300)),
                        Text((_dist / 1000).toStringAsFixed(2),
                            style: GoogleFonts.montserrat(
                                fontSize: 30, fontWeight: FontWeight.w300))
                      ],
                    )
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.play_circle_outline_rounded,
                        size: 50,
                        color: Colors.teal,
                      ),
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        _stopWatchTimer.onExecute.add(StopWatchExecute.start);
                        started = true;
                      },
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.stop_circle_outlined,
                        size: 50,
                        color: Colors.redAccent,
                      ),
                      padding: EdgeInsets.all(0),
                      onPressed: () async {
                        if (started == true) {
                          print('run');
                          Entry en = Entry(
                              date: DateFormat.yMMMMd('en_US')
                                  .format(DateTime.now()),
                              duration: _displayTime,
                              speed: _speedCounter == 0
                                  ? 0
                                  : _avgSpeed / _speedCounter,
                              distance: _dist);
                          Navigator.pop(context, en);
                        } else {
                          // Get.offNamed('\running');
                          Navigator.pop(context);
                          print('did not run');
                        }
                      },
                    ),
                  ],
                )
              ],
            ),
          ))
    ]));
  }
}
