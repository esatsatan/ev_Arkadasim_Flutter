import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ev_arkadasim/src/UserRepositories/UserAuthRepository.dart';
import 'package:ev_arkadasim/src/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserAuthRepositoryImp implements UserAuthRepository {
  final FirebaseAuth _firebaseAuth;
  final usersCollection = FirebaseFirestore.instance.collection('users');

  UserAuthRepositoryImp({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  // TODO: implement user
  Stream<User?> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser;
    });
  }

  @override
  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<MyUser> signUp(MyUser myUser, String username, String email,
      String password, String university) async {
    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: myUser.email,
        password: password,
      );

      myUser = myUser.copyWith(
        userId: user.user!.uid,
        // buraya username giib devamlı seyler gelecek mi araştır?
      );
      return myUser;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> setUserData(MyUser myUser) async {
    try {
      await usersCollection
          .doc(myUser.userId)
          .set(myUser.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> sendEmailVerification() async {
    try {
      User? user = _firebaseAuth.currentUser;
      if (user != null && !user.emailVerified) {
        await user.reload(); // son kullanıcı bilgisini güncelle.
        await user.sendEmailVerification();
        //return user.emailVerified; // tset et
      }
    } catch (e) {
      throw Exception("Email verification failed");
    }
    //return false;
  }
}
