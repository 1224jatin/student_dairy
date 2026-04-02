import 'package:flutter/cupertino.dart';
import 'package:student_dairy/dbHelper/dbHelper.dart';

import '../dairy_model/dairy_Model.dart';

class DairyVm extends ChangeNotifier{
 final dbHelper = Dbhelper();
 void addWork(Catagory catagory){
   dbHelper.insertCatagory(catagory);
   notifyListeners();
 }

  void operator [](other) {}
}