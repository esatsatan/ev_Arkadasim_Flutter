import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ev_arkadasim/src/componets/BottomNavigationBar.dart';
import 'package:ev_arkadasim/src/home/Home.dart';
import 'package:ev_arkadasim/src/home/ProfileScreen.dart';
import 'package:ev_arkadasim/src/home/PublishScreen.dart';
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
  String username = "";
  String email = "";
  String password = "";
  String university = "";
  /*
  @override
  void initState() {
    super.initState();
    //print('kullanıcı idsi : ${FirebaseAuth.instance.currentUser!.uid}');
    getUsername();
  }

  Future getUsername() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;

        String name = data['username'];
        String email = data['email'];
        String password = data['password'];
        String university = data['university'];

        print(name);

        setState(() {
          username = name;
          email = email;
          password = password;
          university = university;
        });
      } else {
        print('Veritabanında böyle bir döküman yok.');
      }
    }).catchError((error) {
      print('bir hata oluştu çünkü : $error');
    });
  }
*/
  //search textfield properties
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNodePassword = FocusNode();
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("İlanlar"),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  _authService.userLogout();
                  setState(() {
                    user == null;
                  });
                });
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => SignIn(),
                  ),
                  (route) => false,
                );
              },
              icon: Icon(
                Icons.logout,
              ),
            ),
          ],
        ),
        body: IndexedStack(
          index: _selectedIndex,
          children: [
            Home(),
            PublishScreen(),
            ProfileScreen(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.blue,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: const [
              BottomNavigationBarItem(
                backgroundColor: Colors.blue,
                icon: Icon(Icons.home),
                label: 'Ana Sayfa',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: 'İlan Yayımla',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profil',
              ),
            ])
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
