import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_dairy/dairy_model/dairy_Model.dart';
import 'package:student_dairy/dairy_view/update_Task.dart';

class Taskscreen extends StatefulWidget {
  const Taskscreen({super.key});

  @override
  State<StatefulWidget> createState() => _Taskscreen();
}

class _Taskscreen extends State<Taskscreen> {
  List<Map<String, dynamic>> tasks = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getTasks();
  }

  Future<void> getTasks() async {
    try {
      final String? uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        QuerySnapshot querySnapshots = await FirebaseFirestore.instance
            .collection("Task")
            .where("userId", isEqualTo: uid)
            .get();

        setState(() {
          tasks = querySnapshots.docs
              .map((doc) => doc.data() as Map<String, dynamic>)
              .toList();
        });
      } else {
        setState(() => isLoading = false);
      }
    } catch (e) {
      print("Error fetching tasks: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child:
          ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return GestureDetector(
                onLongPress: () async {

                  QuerySnapshot querySnapshots = await FirebaseFirestore.instance
                      .collection("Task")
                      .where("userId", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
                      .get();

                  var docId = querySnapshots.docs[index].id;

                  setState(() {
                    try{
                        FirebaseFirestore.instance.collection("Task").doc(docId).delete();
                        if (mounted){
                          getTasks();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Deleted")));
                        }

                    }catch(e){
                      print(e);
                    }
                  });


                },onDoubleTap: (){
                setState(() {
                  var taskIndex = task;
                  Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (context) => UpdateTask(taskIndex: index,),
                      ),);

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("bohpujphyphyg")));

                });

              },
                child: Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  color: Colors.black12,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Task Name: ${task["taskName"]}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Description: ${task["taskDescription"]}",
                          style: const TextStyle(color: Colors.black87),
                        ),
                        SizedBox(height: 20 )
                      ],
                    ),
                  ),
                ),
              );
            },
          ))
        ],
      ),
    );
  }
}
