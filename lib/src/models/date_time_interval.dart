
class DateTimeInterval {
  DateTime begin;
  DateTime end;

  DateTimeInterval({
    required this.begin,
    required this.end
  });

  factory DateTimeInterval.fromJson(Map<String, dynamic> json) {
    return DateTimeInterval(
        begin: parseFromLocaleDateTime(json["beginTime"]),
        end: parseFromLocaleDateTime(json["endTime"])
    );
  }
}

DateTime parseFromLocaleDateTime(String string) {
  int year = int.parse(string.substring(0, 4));
  int month = int.parse(string.substring(5, 7));
  int day = int.parse(string.substring(8, 10));

  return DateTime(year, month, day);
}