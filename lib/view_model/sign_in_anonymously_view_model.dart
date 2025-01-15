import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iss_app/screen/home_screen/home_screen.dart';

class SignInAnonymously {
  Future<void> signInAnonymouslyLogIn(BuildContext context) async {
    try {
      // Perform anonymous sign-in
      await FirebaseAuth.instance.signInAnonymously();
      // Navigate to the second screen after successful sign-in
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),),);
    } catch (e) {
      print("Error signing in anonymously: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to sign in anonymously')),
      );
    }
    finally{

    }
  }

}