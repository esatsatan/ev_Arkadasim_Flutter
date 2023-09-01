import 'dart:async';

import 'package:ev_arkadasim/src/authentication/FirebaseAuth.dart';
import 'package:ev_arkadasim/src/home/HomeScreen.dart';
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
      _authService.sendVerificationEmail();

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
      ? const HomeScreen()
      : Scaffold(
          appBar: AppBar(
            title: Text('Email doğrulayın'),
          ),
        );
  //      ? Scaffold(body: CenteredText('Your email has been verified'))
}
