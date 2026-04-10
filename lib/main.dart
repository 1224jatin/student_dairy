import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:student_dairy/dairy_view/home_screen.dart';
import 'firebase_options.dart';
import 'dairy_view/dairy_Login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   const MyApp({super.key});


   Widget getUser(){
     final firebaseAuth = FirebaseAuth.instance;
    if (firebaseAuth.currentUser != null){
      return HomeScreen();
    }
    else {
      return DairyLogin();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Dairy',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: getUser(),

    );
  }
}
