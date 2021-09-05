import 'package:fitness_pose/Pages/Setting/edit_bmi/loadBMI.dart';
import 'package:fitness_pose/Pages/Setting/edit_goal/load_goal.dart';
import 'package:fitness_pose/Pages/Setting/stat/load_stat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class setting extends StatelessWidget {
  const setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Card(
            child: ListTile(
                onTap: () {
                  Get.to(() => load_bmi());
                },
                title: Text('Edit BMI'),
                trailing: Icon(Icons.edit)),
          ),
          Card(
            child: ListTile(
                onTap: () {
                  Get.to(() => loading_stat());
                },
                title: Text('View Stat'),
                trailing: Icon(Icons.stacked_line_chart)),

            /* ListTile(
                  onTap: () {},
                  title: Text('Change map view to dark'),
                  trailing: Icon(Icons.map_sharp)),
              ListTile(
                  onTap: () {},
                  title: Text('Change map view to night'),
                  trailing: Icon(Icons.map_sharp)),,*/
          ),
          Card(
            child: ListTile(
                onTap: () {
                  Get.to(() => loading_goals());
                },
                title: Text('Edit yours goals'),
                trailing: Icon(Icons.style)),
          ),
        ],
      ),
      backgroundColor: Colors.blueGrey,
    );
  }
}
