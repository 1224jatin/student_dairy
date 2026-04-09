import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_dairy/dairy_Vm/dairy_Vm.dart';
import 'package:student_dairy/dairy_model/dairy_Model.dart';
import 'package:student_dairy/dairy_view/taskScreen.dart';
import 'package:student_dairy/dbHelper/dbHelper.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _HomeScreen();

}
class _HomeScreen extends State<HomeScreen> {

  TextEditingController taskNameController = TextEditingController();
  TextEditingController selectCetagoryController =TextEditingController();
  TextEditingController taskDescriptionController = TextEditingController();
  TextEditingController isCompletedController = TextEditingController();
  List<String> categoriesList= [];
  TextEditingController addCategoryController = TextEditingController();
  final  firestore = FirebaseFirestore.instance;

  /*String username = "jatin";
 Future <void> handleName()async {
     final SharedPreferences prefs = await SharedPreferences.getInstance();
     username = await prefs.getString("Name")?? "user";
 }*/

  /*@override
  initDb(){
   super.initState();
   loadCategories();
 }
  Future<void> loadCategories() async {
   setState(() {

   });
 }
 */

  Future<void> addTask(Task task) async {
     await firestore.collection("tasks").add({
      "taskId":firestore.collection("tasks").doc().id,
      "taskName":task.taskName,
      "taskDesc":task.taskDescription
    });

  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.handshake),
        title: Text(" ADD YOU TASK . ",
            style: TextStyle(
                color: Colors.white,fontSize: 15
            )
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              color: Colors.black12,
              child: TextField(
                controller: taskNameController,
                decoration: InputDecoration(
                  label: const Text("Task Name =")
                ),
              ),
            ),
            //select category
            /*Card(
              child: ElevatedButton(onPressed: (){
                 showDialogBoxforAddCategories(context);
              }, child: const Text("add categorie")),

              ),*/
            Card(
              color: Colors.black12,
              child: TextField(
                controller: taskDescriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                    label: const Text("Task Name ="),
                ),
              ),
            ),
            ElevatedButton(onPressed:() {

              if(taskNameController.text !=null && taskDescriptionController.text!=null){
                try {
                  firestore.collection("Task").add({
                    "taskId":firestore.collection("Task").doc().id,
                    "userId" : FirebaseAuth.instance.currentUser?.uid,
                    "taskName":taskNameController.text,
                    "taskDesc":taskDescriptionController.text
                  });

                }catch (e){
                  print(e);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("error ${e}")));
                }

                Navigator.push(context, MaterialPageRoute(builder: (context)=>Taskscreen()));
              }



            } , child: const Text("Add")),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Taskscreen()));
            }, child: Text("Navigate to List "))
          ],
        ),
      ),
    );
  }


   /*void showDialogBoxforAddCategories (BuildContext contex){
   showDialog(context: context, builder: (BuildContext context){
     return AlertDialog(
       title: const Text("Add catagory"),
       content: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           Card(
             color: Colors.black12,
             child: TextField(

               controller: addCategoryController,
               decoration: InputDecoration(
                   label: const Text("Category =  ")
               ),
             ),
           )
         ],
       ),
       actions: [
         ElevatedButton(onPressed: () {
           if (addCategoryController != null) {
             FirebaseFirestore.instance.collection("categories").add({
               "category": addCategoryController.text,
               "catId": FirebaseFirestore.instance.doc("categories").id,
             });
           }
         }, child: const Text("ADD"))
       ],
     );
   });
   }*/
}