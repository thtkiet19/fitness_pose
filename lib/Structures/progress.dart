class Progress_val {
  static String table = "progress";

  String? date;
  double? jogging;
  double? weigh;
  double? hiit;

  Progress_val({this.date, this.jogging, this.weigh, this.hiit});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'jogging': jogging,
      'weigh': weigh,
      'hiit': hiit
    };
    if (date != null) {
      map['date'] = date;
    }
    return map;
  }

  static Progress_val fromMap(Map<String, dynamic> map) {
    return Progress_val(
        date: map['date'],
        jogging: map['jogging'],
        weigh: map['weigh'],
        hiit: map['hiit']);
  }
}
