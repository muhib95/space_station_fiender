import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iss_app/view_model/sign_in_anonymously_view_model.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  SignInAnonymously signInAnonymously=SignInAnonymously();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
Future.delayed(Duration(milliseconds: 2000),() {
  signInAnonymously.signInAnonymouslyLogIn(context);
},);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
      ),

    );
  }
}
