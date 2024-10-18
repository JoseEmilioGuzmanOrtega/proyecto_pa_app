import 'package:flutter/material.dart';
import 'package:proyecto_pa_app/Controlador/Usuario_controlador.dart'
    as controlador;

class Registro extends StatefulWidget {
  @override
  _RegistroState createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  final controlador.UsuarioControlador _controlador =
      controlador.UsuarioControlador();
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _contrasenaController = TextEditingController();
  String _mensajeError = '';
  List<String> _usuariosRegistrados = [];

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

  void _registrarUsuario() async {
    final usuario = _usuarioController.text;
    final contrasena = _contrasenaController.text;

    if (usuario.isNotEmpty && contrasena.isNotEmpty) {
      await _controlador.registrarUsuario(usuario, contrasena);
      _cargarUsuariosRegistrados();
      _usuarioController.clear();
      _contrasenaController.clear();
    } else {
      setState(() {
        _mensajeError =
            'Por favor, ingrese un usuario y una contraseña válidos';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Agregamos el ícono arriba del texto "Registro de Usuario"
                Icon(
                  Icons.app_registration,
                  size: 80,
                  color: Colors.lightBlueAccent,
                ),
                const SizedBox(height: 10),
                Text(
                  'Registro de Usuario',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlueAccent,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _usuarioController,
                  decoration: InputDecoration(
                    labelText: 'Usuario',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _contrasenaController,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _registrarUsuario,
                  child: const Text('Registrar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlueAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                if (_mensajeError.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      _mensajeError,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                const SizedBox(height: 20),
                Text(
                  'Usuarios Registrados:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: _usuariosRegistrados.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 3,
                      child: ListTile(
                        title: Text(_usuariosRegistrados[index]),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
