import 'package:flutter/material.dart';
import 'package:proyecto_flutter/widgets/text_field_login.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.9],
            colors: [Color.fromARGB(255, 244, 242, 242), Color.fromARGB(255, 231, 232, 234)],
          ),
        ),
        child: Center(
          child: Column(children: [
            Image.asset('assets/images/logo.png', width: 250, height: 250),
            const Column(
              children: [
                Text('Iniciar Sesion', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
                SizedBox(height: 30),
                Text('Hola, gusto en conocerte', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Color.fromARGB(255, 174, 173, 173))),
                SizedBox(height: 30),
                SizedBox(
                  width: 350,
                  child: TextFieldLogin(label: 'AppleID',
                  hintText: 'Ingrese su Apple ID', 
                  obscureText: false,),
                ),
                SizedBox(height: 2),
                SizedBox(
                  width: 350,
                  child: TextFieldLogin(label: 'Password',
                  hintText: 'Ingrese su contraseña', 
                  obscureText: true,),
                ),
                SizedBox(height: 30),
                Text('¿Olvidaste tu Apple ID o tu contraseña?', 
                  style: TextStyle(fontSize: 18, 
                    fontWeight: FontWeight.w600, 
                    color: Colors.blue
                  )
                ),
                SizedBox(height: 30),               
              ],
            ),
            SizedBox(
              width: 350,
              height: 50, // Ancho deseado
              child: ButtonLogin(label: 'Iniciar Sesion',
                onPressed: () {
                      
                },
                backgroundColor: Colors.white,
                textColor: Colors.grey,
                sizeText: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 350,
              height: 50,
              child: ButtonLogin(label: 'Crear Nueva Cuenta',
                onPressed: () {
                      
                },
                backgroundColor: const Color.fromARGB(255, 221, 219, 219),
                textColor: Colors.blue,
                sizeText: 20,
                fontWeight: FontWeight.bold,
              )
            )
          ]),
        ),
      )
      /*
      backgroundColor: Colors.grey[200],*/
    );
  }
}

class ButtonLogin extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double sizeText;
  final FontWeight fontWeight;
  const ButtonLogin({
    super.key, 
    required this.label, 
    required this.onPressed, 
    required this.backgroundColor, 
    required this.textColor, 
    required this.sizeText, required this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Radio de los bordes
        ),
        backgroundColor: backgroundColor,
      ),
      child: Text(label,
        style: TextStyle(color: textColor,
          fontSize: sizeText,
          fontWeight: fontWeight
        ),
        
      ),
    );
  }
}

/*class TextFieldLogin extends StatelessWidget {
  final String label;
  final String hintText;
  final bool obscureText;
  
  const TextFieldLogin({
    super.key, 
    required this.label, required this.hintText, 
    required this.obscureText, 
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
        hintText: hintText,
        hintStyle: const TextStyle(color: Color.fromARGB(255, 8, 8, 8)),
      ),
    );
  }
}*/


