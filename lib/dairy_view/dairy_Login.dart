import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DairyLogin extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _DairyLogin();

}
class _DairyLogin extends State<DairyLogin>{
  TextEditingController nameController = TextEditingController();
  TextEditingController stuIdController = TextEditingController();
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
        backgroundColor: Colors.black45,
        leading: Icon(Icons.login_rounded),
        title: const Text("Login ",style: TextStyle(color: Colors.white,fontSize: 15),),
      ),
      body: Center(
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
                  controller: stuIdController,
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
            ElevatedButton(onPressed: (){
              Navigator.of(context).pop;
            },
                child: const Text("Submit"))
          ],
        ),
      ),
    );
  }

}