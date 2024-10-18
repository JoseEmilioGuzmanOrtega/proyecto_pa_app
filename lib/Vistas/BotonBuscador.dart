import 'package:flutter/material.dart';
import 'package:proyecto_pa_app/Vistas/BotonUsuarios.dart';
import 'package:proyecto_pa_app/Vistas/EntradaSalida.dart';
import 'package:proyecto_pa_app/Vistas/Mercancias.dart';
import 'package:proyecto_pa_app/Vistas/Principal.dart';
import 'package:proyecto_pa_app/Vistas/Proveedor.dart';
import 'package:proyecto_pa_app/Vistas/Reportes.dart';
import 'package:proyecto_pa_app/Vistas/Ventas.dart';
import 'package:proyecto_pa_app/Vistas/BotonMenu.dart';
import 'package:proyecto_pa_app/Controlador/Usuario_controlador.dart';

class BotonBuscador extends StatefulWidget {
  @override
  _BotonBuscadorState createState() => _BotonBuscadorState();
}

class _BotonBuscadorState extends State<BotonBuscador> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];

  // Lista de apartados de la aplicación con sus rutas correspondientes
  final List<Map<String, dynamic>> _appSections = [
    {'name': 'Principal', 'widget': Principal()},
    {'name': 'Reporte de Venta', 'widget': Reportes()},
    {'name': 'Existencia de Mercancias', 'widget': Mercancias()},
    {'name': 'Proveedores', 'widget': Proveedor()},
    {'name': 'Entrada/Salida de Productos', 'widget': EntradaSalida()},
    {'name': 'Gestion de Usuarios', 'widget': BotonUsuarios()},
    {'name': 'Nueva Venta', 'widget': Ventas()},
    {
      'name': 'Menú de Usuario',
      'widget': BotonMenu(
        nombreUsuario: UsuarioControlador().UsuarioActual,
        usuariosRegistrados: UsuarioControlador().obtenerUsuariosRegistrados(),
      ),
    },
    // Agrega más apartados aquí según los apartados que tengas en tu app
  ];

  // Función para realizar la búsqueda
  void _performSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }
    setState(() {
      _searchResults = _appSections
          .where((section) =>
              section['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  // Navegar a la sección seleccionada
  void _navigateToSection(BuildContext context, dynamic widget) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscador'),
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Principal()),
              (Route<dynamic> route) => false,
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Buscar',
                labelStyle: TextStyle(color: Colors.teal),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.tealAccent),
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search, color: Colors.teal),
                  onPressed: () => _performSearch(_searchController.text),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: _searchResults.isEmpty
                  ? Center(
                      child: Text(
                        'No hay resultados',
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        final section = _searchResults[index];
                        return Card(
                          elevation: 4,
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text(section['name']),
                            onTap: () =>
                                _navigateToSection(context, section['widget']),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
