import 'dart:async';

import 'package:ev_arkadasim/src/authentication/AuthRepository.dart';
import 'package:ev_arkadasim/src/home/BaseScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  AuthService _authService = AuthService();
  bool isEmailVerified = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      //_authService.sendVerificationEmail();

      timer = Timer.periodic(
          Duration(
            seconds: 3,
          ),
          (_) => checkEmailVerified());
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    // call after amil verification
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) timer?.cancel();
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 400,
                margin: EdgeInsets.only(left: 40, right: 40),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                ),
                //color: Colors.grey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.verified_user_outlined,
                      size: 100,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Mail adresiniz başarıyla.',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          textBaseline: TextBaseline.alphabetic,
                          decoration: TextDecoration.none),
                    ),
                    Text(
                      'doğrulandı.',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          textBaseline: TextBaseline.alphabetic,
                          decoration: TextDecoration.none),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Düğmeye tıklanınca yapılacak işlemi burada tanımlayın.
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => BaseScreen(),
                          ),
                          (route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.white,
                      ),
                      child: Text(
                        "Devam et",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      : Scaffold(
          appBar: AppBar(
            title: Text('Email doğrulayın'),
          ),
        );
  //      ? Scaffold(body: CenteredText('Your email has been verified'))
}
