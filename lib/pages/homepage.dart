import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nightynotes/pages/login.dart';
import 'package:nightynotes/pages/register.dart';
import 'package:nightynotes/design/colors.dart';
import 'package:nightynotes/pages/verify_email.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  
  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nighty Notes'),
        backgroundColor: titleColor,
      ),
      body: user == null
          ? const RegisterPage()
          : user.emailVerified == false
              ? const EmailVerification()
              : const Center(child: Text('Home Page')),
    );
  }
}
