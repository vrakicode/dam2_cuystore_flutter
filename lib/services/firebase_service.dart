import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
FirebaseAuth _auth = FirebaseAuth.instance;
class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> agregarProducto(Map<String, dynamic> formData, List<String> imageUrls, List<String> selectedCategories) async {
    await _firestore.collection('productos').add({
      'idUser': _auth.currentUser!.uid,
      'nombre': formData['nombreProducto'],
      'precio': formData['precioProducto'],
      'stock': formData['stockProducto'],
      'estado': formData['estadoProducto'],
      'descripcion': formData['descripcionProducto'],
      'categorias': selectedCategories,
      'imagenes': imageUrls,
    });
  }

  Future<List<String>> subirImagenes(List<XFile> images) async {
    List<String> imageUrls = [];

    for (XFile image in images) {
      File file = File(image.path);

      Reference ref = _storage.ref().child('imagenes/${DateTime.now().millisecondsSinceEpoch}');
      await ref.putFile(file);

      String imageUrl = await ref.getDownloadURL();
      imageUrls.add(imageUrl);
    }

    return imageUrls;
  }
  void toggleFavorite(String productId, bool isFavorite) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    if (isFavorite) {
      await users.doc(userId).update({
        'favorites': FieldValue.arrayUnion([productId]),
      });
    } else {
      await users.doc(userId).update({
        'favorites': FieldValue.arrayRemove([productId]),
      });
    }
  }

  static Future<List<DocumentSnapshot>> searchProductos(String searchText) async {
    try {
      String palabra = searchText;
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('productos')
          .where('nombre', isEqualTo: palabra)
          .get();
      return snapshot.docs;
    } catch (e) {
      
      return [];
    }
  }
}
