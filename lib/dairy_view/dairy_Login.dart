import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_dairy/services/AuthService.dart';

import 'dairy_Register.dart';
import 'home_screen.dart';

class DairyLogin extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _DairyLogin();
}
class _DairyLogin extends State<DairyLogin>{
  final firebaseAuth = Authservice();
  final _formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(key:_formkey,child:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Card(
            color: Colors.black12,
            child: TextFormField(
              controller: emailController,
              decoration:InputDecoration(
                label: const Text("email ="),
              ),
            ),
          ),
          Card(
            color: Colors.black12,
            child: TextFormField(
              controller: passController,
              decoration:InputDecoration(
                label: const Text("Password ="),
              ),
            ),
          ),
          ElevatedButton(onPressed: (){
            if(emailController != null && passController != null){
              firebaseAuth.loginUser(emailController.text, passController.text);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${emailController.text} is login successfully....!!")));
              Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
            }
          }, child: const Text("Submit")),
          InkWell(
            child: Text("dont Have any account / click to register"),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> DairyRegister()));
            },
          )
        ],
      ))
    );
  }
}