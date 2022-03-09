import 'date_time_interval.dart';
import 'package:hive/hive.dart';

part 'assignment.g.dart';

@HiveType(typeId:1)
class Assignment extends HiveObject{
  @HiveField(0)
  String procedureName;
  @HiveField(1)
  List<DateTimeInterval> intervals;

  Assignment({
    required this.procedureName,
    required this.intervals
  });

  factory Assignment.fromJson(Map<String, dynamic> json) {
    List<DateTimeInterval> itemsList =
      (List.from(json["intervals"])).map(
              (i) => DateTimeInterval.fromJson(i)
      ).toList();
    return Assignment(
        procedureName: json["procedureName"],
        intervals: itemsList
    );
  }

  @override
  String toString() {
    return 'Assignment{procedureName: $procedureName, intervals: $intervals}';
  }
}