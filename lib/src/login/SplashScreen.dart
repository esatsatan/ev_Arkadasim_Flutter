import 'package:ev_arkadasim/src/home/HomeScreen.dart';
import 'package:ev_arkadasim/src/login/SignIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    // KULLANICI OTURUM AÇMIŞ MI AÇMAMMIŞ MI KONTROL ET.
    if (user != null) {
      return HomeScreen();
    } else {
      //return SignIn();
      return Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'SplashScreen',
                style: TextStyle(color: Colors.white),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignIn(),
                    ),
                  );
                },
                child: Text('Devam Et'),
              ),
            ],
          ));
    }
  }
}
