

class Categories{
  int? catId;
  final String category;

  Categories({
    this.catId,
    required this.category,
});
  Map<String,dynamic> toMapCategories(){
    return {
      "catId": catId,
      "catName": category,
    };
  }
}
class Task{
  int? taskId;
  final String taskName;
  //final int catId;
  final String taskDescription;
  //final bool isCompleted;

  Task({
    this.taskId,
    required this.taskName,
    //required this.catId,
    required this.taskDescription,
    //required this.isCompleted
});

  Map<String,dynamic> toMapTasks(){
    return {
      "taskId": taskId,
      "taskName": taskName,
      //"catID" : catId,
      "taskDescription": taskDescription,
      //"isCompleted": isCompleted,
    };

  }
}
