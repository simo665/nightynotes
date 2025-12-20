import 'package:flutter/material.dart';
import 'package:nightynotes/pages/homepage.dart';
import 'package:nightynotes/pages/login.dart';
import 'package:nightynotes/pages/register.dart' show RegisterPage;


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nighty Notes',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 223, 93, 238)),
      ),
      home: const HomePage(),
      routes: {
        '/login/': (context) => const LoginPage(),
        '/register/': (context) => const RegisterPage(),
      },
    );
  }
}
