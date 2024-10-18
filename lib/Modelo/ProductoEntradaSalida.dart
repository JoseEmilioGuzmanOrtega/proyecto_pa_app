import 'package:hive/hive.dart';

part 'ProductoEntradaSalida.g.dart';

@HiveType(typeId: 0)
class ProductoEntradaSalida {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String nombre;

  @HiveField(2)
  late String descripcion;

  @HiveField(3)
  late double precio;

  @HiveField(4)
  late int cantidad;

  @HiveField(5)
  final String imagen;

  ProductoEntradaSalida({
    required this.nombre,
    required this.descripcion,
    required this.precio,
    required this.cantidad,
    required this.imagen,
  }) {
    id = DateTime.now()
        .millisecondsSinceEpoch
        .toString(); // Generar ID único basado en el tiempo
  }
}
