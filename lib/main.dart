import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:proyecto_pa_app/Modelo/ProductoEntradaSalida.dart';
import 'package:proyecto_pa_app/Modelo/ProductoExistencia.dart';
import 'package:proyecto_pa_app/Modelo/ProductoVentas.dart';
import 'package:proyecto_pa_app/Modelo/ProveedorRegistro.dart';
import 'Vistas/Login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ProductoExistenciaAdapter());
  Hive.registerAdapter(ProductoEntradaSalidaAdapter());
  Hive.registerAdapter(ProveedorRegistroAdapter());
  Hive.registerAdapter(ProductoVentasAdapter());
  await Hive.openBox('usuarios');
  await Hive.openBox('sesion');
  await Hive.openBox<ProductoExistencia>('productos');
  await Hive.openBox<ProductoEntradaSalida>('productosEntradaSalida');
  await Hive.openBox<ProveedorRegistro>('proveedores');
  await Hive.openBox<ProductoVentas>('ventas');
  runApp(MiApp());
}

class MiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}
