import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_dairy/services/AuthService.dart';

import 'dairy_Login.dart';

class DairyRegister extends StatefulWidget {
  const DairyRegister({super.key});

  @override
  State<StatefulWidget> createState() => _DairyRegister();
}

class _DairyRegister extends State<DairyRegister> {
  final firebaseAuthService = Authservice();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF02034C),
        leading: const Icon(Icons.login_rounded),
        title: const Text(
          "Register",
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 600,
                child: Card(
                  color: Colors.black12,
                  child: TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                        label: Text("Name = "), hintText: "joe hopkins"),
                  ),
                ),
              ),
              Container(
                height: 100,
                width: 600,
                child: Card(
                  color: Colors.black12,
                  child: TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      label: Text(" Email = "),
                    ),
                  ),
                ),
              ),
              Container(
                height: 100,
                width: 600,
                child: Card(
                  color: Colors.black12,
                  child: TextFormField(
                    controller: passController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      label: Text("Password"),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (emailController.text.isNotEmpty &&
                        passController.text.isNotEmpty) {
                      try {
                        UserCredential result = await firebaseAuthService
                            .createUser(emailController.text.trim(),
                                passController.text.trim());
                        User? user = result.user;

                        if (user != null) {
                          // Save name to preferences
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await prefs.setString("Name", nameController.text);

                          // Add to Firestore
                          await FirebaseFirestore.instance
                              .collection("Users")
                              .doc(user.uid)
                              .set({
                            "userId": user.uid,
                            "userEmail": emailController.text.trim(),
                            "userName": nameController.text.trim(),
                            "createdAt": FieldValue.serverTimestamp(),
                          });

                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Registration Successful!")));
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const DairyLogin()));
                          }
                        }
                      } on FirebaseAuthException catch (e) {
                        String message = "Registration failed";
                        if (e.code == 'email-already-in-use') {
                          message = "This email is already registered.";
                        } else if (e.code == 'weak-password') {
                          message = "The password provided is too weak.";
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
            ],
          ),
        ),
      ),
    );
  }
}
