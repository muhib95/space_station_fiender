import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iss_app/screen/auth_screen/login_screen.dart';
import 'package:iss_app/screen/home_screen/home_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String email = "", password = "", name = "";
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading=false;

  void registration(String emailAddress, String password) async {
    setState(() {
      isLoading=true;
    });
    try {
      UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      // Save the user's display name
      await credential.user?.updateDisplayName(nameController.text.trim());

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign up successful!')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }finally{
      setState(() {
        isLoading=false;
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading?Center(
        child: CircularProgressIndicator(), // Default circular loader
      ):Container(
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
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          hintText: "Name",
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
                              "Sign Up",
                              style: TextStyle(color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold),
                            ),
                            GestureDetector(
                              onTap: () {
                                final name = nameController.text;
                                final email = emailController.text;
                                final pass = passwordController.text;
                                registration(email, pass);
                                print('Sign Up ${name} ${email} ${pass}');
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
                          Text(
                            "Already have an account? ",
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255), fontSize: 18.0, fontWeight: FontWeight.w500),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LoginScreen()),
                              );
                            },
                            child: Text(
                              "Sign in",
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
      ),
    );
  }
}
