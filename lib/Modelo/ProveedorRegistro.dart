import 'package:hive/hive.dart';

part 'ProveedorRegistro.g.dart';

@HiveType(typeId: 2)
class ProveedorRegistro {
  @HiveField(0)
  late final String nombreEmpresa;

  @HiveField(1)
  late final String ubicacion;

  @HiveField(2)
  late final String contacto;

  @HiveField(3)
  late final String telefono;

  ProveedorRegistro({
    required this.nombreEmpresa,
    required this.ubicacion,
    required this.contacto,
    required this.telefono,
  });
}
