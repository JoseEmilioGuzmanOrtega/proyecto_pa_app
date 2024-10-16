import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'Vistas/Login.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('usuarios');
  runApp(MiApp());
}

class MiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}
