// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProveedorRegistro.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProveedorRegistroAdapter extends TypeAdapter<ProveedorRegistro> {
  @override
  final int typeId = 2;

  @override
  ProveedorRegistro read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProveedorRegistro(
      nombreEmpresa: fields[0] as String,
      ubicacion: fields[1] as String,
      contacto: fields[2] as String,
      telefono: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ProveedorRegistro obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.nombreEmpresa)
      ..writeByte(1)
      ..write(obj.ubicacion)
      ..writeByte(2)
      ..write(obj.contacto)
      ..writeByte(3)
      ..write(obj.telefono);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProveedorRegistroAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
