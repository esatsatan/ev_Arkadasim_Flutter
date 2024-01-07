import 'dart:io';

import 'package:ev_arkadasim/src/authentication/AuthRepository.dart';
import 'package:ev_arkadasim/src/home/HomeScreen.dart';
import 'package:ev_arkadasim/src/login/PhoneLogin.dart';
import 'package:ev_arkadasim/src/login/SignUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final FocusNode _focusNodePassword = FocusNode();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //bool isLoading = false;

  bool _obscurePassword = true;
  //AuthService _authService = AuthService();
  bool _isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  Future<void> loginUser(
      {required String email, required String password}) async {
    try {
      final UserCredential authresult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final User? user = authresult.user;

      // giriş başarılı ise ana sayfaya geç
      if (user != null) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
          (route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            width: 250,
            backgroundColor: Colors.lightBlue[100],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            behavior: SnackBarBehavior.floating,
            content: const Center(
              child: Text(
                "Böyle bir kullanıcı bulunamadı",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            width: 250,
            backgroundColor: Colors.lightBlue[100],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            behavior: SnackBarBehavior.floating,
            content: const Center(
              child: Text(
                "Şifrenizi Tekrar Deneyiniz",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        );
      } else if (e.code == 'invalid-email') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            width: 250,
            backgroundColor: Colors.lightBlue[100],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            behavior: SnackBarBehavior.floating,
            content: const Center(
              child: Text(
                " Lütfen geçerli bir email giriniz",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            width: 250,
            backgroundColor: Colors.lightBlue[100],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            behavior: SnackBarBehavior.floating,
            content: const Center(
              child: Text(
                " Bir hata oluştu ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return HomeScreen();
    } else {
      return Scaffold(
        backgroundColor:
            Colors.white, //Theme.of(context).colorScheme.secondaryContainer,
        body: Form(
          key: _formKey,
          child: _isLoading
              ? Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Center(
                    child: CircularProgressIndicator(color: Colors.black),
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 150),
                      Text(
                        "Hoşgeldiniz",
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Hesabınıza Giriş yapın",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 60),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Email",
                          prefixIcon: const Icon(Icons.email_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onEditingComplete: () =>
                            _focusNodePassword.requestFocus(),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter username.";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _passwordController,
                        focusNode: _focusNodePassword,
                        obscureText: _obscurePassword,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          labelText: "Şifre",
                          prefixIcon: const Icon(Icons.password_outlined),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                              icon: _obscurePassword
                                  ? const Icon(Icons.visibility_outlined)
                                  : const Icon(Icons.visibility_off_outlined)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter password.";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              minimumSize: const Size.fromHeight(50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // user login process
                                setState(() {
                                  _isLoading = true;
                                });
                                loginUser(
                                    email: _emailController.text,
                                    password: _passwordController.text);
                                setState(() {
                                  _isLoading = false;
                                });
                              }
                            },
                            child: _isLoading
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : const Text(
                                    "Giriş Yap",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Hesabınız yok mu?"),
                              TextButton(
                                onPressed: () {
                                  _formKey.currentState?.reset();

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return SignUp();
                                      },
                                    ),
                                  );
                                },
                                child: const Text("Kayıt olun"),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text('Veya'),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Telefon numarası ile'),
                              TextButton(
                                onPressed: () {
                                  _formKey.currentState?.reset();

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return PhoneLogin();
                                      },
                                    ),
                                  );
                                },
                                child: const Text("Giriş Yapın"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
        ),
      );
    }
  }
}
