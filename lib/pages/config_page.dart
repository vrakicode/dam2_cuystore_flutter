import 'package:flutter/material.dart';
class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Center(child: Text('ESTE ES LA CONFIG PAGE')) ,);
  }
}