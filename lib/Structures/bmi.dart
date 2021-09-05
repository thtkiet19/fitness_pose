class Bmi_val {
  static String table = "bmi";
  // date STRING,
  //     meter INTEGER,
  // centi INTEGER,
  //     kg INTEGER
  int? id;
  String date;
  int meter;
  int centi;
  int kg;

  Bmi_val(
      {this.id,
      required this.date,
      required this.meter,
      required this.centi,
      required this.kg});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'date': date,
      'meter': meter,
      'centi': centi,
      'kg': kg
    };

    if (id != null) {
      map['id'] = id;
    }

    return map;
  }

  static Bmi_val fromMap(Map<String, dynamic> map) {
    return Bmi_val(
        id: map['id'],
        date: map['date'],
        meter: map['meter'],
        centi: map['centi'],
        kg: map['kg']);
  }
}
