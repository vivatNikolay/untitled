

class Relaxer {
  String phone;
  String name;
  String surname;
  bool gender;

  Relaxer({
    required this.phone,
    required this.name,
    required this.surname,
    required this.gender
  });

  factory Relaxer.fromJson(Map<String, dynamic> json) {
    return Relaxer(
    phone : json["phone"],
    name : json["name"],
    surname : json["surname"],
    gender : json["gender"]
    );
  }
}


class Assignment {
  String procedureName;
  DateTime begin;
  DateTime end;

  Assignment({
    required this.procedureName,
    required this.begin,
    required this.end
  });

  factory Assignment.fromJson(Map<String, dynamic> json) {
    return Assignment(
        procedureName: json["procedureName"],
        begin: json["begin"],
        end: json["end"]
    );
  }

  @override
  String toString() {
    return 'Assignment{procedureName: $procedureName, begin: $begin, end: $end}';
  }
}