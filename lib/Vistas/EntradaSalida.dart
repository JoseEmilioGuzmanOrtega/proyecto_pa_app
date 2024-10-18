import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_pa_app/Controlador/Producto_Entrada_Salida_controlador.dart';
import 'package:proyecto_pa_app/Modelo/ProductoEntradaSalida.dart';
import 'package:proyecto_pa_app/Vistas/BotonBuscador.dart';
import 'package:proyecto_pa_app/Vistas/BotonMenu.dart';
import 'package:proyecto_pa_app/Vistas/Principal.dart';
import 'package:proyecto_pa_app/Controlador/Usuario_controlador.dart';

class EntradaSalida extends StatefulWidget {
  @override
  _EntradaSalidaState createState() => _EntradaSalidaState();
}

class _EntradaSalidaState extends State<EntradaSalida> {
  int _selectedIndex = 1;

  final List<Widget> _vistas = [
    Principal(),
    EntradaSalida(),
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

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProductoEntradaSalidaControlador>(
      // Proporciona el controlador necesario para el Consumer
      create: (_) => ProductoEntradaSalidaControlador(),
      child: Scaffold(
        backgroundColor: Colors.purple[100],
        appBar: AppBar(
          title: const Text('Entrada y Salida de Productos'),
          backgroundColor: Colors.purple,
        ),
        body: Column(
          children: [
            Expanded(
              child: Consumer<ProductoEntradaSalidaControlador>(
                builder: (context, controlador, child) {
                  return ListView.builder(
                    itemCount: controlador.productos.length,
                    itemBuilder: (context, index) {
                      final producto = controlador.productos[index];
                      return _productoCard(producto);
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            _botonesAcciones(context),
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
              icon: Icon(Icons.add_shopping_cart),
              label: 'Entrada/Salida',
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
      ),
    );
  }

  Widget _productoCard(ProductoEntradaSalida producto) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Image.network(
          producto.imagen,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Image.asset(
              'assets/default_image.png',
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            );
          },
        ),
        title: Text(
          producto.nombre,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Descripción: ${producto.descripcion}'),
            Text(
              'Precio: \$${producto.precio.toStringAsFixed(2)}',
              style: const TextStyle(color: Colors.red),
            ),
            Text('Cantidad: ${producto.cantidad}'),
          ],
        ),
      ),
    );
  }

  Widget _botonesAcciones(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton.icon(
            onPressed: () {
              _mostrarFormularioAgregar(context);
            },
            icon: const Icon(Icons.add),
            label: const Text('Agregar'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[100],
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Principal()),
              );
            },
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

  void _mostrarFormularioAgregar(BuildContext context) {
    // Mover los controladores dentro del método para evitar datos residuales
    final _nombreController = TextEditingController();
    final _descripcionController = TextEditingController();
    final _precioController = TextEditingController();
    final _cantidadController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Agregar Producto'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              TextField(
                controller: _descripcionController,
                decoration: const InputDecoration(labelText: 'Descripción'),
              ),
              TextField(
                controller: _precioController,
                decoration: const InputDecoration(labelText: 'Precio'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _cantidadController,
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
                final String nombre = _nombreController.text;
                final String descripcion = _descripcionController.text;
                final double? precio = double.tryParse(_precioController.text);
                final int? cantidad = int.tryParse(_cantidadController.text);

                if (nombre.isEmpty ||
                    descripcion.isEmpty ||
                    precio == null ||
                    cantidad == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Por favor ingrese datos válidos'),
                    ),
                  );
                  return;
                }
                final nuevoProducto = ProductoEntradaSalida(
                  nombre: nombre,
                  descripcion: descripcion,
                  precio: precio,
                  cantidad: cantidad,
                  imagen: 'https://via.placeholder.com/150',
                );
                Provider.of<ProductoEntradaSalidaControlador>(context,
                        listen: false)
                    .agregarProducto(nuevoProducto);
                Navigator.of(context).pop();
              },
              child: const Text('Agregar'),
            ),
          ],
        );
      },
    );
  }
}
