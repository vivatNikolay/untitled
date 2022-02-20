
class AssignmentBean {
  String procedureName;
  DateTime begin;
  DateTime end;

  AssignmentBean(this.procedureName, this.begin, this.end);

  @override
  String toString() {
    return 'AssignmentBean{procedureName: $procedureName, intervals: $begin - $end}';
  }
}