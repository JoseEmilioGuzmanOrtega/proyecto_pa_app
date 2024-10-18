import 'package:hive/hive.dart';

part 'ProductoVentas.g.dart';

@HiveType(typeId: 3)
class ProductoVentas {
  @HiveField(0)
  late final String nombre;

  @HiveField(1)
  late final double precio;

  @HiveField(2)
  late final String fechaVenta;

  @HiveField(3)
  late final String imagen;

  @HiveField(4)
  late final int cantidad;

  ProductoVentas({
    required this.nombre,
    required this.precio,
    required this.fechaVenta,
    required this.imagen,
    required this.cantidad,
  });
}
