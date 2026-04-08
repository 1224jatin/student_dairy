import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_dairy/services/AuthService.dart';

import 'dairy_Login.dart';

class DairyRegister extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _DairyRegister();

}
class _DairyRegister extends State<DairyRegister>{
  late final firebaseAuthService = Authservice();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  Future<void> handleName() async {
    if (_formkey.currentState!.validate()){
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("Name",nameController.text);
    }


}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF02034C),
        leading: Icon(Icons.login_rounded),
        title: const Text("Login ",style: TextStyle(color: Colors.white,fontSize: 15),),
      ),
      body: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // name controller
            Container(
              height: 100,
              width: 600,
              child: Card(
                color: Colors.black12,
                child: TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                      label: const Text("Name = "),
                      hintText: "joe hopkins"
                  ),
                ),
              ),
            ),
            Container(
              //student id Controller
              height: 100,
              width: 600,
              child: Card(
                color: Colors.black12,
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                      label: const Text(" Student Id = "),
                  ),
                ),
              ),
            ),
            Container(
              // passController
              height: 100,
              width: 600,
              child: Card(
                color: Colors.black12,
                child: TextFormField(
                  controller: passController,
                  decoration: InputDecoration(
                      label: const Text("Password"),
                  ),
                ),
              ),
            ),
            ElevatedButton(onPressed: () async {

              if(emailController.text != null && passController.text!= null){
                /*FirebaseFirestore.instance.collection("Users").add({
                  "id" : FirebaseFirestore.instance.collection("Users").doc().id,
                  "email": emailController,
                  "password": passController
                });*/

                try {

                  UserCredential result = await firebaseAuthService.createUser(emailController.text, passController.text);
                  User? user = result.user;

                  if(user != null){
                    FirebaseFirestore.instance.collection("Users").add({
                      "userId":FirebaseFirestore.instance.collection("Users").doc().id,
                      "userEmail":emailController.text,
                      "userName":nameController.text,
                    });
                  }
                }catch(e){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(" Firebase Errros 0 "),duration: Duration(seconds: 5),));
                }
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DairyLogin()));



              }


            },
                child: const Text("Submit")),

          ],
        ),
      ),
    );
  }

}