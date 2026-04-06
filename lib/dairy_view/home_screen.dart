import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_dairy/dairy_Vm/dairy_Vm.dart';
import 'package:student_dairy/dairy_model/dairy_Model.dart';
import 'package:student_dairy/dbHelper/dbHelper.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _HomeScreen();

}
class _HomeScreen extends State<HomeScreen> {
  final dbhelper = Dbhelper();
  late final vm = Provider.of<DairyVm>(context);
  TextEditingController taskNameController = TextEditingController();
  TextEditingController selectCetagoryController =TextEditingController();
  TextEditingController taskDescriptionController = TextEditingController();
  TextEditingController isCompletedController = TextEditingController();
  List<String> categories= [];
  TextEditingController addCategoryController = TextEditingController();

 late String username;
 Future <void> handleName()async {
     final SharedPreferences prefs = await SharedPreferences.getInstance();
     username = await prefs.getString("Name")?? "user";
 }

  @override
  initDb(){
   super.initState();
   loadCategories();
 }
  Future<void> loadCategories() async {
   final data = await dbhelper.selectTask();
   setState(() {

   });
 }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.handshake),
        title: Text("${username} , ADD YOU TASK . ",
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
            Card(
              ),
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
            ElevatedButton(onPressed:(){

            } , child: const Text("Add"))
          ],
        ),


      ),
    );
  }
  showDialogBox(){
   AlertDialog(
     title: const Text("Add catagory") ,
     content: Column(
       mainAxisAlignment: MainAxisAlignment.center,
       crossAxisAlignment: CrossAxisAlignment.center,
       children: [
         Card(
           color: Colors.black12,
           child: TextField(

             controller: addCategoryController,
             decoration: InputDecoration(
                 label:  const Text("Category =  ")
             ),
           ),
         )
       ],
     ),
     actions: [
       ElevatedButton(onPressed: (){
         if(addCategoryController != null ){
           dbhelper.insertCategory(
             Categories(category: addCategoryController.text)
           );
           loadCategories();
         }
       }, child: const Text("ADD"))
     ],
   );
  }
}