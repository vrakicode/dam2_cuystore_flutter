import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proyecto_flutter/widgets/button_login.dart';
import 'package:proyecto_flutter/widgets/text_field_login.dart';
import 'package:auth_buttons/auth_buttons.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void signInWithEmailAndPassword() async {
    String email = emailController.text;
    String password = passwordController.text;

    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      if (user != null) { 
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, '/index');
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error al iniciar sesión. Verifica tus credenciales.",
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [                     
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/logo.jpg', width: 200, height: 200),
                  const Text('Iniciar Sesion', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 30),
                  const Text('Hola, gusto en conocerte', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Color.fromARGB(255, 174, 173, 173))),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextFieldLogin(label: 'Correo electronico',
                    hintText: 'Ingrese su correo', 
                    obscureText: false,                 
                    controller: emailController,),
                  ),
                  const SizedBox(height: 7),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextFieldLogin(label: 'Password',
                    hintText: 'Ingrese su contraseña', 
                    obscureText: true,
                    controller: passwordController,),
                  ),
                  const SizedBox(height: 30),
                  const Text('¿Olvidaste tu contraseña?', 
                    style: TextStyle(fontSize: 18, 
                      fontWeight: FontWeight.w600, 
                      color: Colors.blue
                    )
                  ),
                  const SizedBox(height: 30),               
                ],
              ),
            ),
            const SizedBox(height: 30),
            Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 50,
                child: ButtonLogin(
                  label: 'Iniciar Sesión',
                  onPressed: () {
                    signInWithEmailAndPassword();
                  },
                  backgroundColor: Colors.white,
                  textColor: Colors.grey,
                  sizeText: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            const SizedBox(height: 30),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 50,
              child: ButtonLogin(label: 'Crear Nueva Cuenta',
                onPressed: () {
                  Navigator.pushNamed(context, '/registerPage');
                },
                backgroundColor: const Color.fromARGB(255, 221, 219, 219),
                textColor: Colors.blue,
                sizeText: 20,
                fontWeight: FontWeight.bold,
              )
            ),
            const SizedBox(height: 20),
            const Text('o iniciar sesion con ', 
              style: TextStyle(fontSize: 18, 
                fontWeight: FontWeight.bold, 
                color: Colors.blue)
            ),
            
            GoogleAuthButton(
              onPressed: () {
                Fluttertoast.showToast(
                  msg: "Funcionalidad no implementada.",
                );
              },
              
              style: AuthButtonStyle(
                iconSize: 30,
                buttonType: AuthButtonType.icon,
                width: MediaQuery.of(context).size.width * 0.8,
                height: 50,
                iconBackground: Colors.white,
                margin: const EdgeInsets.only(top: 10, bottom: 10),
              ),
            ),
          ]),
          
        ),
      )
    );
  }
}



