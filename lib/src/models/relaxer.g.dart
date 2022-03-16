// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relaxer.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RelaxerAdapter extends TypeAdapter<Relaxer> {
  @override
  final int typeId = 0;

  @override
  Relaxer read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Relaxer(
      email: fields[0] as String,
      name: fields[1] as String,
      surname: fields[2] as String,
      sex: fields[3] as bool,
      isActive: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Relaxer obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.email)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.surname)
      ..writeByte(3)
      ..write(obj.sex)
      ..writeByte(4)
      ..write(obj.isActive);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RelaxerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
