import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({super.key});

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Email not verified"),
          Center(
            child: TextButton(
              child: const Text("Send verification link"),
              onPressed: () async {
                await FirebaseAuth.instance.currentUser!.sendEmailVerification();
              },
            ),
          ),
          Center(
            child: TextButton(
              child: const Text("Go Back to Login"),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                // ignore: use_build_context_synchronously
                Navigator.of(context).pushNamedAndRemoveUntil("/login/", (_) => false);
              },
            ),
          )
        ],
      );
  }
}