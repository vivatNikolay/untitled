import 'package:hive/hive.dart';

part 'date_time_interval.g.dart';

@HiveType(typeId:2)
class DateTimeInterval extends HiveObject {
  @HiveField(0)
  DateTime begin;
  @HiveField(1)
  DateTime end;
  @HiveField(2)
  String medRoom;

  DateTimeInterval({
    required this.begin,
    required this.end,
    required this.medRoom
  });

  factory DateTimeInterval.fromJson(Map<String, dynamic> json) {
    return DateTimeInterval(
        begin: parseFromLocaleDateTime(json["beginTime"]),
        end: parseFromLocaleDateTime(json["endTime"]),
        medRoom: json["medRoom"]
    );
  }
}

DateTime parseFromLocaleDateTime(String string) {
  int year = int.parse(string.substring(0, 4));
  int month = int.parse(string.substring(5, 7));
  int day = int.parse(string.substring(8, 10));
  int hour = int.parse(string.substring(11, 13));
  int minute = int.parse(string.substring(14, 16));

  return DateTime(year, month, day, hour, minute);
}