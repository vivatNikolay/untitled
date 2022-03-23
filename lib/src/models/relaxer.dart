import 'package:hive/hive.dart';

part 'relaxer.g.dart';

@HiveType(typeId:0)
class Relaxer extends HiveObject{
  @HiveField(0)
  String email;
  @HiveField(1)
  String name;
  @HiveField(2)
  String surname;
  @HiveField(3)
  bool sex;
  @HiveField(4)
  bool isActive;
  @HiveField(5)
  String sanatorium;

  Relaxer({
    required this.email,
    required this.name,
    required this.surname,
    required this.sex,
    required this.isActive,
    required this.sanatorium,
  });

  factory Relaxer.fromJson(Map<String, dynamic> json) {
    return Relaxer(
    email : json["email"],
    name : json["name"],
    surname : json["surname"],
    sex : json["sex"],
    isActive: false,
    sanatorium: "",
    );
  }

  @override
  bool operator ==(Object other) =>
      other is Relaxer &&
              email == other.email &&
              sanatorium == other.sanatorium;

}