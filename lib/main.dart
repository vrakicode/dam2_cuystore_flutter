import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proyecto_flutter/firebase_options.dart';
import 'package:proyecto_flutter/pages/index.dart';
import 'package:proyecto_flutter/pages/login_page.dart';
import 'package:proyecto_flutter/pages/register_page.dart';
FirebaseAuth _auth = FirebaseAuth.instance;
void main() async {
  

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp(const MyApp());
} 

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(useMaterial3: true),
      initialRoute: _auth.currentUser != null ? '/index' : '/loginPage',
      routes: {
        '/loginPage': (context) => const LoginPage(),
        '/registerPage': (context) => const RegisterPage(),
        '/index': (context) => const IndexPage(),
      },
      onGenerateRoute: (settings) {
        // Puedes manejar rutas adicionales aquí si es necesario
      },
      onUnknownRoute: (settings) {
        // Manejar rutas desconocidas aquí si es necesario
      },
    );
  }
}