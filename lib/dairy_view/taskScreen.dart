import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Taskscreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _Taskscreen();
}
class _Taskscreen extends State<Taskscreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListView.builder(itemBuilder: (context,index){
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
                            const Text("Task Name ="),
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
                ],
              );
            })
          ],
        ),
      ),
    );
  }

}