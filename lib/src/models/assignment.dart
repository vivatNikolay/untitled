import 'date_time_interval.dart';

class Assignment {
  String procedureName;
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