import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:rive/rive.dart';
import '../../DB/db.dart';
import 'entry.dart';
import 'maps.dart';
import 'entry_card.dart';

class RunningHomePage extends StatefulWidget {
  RunningHomePage({Key? key}) : super(key: key);

  @override
  _RunningHomePageState createState() => _RunningHomePageState();
}

class _RunningHomePageState extends State<RunningHomePage> {
  late List<Entry> _data;
  List<EntryCard> _cards = [];
  String Mapjson = 'standard';
  Location _location = Location();
  late LocationData _locationData;

  getLocdata() async {
    print('get loc data');
    _locationData = await _location.getLocation();
    print('center $_locationData');
  }

  void initState() {
    super.initState();
    getLocdata();

    DB.init().then((value) => _fetchEntries());
  }

  void _fetchEntries() async {
    _cards = [];
    List<Map<String, dynamic>> _results = await DB.query(Entry.table);
    print('$_results');
    _data = _results.map((item) => Entry.fromMap(item)).toList();
    for (int index = 0; index < _data.length; index++) {
      _cards.add(EntryCard(entry: _data[_data.length - 1 - index]));
    }
    // _data.forEach((element) => _cards.add(EntryCard(entry: element)));
    setState(() {});
  }

  void _addEntries(Entry en) async {
    DB.insertRun(Entry.table, en);
    _fetchEntries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Running"),
      ),
      body: ListView(
        reverse: false,
        children: _cards,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () => Get.to(() => MapPage(), arguments: {
          'MapJson': Mapjson,
          'lat': _locationData.latitude,
          'long': _locationData.longitude
        })!
            .then((value) => _addEntries(value)),
        child: Icon(Icons.add),
      ),
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 50, 2, 2),
          child: Column(
            children: [
              Card(
                  child: ListTile(
                      onTap: () {
                        DB.deleteAll('entries');
                        Get.offAllNamed('\loading');
                      },
                      title: Text('Delete all running history'),
                      trailing: Icon(Icons.delete_sharp))),
              Card(
                  child: Column(
                children: [
                  ListTile(
                      onTap: () {
                        Mapjson = 'standard';
                      },
                      title: Text('Change map view to standard'),
                      trailing: Icon(Icons.map_sharp)),
                  ListTile(
                      onTap: () {
                        Mapjson = 'retro';
                        print('$Mapjson');
                      },
                      title: Text('Change map view to classic'),
                      trailing: Icon(Icons.map_sharp)),
                  ListTile(
                      onTap: () {
                        Mapjson = 'dark';
                      },
                      title: Text('Change map view to dark'),
                      trailing: Icon(Icons.map_sharp)),
                  ListTile(
                      onTap: () {
                        Mapjson = 'night';
                      },
                      title: Text('Change map view to night'),
                      trailing: Icon(Icons.map_sharp)),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
