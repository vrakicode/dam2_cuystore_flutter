import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('productos').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No hay productos disponibles.'),
            );
          }

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2, // 2 columnas en dispositivos pequeños, 4 en dispositivos más grandes
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                var product = snapshot.data!.docs[index];
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
                        height: 150.0,
                        width: 160.0,
                        fit: BoxFit.cover,
                      ),
                      Text(
                        productName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                        ),
                      ),
                      Text('S/. $productPrice',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                      ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}