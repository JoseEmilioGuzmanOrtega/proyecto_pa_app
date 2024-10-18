import 'package:hive/hive.dart';
import 'package:proyecto_pa_app/Modelo/ProductoExistencia.dart';

class ProductoExistenciaControlador {
  final Box<ProductoExistencia> _box =
      Hive.box<ProductoExistencia>('productos');

  List<ProductoExistencia> get productos => _box.values.toList();

  void agregarProducto(ProductoExistencia producto) {
    _box.add(producto);
  }

  void modificarProducto(int index, ProductoExistencia producto) {
    _box.putAt(index, producto);
  }

  void eliminarProducto(ProductoExistencia producto) {
    final int index = _box.values.toList().indexOf(producto);
    if (index != -1) {
      _box.deleteAt(index);
    }
  }
}
