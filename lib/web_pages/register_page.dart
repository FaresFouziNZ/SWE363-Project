import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:swe363project/cloud_functions/auth_service.dart';
import 'package:swe363project/web_pages/home_page.dart';
import 'package:swe363project/web_pages/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _showPassword = false;
  bool _showConfirmPassword = false;
  String email = '';
  String password = '';
  String confirmPassword = '';
  bool creating = false;
  @override
  Widget build(BuildContext context) {
    final auth = Auth();

    RegExp regExp = RegExp('.*@.*');
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Create Account",
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
                          obscureText: !_showPassword,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  _showPassword = !_showPassword;
                                  setState(() {});
                                },
                                icon: _showPassword
                                    ? const Icon(
                                        Icons.visibility_off,
                                        color: Colors.white,
                                      )
                                    : const Icon(
                                        Icons.visibility,
                                        color: Colors.white,
                                      )),
                            hintText: "Password",
                            hintStyle: const TextStyle(color: Colors.white),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                            ),
                          ),
                          onChanged: (value) => password = value,
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.018),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: TextField(
                          obscureText: !_showConfirmPassword,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  _showConfirmPassword = !_showConfirmPassword;
                                  setState(() {});
                                },
                                icon: _showConfirmPassword
                                    ? const Icon(
                                        Icons.visibility_off,
                                        color: Colors.white,
                                      )
                                    : const Icon(
                                        Icons.visibility,
                                        color: Colors.white,
                                      )),
                            hintText: "Confirm Password",
                            hintStyle: const TextStyle(color: Colors.white),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                            ),
                          ),
                          onChanged: (value) => confirmPassword = value,
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
                            if (confirmPassword == '') {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: const Text("Error"),
                                        content: const Text("Confirm Password is empty"),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(context),
                                            child: const Text("OK"),
                                          ),
                                        ],
                                      ));
                              return;
                            }
                            if (password != confirmPassword) {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: const Text("Error"),
                                        content: const Text("Passwords do not match"),
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
                            creating = true;
                            var result = await auth.registerWithEmailAndPassword(email, password);
                            creating = false;
                            if (result == null) {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: const Text("Error"),
                                        content: const Text("Email is already in use"),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(context),
                                            child: const Text("OK"),
                                          ),
                                        ],
                                      ));
                              return;
                            }
                            await showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: const Text("Success"),
                                      content: const Text("Account created"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            creating = false;
                                            Navigator.pop(context);
                                            Navigator.pushReplacement(
                                                context, MaterialPageRoute(builder: (context) => const HomePage()));
                                          },
                                          child: const Text("OK"),
                                        ),
                                      ],
                                    ));
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: creating == false ? const Text("Create Account") : const CircularProgressIndicator(),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.018),
                      RichText(
                          text: TextSpan(children: [
                        const TextSpan(text: "Already have an account? ", style: TextStyle(color: Colors.white)),
                        TextSpan(
                          text: "Sign In",
                          style: const TextStyle(color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacement(
                                  context, MaterialPageRoute(builder: (context) => const LoginPage()));
                            },
                        ),
                      ])),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
