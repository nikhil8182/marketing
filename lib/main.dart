import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'App.dart';



FirebaseAuth auth = FirebaseAuth.instance;

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(
      MaterialApp(
        home: MyApp(),
         debugShowCheckedModeBanner: false,
  ));
}

