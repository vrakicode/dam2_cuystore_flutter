import 'package:flutter/material.dart';

class NewProductPage extends StatefulWidget {
  const NewProductPage({super.key});

  @override
  State<NewProductPage> createState() => _NewProductPageState();
}

class _NewProductPageState extends State<NewProductPage> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Center(child: Text('ESTA ES LA PAGINA PARA CREAR UN NUEVO PRODUCTO')),);
  }
}