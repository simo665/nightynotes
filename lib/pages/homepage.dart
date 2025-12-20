import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nightynotes/firebase_options.dart';
import 'package:nightynotes/pages/login.dart';
import 'package:nightynotes/pages/register.dart';
import 'package:nightynotes/design/colors.dart';
import 'package:nightynotes/pages/verify_email.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  
  @override
  Widget build(BuildContext context) {
    final future = Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nighty Notes'),
        backgroundColor: titleColor,
      ),
      body: FutureBuilder(
        future: future,
        builder: (context, asyncSnapshot) {
          switch (asyncSnapshot.connectionState) {
            case ConnectionState.done:
              // get current user
              var user = FirebaseAuth.instance.currentUser;
              if (user == null) {
                return const RegisterPage();
              } else if (user.emailVerified == false) {
                  return const EmailVerification();
                } else {
                  return const Center(child: Text('Home Page'));
              }
            default:
              return const CircularProgressIndicator();
          }
        }
      ),
    );
  }
}
