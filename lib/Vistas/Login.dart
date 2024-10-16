import 'package:flutter/material.dart';
import 'package:proyecto_pa_app/Modelo/UsuarioControlador.dart';
import 'Principal.dart';
import 'Registro.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final UsuarioControlador _controlador = UsuarioControlador();
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _contrasenaController = TextEditingController();
  String _mensajeError = '';

  void _iniciarSesion() {
    final usuario = _usuarioController.text;
    final contrasena = _contrasenaController.text;

    if (_controlador.autenticar(usuario, contrasena)) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Principal()),
      );
    } else {
      setState(() {
        _mensajeError = 'Usuario o contraseña incorrectos';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/paco.jpg',
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.width * 0.3,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Tienda “DON PACO’S”',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Iniciar Sesión',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                const Icon(
                  Icons.lock,
                  size: 50,
                  color: Colors.black,
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _usuarioController,
                  decoration: InputDecoration(
                    labelText: 'Usuario',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _contrasenaController,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: _iniciarSesion,
                  icon: const Icon(Icons.login),
                  label: const Text('Iniciar Sesión'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlueAccent,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
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
                const SizedBox(height: 20), // Espacio entre los botones
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Registro()),
                    );
                  },
                  icon: const Icon(Icons.app_registration),
                  label: const Text('Registrar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                  ),
                ),
                const SizedBox(height: 20), // Espacio entre los botones
                ElevatedButton.icon(
                  onPressed: () {
                    // Acción para el botón de salir
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.cancel),
                  label: const Text('Salir'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
