import 'package:flutter/material.dart';
import 'package:proyecto_pa_app/Controlador/Producto_controlador.dart';
import 'package:proyecto_pa_app/Controlador/Usuario_controlador.dart';
import 'package:proyecto_pa_app/Modelo/Producto.dart';
import 'package:proyecto_pa_app/Vistas/BotonBuscador.dart';
import 'package:proyecto_pa_app/Vistas/BotonMenu.dart';
import 'package:proyecto_pa_app/Vistas/BotonUsuarios.dart';
import 'package:proyecto_pa_app/Vistas/Principal.dart';

class ProductosVista extends StatefulWidget {
  @override
  _ProductosVistaState createState() => _ProductosVistaState();
}

class _ProductosVistaState extends State<ProductosVista> {
  final Producto_controlador _controlador = Producto_controlador();
  String _query = '';
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
    List<Producto> productosFiltrados = _controlador.buscarProducto(_query);

    return Scaffold(
      backgroundColor: Color(0xFFD9B3FF), // Fondo color lila
      appBar: AppBar(
        backgroundColor: Color(0xFFD9B3FF),
        title: Row(
          children: [
            Expanded(
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _query = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Buscar producto',
                  border: OutlineInputBorder(),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total:',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  '\$${_controlador.calcularTotal().toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: productosFiltrados.length,
              itemBuilder: (context, index) {
                Producto producto = productosFiltrados[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Image.asset(
                          producto.imagen,
                          width: 80,
                          height: 80,
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                producto.nombre,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                '\$${producto.precio.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                              Text(
                                'Precio Anterior: \$${producto.precioAnterior.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 14,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                setState(() {
                                  _controlador.decrementarCantidad(producto);
                                });
                              },
                            ),
                            Text(
                              '${producto.cantidad}',
                              style: TextStyle(fontSize: 16),
                            ),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  _controlador.incrementarCantidad(producto);
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Salir'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Venta',
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
        backgroundColor: Colors.grey[300], // Color seleccionado para el ítem
      ),
    );
  }
}
