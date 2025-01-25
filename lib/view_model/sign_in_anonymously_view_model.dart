import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iss_app/screen/home_screen/home_screen.dart';
import 'package:iss_app/service/database.dart';

class SignInAnonymously {
  Database database = Database();

  Future<void> signInAnonymouslyLogIn(BuildContext context) async {
    try {
      // Perform anonymous sign-in
      await FirebaseAuth.instance.signInAnonymously();
      // Navigate to the second screen after successful sign-in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    } catch (e) {
      print("Error signing in anonymously: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to sign in anonymously')),
      );
    } finally {}
  }

  void googleSignIn(BuildContext context) async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    print('credential: ${googleAuth?.accessToken.toString()}');
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    UserCredential result = await FirebaseAuth.instance.signInWithCredential(credential);
    print('credential: ${result.user}');
    User? userdetails = result.user;
    if (result != null) {
      Map<String, dynamic> userInfoMap = {
        "email": userdetails!.email,
        "name": userdetails.displayName,
        "imgUrl": userdetails.photoURL,
        "id": userdetails.uid,
      };
      print('credential: ${userInfoMap}');

    }
  }
}
