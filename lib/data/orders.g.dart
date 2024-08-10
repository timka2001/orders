// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderAdapter extends TypeAdapter<Order> {
  @override
  final int typeId = 2;

  @override
  Order read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Order(
      order_name: fields[0] as String,
      order_description: fields[1] as String,
      order_date: fields[2] as String,
      priority: fields[3] as bool,
      difficulty: fields[4] as String,
      tasks: fields[5] as Tasks?,
      client: fields[6] as Client?,
      isComplte: fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Order obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.order_name)
      ..writeByte(1)
      ..write(obj.order_description)
      ..writeByte(2)
      ..write(obj.order_date)
      ..writeByte(3)
      ..write(obj.priority)
      ..writeByte(4)
      ..write(obj.difficulty)
      ..writeByte(5)
      ..write(obj.tasks)
      ..writeByte(6)
      ..write(obj.client)
      ..writeByte(7)
      ..write(obj.isComplte);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
