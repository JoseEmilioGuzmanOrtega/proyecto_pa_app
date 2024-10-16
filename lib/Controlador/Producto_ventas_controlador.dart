import 'package:proyecto_pa_app/Modelo/ProductoVentas.dart';

class ProductoVentasControlador {
  List<ProductoVentas> productos = [
    ProductoVentas(
      nombre: 'Coca Cola 600 ml',
      precio: 22.0,
      fechaVenta: '2024-10-09',
      imagen: 'ruta/a/la/imagen/coca_cola.png',
      cantidad: 1,
    ),
    // Agrega más productos si es necesario
  ];

  List<ProductoVentas> buscarPorFecha(String fecha) {
    return productos.where((producto) => producto.fechaVenta == fecha).toList();
  }
}
