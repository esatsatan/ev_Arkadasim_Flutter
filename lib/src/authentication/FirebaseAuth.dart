import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> createUser(
      {required String email,
      required String password,
      required String username,
      required String university}) async {
    String res = "Some Error occurred";
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      print(credential.user!.uid);
      await _firestore.collection('users').add({
        'username': username,
        'email': email,
        'password': password,
        'university': university,
      });
      res = "Success";
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  Future<void> loginUser(
      {required String email, required String password}) async {
    try {
      final UserCredential authresult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final User? user = authresult.user;
      
    } on FirebaseAuthException catch (error) {
      print('error caused by: $error');
    }
  }

  Future sendVerificationEmail() async {
    String res = "Some Error occureed";
    try {
      await _auth.currentUser?.sendEmailVerification();
      res = "success";
    } catch (e) {
      print("error caused by : ${e.toString()}");
      res = e.toString();
    }
  }

  Future userLogout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print('Çıkış yapıldı');
    }
  }
}
