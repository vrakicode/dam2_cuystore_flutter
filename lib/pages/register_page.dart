import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
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
  
  final _formKey = GlobalKey<FormBuilderState>();
  bool termsChecked = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
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
      await FirebaseFirestore.instance.collection('users').doc(user?.uid).set({
        'fullName': fullNameController.text,
        'email': email,
        'dob': dobController.text,
      });
      
      
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
                  padding: EdgeInsets.only(top: 90, left: 55), // Añadido padding izquierdo
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
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextFieldLogin(label: 'Correo Electronico',
                  hintText: 'Ingrese su correo', 
                  obscureText: false,
                  controller: emailController,
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFieldLogin(label: 'Nombre Completo',
                hintText: 'Ingrese su nombre completo', 
                obscureText: false,
                controller: fullNameController,),
              ),
              const SizedBox(height: 10),
              FormBuilder(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: FormBuilderDateTimePicker(
                        name: 'dob',
                        inputType: InputType.date,
                        controller: dobController,
                        decoration: const InputDecoration(
                          labelText: 'Fecha de Nacimiento',
                        ),
                        validator: FormBuilderValidators.required(),
                      ),
                    ),
                    const SizedBox(height: 7),
                    // ... (existing code)
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFieldLogin(label: 'Contraseña',
                hintText: 'Ingrese su contraseña', 
                obscureText: true,
                controller: passwordController,),
              ),
              const SizedBox(height: 10,),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFieldLogin(
                  label: 'Confirmar Contraseña',
                  hintText: 'Confirme su contraseña',
                  obscureText: true,
                  controller: confirmPasswordController,
                ),
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
                
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: RichText(
                    text: TextSpan(
                      text: 'Acepto los ',
                      style: const TextStyle(
                        fontSize: 15,
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
                ),
              ],
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 50,
                child: ButtonLogin(label: 'Crear Cuenta',
                  onPressed: () {
                    if (emailController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty &&
                        confirmPasswordController.text.isNotEmpty) {
                          if (termsChecked) {
                            if (passwordController.text == confirmPasswordController.text) {
                        
                              String email = emailController.text;
                              String password = passwordController.text;
        
                              _registerWithEmailAndPassword(email, password);
                              Fluttertoast.showToast(
                                msg: "Cuenta creada con exito",
                              );
                              Navigator.pushNamed(context, '/loginPage');
                            } else {
                              Fluttertoast.showToast(
                                msg: "Las contraseñas no coinciden",
                              );
                            }
                          } else {
                            Fluttertoast.showToast(
                              msg: "Debes aceptar los terminos y condiciones",
                            );
                          }
                      
                    } else {
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
    confirmPasswordController.dispose();
    super.dispose();
  }
}