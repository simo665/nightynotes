import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nightynotes/firebase_options.dart';
import 'package:nightynotes/pages/homepage.dart';
import 'package:nightynotes/pages/login.dart';
import 'package:nightynotes/pages/register.dart' show RegisterPage;
import 'package:nightynotes/pages/verify_email.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print('Firebase initialization error: $e');
  }
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
        "/verify-email/": (context) => const EmailVerification(),
      },
    );
  }
}
