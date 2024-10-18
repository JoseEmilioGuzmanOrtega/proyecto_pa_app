import 'package:hive/hive.dart';
import 'package:proyecto_pa_app/Modelo/ProductoVentas.dart';

class ProductoVentasControlador {
  final Box<ProductoVentas> _box = Hive.box<ProductoVentas>('ventas');

  // Obtiene la lista de ventas guardadas en Hive
  List<ProductoVentas> get ventas => _box.values.toList();

  // Agrega una nueva venta al box
  void agregarVenta(ProductoVentas venta) {
    _box.add(venta);
  }

  // Método para buscar ventas por fecha
  List<ProductoVentas> buscarPorFecha(String fecha) {
    return _box.values.where((venta) {
      return venta.fechaVenta.startsWith(fecha); // Compara las fechas
    }).toList();
  }

  // Método para limpiar el box (opcional, si quieres reiniciar las ventas)
  void limpiarVentas() {
    _box.clear();
  }
}
