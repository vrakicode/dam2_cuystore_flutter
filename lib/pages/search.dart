import 'package:flutter/material.dart';
class Search extends StatefulWidget {
  const Search({Key? key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String searchText = ''; // Variable para almacenar el texto de búsqueda

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Productos'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 200,
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchText = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Buscar productos...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              // Aquí puedes manejar la lógica de búsqueda usando el texto en 'searchText'
              // Por ejemplo, puedes navegar a una nueva pantalla con los resultados.
              // Navigator.push(context, MaterialPageRoute(builder: (context) => ResultadosBusqueda(searchText)));
              // O puedes realizar una búsqueda directa en Firebase.
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Center(
        child: Text('ESTE ES LA PGINA DE BUSQUEDA'),
      ),
    );
  }
}
