import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_flutter/widgets/button_login.dart';
import 'package:proyecto_flutter/widgets/text_field_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterPage extends StatefulWidget {
  
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool termsChecked = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Future<void> _registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      if (user != null) {
        if (!user.emailVerified) {
          await user.sendEmailVerification();
        }
      }
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, '/loginPage');
    } catch (e) {
      
      Fluttertoast.showToast(msg: e.toString());
      emailController.text = '';
      passwordController.text = '';
    }
  }
  
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
          child: Column(
            children: [
              const Align(
                alignment: Alignment.topLeft, // Alineación en la esquina superior izquierda
                child: Padding(
                  padding: EdgeInsets.only(top: 90, left: 63), // Añadido padding izquierdo
                  child: Text(
                    'Crear Cuenta',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: SizedBox(
                  width: 350,
                  child: TextFieldLogin(label: 'AppleID',
                  hintText: 'Ingrese su Apple ID', 
                  obscureText: false,
                  controller: emailController,
                  ),
                ),
              ),
              const SizedBox(height: 2),
              SizedBox(
                width: 350,
                child: TextFieldLogin(label: 'Password',
                hintText: 'Ingrese su contraseña', 
                obscureText: true,
                controller: passwordController,),
              ),
              const SizedBox(height: 70),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Checkbox(
                  value: termsChecked,
                  onChanged: (bool? termsChecked) {
                    setState(() {
                      this.termsChecked = termsChecked?? false;
                    });
                  },
                ),
                
                RichText(
                  text: TextSpan(
                    text: 'Acepto los ',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: 'términos y condiciones',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                          },
                      ),
                      const TextSpan(
                        text: '\nademás de nuestra ',
                      ),
                      const TextSpan(
                        text: 'política de privacidad',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ],
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: 350,
                height: 50,
                child: ButtonLogin(label: 'Crear Cuenta',
                  onPressed: () {
                    if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){
                      if(termsChecked){
                        String email = emailController.text;
                        String password = passwordController.text;
                        
                        _registerWithEmailAndPassword(email, password);
                        
                      }else{
                        Fluttertoast.showToast(
                            msg: "Debes aceptar los terminos y condiciones",
                            
                        );
                      }
                    }else{
                      Fluttertoast.showToast(
                          msg: "Debes llenar todos los campos",

                      );
                    }     
                  },
                  backgroundColor: const Color.fromARGB(255, 221, 219, 219),
                  textColor: Colors.blue,
                  sizeText: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(text: TextSpan(
                    text: 'Ya tienes una cuenta ? ',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 159, 159, 159),
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: 'Inicia sesion',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, '/loginPage');
                          },
                      ),
                    ]
                  )
                  )
                ],
              ),
            ],
          ), 
        ),
    );

  }
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}