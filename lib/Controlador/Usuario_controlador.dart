import 'package:hive/hive.dart';

class UsuarioControlador {
  final Box _usuariosBox = Hive.box('usuarios');

  Future<void> registrarUsuario(String usuario, String contrasena) async {
    await _usuariosBox.put(usuario, contrasena);
  }

  bool autenticar(String usuario, String contrasena) {
    final storedPassword = _usuariosBox.get(usuario);
    return storedPassword == contrasena;
  }

  String get UsuarioActual {
    return "";
  }

  List<String> obtenerUsuariosRegistrados() {
    return _usuariosBox.keys.cast<String>().toList();
  }
}
