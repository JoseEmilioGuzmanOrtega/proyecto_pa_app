import 'package:proyecto_pa_app/Modelo/Producto.dart';

class Producto_controlador {
  List<Producto> productos = [
    Producto(
      nombre: 'Coca Cola 600ml',
      precio: 22.0,
      precioAnterior: 25.0,
      imagen: 'assets/coca_600ml.jpeg',
    ),
    Producto(
      nombre: 'Coca Cola 355ml',
      precio: 10.0,
      precioAnterior: 12.0,
      imagen: 'assets/coca_355ml.jpeg',
    ),
    Producto(
      nombre: 'Coca Cola 2L',
      precio: 31.0,
      precioAnterior: 35.0,
      imagen: 'assets/coca_2l.jpeg',
    ),
  ];

  double calcularTotal() {
    double total = 0.0;
    for (var producto in productos) {
      total += producto.precio * producto.cantidad;
    }
    return total;
  }

  List<Producto> buscarProducto(String query) {
    return productos
        .where((producto) =>
            producto.nombre.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  void incrementarCantidad(Producto producto) {
    producto.cantidad++;
  }

  void decrementarCantidad(Producto producto) {
    if (producto.cantidad > 0) producto.cantidad--;
  }
}
