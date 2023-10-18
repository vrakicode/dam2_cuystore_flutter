import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:proyecto_flutter/pages/index.dart';
import 'package:proyecto_flutter/pages/login_page.dart';
FirebaseAuth _auth = FirebaseAuth.instance;
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: "assets/images/logo.jpg", 
      nextScreen: _auth.currentUser != null ? const IndexPage() : const LoginPage(),
      splashTransition: SplashTransition.slideTransition,
      
    );
  }
}