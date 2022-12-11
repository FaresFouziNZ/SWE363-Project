import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:swe363project/web_pages/register_page.dart';

import '../cloud_functions/auth_service.dart';
import 'home_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Auth();
    RegExp regExp = RegExp('.*@.*');
    String email = '';
    String password = '';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF5C9CBF),
        elevation: 0,
        title: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          },
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.04,
            // color: const Color(0xFF477281),
            child: Icon(
              Icons.home_filled,
              size: MediaQuery.of(context).size.width * 0.03,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://firebasestorage.googleapis.com/v0/b/spc-watch-23a53.appspot.com/o/priscilla-du-preez-XkKCui44iM0-unsplash.jpg?alt=media&token=2db3a701-3908-40f8-8eaa-dff41576609b'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
              constraints: const BoxConstraints(
                minHeight: 100,
                minWidth: 350,
              ),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Color(0x88000000),
              ),
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.height * 0.4,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.018),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: TextField(
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: "Email",
                          hintStyle: TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                        onChanged: (value) => email = value,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.018),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: TextField(
                        obscureText: true,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: "Password",
                          hintStyle: TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                        onChanged: (value) => password = value,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.018),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (email == '') {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: const Text("Error"),
                                      content: const Text("Email is empty"),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: const Text("OK"),
                                        ),
                                      ],
                                    ));
                            return;
                          }
                          if (password == "") {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: const Text("Error"),
                                      content: const Text("Password is empty"),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: const Text("OK"),
                                        ),
                                      ],
                                    ));
                            return;
                          }
                          if (!regExp.hasMatch(email)) {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: const Text("Error"),
                                      content: const Text("Email is not valid"),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: const Text("OK"),
                                        ),
                                      ],
                                    ));
                            return;
                          }
                          if (password.length < 8) {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: const Text("Error"),
                                      content: const Text("Password must be at least 8 characters"),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: const Text("OK"),
                                        ),
                                      ],
                                    ));
                            return;
                          }
                          var result = await auth.signInWithEmailAndPassword(email, password);
                          if (result == null) {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: const Text("Error"),
                                      content: const Text("Email or password is incorrect"),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: const Text("OK"),
                                        ),
                                      ],
                                    ));
                            return;
                          }
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text("Login"),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.018),
                    RichText(
                        text: TextSpan(children: [
                      const TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(color: Colors.white),
                      ),
                      TextSpan(
                        text: "Sign up",
                        style: const TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacement(
                                context, MaterialPageRoute(builder: (context) => const RegisterPage()));
                          },
                      ),
                    ])),
                  ]),
                ),
              )),
        ),
      ),
    );
  }
}
