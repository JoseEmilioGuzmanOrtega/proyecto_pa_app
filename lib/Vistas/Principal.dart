import 'package:flutter/material.dart';
import 'package:proyecto_pa_app/Controlador/Usuario_controlador.dart';
import 'package:proyecto_pa_app/Vistas/BotonBuscador.dart';
import 'package:proyecto_pa_app/Vistas/BotonMenu.dart';
import 'package:proyecto_pa_app/Vistas/BotonUsuarios.dart';
import 'package:proyecto_pa_app/Vistas/EntradaSalida.dart';
import 'package:proyecto_pa_app/Vistas/Mercancias.dart';
import 'package:proyecto_pa_app/Vistas/Proveedor.dart';
import 'package:proyecto_pa_app/Vistas/Reportes.dart';
import 'package:proyecto_pa_app/Vistas/Ventas.dart';

class Principal extends StatefulWidget {
  _PrincipalState createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  int _selectedIndex = 0;

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
      backgroundColor: Color(0xFFD9B3FF), // Fondo color lila
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'TIENDA "DON PACO\'S"',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Image.asset('assets/Nventa.png',
                  height: 40), // Imagen de Logo más grande
              SizedBox(height: 50),
              MenuButton(
                iconPath: 'assets/Carrito-de-compras.png',
                label: 'Nueva venta',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProductosVista()),
                  );
                },
              ),
              MenuButton(
                iconPath: 'assets/report.png',
                label: 'Reporte de Venta',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Reportes()),
                  );
                },
              ),
              MenuButton(
                iconPath: 'assets/inventario.png',
                label: 'Existencia de Mercancías',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Mercancias()),
                  );
                },
              ),
              MenuButton(
                iconPath: 'assets/proveedor.png',
                label: 'Proveedores',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Proveedor()),
                  );
                },
              ),
              MenuButton(
                iconPath: 'assets/producto.png',
                label: 'Entrada/Salida de Productos',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EntradaSalida()),
                  );
                },
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  textStyle: TextStyle(fontSize: 18),
                ),
                icon: Image.asset('assets/eliminar.png', height: 20),
                label: Text('Salir'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
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
            icon: Icon(Icons.person),
            label: 'Principal',
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

class MenuButton extends StatelessWidget {
  final String iconPath;
  final String label;
  final VoidCallback? onPressed;

  MenuButton({
    required this.iconPath,
    required this.label,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Image.asset(iconPath, height: 40), // Imagen más grande
        label: Text(label, style: TextStyle(fontSize: 20)), // Texto más grande
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(
              horizontal: 50, vertical: 15), // Botón más grande
          backgroundColor: Colors.redAccent, // Fondo rojo del botón
          foregroundColor: Colors.black, // Color del texto
          side: BorderSide(color: Colors.grey.shade400), // Borde gris
          shadowColor: Colors.grey.shade300,
          elevation: 5,
        ),
      ),
    );
  }
}
