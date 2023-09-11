import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ev_arkadasim/src/model/user.dart' as model;
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

      model.User user = model.User(
          username: username,
          email: email,
          password: password,
          university: university);

      await _firestore
          .collection('users')
          .doc(credential.user!.uid)
          .set(user.toJson());
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
      print('OTURUM AÇILDI!!');
    } on FirebaseAuthException catch (error) {
      print('oturum açılamadı çünkü : $error');
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
      print('Çıkış yapılamadı');
    }
  }
}
