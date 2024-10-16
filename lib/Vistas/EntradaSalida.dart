import 'package:flutter/material.dart';
import 'package:proyecto_pa_app/Controlador/Producto_Entrada_Salida_controlador.dart';
import 'package:proyecto_pa_app/Controlador/Usuario_controlador.dart';
import 'package:proyecto_pa_app/Modelo/ProductoEntradaSalida.dart';
import 'package:proyecto_pa_app/Vistas/BotonBuscador.dart';
import 'package:proyecto_pa_app/Vistas/BotonMenu.dart';
import 'package:proyecto_pa_app/Vistas/BotonUsuarios.dart';
import 'package:proyecto_pa_app/Vistas/Principal.dart';

class EntradaSalida extends StatefulWidget {
  @override
  _EntradaSalidaState createState() => _EntradaSalidaState();
}

class _EntradaSalidaState extends State<EntradaSalida> {
  final ProductoEntradaSalidaControlador _controlador =
      ProductoEntradaSalidaControlador();
  int _selectedIndex = 1;

  final List<Widget> _vistas = [
    Principal(),
    BotonUsuarios(),
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
    // Navegar a la vista seleccionada
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => _vistas[_selectedIndex]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      appBar: AppBar(
        title: const Text('Entrada y Salida de Productos'),
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
            onPressed: () {
              // Lógica para agregar producto
            },
            icon: const Icon(Icons.add),
            label: const Text('Agregar'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[100],
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              // Lógica para eliminar producto
            },
            icon: const Icon(Icons.delete),
            label: const Text('Eliminar'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[100],
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              // Lógica para salir
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
}
