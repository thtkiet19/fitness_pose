import 'package:fitness_pose/Structures/progress.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class stat_running extends StatefulWidget {
  final List<Progress_val>? progress;
  stat_running({Key? key, this.progress}) : super(key: key);
  @override
  State<StatefulWidget> createState() => stat_runningState();
}

class stat_runningState extends State<stat_running> {
  final Color BarColor = const Color(0xff53fdd7);
  final double width = 7;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;
  List<int> recent = [0, 0, 0, 0, 0, 0, 0];
  List<String> date = ['', '', '', '', '', '', ''];

  List<int> getRecent() {
    List<int> recent = [0, 0, 0, 0, 0, 0, 0];
    if (widget.progress!.length >= 7) {
      for (int i = 0; i < 7; i--)
        recent[i] = widget.progress![6 - i].jogging!.ceil();
      return recent;
    } else {
      for (int i = widget.progress!.length; i > 0; i--)
        recent[7 - i] = widget.progress![i - 1].jogging!.ceil();
      return recent;
    }
  }

  List<String> getDate() {
    List<String> date = ['', '', '', '', '', '', ''];
    if (widget.progress!.length >= 7) {
      for (int i = 0; i < 7; i--) date[i] = widget.progress![6 - i].date!;
      return date;
    } else {
      for (int i = widget.progress!.length; i > 0; i--)
        date[7 - i] = widget.progress![i - 1].date!;
      return date;
    }
  }

  @override
  void initState() {
    super.initState();
    recent = getRecent();
    date = getDate();
    final barGroup1 = makeGroupData(0, recent[0].toDouble());
    final barGroup2 = makeGroupData(1, recent[1].toDouble());
    final barGroup3 = makeGroupData(2, recent[2].toDouble());
    final barGroup4 = makeGroupData(3, recent[3].toDouble());
    final barGroup5 = makeGroupData(4, recent[4].toDouble());
    final barGroup6 = makeGroupData(5, recent[5].toDouble());
    final barGroup7 = makeGroupData(6, recent[6].toDouble());

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
    ];

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 9 / 16,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: const Color(0xff2c4260),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.query_stats,
                    size: 40,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Text(
                    'Running',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  const Text(
                    'distance',
                    style: TextStyle(color: Color(0xff77839a), fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(
                height: 38,
              ),
              Expanded(
                child: BarChart(
                  BarChartData(
                    maxY: 2000,
                    titlesData: FlTitlesData(
                      show: true,
                      rightTitles: SideTitles(showTitles: false),
                      topTitles: SideTitles(showTitles: false),
                      bottomTitles: SideTitles(
                          rotateAngle: 90,
                          showTitles: true,
                          getTextStyles: (context, value) => const TextStyle(
                              color: Color(0xff7589a2),
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                          margin: 20,
                          getTitles: (double value) => date[value.toInt()]),
                      leftTitles: SideTitles(
                        showTitles: true,
                        getTextStyles: (context, value) => const TextStyle(
                            color: Color(0xff7589a2),
                            fontWeight: FontWeight.normal,
                            fontSize: 11),
                        margin: 8,
                        reservedSize: 28,
                        interval: 1,
                        getTitles: (value) {
                          if (value == 0) {
                            return '0';
                          } else if (value == 1000) {
                            return '1000';
                          } else if (value == 2000) {
                            return '2000';
                          } else {
                            return '';
                          }
                        },
                      ),
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    barGroups: showingBarGroups,
                    gridData: FlGridData(show: false),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(int x, double y) {
    return BarChartGroupData(barsSpace: 4, x: x, barRods: [
      BarChartRodData(
        y: y,
        colors: [BarColor],
        width: width,
      ), /*
      BarChartRodData(
        y: y2,
        colors: [leftBarColor],
        width: width,
      ),*/
    ]);
  }
}
