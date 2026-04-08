import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Taskscreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _Taskscreen();
}
class _Taskscreen extends State<Taskscreen>{
  late List<Map<String,dynamic>> tasks = [];

  @override
  void initState(){
    getTasks();
  }

  Future<void>getTasks() async {
     // tasks = (await FirebaseFirestore.instance.collection("tasks").get()) as Map<String, dynamic>;

    try{
      var user = FirebaseAuth.instance.currentUser?.uid;
      if(user != null ){

        QuerySnapshot querySnapshots =  await FirebaseFirestore.instance.collection("Task").where("userId",isEqualTo: FirebaseAuth.instance.currentUser?.uid).get();
        setState(() {

          tasks = querySnapshots.docs.map((doc) => doc.data().toString()).cast<Map<String, dynamic>>().toList();

        });

      }else{
        print(" Error fethcvhing ");
      }

    }catch(e){
      print("${e}");
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child:
            ListView.builder(itemBuilder: (context,index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    color: Colors.black12,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Task Name =  ${tasks[index]["taskName"]}"),

                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("Task Description"),
                            Text("")
                          ],
                        )
                      ],
                    ),
                  )
                ]
              );

            },
              itemCount: tasks.length,
            ))
          ],
        ),
      ),
    );
  }


}