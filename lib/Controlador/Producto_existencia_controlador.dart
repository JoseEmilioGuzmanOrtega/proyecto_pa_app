import 'package:proyecto_pa_app/Modelo/ProductoExistencia.dart';

class ProductoExistenciaControlador {
  List<ProductoExistencia> productos = [
    ProductoExistencia(
      nombre: 'Coca Cola 600 ml',
      descripcion: 'Bebida refrescante',
      precio: 22.00,
      cantidad: 20,
      imagen: 'assets/coca_600ml.jpeg',
    ),
    ProductoExistencia(
      nombre: 'Coca Cola 355 ml',
      descripcion: 'Bebida refrecante',
      precio: 10.00,
      cantidad: 10,
      imagen: 'aseets/coca_355ml.jpeg',
    ),
  ];

  void agregarProducto(ProductoExistencia producto) {
    productos.add(producto);
  }

  void eliminarProducto(ProductoExistencia producto) {
    productos.remove(producto);
  }

  void modificarProducto(int index, ProductoExistencia producto) {
    productos[index] = producto;
  }

  registrarUsuario() {}
}
