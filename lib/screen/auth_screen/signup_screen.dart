import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Image.asset("assets/images/account.png"),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 30.0, right: 30.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color(0xFF498aa2),
                    Color(0xFF377b94),
                    Color(0xFF81b7cf),
                    Color(0xFF81b7cf),

                  ],begin: Alignment.topLeft, end: Alignment.bottomRight)
                ),
                
              ),
            ),

          ],
        ),
      ),

    );
  }
}
