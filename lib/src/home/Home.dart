import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ev_arkadasim/src/componets/PostCard.dart';
import 'package:ev_arkadasim/src/login/SignIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../authentication/FirebaseAuth.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthService _authService = AuthService();
  User? user = FirebaseAuth.instance.currentUser;
  String username = "";
  String email = "";
  String password = "";
  String university = "";

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

  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNodePassword = FocusNode();
  List<String> ilanlar = ["İlan 1", "İlan 2", "İlan 3"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              maxLines: 1,
              controller: _searchController,
              onChanged: ((value) {
                //Arama işlemleri burada gerçekleştirilebilir.
                // Örneğin, ilanlar listesini filtrelemek için kullanılabilir.
              }),
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
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              'Güncel İlanlar',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 22,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10, // Örnek bir öğe sayısı
              itemBuilder: (BuildContext context, int index) {
                return const PostCard();
              },
            ),
          ),
        ],
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
