import 'package:proyecto_pa_app/Modelo/ProductoEntradaSalida.dart';

class ProductoEntradaSalidaControlador {
  List<ProductoEntradaSalida> productos = [
    ProductoEntradaSalida(
      nombre: 'Coca Cola 600 ml',
      descripcion: 'Bebida refrescante',
      precio: 22.00,
      cantidad: 20,
      imagen: 'assets/coca_600ml.jpeg',
    ),
    ProductoEntradaSalida(
      nombre: 'Coca Cola 355 ml',
      descripcion: 'Bebida refrescante',
      precio: 10.00,
      cantidad: 10,
      imagen: 'assets/coca_355ml.jpeg',
    ),
  ];

  void agregarProducto(ProductoEntradaSalida producto) {
    productos.add(producto);
  }

  void eliminarProducto(ProductoEntradaSalida producto) {
    productos.remove(producto);
  }
}
