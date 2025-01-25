import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iss_app/screen/auth_screen/signup_screen.dart';
import 'package:iss_app/screen/home_screen/home_screen.dart';
import 'package:iss_app/view_model/sign_in_anonymously_view_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  SignInAnonymously signInAnonymously=SignInAnonymously();
  String email = "", password = "";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  void login(String emailAddress, String password) async {
    print('$emailAddress, $password');
    setState(() {
      isLoading = true;
    });
    try {
      FirebaseAuth.instance.setLanguageCode('en');
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      print("Login ${credential.user}");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign in successful!')),
      );
    } catch (e) {
      print('Error: ${e}');
      // if (e.code == 'user-not-found') {
      //   print('No user found for that email.');
      // } else if (e.code == 'wrong-password') {
      //   print('Wrong password provided for that user.');
      // }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset("assets/images/welcome_screen.png"),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 30.0, right: 30.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color(0xFF9dc3d5),
                Color(0xFF9ac3d4),
                Color.fromARGB(145, 27, 94, 118),
              ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
              child: Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 30.0,
                    ),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255), fontSize: 20.0, fontWeight: FontWeight.bold),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.5), // The default color when not focused
                        ),
                      ),
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255), fontSize: 20.0, fontWeight: FontWeight.bold),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.5), // The default color when not focused
                        ),
                      ),
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0, left: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Sign in",
                            style: TextStyle(color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            onTap: () {
                              email = emailController.text;
                              password = passwordController.text;
                              login(email, password);
                              print('Sign In');
                            },
                            child: Material(
                              elevation: 5.0,
                              borderRadius: BorderRadius.circular(60),
                              child: Container(
                                padding: EdgeInsets.all(20),
                                decoration:
                                    BoxDecoration(color: Color(0xFF4C7296), borderRadius: BorderRadius.circular(60)),
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 30.0,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // AuthMethods().signInWithGoogle(context);
                            print('google');
                            signInAnonymously.googleSignIn(context);                          },
                          child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                            child: Image.asset(
                              "assets/images/google.png",
                              height: 40,
                              width: 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 30.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            print('google');
                            // AuthMethods().signInWithGoogle(context);
                            // signInAnonymously.googleSignIn();
                          },
                          child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                            child: Image.asset(
                              "assets/images/apple.png",
                              height: 40,
                              width: 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255), fontSize: 18.0, fontWeight: FontWeight.w500),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignupScreen()),
                            );
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
