import 'package:flutter/material.dart';
import 'package:proyecto_pa_app/Controlador/Proveedor_controlador.dart';
import 'package:proyecto_pa_app/Modelo/ProveedorRegistro.dart';
import 'package:proyecto_pa_app/Controlador/Usuario_controlador.dart';
import 'package:proyecto_pa_app/Vistas/BotonBuscador.dart';
import 'package:proyecto_pa_app/Vistas/BotonMenu.dart';
import 'package:proyecto_pa_app/Vistas/Principal.dart';

class Proveedor extends StatefulWidget {
  @override
  _ProveedorState createState() => _ProveedorState();
}

class _ProveedorState extends State<Proveedor> {
  final Proveedor_controlador _controlador = Proveedor_controlador();
  ProveedorRegistro? _proveedorSeleccionado;
  int _selectedIndex = 1;

  final List<Widget> _vistas = [
    Principal(),
    Proveedor(),
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
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => _vistas[_selectedIndex]),
    );
  }

  void _mostrarDialogoAgregar() {
    final nombreController = TextEditingController();
    final ubicacionController = TextEditingController();
    final contactoController = TextEditingController();
    final telefonoController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Agregar Proveedor'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nombreController,
                decoration: const InputDecoration(labelText: 'Nombre Empresa'),
              ),
              TextField(
                controller: ubicacionController,
                decoration: const InputDecoration(labelText: 'Ubicación'),
              ),
              TextField(
                controller: contactoController,
                decoration: const InputDecoration(labelText: 'Contacto'),
              ),
              TextField(
                controller: telefonoController,
                decoration: const InputDecoration(labelText: 'Teléfono'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                final String nombre = nombreController.text;
                final String ubicacion = ubicacionController.text;
                final String contacto = contactoController.text;
                final String telefono = telefonoController.text;

                if (nombre.isEmpty ||
                    ubicacion.isEmpty ||
                    contacto.isEmpty ||
                    telefono.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Por favor ingrese datos válidos')),
                  );
                  return;
                }

                setState(() {
                  final nuevoProveedor = ProveedorRegistro(
                    nombreEmpresa: nombre,
                    ubicacion: ubicacion,
                    contacto: contacto,
                    telefono: telefono,
                  );
                  _controlador.agregarProveedor(nuevoProveedor);
                });
                Navigator.of(context).pop();
              },
              child: const Text('Agregar'),
            ),
          ],
        );
      },
    );
  }

  void _modificarProveedor() {
    if (_proveedorSeleccionado == null) return;

    final nombreController =
        TextEditingController(text: _proveedorSeleccionado!.nombreEmpresa);
    final ubicacionController =
        TextEditingController(text: _proveedorSeleccionado!.ubicacion);
    final contactoController =
        TextEditingController(text: _proveedorSeleccionado!.contacto);
    final telefonoController =
        TextEditingController(text: _proveedorSeleccionado!.telefono);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Modificar Proveedor'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nombreController,
                decoration: const InputDecoration(labelText: 'Nombre Empresa'),
              ),
              TextField(
                controller: ubicacionController,
                decoration: const InputDecoration(labelText: 'Ubicación'),
              ),
              TextField(
                controller: contactoController,
                decoration: const InputDecoration(labelText: 'Contacto'),
              ),
              TextField(
                controller: telefonoController,
                decoration: const InputDecoration(labelText: 'Teléfono'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                final String nombre = nombreController.text;
                final String ubicacion = ubicacionController.text;
                final String contacto = contactoController.text;
                final String telefono = telefonoController.text;

                if (nombre.isEmpty ||
                    ubicacion.isEmpty ||
                    contacto.isEmpty ||
                    telefono.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Por favor ingrese datos válidos')),
                  );
                  return;
                }

                setState(() {
                  _proveedorSeleccionado!.nombreEmpresa = nombre;
                  _proveedorSeleccionado!.ubicacion = ubicacion;
                  _proveedorSeleccionado!.contacto = contacto;
                  _proveedorSeleccionado!.telefono = telefono;
                  final int index =
                      _controlador.proveedores.indexOf(_proveedorSeleccionado!);
                  _controlador.modificarProveedor(
                      index, _proveedorSeleccionado!);
                });
                Navigator.of(context).pop();
              },
              child: const Text('Modificar'),
            ),
          ],
        );
      },
    );
  }

  void _eliminarProveedor() {
    if (_proveedorSeleccionado != null) {
      setState(() {
        _controlador.eliminarProveedor(_proveedorSeleccionado!);
        _proveedorSeleccionado = null;
      });
    }
  }

  void _salir() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      appBar: AppBar(
        title: const Text('Lista de Proveedores'),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _controlador.proveedores.length,
              itemBuilder: (context, index) {
                final proveedor = _controlador.proveedores[index];
                return _proveedorCard(proveedor);
              },
            ),
          ),
          const SizedBox(height: 10),
          _botonesAcciones(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Proveedores',
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
        backgroundColor: Colors.grey[300],
      ),
    );
  }

  Widget _proveedorCard(ProveedorRegistro proveedor) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: const Icon(Icons.groups, size: 40),
        title: Text(
          proveedor.nombreEmpresa,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(proveedor.ubicacion),
            Text(proveedor.contacto,
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        trailing: Text(proveedor.telefono,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        onTap: () {
          setState(() {
            _proveedorSeleccionado = proveedor;
          });
        },
      ),
    );
  }

  Widget _botonesAcciones() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton.icon(
            onPressed: _mostrarDialogoAgregar,
            icon: const Icon(Icons.add),
            label: const Text('Agregar'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[100],
            ),
          ),
          ElevatedButton.icon(
            onPressed: _modificarProveedor,
            icon: const Icon(Icons.edit),
            label: const Text('Modificar'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[100],
            ),
          ),
          ElevatedButton.icon(
            onPressed: _eliminarProveedor,
            icon: const Icon(Icons.delete),
            label: const Text('Eliminar'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[100],
            ),
          ),
          ElevatedButton.icon(
            onPressed: _salir,
            icon: const Icon(Icons.close),
            label: const Text('Salir'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[100],
            ),
          ),
        ],
      ),
    );
  }
}
