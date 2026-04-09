import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_dairy/services/AuthService.dart';

import 'dairy_Register.dart';
import 'home_screen.dart';

class DairyLogin extends StatefulWidget {
  const DairyLogin({super.key});

  @override
  State<StatefulWidget> createState() => _DairyLogin();
}

class _DairyLogin extends State<DairyLogin> {
  final firebaseAuth = Authservice();
  final _formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  color: Colors.black12,
                  child: TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      label: Text("email ="),
                    ),
                  ),
                ),
                Card(
                  color: Colors.black12,
                  child: TextFormField(
                    controller: passController,
                    decoration: const InputDecoration(
                      label: Text("Password ="),
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (emailController.text.isNotEmpty &&
                          passController.text.isNotEmpty) {
                        try {
                          await firebaseAuth.loginUser(
                              emailController.text.trim(),
                              passController.text.trim());
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Login Successfully")));
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>  HomeScreen()));
                          }
                        } on FirebaseAuthException catch (e) {
                          String message = "Login failed";
                          if (e.code == 'invalid-credential' ||
                              e.code == 'wrong-password' ||
                              e.code == 'user-not-found') {
                            message = "Incorrect email or password.";
                          } else if (e.code == 'invalid-email') {
                            message = "Invalid email format.";
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(message)));
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Error: $e")));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text("Please fill all fields")));
                      }
                    },
                    child: const Text("Submit")),
                InkWell(
                  child: const Text("dont Have any account / click to register"),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DairyRegister()));
                  },
                )
              ],
            )));
  }
}
