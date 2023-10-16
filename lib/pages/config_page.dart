import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
FirebaseAuth _auth = FirebaseAuth.instance;
class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  Future<void> cerrarSesion() async {
    await _auth.signOut();
  }
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: (){
      cerrarSesion();
      Navigator.pushNamed(context, '/loginPage');
    }, child: const Text('Cerrar Sesión'));
    
  }
}