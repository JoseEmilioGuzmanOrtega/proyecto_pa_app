import 'package:flutter/material.dart';
import 'package:proyecto_pa_app/Vistas/Principal.dart';

class BotonMenu extends StatelessWidget {
  final String nombreUsuario;
  final List<String> usuariosRegistrados;

  BotonMenu({required this.nombreUsuario, required this.usuariosRegistrados});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menú de Usuario'),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Estado del Usuario: $nombreUsuario',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Usuarios Registrados:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(color: Colors.teal),
            Expanded(
              child: ListView.builder(
                itemCount: usuariosRegistrados.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.teal,
                        child: const Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(usuariosRegistrados[index]),
                    ),
                  );
                },
              ),
            ),
            const Divider(color: Colors.teal),
            const Text(
              'Opciones del Menú:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildMenuOption(
              context,
              icon: Icons.exit_to_app,
              text: 'Salir a la Página Principal',
              onTap: () {
                _cerrarSesion(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  // Helper para crear las opciones del menú
  Widget _buildMenuOption(
    BuildContext context, {
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.teal),
        title: Text(text, style: TextStyle(fontSize: 16)),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }

  // Función para cerrar sesión (adaptable según tu lógica)
  void _cerrarSesion(BuildContext context) {
    // Aquí puedes agregar lógica para cerrar sesión, como limpiar datos del usuario
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Saliendo...')),
    );

    // Regresar a la página principal
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Principal()),
      (Route<dynamic> route) => false,
    );
  }
}
