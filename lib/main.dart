import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_app/screens/base.dart';
import 'package:food_app/screens/sign_in_screen.dart';
import 'package:food_app/screens/sign_up_screen.dart';
import 'package:food_app/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      log('user.email: ${user.email}');
      log('user.metadata: ${user.metadata}');
      print('User is signed in!');
    }
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Our Food App',
      debugShowCheckedModeBanner: false,
      // home: const SplashScreen(),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        'base_screen': (context) => const BaseScreen(),
        'SignUpScreen': (context) => const SignUpScreen(),
        'SignInScreen': (context) => const SignInScreen(),
      },
    );
  }
}
