class Producto {
  String nombre;
  double precio;
  double precioAnterior;
  String imagen;
  int cantidad;

  Producto({
    required this.nombre,
    required this.precio,
    required this.precioAnterior,
    required this.imagen,
    this.cantidad = 0,
  });
}
