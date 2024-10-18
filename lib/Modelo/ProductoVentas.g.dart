// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProductoVentas.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductoVentasAdapter extends TypeAdapter<ProductoVentas> {
  @override
  final int typeId = 3;

  @override
  ProductoVentas read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductoVentas(
      nombre: fields[0] as String,
      precio: fields[1] as double,
      fechaVenta: fields[2] as String,
      imagen: fields[3] as String,
      cantidad: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ProductoVentas obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.nombre)
      ..writeByte(1)
      ..write(obj.precio)
      ..writeByte(2)
      ..write(obj.fechaVenta)
      ..writeByte(3)
      ..write(obj.imagen)
      ..writeByte(4)
      ..write(obj.cantidad);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductoVentasAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
