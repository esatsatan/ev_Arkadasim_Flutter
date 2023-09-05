import 'package:ev_arkadasim/src/componets/BottomNavigationBar.dart';
import 'package:ev_arkadasim/src/login/SignIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../authentication/FirebaseAuth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthService _authService = AuthService();
  User? user = FirebaseAuth.instance.currentUser;

  //search textfield properties
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNodePassword = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ana sayfa"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => SignIn(),
                ),
                (route) => false,
              );
              setState(() {
                _authService.userLogout();
              });
            },
            icon: Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextField(
                        maxLines: 1,
                        controller: _searchController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 15,
                          ),
                          prefixIcon: Icon(Icons.search_sharp),
                          hintText: "Üniversite Ara",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
