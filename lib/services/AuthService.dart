import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authservice {
  final auth= FirebaseAuth.instance;

  Future<void> createUser( String email, String password) async{
    auth.createUserWithEmailAndPassword( email: email, password: password);
  }
  Future<void> loginUser(String email , String password ) async {
    auth.signInWithEmailAndPassword(email: email, password: password);
  }


}