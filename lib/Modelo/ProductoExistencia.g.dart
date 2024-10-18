// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProductoExistencia.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductoExistenciaAdapter extends TypeAdapter<ProductoExistencia> {
  @override
  final int typeId = 1;

  @override
  ProductoExistencia read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductoExistencia(
      nombre: fields[0] as String,
      descripcion: fields[1] as String,
      precio: fields[2] as double,
      cantidad: fields[3] as int,
      imagen: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ProductoExistencia obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.nombre)
      ..writeByte(1)
      ..write(obj.descripcion)
      ..writeByte(2)
      ..write(obj.precio)
      ..writeByte(3)
      ..write(obj.cantidad)
      ..writeByte(4)
      ..write(obj.imagen);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductoExistenciaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
