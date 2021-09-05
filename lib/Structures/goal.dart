class Goal_val {
  static String table = "goals";
  int? id;
  String? date;
  double? jogging_goal;
  double? weigh_goal;
  double? hiit_goal;

  Goal_val(
      {this.id, this.date, this.jogging_goal, this.weigh_goal, this.hiit_goal});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'date': date,
      'jogging_goal': jogging_goal,
      'weigh_goal': weigh_goal,
      'hiit_goal': hiit_goal
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  static Goal_val fromMap(Map<String, dynamic> map) {
    return Goal_val(
        id: map['id'],
        date: map['date'],
        jogging_goal: map['jogging_goal'],
        weigh_goal: map['weigh_goal'],
        hiit_goal: map['hiit_goal']);
  }
}
