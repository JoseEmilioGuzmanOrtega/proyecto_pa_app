import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:proyecto_pa_app/Modelo/ProductoEntradaSalida.dart';

class ProductoEntradaSalidaControlador extends ChangeNotifier {
  final Box<ProductoEntradaSalida> _box =
      Hive.box<ProductoEntradaSalida>('productosEntradaSalida');

  // Obtiene la lista de productos del box
  List<ProductoEntradaSalida> get productos => _box.values.toList();

  // Agrega un producto nuevo al box
  void agregarProducto(ProductoEntradaSalida producto) {
    _box.add(producto);
  }
}
