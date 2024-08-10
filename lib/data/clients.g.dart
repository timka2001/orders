// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clients.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClientAdapter extends TypeAdapter<Client> {
  @override
  final int typeId = 1;

  @override
  Client read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Client(
      client_name: fields[0] as String,
      client_description: fields[1] as String,
      phone: fields[2] as String,
      mail: fields[3] as String,
      constants: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Client obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.client_name)
      ..writeByte(1)
      ..write(obj.client_description)
      ..writeByte(2)
      ..write(obj.phone)
      ..writeByte(3)
      ..write(obj.mail)
      ..writeByte(4)
      ..write(obj.constants);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClientAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
