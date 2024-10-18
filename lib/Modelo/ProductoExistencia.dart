import 'package:hive/hive.dart';

part 'ProductoExistencia.g.dart';

@HiveType(typeId: 1)
class ProductoExistencia {
  @HiveField(0)
  late final String nombre;

  @HiveField(1)
  late final String descripcion;

  @HiveField(2)
  late final double precio;

  @HiveField(3)
  late final int cantidad;

  @HiveField(4)
  late final String imagen;

  ProductoExistencia({
    required this.nombre,
    required this.descripcion,
    required this.precio,
    required this.cantidad,
    required this.imagen,
  });

  get id => null;
}
