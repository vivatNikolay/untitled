// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date_time_interval.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DateTimeIntervalAdapter extends TypeAdapter<DateTimeInterval> {
  @override
  final int typeId = 2;

  @override
  DateTimeInterval read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DateTimeInterval(
      begin: fields[0] as DateTime,
      end: fields[1] as DateTime,
      medRoom: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DateTimeInterval obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.begin)
      ..writeByte(1)
      ..write(obj.end)
      ..writeByte(2)
      ..write(obj.medRoom);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DateTimeIntervalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
