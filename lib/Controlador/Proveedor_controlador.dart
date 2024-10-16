import 'package:proyecto_pa_app/Modelo/ProveedorRegistro.dart';

class Proveedor_controlador {
  List<ProveedorRegistro> proveedores = [
    ProveedorRegistro(
      nombreEmpresa: 'Gamesa',
      ubicacion: 'Tampico, Tamaulipas',
      contacto: 'Pablo Mendez',
      telefono: '8332857463',
    ),
    ProveedorRegistro(
      nombreEmpresa: 'Sabritas',
      ubicacion: 'Monterrey, Nuevo León',
      contacto: 'Monica Perez',
      telefono: '8332546372',
    ),
  ];

  void agregarProveedor(ProveedorRegistro proveedor) {
    proveedores.add(proveedor);
  }

  void eliminarProveedor(ProveedorRegistro proveedor) {
    proveedores.remove(proveedor);
  }

  void modificarProveedor(int index, ProveedorRegistro proveedor) {
    proveedores[index] = proveedor;
  }
}
