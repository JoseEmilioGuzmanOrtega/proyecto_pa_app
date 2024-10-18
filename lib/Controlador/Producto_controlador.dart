import 'package:proyecto_pa_app/Modelo/Producto.dart';
import 'package:proyecto_pa_app/Modelo/ProductoVentas.dart';
import 'package:proyecto_pa_app/Controlador/Producto_ventas_controlador.dart';

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
    Producto(
      nombre: 'Sabritas 170g',
      precio: 20.0,
      precioAnterior: 22.0,
      imagen: 'assets/Sabritas.jpg',
    ),
    Producto(
      nombre: 'Cloralex 950ml',
      precio: 22.0,
      precioAnterior: 24.0,
      imagen: 'assets/Cloralex.jpeg',
    ),
    Producto(
      nombre: 'Aceite Nutrioli 890ml',
      precio: 42.0,
      precioAnterior: 45.0,
      imagen: 'assets/Aceite.jpeg',
    ),
    Producto(
      nombre: 'Nescafe Decaf 170g',
      precio: 115.0,
      precioAnterior: 120.0,
      imagen: 'assets/Nescafe.jpeg',
    ),
    Producto(
      nombre: 'Leche Marsella 1L',
      precio: 19.0,
      precioAnterior: 22.0,
      imagen: 'assets/Leche.jpeg',
    ),
    Producto(
      nombre: 'Jabón Axion 400g',
      precio: 35.0,
      precioAnterior: 40.0,
      imagen: 'assets/Jabon.jpeg',
    ),
    Producto(
      nombre: 'Galletas Emperador 90g',
      precio: 23.0,
      precioAnterior: 25.0,
      imagen: 'assets/Galletas.jpeg',
    ),
  ];

  final ProductoVentasControlador ventasControlador =
      ProductoVentasControlador();

  // Método para realizar una venta de un producto
  bool realizarVenta(Producto producto, int cantidadVendida) {
    if (producto.cantidad >= cantidadVendida) {
      producto.cantidad -= cantidadVendida;

      // Registro de la venta en Hive
      final venta = ProductoVentas(
        nombre: producto.nombre,
        precio: producto.precio,
        fechaVenta: DateTime.now().toString(),
        imagen: producto.imagen,
        cantidad: cantidadVendida,
      );

      ventasControlador.agregarVenta(venta);
      return true;
    } else {
      return false; // No hay suficiente cantidad
    }
  }

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
