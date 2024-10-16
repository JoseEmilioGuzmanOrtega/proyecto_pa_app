import 'package:flutter/material.dart';
import 'package:proyecto_pa_app/Vistas/Principal.dart';

class BotonBuscador extends StatefulWidget {
  @override
  _BotonBuscadorState createState() => _BotonBuscadorState();
}

class _BotonBuscadorState extends State<BotonBuscador> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _searchResults = [];

  void _performSearch(String query) {
    if (query.isEmpty) {
      _searchResults = [];
      return;
    }
    setState(() {
      _searchResults =
          List.generate(10, (index) => 'Resultado $index para "$query"');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscador'),
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
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Buscar',
                labelStyle: TextStyle(color: Colors.teal),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.tealAccent),
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search, color: Colors.teal),
                  onPressed: () => _performSearch(_searchController.text),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: _searchResults.isEmpty
                  ? Center(
                      child: Text(
                        'No hay resultados',
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 4,
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text(_searchResults[index]),
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
