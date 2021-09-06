import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:rive/rive.dart';
import 'package:fitness_pose/DB/db.dart';
import '../../../Structures/entry.dart';
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
  late String dropdownvalue = 'standard';

  getLocdata() async {
    print('get loc data');
    _locationData = await _location.getLocation();
    print('center $_locationData');
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
    List<Map<String, dynamic>> _map = await DB.query('system_pref');

    if (_map.isBlank == false) dropdownvalue = _map[0]['mapJson'];

    Mapjson = dropdownvalue;
    setState(() {});
  }

  void _addEntries(Entry en) async {
    DB.insertRun(Entry.table, en);
    _fetchEntries();
  }

  void initState() {
    super.initState();
    getLocdata();

    DB.init().then((value) => _fetchEntries());
  }

  List<String> mapStyle = ['standard', 'retro', 'dark', 'night'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Running"),
        actions: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Map style: '),
              DropdownButton(
                value: dropdownvalue,
                dropdownColor: Colors.teal,
                icon: Icon(Icons.keyboard_arrow_down),
                items: mapStyle.map((String items) {
                  return DropdownMenuItem(
                      value: items,
                      child: Text(
                        items,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ));
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalue = newValue!;
                    Mapjson = newValue;
                    DB.deleteAll('system_pref');
                    DB.insertMapstyle('system_pref', Mapjson);
                  });
                },
              ),
              SizedBox(
                width: 10,
              ),
            ],
          )
        ],
      ),
      body: ListView(
        reverse: false,
        children: _cards,
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.teal,
            onPressed: () {
              Navigator.pop(context);
              Get.offAllNamed('/loading');
            },
            child: Icon(Icons.arrow_back_ios),
          ),
          FloatingActionButton(
            backgroundColor: Colors.teal,
            onPressed: () => Get.to(() => MapPage(), arguments: {
              'MapJson': Mapjson,
              'lat': _locationData.latitude,
              'long': _locationData.longitude
            })!
                .then((value) => _addEntries(value)),
            child: Icon(Icons.add),
          ),
        ],
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
            ],
          ),
        ),
      ),
    );
  }
}
