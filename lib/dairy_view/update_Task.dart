import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_dairy/dairy_view/taskScreen.dart';

class UpdateTask extends StatefulWidget
{
  final dynamic taskIndex;

  const UpdateTask({super.key,required this.taskIndex});
  
  @override
  State<StatefulWidget> createState() =>_UpdateTask();
}
class _UpdateTask extends State<UpdateTask>{

  final _formkey = GlobalKey<FormState>();
  TextEditingController updateTaskNameContorller =TextEditingController();
  TextEditingController updateDescContorller =TextEditingController();


  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Form(key:_formkey,
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: updateTaskNameContorller,
                decoration: InputDecoration(
                  label: const Text("Update Task Name")
                ),
              ),
              TextFormField(
                controller: updateDescContorller,
                decoration: InputDecoration(
                    label: const Text("Update Task Description")
                ),
              ),
              ElevatedButton(onPressed: () async {
                try{
                  setState(() async {

                    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("Task").where("userId",isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();
                    var docId = querySnapshot.docs[widget.taskIndex].id;

                    FirebaseFirestore.instance.collection("Task").doc(docId).update(
                        {
                          "taskName": updateTaskNameContorller.text,
                          "taskDesc": updateDescContorller.text
                        }
                    );
                  });

                }catch (e){
                  print(e);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("error - ${e}")));
                }
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Taskscreen()));
              }, child: Text("Update"))
            ],
          )
      )
    );
  }

}