
class Relaxer {
  String phone;
  String name;
  String surname;
  bool sex;

  Relaxer({
    required this.phone,
    required this.name,
    required this.surname,
    required this.sex
  });

  factory Relaxer.fromJson(Map<String, dynamic> json) {
    return Relaxer(
    phone : json["phone"],
    name : json["name"],
    surname : json["surname"],
    sex : json["sex"]
    );
  }
}