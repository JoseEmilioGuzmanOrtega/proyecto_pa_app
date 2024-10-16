import 'package:flutter/material.dart';
import 'package:proyecto_pa_app/Controlador/Producto_ventas_controlador.dart';
import 'package:proyecto_pa_app/Controlador/Usuario_controlador.dart';
import 'package:proyecto_pa_app/Modelo/ProductoVentas.dart';
import 'package:proyecto_pa_app/Vistas/BotonBuscador.dart';
import 'package:proyecto_pa_app/Vistas/BotonMenu.dart';
import 'package:proyecto_pa_app/Vistas/BotonUsuarios.dart';
import 'package:proyecto_pa_app/Vistas/Principal.dart';

class Reportes extends StatefulWidget {
  @override
  _ReportesState createState() => _ReportesState();
}

class _ReportesState extends State<Reportes> {
  final ProductoVentasControlador _controlador = ProductoVentasControlador();
  final TextEditingController _fechaController = TextEditingController();
  List<ProductoVentas> _productosFiltrados = [];
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

  void _buscar() {
    setState(() {
      _productosFiltrados = _controlador.buscarPorFecha(_fechaController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      appBar: AppBar(
        title: const Text('Buscar Venta'),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _fechaController,
                    decoration: const InputDecoration(
                      hintText: 'YYYY-MM-DD',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _buscar,
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: _productosFiltrados.length,
              itemBuilder: (context, index) {
                final producto = _productosFiltrados[index];
                return _productoCard(producto);
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  // Lógica para generar el reporte
                },
                icon: const Icon(Icons.picture_as_pdf),
                label: const Text('Generar Reporte'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[100],
                ),
              ),
              const SizedBox(width: 20),
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
          const SizedBox(
              height: 40), // Add this line to create space below the buttons
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
            icon: Icon(Icons.assessment),
            label: 'Reportes',
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

  Widget _productoCard(ProductoVentas producto) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Image.asset(
          producto.imagen,
          width: 50,
          height: 50,
        ),
        title: Text(
          producto.nombre,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Precio: \$${producto.precio.toStringAsFixed(2)}',
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('Fecha Venta: ${producto.fechaVenta}'),
          ],
        ),
        trailing: Column(
          children: [
            const Text('Cantidad'),
            Text(
              producto.cantidad.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
