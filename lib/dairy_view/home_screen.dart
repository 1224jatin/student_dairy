import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _HomeScreen();

}
class _HomeScreen extends State<HomeScreen> {

 late String username;
 Future <void> handleName()async {
     final SharedPreferences prefs = await SharedPreferences.getInstance();
     username = await prefs.getString("Name")?? "user";

 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.handshake),
        title: Text(username,
            style: TextStyle(
                color: Colors.white,fontSize: 15
            )
        ),
      ),
      body: Center(

      ),
    );
  }

}