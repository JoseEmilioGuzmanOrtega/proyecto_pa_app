import 'package:hive/hive.dart';
import 'package:proyecto_pa_app/Modelo/ProveedorRegistro.dart';

class Proveedor_controlador {
  final Box<ProveedorRegistro> _box =
      Hive.box<ProveedorRegistro>('proveedores');

  List<ProveedorRegistro> get proveedores => _box.values.toList();

  void agregarProveedor(ProveedorRegistro proveedor) {
    _box.add(proveedor);
  }

  void modificarProveedor(int index, ProveedorRegistro proveedor) {
    _box.putAt(index, proveedor);
  }

  void eliminarProveedor(ProveedorRegistro proveedor) {
    final int index = _box.values.toList().indexOf(proveedor);
    if (index != -1) {
      _box.deleteAt(index);
    }
  }
}
