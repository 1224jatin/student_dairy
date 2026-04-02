class Catagory{
  final String catagory;

  Catagory({
    required this.catagory,

});
  Map<String,dynamic> toMap(Catagory catagory){
    return {
      "id" : catagory,
    };
  }
}

