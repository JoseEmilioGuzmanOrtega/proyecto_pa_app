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
              'Nombre de Usuario: $nombreUsuario',
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
                        child: Text(
                          usuariosRegistrados[index][0],
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(usuariosRegistrados[index]),
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
