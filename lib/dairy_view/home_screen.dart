import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_dairy/dairy_Vm/dairy_Vm.dart';
import 'package:student_dairy/dbHelper/dbHelper.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _HomeScreen();

}
class _HomeScreen extends State<HomeScreen> {
  final dbhelper = Dbhelper();
  TextEditingController catogaryName = TextEditingController();
  late final vm = Provider.of<DairyVm>(context);
 late String username;
 Future <void> handleName()async {
     final SharedPreferences prefs = await SharedPreferences.getInstance();
     username = await prefs.getString("Name")?? "user";
 }
  final List<String> workGrid=[];

  @override
  void initState(){
    super.initState();
    loadWork();
  }
  Future<void> loadWork() async {
    final data = await Dbhelper().insertCatagory();
    setState(() {
      workGrid=data;
    });
  }
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
                itemCount: workGrid.length,
                itemBuilder: (context,index){
              return Container(
                height: 400,
                width: 400,
                child: Card(
                  color: Colors.black26,
                  child: Text(workGrid[index]),
                ),
              );

                }),ElevatedButton(onPressed: (){

            }, child: const Text("Add Tasks"))
          ],
        ),


      ),
    );
  }
  showDialogBox(){
    return AlertDialog(
      title: const Text("ADD Catagory"),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextField(
          controller: catogaryName,
          decoration: InputDecoration(
            label: const Text("Add catogory"),
            hintText: "DSA"
          ),
        ),
      ],
      ),
      actions: [
        ElevatedButton(onPressed: (){
          if(catogaryName!= null){
            dbhelper.insertCatagory(to);
          }
        }, child: const Text("ADD"))
      ],
    );
  }

}