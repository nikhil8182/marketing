import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:marketing/splashScreen.dart';


FirebaseAuth auth = FirebaseAuth.instance;

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(
      MaterialApp(
        home: SplashScreen(),
         debugShowCheckedModeBanner: false,
  ));
}

