import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nightynotes/design/colors.dart';
import 'package:nightynotes/firebase_options.dart';
import 'package:nightynotes/pages/homepage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  late final TextEditingController _email = TextEditingController();
  late final TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future register() async {
    final email = _email.text;
    final password = _password.text;
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      if (credential.user != null) {
        if (credential.user!.emailVerified == false) {
          await credential.user!.sendEmailVerification();
        } else {
          // ignore: use_build_context_synchronously
          Navigator.of(context).pushNamedAndRemoveUntil("/login/", (_) => false);
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } else {
        print("Error: ${e.code}");
      }
    }
  }

  final future = Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: titleColor,
      ),
      body: Column(
        children: [
          // email field
          TextField(
            controller: _email,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email',
              hintText: 'Enter your email',
              prefixIcon: const Icon(Icons.email)
            ),
          ),
          // password field
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(
              labelText: 'Password',
              hintText: 'Enter your password',
              prefixIcon: const Icon(Icons.lock),
            ),
          ),
          TextButton(
            onPressed: register, 
            child: const Text('Register'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil("/login/", (_) => false);
            },
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}