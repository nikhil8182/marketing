import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:marketing/splashScreen.dart';

import 'App.dart';


FirebaseAuth auth = FirebaseAuth.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations
    ([
  DeviceOrientation.portraitUp,
  DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp();
  runApp(
      MaterialApp(
        home: MyApp(),
         debugShowCheckedModeBanner: false,
  ));
}

