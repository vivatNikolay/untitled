
class AssignmentBean {
  String procedureName;
  DateTime begin;
  DateTime end;
  String medRoom;

  AssignmentBean(this.procedureName, this.begin, this.end, this.medRoom);

  @override
  String toString() {
    return 'AssignmentBean{procedureName: $procedureName, intervals: $begin - $end, medRoom: $medRoom}';
  }
}