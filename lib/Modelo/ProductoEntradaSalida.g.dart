// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProductoEntradaSalida.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductoEntradaSalidaAdapter extends TypeAdapter<ProductoEntradaSalida> {
  @override
  final int typeId = 0;

  @override
  ProductoEntradaSalida read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductoEntradaSalida(
      nombre: fields[1] as String,
      descripcion: fields[2] as String,
      precio: fields[3] as double,
      cantidad: fields[4] as int,
      imagen: fields[5] as String,
    )..id = fields[0] as String;
  }

  @override
  void write(BinaryWriter writer, ProductoEntradaSalida obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nombre)
      ..writeByte(2)
      ..write(obj.descripcion)
      ..writeByte(3)
      ..write(obj.precio)
      ..writeByte(4)
      ..write(obj.cantidad)
      ..writeByte(5)
      ..write(obj.imagen);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductoEntradaSalidaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
