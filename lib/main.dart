import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_flutter/firebase_options.dart';
import 'package:proyecto_flutter/pages/index.dart';
import 'package:proyecto_flutter/pages/login_page.dart';
import 'package:proyecto_flutter/pages/register_page.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
} 

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute:'/loginPage',
      routes: {
        '/loginPage':(context) => const LoginPage(),
        '/registerPage':(context) => const RegisterPage(),
        '/':(context) => const IndexPage(),
      },
    );
  }
}