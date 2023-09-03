import 'package:ev_arkadasim/src/authentication/VerifyEmailScreen.dart';
import 'package:ev_arkadasim/src/home/HomeScreen.dart';
import 'package:ev_arkadasim/src/login/SignIn.dart';
import 'package:ev_arkadasim/src/login/SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../src/Home/HomeScreen.dart';
import 'src/login/SignUp.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData( 
        primarySwatch: Colors.blue,
      ),
      home: SignIn(),
    );
  }
}
