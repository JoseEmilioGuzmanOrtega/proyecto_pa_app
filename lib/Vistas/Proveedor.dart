import 'package:flutter/material.dart';
import 'package:proyecto_pa_app/Controlador/Proveedor_controlador.dart';
import 'package:proyecto_pa_app/Controlador/Usuario_controlador.dart';
import 'package:proyecto_pa_app/Modelo/ProveedorRegistro.dart';
import 'package:proyecto_pa_app/Vistas/BotonBuscador.dart';
import 'package:proyecto_pa_app/Vistas/BotonMenu.dart';
import 'package:proyecto_pa_app/Vistas/BotonUsuarios.dart';
import 'package:proyecto_pa_app/Vistas/Principal.dart';

class Proveedor extends StatefulWidget {
  @override
  _ProveedorState createState() => _ProveedorState();
}

class _ProveedorState extends State<Proveedor> {
  final Proveedor_controlador _controlador = Proveedor_controlador();
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
        title: const Text('Lista de Proveedores'),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _controlador.proveedores.length,
              itemBuilder: (context, index) {
                final proveedor = _controlador.proveedores[index];
                return _proveedorCard(proveedor);
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
            icon: Icon(Icons.store),
            label: 'Proveedores',
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

  Widget _proveedorCard(ProveedorRegistro proveedor) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: const Icon(Icons.groups, size: 40),
        title: Text(
          proveedor.nombreEmpresa,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(proveedor.ubicacion),
            Text(proveedor.contacto,
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        trailing: Text(
          proveedor.telefono,
          style: const TextStyle(fontWeight: FontWeight.bold),
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
              // Lógica para agregar proveedor
            },
            icon: const Icon(Icons.add),
            label: const Text('Agregar'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[100],
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              // Lógica para eliminar proveedor
            },
            icon: const Icon(Icons.delete),
            label: const Text('Eliminar'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[100],
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              // Lógica para modificar proveedor
            },
            icon: const Icon(Icons.edit),
            label: const Text('Modificar'),
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
