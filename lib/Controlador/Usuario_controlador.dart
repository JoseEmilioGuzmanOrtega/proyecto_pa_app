import 'package:hive/hive.dart';

class UsuarioControlador {
  final Box _usuariosBox = Hive.box('usuarios');
  final Box _sesionBox =
      Hive.box('sesion'); // Caja separada para guardar el usuario actual

  // Método para registrar un nuevo usuario
  Future<void> registrarUsuario(String usuario, String contrasena) async {
    await _usuariosBox.put(usuario, contrasena);
  }

  // Método para autenticar un usuario
  bool autenticar(String usuario, String contrasena) {
    final storedPassword = _usuariosBox.get(usuario);
    if (storedPassword == contrasena) {
      // Si la autenticación es correcta, guarda el usuario en la caja de sesión
      _sesionBox.put('usuarioActual', usuario);
      return true;
    }
    return false;
  }

  // Método para obtener el nombre del usuario actualmente autenticado
  String get UsuarioActual {
    // Obtiene el usuario guardado en la caja de sesión
    return _sesionBox.get('usuarioActual', defaultValue: 'Usuario Conectado');
  }

  // Método para obtener una lista de los usuarios registrados
  List<String> obtenerUsuariosRegistrados() {
    return _usuariosBox.keys.cast<String>().toList();
  }

  // Método para cerrar la sesión del usuario
  Future<void> cerrarSesion() async {
    await _sesionBox.delete('usuarioActual');
  }
}
