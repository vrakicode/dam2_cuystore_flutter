import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_flutter/services/firebase_service.dart';
class Search extends StatefulWidget {
  const Search({Key? key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String searchText = ''; // Variable para almacenar el texto de búsqueda
  late Future<List<DocumentSnapshot>> searchResults;
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    // Initialize the searchResults variable.
    searchResults = FirebaseService.searchProductos("");
  } 
  Future<void> searchProductos() async {
    searchResults = FirebaseService.searchProductos(searchText);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(top:30),
          child: Text('Buscar Productos'),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(top:20),
            child: SizedBox(
              width: 200,
              child: TextField(
                focusNode: _focusNode,
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  setState(() {
                    searchText = value;
                  });
                },
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:20),
            child: IconButton(
              onPressed: () {
                _focusNode.unfocus();
                setState(() {
                  
                  searchProductos();
                });
                
              },
              icon: const Icon(Icons.search),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: FutureBuilder<List<DocumentSnapshot>>(
          future: searchResults,
          builder: (BuildContext context, AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              List<DocumentSnapshot> productos = snapshot.data!;
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2, // 2 columnas en dispositivos pequeños, 4 en dispositivos más grandes
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 0.78,
                ),
                itemCount: productos.length,
                itemBuilder: (BuildContext context, int index) {
                  var product = productos[index];
                  var productName = product['nombre'];
                  var productImageURL = product['imagenes'][0]; // Asume que tienes una URL de imagen almacenada en Firebase
                  var productPrice = product['precio'];
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      color: Colors.indigo[50],
                    ),
                    child: Column(
                      children: [
                        Image.network(
                          productImageURL,
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width * 0.4,
                          fit: BoxFit.cover,
                        ),
                        Text(
                          productName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          'S/. $productPrice',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
