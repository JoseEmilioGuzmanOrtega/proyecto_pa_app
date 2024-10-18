import 'package:flutter/material.dart';
import 'package:proyecto_pa_app/Controlador/Producto_existencia_controlador.dart';
import 'package:proyecto_pa_app/Modelo/ProductoExistencia.dart';
import 'package:proyecto_pa_app/Vistas/BotonBuscador.dart';
import 'package:proyecto_pa_app/Vistas/BotonMenu.dart';
import 'package:proyecto_pa_app/Vistas/Principal.dart';
import 'package:proyecto_pa_app/Controlador/Usuario_controlador.dart';

class Mercancias extends StatefulWidget {
  @override
  _MercanciasState createState() => _MercanciasState();
}

class _MercanciasState extends State<Mercancias> {
  final ProductoExistenciaControlador _controlador =
      ProductoExistenciaControlador();
  int _selectedIndex = 1;
  ProductoExistencia? _productoSeleccionado;

  final List<Widget> _vistas = [
    Principal(),
    Mercancias(),
    BotonBuscador(),
    BotonMenu(
      nombreUsuario: UsuarioControlador().UsuarioActual,
      usuariosRegistrados: UsuarioControlador().obtenerUsuariosRegistrados(),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => _vistas[_selectedIndex]),
    );
  }

  void _mostrarDialogoAgregar() {
    final nombreController = TextEditingController();
    final descripcionController = TextEditingController();
    final precioController = TextEditingController();
    final cantidadController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Agregar Producto'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nombreController,
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              TextField(
                controller: descripcionController,
                decoration: const InputDecoration(labelText: 'Descripción'),
              ),
              TextField(
                controller: precioController,
                decoration: const InputDecoration(labelText: 'Precio'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: cantidadController,
                decoration: const InputDecoration(labelText: 'Cantidad'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                final String nombre = nombreController.text;
                final String descripcion = descripcionController.text;
                final double? precio = double.tryParse(precioController.text);
                final int? cantidad = int.tryParse(cantidadController.text);

                if (nombre.isEmpty ||
                    descripcion.isEmpty ||
                    precio == null ||
                    cantidad == null) {
                  // Mostrar un mensaje de error si hay datos inválidos
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Por favor ingrese datos válidos')),
                  );
                  return;
                }

                setState(() {
                  final nuevoProducto = ProductoExistencia(
                    nombre: nombre,
                    descripcion: descripcion,
                    precio: precio,
                    cantidad: cantidad,
                    imagen: 'https://via.placeholder.com/150',
                  );
                  _controlador.agregarProducto(nuevoProducto);
                });
                Navigator.of(context).pop();
              },
              child: const Text('Agregar'),
            ),
          ],
        );
      },
    );
  }

  void _modificarProducto() {
    if (_productoSeleccionado == null) return;

    final nombreController =
        TextEditingController(text: _productoSeleccionado!.nombre);
    final descripcionController =
        TextEditingController(text: _productoSeleccionado!.descripcion);
    final precioController =
        TextEditingController(text: _productoSeleccionado!.precio.toString());
    final cantidadController =
        TextEditingController(text: _productoSeleccionado!.cantidad.toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Modificar Producto'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nombreController,
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              TextField(
                controller: descripcionController,
                decoration: const InputDecoration(labelText: 'Descripción'),
              ),
              TextField(
                controller: precioController,
                decoration: const InputDecoration(labelText: 'Precio'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: cantidadController,
                decoration: const InputDecoration(labelText: 'Cantidad'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                final String nombre = nombreController.text;
                final String descripcion = descripcionController.text;
                final double? precio = double.tryParse(precioController.text);
                final int? cantidad = int.tryParse(cantidadController.text);

                if (nombre.isEmpty ||
                    descripcion.isEmpty ||
                    precio == null ||
                    cantidad == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Por favor ingrese datos válidos')),
                  );
                  return;
                }

                setState(() {
                  _productoSeleccionado!.nombre = nombre;
                  _productoSeleccionado!.descripcion = descripcion;
                  _productoSeleccionado!.precio = precio;
                  _productoSeleccionado!.cantidad = cantidad;
                  _controlador.modificarProducto(
                      _productoSeleccionado!.id as int, _productoSeleccionado!);
                });
                Navigator.of(context).pop();
              },
              child: const Text('Modificar'),
            ),
          ],
        );
      },
    );
  }

  void _eliminarProducto() {
    if (_productoSeleccionado != null) {
      setState(() {
        _controlador.eliminarProducto(_productoSeleccionado!);
        _productoSeleccionado = null;
      });
    }
  }

  void _salir() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      appBar: AppBar(
        title: const Text('Existencia de Mercancías'),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _controlador.productos.length,
              itemBuilder: (context, index) {
                final producto = _controlador.productos[index];
                return _productoCard(producto);
              },
            ),
          ),
          const SizedBox(height: 10),
          _botonesAcciones(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: 'Mercancias',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Buscar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Menú',
          ),
        ],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.grey[300],
      ),
    );
  }

  Widget _productoCard(ProductoExistencia producto) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(
          Icons.sell,
          size: 50,
          color: Colors.grey,
        ),
        title: Text(
          producto.nombre,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Descripción: ${producto.descripcion}'),
            Text('Precio: \$${producto.precio.toStringAsFixed(2)}',
                style: const TextStyle(color: Colors.red)),
            Text('Cantidad: ${producto.cantidad}'),
          ],
        ),
        onTap: () {
          setState(() {
            _productoSeleccionado = producto;
          });
        },
      ),
    );
  }

  Widget _botonesAcciones() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton.icon(
            onPressed: _mostrarDialogoAgregar,
            icon: const Icon(Icons.add),
            label: const Text('Agregar'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[100],
            ),
          ),
          ElevatedButton.icon(
            onPressed: _modificarProducto,
            icon: const Icon(Icons.edit),
            label: const Text('Modificar'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[100],
            ),
          ),
          ElevatedButton.icon(
            onPressed: _eliminarProducto,
            icon: const Icon(Icons.delete),
            label: const Text('Eliminar'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[100],
            ),
          ),
          ElevatedButton.icon(
            onPressed: _salir,
            icon: const Icon(Icons.close),
            label: const Text('Salir'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[100],
            ),
          ),
        ],
      ),
    );
  }
}
