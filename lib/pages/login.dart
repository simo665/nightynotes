import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nightynotes/firebase_options.dart';
import 'package:nightynotes/design/colors.dart';
import 'package:nightynotes/pages/verify_email.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  late final TextEditingController _email = TextEditingController();
  late final TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future login() async {
    final email = _email.text;
    final password = _password.text;
    try {
				final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
        print(credential);
        if (credential.user != null) {
          if (credential.user!.emailVerified == false) {
            Navigator.of(context).pushNamedAndRemoveUntil("/verify-email/", (_) => false);
          } else {
            // ignore: use_build_context_synchronously
            Navigator.of(context).pushNamedAndRemoveUntil("/home/", (_) => false);
          }
        }
				
    } on FirebaseAuthException catch (e) {
			if (e.code == 'user-not-found') {
				print('No user found for that email.');
			} else if (e.code == 'wrong-password') {
				print('Wrong password provided for that user.');
			} else if (e.code == 'invalid-email') {
				print('Invalid email.');
			} else if (e.code == 'invalid-credential') {
				print('Invalid credential.');
			}
			 else {
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
        title: const Text('Login'),
        backgroundColor: titleColor,
        centerTitle: true,
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
            onPressed: login, 
            child: const Text('Login'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil("/register/", (_) => false), 
            child: const Text('Register'),
          ),
        ],
      ),
    );
  }
}