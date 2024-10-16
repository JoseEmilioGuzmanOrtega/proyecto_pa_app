import 'package:flutter/material.dart';
import 'package:proyecto_pa_app/Vistas/Principal.dart';
import 'package:proyecto_pa_app/Controlador/Usuario_controlador.dart';

class BotonUsuarios extends StatefulWidget {
  @override
  _BotonUsuariosState createState() => _BotonUsuariosState();
}

class _BotonUsuariosState extends State<BotonUsuarios> {
  List<String> _usuariosRegistrados = [];
  final UsuarioControlador _controlador = UsuarioControlador();

  @override
  void initState() {
    super.initState();
    _cargarUsuariosRegistrados();
  }

  void _cargarUsuariosRegistrados() {
    setState(() {
      _usuariosRegistrados = _controlador.obtenerUsuariosRegistrados();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuarios Registrados'),
        backgroundColor: Colors.blueAccent, // Color de fondo del AppBar
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
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: _usuariosRegistrados.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(_usuariosRegistrados[index][0]),
                ),
                title: Text(
                  _usuariosRegistrados[index],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
